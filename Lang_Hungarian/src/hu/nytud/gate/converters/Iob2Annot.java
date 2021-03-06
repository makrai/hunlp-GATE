package hu.nytud.gate.converters;

import gate.*;
import gate.creole.*; 
import gate.creole.metadata.*; 
import gate.creole.metadata.Optional;
import gate.util.*;

import java.util.*;

/** 
 *  IOB (inside/outside/begin) code to regular annotation converter.
 *  Takes IOB code which is present on some annot (e.g. Tokens),
 *  and creates new annotations based on the info encoded in IOB codes.
 *  Handles IOB, IOBE (+end) and IOBE1 (+end/single) code systems.
 *  Only the first char of the IOB code is taken into account,
 *  if it is not "I", "B", "E" or "1", it is considered as "O".
 *  @author Bálint Sass
 */ 
@CreoleResource(name = "HU 5. IOB2Annotation Converter",
  comment = "Requires 'Token' annotation with IOB codes in 'ne_iob' attrib"
  // helpURL = "http://corpus.nytud.hu/gate/doc/Iob2Annot"
) 
public class Iob2Annot extends AbstractLanguageAnalyser { 
 
  /**
   * (Generated, by Eclipse) -- ezzel mi legyen? XXX
   */
  private static final long serialVersionUID = 4881484671828244243L;
  
  public Resource init() throws ResourceInstantiationException { 
    return this; 
  }

  public void reInit() throws ResourceInstantiationException { 
  } 

  /** 
   * Creates new annotations based on the info encoded in IOB codes.
   */ 
  public void execute() throws ExecutionException { 

    // lets start the progress and initialize the progress counter
    fireProgressChanged(0);

    // If no document provided to process throw an exception
    if(document == null) {
      fireProcessFinished();
      throw new GateRuntimeException("No document to process!");
    }

    // get the input annotationSet name provided by the user,
    // or otherwise use the default method
    AnnotationSet inputAs =
      (inputASName == null || inputASName.trim().length() == 0)
      ? document.getAnnotations()
      : document.getAnnotations(inputASName);

    // get the output annotationSet name provided by the user,
    // or otherwise use the default method
    AnnotationSet outputAs =
      (outputASName == null || outputASName.trim().length() == 0)
      ? document.getAnnotations()
      : document.getAnnotations(outputASName);

    try {
      // -----
      // convert IOB to regular annot begin
      // simple functionality: codes can be
      // iCode, oCode or bCode (and possibly eCode or sCode)
  
      // Get token annotations in document order
      // If there is no 'inputIobAnnotType' annot no new annot will be created
      List<Annotation> tokens =
        gate.Utils.inDocumentOrder( inputAs.get( inputIobAnnotType ));
  
      DocumentContent doc = document.getContent();
  
      List<String> childIds = new ArrayList<String>();
  
      Long start = 0l; // startOffset
      Long end = 0l; // endOffset

      //   I O B 1 E
      // I + . . . + "in"
      // O . + + + . "out"
      // B + . . . + "in"
      // 1 . + + + . "out"
      // E . + + + . "out"
      // all transitions are tested on hp3_2bek
      // by the following ids: 56-63, 72-88, 120-121, 210-215
  
      // go through the tokens
      for ( Annotation a : tokens ) {
  
        // if ( B )
        //   create annot: annotStartOffset..annotEndOffset,
        //     contentFromOffsets, tokenIdsAsString   
        //   annotStartOffset = B.begin
        //   annotEndOffset = B.end
        //   ArrayList tokens = B.id
        // if ( I )
        //   annotEndOffset = I.end
        //   tokens.add( I.id )
        // if ( O or none )
        //   create annot: annotStartOffset..annotEndOffset,
        //     contentFromOffsets, tokenIdsAsString   
  
        String iobCode = "";
        try {
          iobCode = a.getFeatures().get( inputIobAnnotAttrib ).toString();
          // getFeatures() returns null if there is no inputIobAnnotAttrib attrib
        } catch( NullPointerException e ) {
          iobCode = "";
        }
  
        // XXX ez elég hatékony így a 2db startsWith() -del?
        if ( iobCode.startsWith( bCode ) || iobCode.startsWith( sCode ) ) {
          if ( ! childIds.isEmpty() ) {
            createAnnotation( start, end, doc, childIds, outputAs );
            childIds = new ArrayList<String>();
            start = 0l;
            end = 0l;
          }
          start = a.getStartNode().getOffset();
          end = a.getEndNode().getOffset();
          childIds.add( a.getId().toString() );
        } else if ( iobCode.startsWith( iCode ) || iobCode.startsWith( eCode ) ) {
          end = a.getEndNode().getOffset();
          childIds.add( a.getId().toString() );
        } else { // if oCode or anything else
          if ( ! childIds.isEmpty() ) {
            createAnnotation( start, end, doc, childIds, outputAs );
            childIds = new ArrayList<String>();
            start = 0l;
            end = 0l;
          }
        }
      }
      // handling last NE -- needed if the last code is not oCode
      // XXX ez most így szép külön fgvénybe véve 1000 paraméterrel?? :)
      if ( ! childIds.isEmpty() ) {
        createAnnotation( start, end, doc, childIds, outputAs );
      }

      // convert IOB to regular annot end
      // -----
    } catch(InvalidOffsetException e) {
      throw new ExecutionException(e);
    }

    // process finished, acknowledge user about this.
    fireProcessFinished();
  }

  /** 
   * Creates one annotation.
   */ 
  public void createAnnotation ( Long start, Long end, DocumentContent doc,
      List<String> childIds, AnnotationSet outputAs )
      throws InvalidOffsetException {

    String content = doc.getContent( start, end ).toString();

    FeatureMap fm = gate.Factory.newFeatureMap();
    fm.put( "text", content );
    fm.put( "childIds", childIds );

    outputAs.add( start, end, outputAnnotationName, fm);
    // XXX ... és ha van már outputAnnotationName (=NE) annot? Lesz még.
  }

  @RunTime
  @Optional
  @CreoleParameter(
    comment="The annotation set to take inputIobAnnotType (Token) annotation from"
  )
  public void setInputASName( String s ) {
    this.inputASName = s;
  }
  public String getInputASName() {
    return inputASName;
  }
  private String inputASName;

  @RunTime
  @Optional
  @CreoleParameter(
    comment="The annotation set to be used for the generated annotations"
  )
  public void setOutputASName( String s ) {
    this.outputASName = s;
  }
  public String getOutputASName() {
    return outputASName;
  }
  private String outputASName;

  // XXX hogy lehetne, hogy
  // XXX a Token/ne_iob/I/O/B/NE-t csak 1x kelljen leírni alább?
  @RunTime
  @CreoleParameter(
    comment="Annotation type which has an attrib containing the IOB code",
    defaultValue="Token"
  )
  public void setInputIobAnnotType( String s ) {
    this.inputIobAnnotType = s.trim().length() == 0 ? "Token" : s;
  }
  public String getInputIobAnnotType() {
    return inputIobAnnotType;
  }
  private String inputIobAnnotType;

  @RunTime
  @CreoleParameter(
    comment="Attribute of 'inputIobAnnotType' which contains the IOB code",
    defaultValue="ne_iob"
  )
  public void setInputIobAnnotAttrib( String s ) {
    this.inputIobAnnotAttrib = s.trim().length() == 0 ? "ne_iob" : s;
  }
  public String getInputIobAnnotAttrib() {
    return inputIobAnnotAttrib;
  }
  private String inputIobAnnotAttrib;

  @RunTime
  @CreoleParameter(
    comment="'Inside' code value for IOB code",
    defaultValue="I"
  )
  public void setICode( String s ) {
    this.iCode = s.trim().length() == 0 ? "I" : s;
  }
  public String getICode() {
    return iCode;
  }
  private String iCode;

  @RunTime
  @CreoleParameter(
    comment="'Outside' code value for IOB code",
    defaultValue="O"
  )
  public void setOCode( String s ) {
    this.oCode = s.trim().length() == 0 ? "O" : s;
  }
  public String getOCode() {
    return oCode;
  }
  private String oCode;

  @RunTime
  @CreoleParameter(
    comment="'Begin' code value for IOB code",
    defaultValue="B"
  )
  public void setBCode( String s ) {
    this.bCode = s.trim().length() == 0 ? "B" : s;
  }
  public String getBCode() {
    return bCode;
  }
  private String bCode;

  @RunTime
  @CreoleParameter(
    comment="Possible 'End' code value for IOB code",
    defaultValue="E"
  )
  public void setECode( String s ) {
    this.eCode = s.trim().length() == 0 ? "E" : s;
  }
  public String getECode() {
    return eCode;
  }
  private String eCode;

  @RunTime
  @CreoleParameter(
    comment="Possible 'Single' code value for IOB code",
    defaultValue="1"
  )
  public void setSCode( String s ) {
    this.sCode = s.trim().length() == 0 ? "1" : s;
  }
  public String getSCode() {
    return sCode;
  }
  private String sCode;

  @RunTime
  @CreoleParameter(
    comment="Annotation type for the new regular annotation created from the IOB code",
    defaultValue="NE"
  )
  public void setOutputAnnotationName( String s ) {
    this.outputAnnotationName = s.trim().length() == 0 ? "NE" : s;
  }
  public String getOutputAnnotationName() {
    return outputAnnotationName;
  }
  private String outputAnnotationName;

}

