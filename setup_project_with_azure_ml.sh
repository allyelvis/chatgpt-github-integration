#!/bin/bash

# Exit on error
set -e

# Colors for output
GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m"

echo -e "${GREEN}Starting Azure CLI and project landing page setup...${NC}"

# Step 1: Update the system
echo -e "${GREEN}Updating system packages...${NC}"
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget git python3-pip build-essential

# Step 2: Install Azure CLI
echo -e "${GREEN}Installing Azure CLI...${NC}"
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
echo -e "${GREEN}Azure CLI installed successfully.${NC}"

# Step 3: Login to Azure CLI
echo -e "${GREEN}Logging into Azure CLI...${NC}"
az login --use-device-code

# Step 4: Create a landing page
echo -e "${GREEN}Setting up landing page...${NC}"
PROJECT_DIR="project_landing_page"
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"

# Create HTML for landing page
cat <<EOF > index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Project Landing Page</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header>
        <h1>Welcome to Our Project</h1>
    </header>
    <main>
        <section>
            <h2>About the Project</h2>
            <p>This project integrates AI and self-maintenance features, enhanced with machine learning capabilities.</p>
        </section>
        <section>
            <h2>Features</h2>
            <ul>
                <li>Azure Integration</li>
                <li>Machine Learning Enhancements</li>
                <li>Self-Maintenance</li>
            </ul>
        </section>
        <footer>
            <p>&copy; 2024 by Ally Elvis Nzeyimana</p>
        </footer>
    </main>
</body>
</html>
EOF

# Create CSS for landing page
cat <<EOF > styles.css
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f4f4f4;
    color: #333;
}
header {
    background-color: #0078d7;
    color: white;
    padding: 10px 20px;
    text-align: center;
}
main {
    padding: 20px;
}
footer {
    text-align: center;
    padding: 10px;
    background-color: #0078d7;
    color: white;
}
EOF

echo -e "${GREEN}Landing page created at $PWD.${NC}"

# Step 5: Enhance with ML capabilities
echo -e "${GREEN}Setting up machine learning environment...${NC}"
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install numpy pandas scikit-learn azureml-sdk

# Create an ML script
cat <<EOF > ml_model.py
import numpy as np
from sklearn.linear_model import LinearRegression
import joblib

# Sample ML model
def train_model():
    X = np.array([[1], [2], [3], [4], [5]])
    y = np.array([2, 4, 6, 8, 10])
    model = LinearRegression()
    model.fit(X, y)
    joblib.dump(model, "model.joblib")
    print("Model trained and saved as model.joblib")

if __name__ == "__main__":
    train_model()
EOF

python3 ml_model.py
deactivate
echo -e "${GREEN}Machine learning environment set up with a sample model.${NC}"

# Step 6: Self-maintenance script
echo -e "${GREEN}Creating self-maintenance script...${NC}"
cat <<EOF > self_maintain.sh
#!/bin/bash

# Function to update project dependencies
update_dependencies() {
    echo "Updating system packages..."
    sudo apt update && sudo apt upgrade -y
    echo "Updating Python packages..."
    source venv/bin/activate
    pip install --upgrade pip numpy pandas scikit-learn azureml-sdk
    deactivate
}

# Function to retrain ML model
retrain_model() {
    echo "Retraining machine learning model..."
    source venv/bin/activate
    python3 ml_model.py
    deactivate
}

# Run maintenance tasks
update_dependencies
retrain_model
echo "Maintenance completed successfully."
EOF

chmod +x self_maintain.sh
echo -e "${GREEN}Self-maintenance script created at $PWD/self_maintain.sh.${NC}"

# Step 7: Publish project to GitHub
echo -e "${GREEN}Publishing project to GitHub...${NC}"
git init
git remote add origin https://github.com/allyelvis/project_landing_page.git
git add .
git commit -m "Initial commit with landing page, ML script, and self-maintenance."
git branch -M main
git push -u origin main
echo -e "${GREEN}Project published to GitHub.${NC}"

# Final Message
echo -e "${GREEN}Project setup complete!${NC}"
echo -e "${GREEN}Landing page directory: $PWD${NC}"
