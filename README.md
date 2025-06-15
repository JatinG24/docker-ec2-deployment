# docker-ec2-deployment
DevOps Intern Assignment: Dockerize and Deploy Web App on AWS EC2

Step-by-Step Implementation

1. GitHub Repository Setup
    a.Created a new GitHub repository: docker-ec2-deployment
    b. Cloned the repo locally:
        git clone https://github.com/JatinG24/docker-ec2-deployment.git
        cd docker-ec2-deployment
        ![alt text](</Screenshots/Github Repository.png>)

2. Created Flask Web Application
    a. Created app.py:
        from flask import Flask
        app = Flask(__name__)

        @app.route("/")
        def home():
            return "Hello from Docker on EC2!"

    if __name__ == "__main__":
        app.run(host="0.0.0.0", port=5000)

    ![alt text](</Screenshots/Created Flask Web Application-1.png>)

    b. Created requirements.txt:
        ![alt text](/Screenshots/Requirements.png)


3. Dockerized the App
    a.Created Dockerfile:
        FROM python:3.9
        WORKDIR /app
        COPY . .
        RUN pip install -r requirements.txt
        CMD ["python", "app.py"]

    b. Built Docker image locally:
        docker build -t flask-app .

    c. Ran it locally:
        docker run -d -p 5000:5000 flask-app

    d. Verified app at localhost :
        ![alt text](</Screenshots/Verified app at localhost.png>)

4. Launched EC2 Instance on AWS
    a.Chose Ubuntu 20.04 and t2.micro (Free Tier)
    b.Created new key pair (.pem)
    c.Configured Security Group:
        i.Allowed SSH (port 22)
            ![alt text](</Screenshots/SSH Port 5000.png>)
        ii.Allowed Custom TCP (port 5000) from 0.0.0.0/0

    d. EC2 Dashboard:
        ![alt text](</Screenshots/EC2 Dashboard.png>)
    e. EC2 instance:
        ![alt text](</Screenshots/EC2 Instance.png>)

5. Connected to EC2 via SSH
    a. Moved Devops-key.pem file to folder
    b.Set permissions:
        chmod 400 Devops-key.pem
    c.Connected using Git Bash:
        ssh -i "Devops-key.pem" ubuntu@65.0.7.107
    d. SSH terminal session:
        ![alt text](</Screenshots/SSH terminal session.png>)

6. Installed Docker on EC2
    a.sudo apt update
    b.sudo apt install docker.io -y
    c.sudo systemctl start docker
    d.sudo systemctl enable docker
    e.Verified Docker:
        sudo docker --version

7. Deployed the App on EC2
    a.Cloned the GitHub repo on EC2:
        git clone https://github.com/JatinG24/docker-ec2-deployment.git
        cd docker-ec2-deployment
    b. Built Docker image:
        sudo docker build -t flask-app .
    c. Ran the app:
        sudo docker run -d -p 5000:5000 flask-app
    d.http://65.0.7.107:5000
        ![alt text](</Screenshots/Verified app at public EC2 IP.png>)

**. Bonus Points Implementation

8.Use IAM Role to Access S3 from EC2
    a. Create an IAM Role
        Go to AWS Console > IAM > Roles
        Click “Create role”
    b.Attach S3 Access Policy
        Click Next, named the role: EC2-S3-Access-Role
        Click Create Role
    c.Attach Role to EC2    
        Go to EC2 Dashboard > Instances
        Select your instance
        Click Actions > Security > Modify IAM Role
        Select EC2-S3-Access-Role and click Update
    d.Created ROle 
        ![alt text](</Screenshots/Created Role.png>)
    e.Successfully Attached 
        ![alt text](</Screenshots/Successfully Attached.png>)
    f.Test S3 Access from EC2
        ssh -i "Devops-key.pem" ubuntu@65.0.7.107

9. Automate Deployment with cloud-init
    a. Prepare a cloud-init Script
        #!/bin/bash
        apt update
        apt install -y docker.io git
        git clone https://github.com/JatinG24/docker-ec2-deployment.git
        cd docker-ec2-deployment
        docker build -t flask-app .
        docker run -d -p 5000:5000 flask-app
    b. Launch a New EC2 Instance With This Script
        In EC2 Dashboard, click Launch Instance
        Paste the above script in the User Data box
        Open http://65.0.7.107:5000

10. deploy.sh — One-Click Deployment Script
    a.Create deploy.sh in your repo
        File: deploy.sh
        ![alt text](</Screenshots/Deploy Sh.png>)
    b. Make It Executable
        chmod +x deploy.sh
    c.Then execute:
        ./deploy.sh
    
