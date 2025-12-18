# Materials for the course: DevSecOps in cloud-based CI/CD

[Subscribe to the course](https://practicum.yandex.ru/profile/ycloud-devsecops/subscribe)

* [How to build a container](#build)
* [How to run it on a local machine](#runlocal)
* [How to edit the code](#edit)
* [How to run it in a cluster](#runcluster)

## How to build a container <a id="build"/></a>

Building a container:

```
docker build . -t maniaque/finenomore:1.0
```

Pushing it to Docker Hub:

```
docker push maniaque/finenomore:1.0
```

## How to run it on a local machine <a id="runlocal"/></a>

```
docker-compose up
```

## How to edit the code <a id="edit"/></a>

Since the code is copied into the container when building the latter, editing the code online is not that simple.

To become able to do so, rename the `docker-compose.override.yml-` file (note the hyphen character) to `docker-compose.override.yml` (without the trailing hyphen).

Now run the `docker-compose up` command that will put the `app` directory inside the container while remaining fully editable from the local file system.

## How to run it in a cluster <a id="runcluster"/></a>

Starting it requires a number of check steps:

1. The app container must be built and located somewhere the cluster is able to access it. In most cases, Docker Hub does perfectly.

1. The cluster service account must have the `load-balancer.admin` role. That role is not assigned if the service account for the cluster is created automatically.

1. Before you start installing, determine how your app will receive traffic. This example employs a NGINX Ingress controller; to install it, follow [this tutorial](https://yandex.cloud/en/docs/managed-kubernetes/tutorials/ingress-cert-manager).

Next, after obtaining the configuration file to access the cluster, run the following commands to install the NGINX Ingress controller:

```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

helm repo update

helm install ingress-nginx ingress-nginx/ingress-nginx
```

To install your app in the cluster, use Helm Chart (find it in the `k8s/finenomore` directory).

Go to that directory:

```
cd k8s/finenomore
```

Install the chart:

```
helm install finenomore .
```







