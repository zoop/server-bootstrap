#!/bin/bash

# Ensure the script is run with sudo privileges
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root or with sudo privileges."
  exit 1
fi

# Update and Upgrade the system
echo "➡️  Updating system packages..."
sudo apt-get update -qq > /dev/null
sudo apt-get upgrade -y -qq > /dev/null
echo "✅ System updated!"

# Install dependencies
echo "➡️  Installing dependencies..."
sudo apt-get install -y -qq apt-transport-https ca-certificates curl software-properties-common gnupg lsb-release wget build-essential uidmap > /dev/null
echo "✅ Dependencies installed!"

# Install Java 17
echo "➡️  Installing Java 17..."
sudo apt install -y -qq openjdk-17-jdk -qq > /dev/null
echo "✅ Java 17 installed!"

# Install Nginx for health check
echo "➡️  Installing Nginx..."
sudo apt install -y -qq nginx > /dev/null
echo "✅ Nginx installed!"

# Install Docker (latest LTS)
echo "➡️  Installing Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -qq > /dev/null
sudo apt-get install -y -qq docker-ce docker-ce-cli containerd.io > /dev/null
sudo usermod -aG docker ubuntu
echo "✅ Docker installed!"

# Install Google Cloud SDK and gke-gcloud-auth-plugin
echo "➡️  Installing Google Cloud SDK..."
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list > /dev/null
sudo apt-get update -qq > /dev/null
sudo apt-get install -y -qq google-cloud-sdk > /dev/null
sudo apt-get install -y -qq google-cloud-sdk-gke-gcloud-auth-plugin > /dev/null
sudo apt-get install -y -qq kubectl > /dev/null
echo "✅ Google Cloud SDK installed!"

# Install Helm (latest LTS)
echo "➡️  Installing Helm..."
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash > /dev/null
echo "✅ Helm installed!"

# Install Terraform (latest LTS)
echo "➡️  Installing Terraform..."
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null
sudo apt update -qq > /dev/null
sudo apt install -y -qq terraform > /dev/null
echo "✅ Terraform installed!"

# Install Speedtest CLI
echo "➡️  Installing Speedtest CLI..."
sudo apt install -y -qq speedtest-cli > /dev/null
echo "✅ Speedtest CLI installed!"

# Install Maven
echo "➡️  Installing Maven..."
sudo apt install -y -qq maven > /dev/null
echo "✅ Maven installed!"

# Install wkhtmltopdf
echo "➡️  Installing wkhtmltopdf..."
sudo apt install -y -qq wkhtmltopdf > /dev/null
echo "✅ wkhtmltopdf installed!"

# Install Node.js (via NVM)
echo "➡️  Installing NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash > /dev/null
source ~/.bashrc
echo "➡️  Installing Node.js..."
nvm install 22 > /dev/null
echo "✅ Node.js installed!"

# Install Yarn
echo "➡️  Installing Yarn..."
npm install -g yarn > /dev/null
echo "✅ Yarn installed!"

# All Done!
echo "🎉 All required software has been installed!"
