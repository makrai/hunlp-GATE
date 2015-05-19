# GATE installation directory
export GATE_HOME=/home/$(USER)/GATE_Developer_8.0

# userid on corpus.nytud.hu used for uploading, see target "upload"
CORPUSUSER=yourusername

.PHONY: build upload

# Build the GATE CREOLE plugin "Lang_Hungarian" in ./Lang_Hungarian/
build:
	cd Lang_Hungarian ; ant

# Upload the Lang_Hungarian plugin to the plugin repository at corpus.nytud.hu/GATE/
# Invoke with your own username on corpus.nytud.hu:
# make upload CORPUSUSER=mylogin
upload:
	mkdir -p upload_dir/Lang_Hungarian
	cp -p Lang_Hungarian/hungarian.jar upload_dir/Lang_Hungarian
	cp -p Lang_Hungarian/creole.xml upload_dir/Lang_Hungarian
	cd upload_dir ; zip Lang_Hungarian.zip Lang_Hungarian/*
	cp -p update-site/gate-update-site.xml upload_dir
	rsync -vR upload_dir/./gate-update-site.xml upload_dir/./Lang_Hungarian.zip upload_dir/./Lang_Hungarian/* $(CORPUSUSER)@corpus.nytud.hu:/var/www/GATE/
	rm -rf upload_dir

