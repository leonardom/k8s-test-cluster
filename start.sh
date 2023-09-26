# building the projects
projects=("go-url-shortener" "go-albums") 

for project in ${projects[@]}; do
  echo "Building project: $project image..."
  docker build -t "leonardom/$project-app" "https://github.com/leonardom/$project.git"
  minikube image load "leonardom/$project-app"
done

echo "Deploying projects in minikube..."
kubectl apply -f ./k8s --recursive

for project in ${projects[@]}; do
  echo "Exposing service $project..."
  minikube service "$project-app-service" --url &
done
#kubectl port-forward "deployment/$project-app" 8000:8000 
#minikube service go-albums-service --url

