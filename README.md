# isulad_script
iSulad一键安装脚本+适配海外源

<img src="https://github.com/openeuler-mirror/iSulad/blob/master/logo/iSulad-logo.svg" alt="iSulad" style="max-width: 25%;" />

<a href="https://github.com/openeuler-mirror/iSulad"><img src="https://img.shields.io/badge/github-iSulad-blue"/></a> ![license](https://img.shields.io/badge/license-Mulan%20PSL%20v2-blue) ![language](https://img.shields.io/badge/language-C%2FC%2B%2B-blue)

## Introduction

`iSulad`是一个由C/C++编写实现的轻量级容器引擎，具有轻、灵、巧、快的特点，不受硬件规格和架构限制，底噪开销更小，可应用的领域更为广泛。

## Architecture

`iSulad`架构的相关介绍请查看：[architecture](./docs/design/architecture_zh.md)。

## Getting Started

- [一键脚本](wget --no-check-certificate https://raw.githubusercontent.com/xwen222/isulad_script/master/install.sh && chmod +x ./install.sh && ./install.sh)

- [开发指南](https://docs.openeuler.org/zh/docs/22.03_LTS/docs/Container/container.html)

## Performance

采用[ptcr](https://gitee.com/openeuler/ptcr)作为容器引擎的性能测试工具，展示在不同架构的计算机中`iSulad`的性能效果。

### ARM

- 10个容器串行操作的情况下，`iSula`与`docker`、`podman`的性能对比雷达图如下：

<img src="https://github.com/openeuler-mirror/iSulad/docs/images/performance_arm_seri.png" alt="ARM searially" style="zoom:80%;" />

- 100个容器并行操作的情况下，`iSula`与`docker`、`podman`的性能对比雷达图如下：

<img src="https://github.com/openeuler-mirror/iSulad/docs/images/performance_arm_para.png" alt="ARM parallerlly" style="zoom:80%;" />

### X86

- 10个容器串行操作的情况下，`iSula`与`docker`、`podman`的性能对比雷达图如下：

<img src="https://github.com/openeuler-mirror/iSulad/docs/images/performance_x86_seri.png" alt="X86 searially" style="zoom:80%;" />

- 100个容器并行操作的情况下，`iSula`与`docker`、`podman`的性能对比雷达图如下：

<img src="https://github.com/openeuler-mirror/iSulad/docs/images/performance_x86_para.png" alt="X86 parallerlly" style="zoom:80%;" />

**关于性能测试的更多信息请查看**  [Performance test](https://gitee.com/openeuler/iSulad/wikis/Performance?sort_id=5449355)。

## Kernel Requirements

`iSulad`支持在3.0.x之后的Kernel上运行。

## Compatibility

`iSulad` 能够兼容的标准规范版本如下：

- 兼容 1.0.0 版本的OCI
- 兼容 0.3.0 版本以上的CNI
- 兼容 2.1.x 版本以上的lcr
