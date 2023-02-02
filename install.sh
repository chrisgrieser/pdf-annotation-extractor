#!/usr/bin/env zsh

# install homebrew if not yet

brew install mgmeyers/pdfannots2json/pdfannots2json

cd "/Applications" || exit 1
curl -o "anno-extractor.zip" "https://github.com/chrisgrieser/pdf-annotation-extractor/blob/main/PDF%20Annotation%20Extractor.zip?raw=true" 
unzip anno-extractor.zip
rm -f anno-extractor.zip 
rm -rf __MACOSX 
xattr -d com.apple.quarantine "PDF Annotation Extractor.app"
