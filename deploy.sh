docker build -t programmingwithbadri/multi-client:latest -t programmingwithbadri/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t programmingwithbadri/multi-server:latest -t programmingwithbadri/multi-server:$SHA ./server/Dockerfile ./server
docker build -t programmingwithbadri/multi-worker:latest -t programmingwithbadri/multi-worker:$SHA ./worker/Dockerfile ./worker

docker push programmingwithbadri/multi-client:latest
docker push programmingwithbadri/multi-server:latest
docker push programmingwithbadri/multi-worker:latest

docker push programmingwithbadri/multi-client:$SHA
docker push programmingwithbadri/multi-server:$SHA
docker push programmingwithbadri/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=programmingwithbadri/multi-server$SHA
kubectl set image deployments/client-deployment client=programmingwithbadri/multi-client$SHA
kubectl set image deployments/worker-deployment worker=programmingwithbadri/multi-worker$SHA