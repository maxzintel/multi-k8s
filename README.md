# Project Structure Overview:

### Goal:
#### Re-architect multi-k8s project for production.
1. Create config file for each service and deployment.
2. Test locally via Minikube.
3. Create a Github -> TravisCI flow to build images and deploy.
4. Deploy to Google Cloud.

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


### Why Google Cloud over AWS for this project?
* Subjective. Looking for experience with other cloud providers.
* Google created K8s.
* Easier to navigate K8s in Google Cloud. Cloud Console connected to our VPC.
  * Can use kubectl against our production instances very easily.
* Superior documentation.

### .travis.yml Setup
1. Install Google Cloud CLI
2. Configure the sdk with Google Cloud auth info
3. Login to the Docker CLI
4. Build the 'test' version of multi-client
5. Run tests
6. If tests successful, run script to deploy the newest images
7. Build all our images, tag each, push to Docker Hub
8. Apply all configs (yaml) in the k8s folder
9. Imperatively set latest images on each deployment

### Service Account and Encryption Setup
1. Create Service Account in Google Cloud via IAM & Admin -> Create Service Account
  * Give K8s Engine Admin role, generate json key file.
2. Install TravisCI with Ruby container
  * `docker run -it -v $(pwd):/app ruby:2.3 sh`
    * Sets up multi-k8s (present working directory) as a volume in the ruby container and opens a bash shell.
    * End goal here is to copy the json key file from (1) into the container, and encrypt it.
3. `cd /app`
4. `gem install travis`
  * Quick Note: if using Ruby Alpine instead, this step will fail.
5. `travis login` Enter your github credentials
6. Copy json key file into our volume (pwd, aka multi-k8s)
  * `ls` in the container should now show the json file.
7. `travis encrypt-file service-account.json -r s1dequest/multi-k8s`
  * Follow directions in output.
8. DELETE ORIGINAL JSON KEY FILE.
