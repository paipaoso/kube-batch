#!/bin/bash

# Copyright 2019 The Kube-batch Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -o errexit
set -o nounset
set -o pipefail

SCRIPT_ROOT=$(dirname ${BASH_SOURCE})/..
CODEGEN_PKG=${SCRIPT_ROOT}/vendor/k8s.io/code-generator

# generate the code with:
# --output-base    because this script should also be able to run inside the vendor dir of
#                  k8s.io/kubernetes. The output-base is needed for the generators to output into the vendor dir
#                  instead of the $GOPATH directly. For normal projects this can be dropped.
cd ${SCRIPT_ROOT}

bash ${CODEGEN_PKG}/generate-groups.sh "deepcopy,client,informer,lister" \
github.com/paipaoso/kube-batch/pkg/client github.com/paipaoso/kube-batch/pkg/apis \
"scheduling:v1alpha1 scheduling:v1alpha2" \
--go-header-file ${SCRIPT_ROOT}/hack/boilerplate/boilerplate.generatego.txt

# To use your own boilerplate text use:
#   --go-header-file ${SCRIPT_ROOT}/hack/custom-boilerplate.go.txt

