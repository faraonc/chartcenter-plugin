# ChartCenter plugin

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Release](https://img.shields.io/github/release/jfrog/chartcenter-plugin.svg?style=flat-square)](https://github.com/jfrog/chartcenter-plugin/releases/latest)

## What this plugin solves

[Helm](https://helm.sh) v2 and v3 plugin is for packaging dependency charts pulled from [ChartCenter](https://chartcenter.io).

[ChartCenter](https://chartcenter.io) is a free, immutable, central repository of public Helm charts for the Kubernetes community.
You can read more about [ChartCenter](https://chartcenter.io) and how to use it:
- Rimas Mocevicius [blog](https://rimusz.net/chartcenter)
- JFrog [blog](https://jfrog.com/resource-center/?src=chartcenter)

It allows 250+ public Helm repositories be accessed by just one central Helm repository, and to make it work it adds an extra namespace for the helm repositories which are part of [ChartCenter](https://chartcenter.io).

```console
helm repo add center https://repo.chartcenter.io
helm repo up
helm install postgresql center/bitnami/postgresql
```

In the example above we are installing `bitnami/postgresql` from the helm repo `https://repo.chartcenter.io`, and it works just fine.

But if we want to use dependency charts from the `https://repo.chartcenter.io` this is where Helm cli v2 and v3 `helm package` command does not understand the extra namespace specified in `requirements.yaml/Chart.yaml` and fails to package the chart. Helm `helm dependency` works just fine and pulls all the charts and stores in the `charts` folder.

The example Helm `requirements.yaml/Chart.yaml` file of using ChartCenter as Helm repository:

```yaml
dependencies:
- name: bitnami/postgresql
  version: 8.7.3
  repository: https://repo.chartcenter.io
  condition: postgresql.enabled
- name: bitnami/rabbitmq-ha
  version: 1.46.4
  repository: https://repo.chartcenter.io
  condition: rabbitmq-ha.enabled
- name: bitnami/rabbitmq
  version: 7.4.3
  repository: https://repo.chartcenter.io
  condition: rabbitmq.enabled
```

`bitnami` namespace from the example above is the extra namespace which was added to support [ChartCenter](https://chartcenter.io) and `helm package` doesn't understand it yet. Till the [fix](https://github.com/helm/helm/issues/8537) is done in Helm v3 client, ChartCenter's plugin can be used instead.

**Note:** Helm v2 client is not accepting any new features so the plugin needs to be used at all times in Helm v2.
 

## Installation

Install Helm client as per one of recommended [ways](https://helm.sh/docs/intro/install/).

Then install the latest plugin version:

```console
helm plugin install https://github.com/jfrog/chartcenter-plugin
```

## Usage

Using the plugin is so simple it replaces helm `dependency update` and `package` commands with just one:

```console
helm center <CHART_NAME>
```

It will run `helm dependency update` pulling the sub chart(s) from the ChartCenter and then package the chart with sub chart(s) to the `.tgz` file to be ready to be uploaded to any helm repository.


# Contact Us

* Twitter: tweet at us [@chartcenterio](https://twitter.com/chartcenterio)
* Github: [chartcenter](https://github.com/jfrog/chartcenter)
* Slack: Find us in #ChartCenter channel in the [Kubernetes Slack](https://kubernetes.slack.com/)
* Email: chartcenter@jfrog.com
