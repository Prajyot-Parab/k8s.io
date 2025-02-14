#!/usr/bin/env bash

ARCH="amd64"
KUBECTL_VERSION="v1.32.0"
GO_VERSION="1.24.0" 

function cleanup {
  echo "### Cleanup ###"
  rm -rf go1* kubetest2*
}

function install_golang {
  echo "### Install Golang ###"
  wget -L "https://golang.org/dl/go${GO_VERSION}.linux-${ARCH}.tar.gz"
  rm -rf /usr/local/go && tar -C /usr/local -xzf go${GO_VERSION}.linux-${ARCH}.tar.gz
  export GOPATH=$HOME/go
  export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
}

function install_terraform {
  echo "### Install Terraform ###"
  OS=$(uname)
  OS="${OS,,}"
  TF_LATEST=$(curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d '"' -f4)
  curl --connect-timeout 30 -fsSL https://releases.hashicorp.com/terraform/${TF_LATEST:1}/terraform_${TF_LATEST:1}_${OS}_${ARCH}.zip -o ./terraform.zip
  unzip -o ./terraform.zip  >/dev/null 2>&1
  rm -f ./terraform.zip
  chmod +x ./terraform
  ./terraform version | grep "Terraform v"
}

function install_kubetest2 {
  echo "### Install kubetest2 ###"
  git clone https://github.com/kubernetes-sigs/kubetest2
  pushd kubetest2
  make install
  popd
}

function install_tf_deployer {
  echo "### Install kubetest2-tf plugin ###"
  git clone https://github.com/ppc64le-cloud/kubetest2-plugins
  pushd kubetest2-plugins
  make install-deployer-tf
  popd
}

function install_kubectl {
  echo "### Install kubectl ###"
  export GOPATH_BIN=$HOME/go/bin
  curl -sLo "${GOPATH_BIN}/kubectl" https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${ARCH}/kubectl
  chmod +x "${GOPATH_BIN}/kubectl"
}

function main {
  # Install ansible, make and git 
  apt-get update && apt-get install -y ansible make git --no-install-recommends
  cleanup
  install_golang
  install_terraform
  install_kubetest2
  install_tf_deployer
  install_kubectl
}

main "$@"
