
sudo apt update
sudo apt install -y docker.io git

# Clone the repo if it doesn't exist
if [ ! -d "docker-ec2-deployment" ]; then
    git clone https://github.com/JatinG24/docker-ec2-deployment.git
fi

cd docker-ec2-deployment

# Build and run the app
sudo docker build -t flask-app .
sudo docker run -d -p 5000:5000 flask-app
