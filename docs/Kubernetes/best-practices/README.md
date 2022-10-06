# Application development best practices

## Health checks

### Readiness probes

Readiness probe is used to notify kubelet that the app is ready to receive traffic. If this probe is not configured, the application will receive traffic as soon as the container start whereas the application may not be really ready.

### Liveness probes

Liveness probe is used to restart a container when there is an issue. If a container fully consumes the allocated memory, it will no longer be able to answer the readiness probe checks, thus it will be removed / detached from the service but it will remain registered as an active replica. To sum-up, it will consume resources whereas it will no longer receive workload.

## Readiness and liveness must be different

When both probes are configured to monitor the same endpoint, you can observe weird effects. Indeed kubelet will receive a not ready or not alive signal which will detached the container from the service and delete it at the same time. The consequence might be to observe dropping connections because the container does not have enough time to drain the current connections or processes.

## Apps are independent

Do not use dependencies endpoint as a targeted endpoint of a liveness or readiness probe.

## High availability

### Use more than one pod

An application should run on more than one replica. If one of the replicas fails the other will be able to handle the traffic until a new replica will be spun-up.

### Use pod affinity

Having multiple replica will not guaranty the high availability of an application. Indeed all the replicas may be hosted on the same node. To avoid this situation, post affinity may be used to ensure two pods will not be hosted on the same node.

### Pod disruption budget

By default, Kubernetes uses rolling update to update its nodes. If an application is deployed on multiple nodes, it may happens that those nodes will be updated at the same time. In such case there is a downtime risk. To avoid this issue a pod disruption budget can be configured to alert kubelet that some pod must be evicted if it breaks the pod disruption budget rule. This is a guaranty that a minimum number of pod will remain up no matter the situation is.

## Resources utilization

### Configure resource request

This information is used by the scheduler to deploy pods on nodes. If a memory request is not configured then its value is 0 which indicates to the scheduler that the pods can be placed anywhere. This can lead to a resource overcommitment on a node, and potentially to kubelet crashes. The same applies to CPU requests.

### Configure resource limit

The resource limit can be configured or not depending on the needs. It will directly impact the SLA associated with the pods:

- Guaranteed:
    * Every Container in the Pod must have a memory limit and a memory request.
    * For every Container in the Pod, the memory limit must equal the memory request.
    * Every Container in the Pod must have a CPU limit and a CPU request.
    * For every Container in the Pod, the CPU limit must equal the CPU request.
- Burstable:
    * The Pod does not meet the criteria for QoS class Guaranteed.
    * At least one Container in the Pod has a memory or CPU request.
- BestEffort:
    * The Container has no memory or CPU limits or requests

**If a process goes over the memory limit, then it is terminated whereas if it goes over the CPU limit, it is throttled.**

!!! info

    For a lot of use cases, configuring the requested limits is enough

## Tagging resources

As in any cloud, it is wise to tag resources. I may help the operation team in their day to day activity. The [official documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels/) proposes a list of tags.

## Logging

An application deployed to Kubernetes should send its logs to stdout and stdin so that it may be displayed with kubectl command or send to external system by applications such as Fluentd.

## Scaling

### Stateless application

An application must not have stored state in their local file system, if there is a need for persistent data then a persistent volume must be used.

### Horizontal pod auto scaler

An horizontal pod auto scaler must be configured to allow an application to scale out and scale in depending on thresholds. In this way an application can allow respond to incoming request no matter the number of request it has, and always at the lowest cost.

## Configuration and secrets

### Externalize configuration

As mentioned in the [twelve factors](https://12factor.net/config){target=_blank} the configuration must be separated from the code. Doing this will allow a Kubernetes manifest to be reusable in multiple context or in multiple stacks. The technical way to achieve this goal is to use ConfigMaps to store the configuration and mount the ConfigMaps inside a container.

### Mount secrets as volume

Secrets are often transmitted to a pod via environment variables. This is the easiest way to copy secrets for the CI to the pods. However, it is not really a good practice as secrets in environment variables can be displayed in the container start command logs, which may be inspected by people who should not know it.

??? example "references"

    - [learnk8](https://learnk8s.io/production-best-practices#application-development){target=_blank}
    - [Kubernetes official documentation](https://kubernetes.io/docs){target=_blank}
