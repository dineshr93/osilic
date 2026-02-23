#!/bin/bash

# ----------------------------
# Check required environment variables
# ----------------------------
missing_vars=()

if [ -z "$DETECT_VERSION" ]; then
    missing_vars+=("DETECT_VERSION")
fi

if [ -z "$BLACKDUCK_API_TOKEN" ]; then
    missing_vars+=("BLACKDUCK_API_TOKEN")
fi

if [ -z "$BLACKDUCK_URL" ]; then
    missing_vars+=("BLACKDUCK_URL")
fi

if [ ${#missing_vars[@]} -ne 0 ]; then
    echo "The following required environment variables are not set:"
    for var in "${missing_vars[@]}"; do
        echo "  export $var=<value>"
    done
    echo "Please set them before running the script."
    exit 1
fi

# ----------------------------
# Export fallback test values (optional, only if you want to use BDURL_TEST/BDAPI_TEST)
# ----------------------------
export BLACKDUCK_URL="${BLACKDUCK_URL:-$BDURL_TEST}"
export BLACKDUCK_API_TOKEN="${BLACKDUCK_API_TOKEN:-$BDAPI_TEST}"

# ----------------------------
# Documentation
# ----------------------------
echo "************************************** HELP *****************************************"
echo "https://documentation.blackduck.com/bundle/detect/page/properties/all-properties.html"
echo "*************************************************************************************"

# ----------------------------
# Generate application.yml
# ----------------------------
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

# ----------------------------
# Run Black Duck Detect
# ----------------------------
bash <(curl -s "https://detect.blackduck.com/detect${DETECT_VERSION}.sh")
