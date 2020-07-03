# Copyright (c) 2020 Intel Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ============================================================================
#
# THIS IS A GENERATED DOCKERFILE.
#
# This file was assembled from multiple pieces, whose use is documented
# throughout. Please refer to the TensorFlow dockerfiles documentation
# for more information.

ARG TENSORFLOW_IMAGE="intel/intel-optimized-tensorflow"
ARG TENSORFLOW_TAG

FROM ${TENSORFLOW_IMAGE}:${TENSORFLOW_TAG}


ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install --no-install-recommends --fix-missing python-tk libsm6 libxext6 -y && \
    pip install requests


ARG PACKAGE_DIR=model_packages
ARG PACKAGE_NAME
ARG WORKSPACE

# ${WORKSPACE} and below needs to be owned by root:root rather than the current UID:GID
# this allows the default user (root) to work in k8s single-node, multi-node
ADD --chown=0:0 ${PACKAGE_DIR}/${PACKAGE_NAME}.tar.gz ${WORKSPACE}
RUN chown -R root ${WORKSPACE}/${PACKAGE_NAME} && chgrp -R root ${WORKSPACE}/${PACKAGE_NAME} && chmod -R g+s+w ${WORKSPACE}/${PACKAGE_NAME}

WORKDIR ${WORKSPACE}/${PACKAGE_NAME}

