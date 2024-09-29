import kopf
import kubernetes.client
from kubernetes.client.rest import ApiException

def create_deployment(namespace, name, image, replicas, port):
    apps_v1 = kubernetes.client.AppsV1Api()
    container = kubernetes.client.V1Container(
        name=name,
        image=image,
        ports=[kubernetes.client.V1ContainerPort(container_port=port)]
    )
    template = kubernetes.client.V1PodTemplateSpec(
        metadata=kubernetes.client.V1ObjectMeta(labels={"app": name}),
        spec=kubernetes.client.V1PodSpec(containers=[container])
    )
    spec = kubernetes.client.V1DeploymentSpec(
        replicas=replicas,
        template=template,
        selector={'matchLabels': {'app': name}}
    )
    deployment = kubernetes.client.V1Deployment(
        api_version="apps/v1",
        kind="Deployment",
        metadata=kubernetes.client.V1ObjectMeta(name=name),
        spec=spec
    )
    apps_v1.create_namespaced_deployment(namespace=namespace, body=deployment)

@kopf.on.create('yourcompany.com', 'v1', 'fastapideployments')
def create_fn(body, spec, **kwargs):
    name = body['metadata']['name']
    namespace = body['metadata']['namespace']
    image = spec.get('image', 'qiross/fastapi-app:latest')
    replicas = spec.get('replicas', 1)
    port = spec.get('port', 8000)
    
    create_deployment(namespace, name, image, replicas, port)
