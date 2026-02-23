#!/bin/bash

echo "************************************** HELP *****************************************"
echo "https://documentation.blackduck.com/bundle/detect/page/properties/all-properties.html"
echo "*************************************************************************************"

cat <<EOF > application.yml
detect.project.name: $(basename "$PWD")
detect.project.version.name: $(git branch --show-current)_$(git rev-parse --short HEAD)
detect.code.location.name: $(basename "$PWD")_$(git branch --show-current)_$(git rev-parse --short HEAD)
blackduck.trust.cert: true
detect.blackduck.signature.scanner.individual.file.matching: ALL
detect.blackduck.signature.scanner.upload.source.mode: true
detect.blackduck.signature.scanner.license.search: true
detect.blackduck.signature.scanner.copyright.search: true
detect.blackduck.signature.scanner.snippet.matching: SNIPPET_MATCHING
detect.detector.search.depth: 50
detect.excluded.directories.search.depth: 50
detect.excluded.directories: ".idea,.gradle,docs,test,bin,build,.git,out,.repo,doc,tests,screenshot,dist,.venv"
detect.tools: "SIGNATURE_SCAN,DETECTOR"
detect.required.detector.types: UV
detect.accuracy.required: UV
detect.included.detector.types: UV
detect.excluded.detector.types: "GIT,PIP"
detect.uv.dependency.groups.excluded: dev
EOF

export BLACKDUCK_URL="${BDURL_TEST}"
export BLACKDUCK_API_TOKEN="${BDAPI_TEST}"


bash <(curl -s https://detect.blackduck.com/detect${DETECT_VERSION}.sh)
