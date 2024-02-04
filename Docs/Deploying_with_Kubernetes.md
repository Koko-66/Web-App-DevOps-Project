# Deploying with Kubernetes

## Defining resources - Deployment and Service
The manifest file for this application, **application-mainfest.yaml** contains the code defining the following:
<!-- Explain the key concepts and configuration settings within these manifests. -->
### Deployment
The Deployment resource is used to deploy the containerized _Orders_ application onto the AKS cluster. Resource details:
Deployment name: `flask-app-deployment`
Specifications in the `spec` section:
- number of `replicas` set to 2 (allows app to run concurrently on two pods, for scalability and high availability
- `selector > matchLabels > app` set to `flask-orders-app` (allows Kubernetes to identify pods the Deployment should manage) 
- `template > metadata > labels > app` set to `flask-orders-app` (gives the pods the same label as the selector to establish connection between them and the application that is managed)
- `spec > container` set to the applications Docker image. This part also exposes port 5000 for communication within the AKS cluster. 
- `strategy` selected for the project: RollingUpdate with both max unavailable pods and max new pods set to 1 to ensure continuous app availability.
    This strategy is ideal for this kind of project as it offers minimal downtime, and remembers the current state of data, which means that the users can continue checking and adding orders even during updates. It is also quick and easy to implment, which aligns with the size of application and it's internal nature.

### Service
Service resource is required to enable internal communication within the AKS cluster. Resource details:
Service name: flask-app-service
Specifications in the `spec` section:
- `selector` set to match the labels assigned to the pods in the Deployment resource to ensure the correct direction of the traffic.
- `ports` with protocol set as TCP, port 80 for communication within the cluster and the targetPort set to match the port exposed by the container, i.e. 5000.
- `type` set to the default ClusterIP internal service within the AKS cluster)

## Deploying
The first step in the deployment staged was to make sure that the deployment will be applied to the correct cluster and with correct user details. 
This was done by first setting the context to the desired one using `kubectl config use-context terraform-aks-cluster` and then verifying the switch by running `kubectl config current-context` command.
The configuration was then applied using the `kubectl apply -f application-manifest.yaml` command.

## Testing and validating
The deployment process was monitored while running. Once finished the application was tested with the following steps: 

1. Verified the status and details of the pods and services in the cluster using `kubectl get all` command 
2. Initiate port forwarding using the `kubectl port-forward <pod-name> 5000:5000` command, where <pod-name> was replaced  with the actual name of a pod.
3. Accessed http://127.0.0.1:5000 to check whether application runs successfully
4. Viewed and added orders to confirm all functionality works as expected while monitoring output in the 

## App distribution

### Sharing app with internal users
In its current state, application can only be accessed using the port forwarding. In order to share it with other internal users, the service type should be changed to either NodePort or LoadBalancer and configured accordingly. Both of these service types allow access to the pods from outside of cluster, thus allowing access via web browser on specific port.

In our case, since the cluster only has one node and the app would be for internal use only, the simplest solution would be to use NodePort. 
To implement NodePort:
1. Change _Service_ `type` from ClusterIP to NodePort in the Service manifest.
2. You can optionally specify the `nodePort` (in the `ports` section) in the 30000-32767 range. If not specified, Kubernetes will assign one automatically.
3. Deploy the manifest again, to apply the changes.
4. Check wether everything is running as should, e.g. by running `kubectl get all`
5. Find the External IP and the NodePort, if you did not specify it. You can run `kubectl get svc flask-app-service` to get both of these. 
The URL for the app would be <span style="color:orange">http://\<Node-Public-IP>:\<NodePort></span>. e.g. http://123.45.67.89:3109
6.  Test if everything is running as expected.
6. Subject to successful testing, share the link above with your team.

### Sharing app with external users
If the need to share the application outside of organisation arises, the best way to apporach this would be to implement Ingress service, which supports both HTTP and HTTPS traffic.

#### <u>Considerations for allowing external access</u>

Allowing external users access to the application comes with additional considerations surrounding security and app maintenance.
Some of the things to consider include:

- Implmenetation of **Kubernetes Network Policies** to control traffic between different parts of the application and restricting access to the app.
- Implementation of **authentication and authorization** mechanisms to ensure that only authorized users can access sensitive parts of the application.
- Setting up **monitoring and logging** to track access patterns, errors, and potential security issues.
- Following **security best practices** for both AKS and a Flask application, including regular security updates, secure coding practices, etc.

If external access is needed, we suggest implementing Ingress, which supports HTTPS traffic and offers load balancing capabilities. A suggested process for such 

1. Define an Ingress resource to expose the app externally. Configure the Ingress to use a secure connection (HTTPS), adding tls information:

        tls:
        - hosts:
            - your-app-domain.com
            secretName: your-tls-secret

2. Deploy the Ingress Resource to AKS using `kubectl apply -f <your-flask-app-ingress.yaml>`
3. Obtain an SSL/TLS certificate for your domain. You can use Let's Encrypt or a certificate from a certificate authority.
4. Create a Kubernetes Secret to store the TLS certificate.
        
        kubectl create secret tls your-tls-secret --cert=path/to/certificate.crt --key=path/to/private-key.key

5. You should now be able to access the app using the specified domain with HTTPS, e.g. https://your-app-domain.com



