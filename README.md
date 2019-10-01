# Project Structure Overview:

### Goal:
#### Re-architect multi-docker project for production.
1. Create config file for each service and deployment.
2. Test locally via Minikube.
3. Create a Github -> TravisCI flow to build images and deploy.
4. Deploy to AWS.

### Components
* Ingress Service
* ClusterIP Service
* Deployments
* Redis
* Postgres
