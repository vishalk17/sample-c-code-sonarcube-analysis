# Sample C Code SonarQube Analysis

This repository contains sample C code for demonstrating SonarQube analysis. The analysis can be performed using two different methods:
1. Jenkins (using `Jenkinsfile` in the repo)
2. Shell script (using `sonarqube-analysis.sh`)

## Getting Started
### Prerequisites
- SonarQube Server (Developer version, as C code analysis is not supported on the community edition)
- Jenkins Server (if using Jenkins method)
- Shell environment (if using shell script method)

### Using Jenkins

To perform SonarQube analysis using Jenkins, follow these steps:

1. **Install SonarQube Scanner on Jenkins:**
   - Go to Jenkins dashboard.
   - Navigate to `Manage Jenkins` > `Global Tool Configuration`.
   - Under `SonarQube Scanner`, click `Add SonarQube Scanner`.
   - Set the name as `sonar-scanner`.
   - Save the configuration.

2. **Configure SonarQube Server:**
   - Go to Jenkins dashboard.
   - Navigate to `Manage Jenkins` > `Configure System`.
   - Under `SonarQube servers`, click `Add SonarQube`.
   - Set the name as `sonar-server-paid`.
   - Provide your SonarQube server URL (in this case, `http://sonarqube.vishalk17.com:9000`) and authentication token.
   - Save the configuration.

3. **Install Build Wrapper on Jenkins Node:**
   - SSH into the Jenkins node where the build will run.
   - Download and install the build wrapper:
     ```sh
     mkdir -p temp
     cd temp
     wget http://sonarqube.vishalk17.com:9000/static/cpp/build-wrapper-linux-x86.zip
     unzip build-wrapper-linux-x86.zip
     sudo mv build-wrapper-linux-x86/* /usr/local/bin/
     ```

4. **Setup `Jenkinsfile`:**
   - Ensure your `Jenkinsfile` contains the following configurations:
     ```groovy
     def SONAR_SCANNER_HOME = tool 'sonar-scanner'
     def BUILD_WRAPPER_HOME = "/usr/local/bin/build-wrapper-linux-x86-64"
     ```

## Video Tutorial  

<p align="center">
  <a href="https://youtu.be/c3ClxHU1Ff8">
    <img src="https://img.youtube.com/vi/c3ClxHU1Ff8/0.jpg" alt="SonarQube Analysis using Jenkins" width="800" height="450">
  </a>
</p>

### Using Shell Script

To perform SonarQube analysis using the shell script, follow these steps:

1. **Install Build Wrapper:**
   - Download and install the build wrapper:
     ```sh
     mkdir -p temp
     cd temp
     wget http://sonarqube.vishalk17.com:9000/static/cpp/build-wrapper-linux-x86.zip
     unzip build-wrapper-linux-x86.zip
     sudo mv build-wrapper-linux-x86/* /usr/local/bin/
     ```

2. **Install SonarQube Scanner:**
   - Download and install the SonarQube Scanner:
     ```sh
     wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-7.0.1.4817-linux-x64.zip
     unzip sonar-scanner-cli-7.0.1.4817-linux-x64.zip
     sudo mv sonar-scanner-7.0.1.4817-linux-x64/ /opt/
     ```

3. **Run the Shell Script:**
   - Modify the `sonarqube-analysis.sh` script with your SonarQube server details.
   - Execute the script in your shell environment:
     ```sh
     ./sonarqube-analysis.sh
     ```

## Repository Structure
- `Jenkinsfile`: Jenkins pipeline script for SonarQube analysis.
- `sonarqube-analysis.sh`: Shell script for SonarQube analysis.

## Contact
For any questions or issues, please contact [vishalk17](https://github.com/vishalk17).

> **Note:** The SonarQube server URL (`http://sonarqube.vishalk17.com:9000`) is specific to this repository and should be replaced with your own server details. We are using the developer version of SonarQube as C code analysis is not supported on the community edition.