# Project Structure Overview:

### Goal:
#### Re-architect multi-docker project for production.
1. Create config file for each service and deployment.
2. Test locally via Minikube.
3. Create a Github -> TravisCI flow to build images and deploy.
4. Deploy to AWS.

### Components
* Ingress Service
  * Used to funnel traffic to inside of our node. Technically in the cluster, and thus, able to make connections to ClusterIP's.
* ClusterIP Service
  * Opens ports to allow any other service in the cluster to connect to the object it is fronting.
* Deployments
  * Eliminates limitations/risk of architecting connections to a pod directly.
  * Runs as a set of identical pods, automatically monitors and updates pod state.
  * Works with ClusterIP via `matchLabels`.
* Redis
  * Open source image for use as a in-memory data structure store (cache).
* Postgres
  * Object-relational database system.
