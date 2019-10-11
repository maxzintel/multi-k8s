docker build -t s1dequest/multi-client:latest -t s1dequest/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t s1dequest/multi-server:latest -t s1dequest/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t s1dequest/multi-worker:latest -t s1dequest/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push s1dequest/multi-client:latest
docker push s1dequest/multi-client:$SHA
docker push s1dequest/multi-server:latest
docker push s1dequest/multi-server:$SHA
docker push s1dequest/multi-worker:latest
docker push s1dequest/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=s1dequest/multi-client:$SHA
kubectl set image deployments/server-deployment server=s1dequest/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=s1dequest/multi-worker:$SHA

