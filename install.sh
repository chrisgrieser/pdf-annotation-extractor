#!/usr/bin/env zsh

cd "/Applications" || exit 1
curl -o "anno-extractor.zip" "https://github.com/chrisgrieser/pdf-annotation-extractor/blob/main/PDF%20Annotation%20Extractor.zip?raw=true" 
unzip anno-extractor.zip
rm -f anno-extractor.zip 
rm -rf __MACOSX 
xattr -d com.apple.quarantine "PDF Annotation Extractor.app"
