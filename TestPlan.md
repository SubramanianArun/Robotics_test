## TEST PLAN DOCUMENT

#### 1) DOCUMENT IDENTIFIER INFORMATION
#### Revision History
 
| Version Date |    Revision | Description   | Author          |
| :----------- | :---------- | :------------- | :------------- |
| 29 Jan 2021  |  1.0        | Initial Release - Test Plan| Subramanian Arunachalam          |


#### 2) INTRODUCTION
   **2.1) Purpose**: Test plan to check the requirements on actuator position, battery life and maintenance cycle
   
   **2.2) Project Overview**: _'buggy_robot'_ is a ROS package which models a simple 1 dimensional actuator. The project aims to achieve the target set point with accuracy of +/- 0.05m
   
   **2.3) Audience** : MaidBot Testing team, project coordinators and upper management   

#### 3) SCOPE
**In Scope** : This test plan will outline the procedure to test the current position of the 1D actuator, target set point, the error and testing if the position falls within the threshold of acceptance.

**Out of Scope** : This test plan will not outline methods to test the battery life and the maintenance cycle of the hardware components in the _'buggy_robot'_ system
#### 4) REFERENCES
This document was made with reference to the IEEE Standard for Software and System Test Documentation IEEE -829 : 2008 taking certain topics and headers that are relevant to this project.

#### 5) TEST STRATEGY
##### 5.1) FUNCTIONAL TESTING
This section outlines the testing plan for functional aspects of the _buggy_robot_.
##### 5.1.1) Unit Testing:
Nodes can be individually tested for compilation and runtime errors.
- **hardware_node.py**: 
Execute the command ``` rosrun buggy_robot hardware_node.py``` in a new terminal tab inside the ROS environment. If it executes without any errors, then there are no compilation errors.
- **controller_node.py**:
Execute the command ``` rosrun buggy_robot controller_node.py``` in a new terminal tab inside the ROS environment. If it executes without any errors, then there are no compilation errors.

##### 5.1.2) Interface Testing:
Communication between controller and hardware nodes can be verified by launching the nodes individually by the two commands given in _section 4.1_ and typing the following command: ```rostopic list```. If the list contains two topics '/controller/command' and '/hardware/state', then the nodes are up and have started subscribing each other which denotes the communication between the nodes.

##### 5.1.3) System Testing: 
There are three primary requirements in the test schedule: Actuator position, Battery Life and Maintenance cycle. Setup the environment conditons as mentioned in section 6 of the document. The host computing device can be a laptop, desktop or a raspberry pi. It is mentioned as '**Host**' from this section onwards. Similarly, the terminal application in macOS and linux (Windows powershell for windows 10) will be addressed as '**terminal**' from this section. Follow the procedures as outlined below:
- Power on the host and log in to the host 
- Download Docker Desktop for Mac/OS/Linux based on the host operating system
- Plug in the USB pendrive and download the zip file contents on to the host
- Extract the zip file contents to a desktop folder. Name the folder as '_actuator_'. There will be a folder named 'catkin_ws', a docker file and a readme file.
- Open terminal window. Navigate to the desktop folder using the cd command ```cd [SystemPath]/desktop/actuator```. Here system path depends on the host operating system. It is assumed that the reader knows to find the system desktop path on their own.
- Navigate to the actuator folder and type the command ```docker build -t maidbot:0.1```. It will take few minutes while docker pulls the relevant environment from the online code repositories.
- Once it is finished, type ```docker images``` in the terminal. The list would contain the image name to be maidbot:0.1. Note down the image id.
- Type ```docker run -it [imageid]``` in terminal. The container will run in the background. It can be verified by the command ```docker container list```. Find the name of the container that was created.
- Type the command ```docker exec -it [imageid] /bin/sh``` in the terminal.
- A shell terminal opens by default. It will be indicated by the label 'sh' followed by some digits like 4.0 or 5.0 (varies with user). Next step is to source the environments.
- Type the following commands in the second shell window that opened from the docker container
> echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
> echo “source /home/robot/catkin_ws/devel/setup.bash” >> ~/.bashrc
> source ~/.bashrc
- The terminal prompt will change from 'sh-5.0' to root@[imageid]:/home/robot. Now the terminal is inside the ROS environment that can be used for testing
- Run ``` sudo apt-get update``` and ```sudo apt-get upgrade``` to update the container to the latest version.
- Navigate to the folder 'catkin_ws' in the /home/robot folder using the command ```cd /home/robot/catkin_ws/```
- Type the command ```catkin_make```. It will build the packages required for testing the _'buggy_robot_'

##### ACTUATOR POSITION
- Actuator position can be tested by using a customised python script that inherits from the controller_node and the hardware node.
- Launch the two nodes with the commands mentioned in the unit testing section 5.1.1
- Python script will instantiate an object and send the target position to the rosservice '_SetTarget_'.
- The current position of the actuator is posted in the state message '/hardware/state'. It contains a typedefinition that has the float variables: x and x_dot. x denotes the current position and x_dot denotes the current velocity.
- Python script can have methods that will read from the state messages and calculate the error (target position - current position) and check if its within the tolerance limit of '0.05m'.
- A **defect** in the hardware is identified if it doesn't fall within the limit of 0.05m for any set point within the range [0,0.5m].

##### BATTERY LIFE
- Battery health can be monitored by adding new methods to controller and hardware node classes.
- A new state message or a variable can be added in the existing state message to post the periodic status of the battery as publisher in the hardware node.
- The controller node can subscribe to the state message and the python test scripts can inherit from the controller node to monitor battery health
- If the battery health falls to zero within an hour, the hardware is labelled as a **defect**.

##### MAINTENANCE CYCLE
- The time period between the circuit board replacement can be monitored by the existing triggers in the hardware node. There are two services: 'reset' and 'next'.
- The reset service publishes when the hardware is reset anytime. The next service publishes the message when any hardware component is replaced.
- By logging the time stamp everytime the next trigger message is published on to some file in the disk and calculating the time period between two consecutive timestamps, we can find the average life cycle of the circuit components.
- If the component fails within 3 months, then it is labelled as a **defect**.
##### 5.2) NON FUNCTIONAL TESTING
This section outlines the testing plan for functional aspects of the _buggy_robot_.
##### 5.2.1) Stress Testing
- Actuator : Repeated setpoints sent periodically making the actuator move to the extreme ends can show the end of life conditions and number of cycles to achieve it
- Battery Life : Battery health can be monitored and its characteristics can be observed with changes in temperature conditons. Upper limits can be figured out by slowly increasing temperature to the point of battery failure
- Maintenance cycle:  Not applicable

##### 5.2.2) Security Testing
Communication channels can be monitored for possible side channel or man-in-the-middle attacks. Ransomware, malware scans should be done periodically to avoid carefully manipulated malfuctioning by threat actors.

##### 5.2.3) Reliability Testing
Testing can be done periodically to ensure that the results are consistent with the expectations of the product.

#### 6) ENVIRONMENT REQUIREMENTS
##### 6.1) Surface Requirements
- The bot has to be tested on an even flat surface with minimal bumps
(in case of physical bot testing)
##### 6.2) Hardware Requirements
- Host Computing device (Desktop/Laptop/Raspberry Pi) minimum requirements 
-- RAM : 4GB
-- Hard Disk space : 32 GB
Source for these calculations can be found in the attached findings document.
- Buggy_robot 

##### 6.3) Software Requirements
- Docker Desktop
- Buggy_robot Dockerfile
- Core OS: Linux Ubuntu 20.0 LTS (Focal fossa)
- ROS version: "Noetic Ninjemys"
- Python 3
- Catkin tools
- Nosetests module
All the software other than the Docker Desktop application can be installed by using the buggy_robot dockerfile. A zip file containing the project environment and the necessary files will be handed over in a USB Pen drive before testing.

#### 7) TEST SCHEDULE
The tentative schedule of the testing procedure is as follows:
 | Action Items  | Dates    |
   | :--------------------: | :---------------: |
   | Environment Setup: ROS/Docker |  22-23 Jan 2021     |
   | Test Plan creation |  24-25 Jan 2021     |
   | Test Execution and results |  26-27 Jan 2021     |
   | Result analysis and findings summary |  28-29 Jan 2021     |
   | GitHub repository submission and handover| 29 Jan 2021 |
   
#### 8) CONTROL PROCEDURES
##### 8.1) Problem Reporting
Incidents encountered during testing should be properly documented based on the predefined templates in the organization. All the troubleshooting steps need to be tracked and made sure that the same incident is never repeated.
##### 8.2) Change Requests
Change requests can be raised in case a section of the code needs to be looked into or modified depending on the seriousness of the incident.Proper documentation of the bug fixes and the approvals for software releases after bug fixes need to be carried out. If required, regression testing needs to be done periodically to ensure that the system performance is unaffected. 
#### 9) FEATURES TO BE TESTED
   This version of the software release focuses on testing the following feature

   | Feature        | Software       | Criticality to this version    | Notes          |
   | :------------- | :------------- | :------------- | :------------- |
   | Actuator  Position | version 1.0 | HIGH          |                |


#### 10) FEATURES NOT TO BE TESTED
   This version of the software release ignores testing of the following features

   | Feature        | Software       | Criticality to this version   | Notes |
   | :------------- | :------------- | :------------- | :------------- |
   | Battery life   | version 1.0    | LOW            |                |
   | Maintenance    | version 1.0    | LOW            |                |

#### 11) ITEM PASS/FAIL CRITERIA
**Position** : The actuator position lies between +/- 0.05m of the target set point
**Battery Life** : The robot runs for atleast 60 minutes on a single charge
**Maintenance Cycle** : The robot runs for at least 3 months before any hardware replacement
#### 12) SUSPENSION/RESUMPTION CRITERIA
This section of the document outlines the suspension criteria of all or a portion of the modules while testing. Testing is suspended temporarily or  until the conditions get better so as to avoid equipment damage or serious consequential errors.
##### 12.1) Suspension:
Suspension of testing can happen for several conditions including, but not limited to,
- Power loss
- Unexpected communication failure between modules
- Dependent systems failure
- Defect identification that bars further testing

##### 12.2) Resumption:
In such cases, the root cause of the defects is identified and then the testing is resumed. If a section of testing cannot happen until replacement of part/code fix and if there are other code modules that aren't affected, partial testing can be resumed with results documenting the situation.
#### 13) RESPONSIBILITIES
 | Responsibilities | Incharge    |
   | :--------------------:| :---------------: |
   |Test plan generation|    Subramanian Arunachalam   |
   |Test plan approval | Gwen Johnson |
   |Test plan execution| Subramanian Arunachalam|
   |Test results and summary| Subramanian Arunachalam|
   |Test results review and feedback| Gwen Johnson|
#### 14) RISKS
 The test is carried under the condition that both the _buggy_robot_ and the software are tested and validated.  Results are valid only if it satisfies the above condition. 
 
##### 14.1) Risk Identification
Risks can be positive or negative based on the consequences. In case a scenario arises where the software or the _buggy_robot_ has not encountered before but it does not affect its operation is classified as a positive risk. Positive risks can be used to identify bugs and enhance the operation of the system. Risks that have negative impacts need to be mitigated and analysed. Proper contingency measures need to be planned for negative risk scenarios.

##### 14.2) Risk Mitigation
 Negative risks can be mitigated on both hardware and software levels.
- **Hardware**: Sensors can be placed to avoid the bot from crashing or cause serious injury to its mechanical parts. 
- **Software**: Software alarms and triggers can ensure active mitigation of risks. High current, close distance obstacles, sudden fluctuation of values etc., can be triggers for shutdown in case of risky conditions

##### 14.3) Risk Contingency
 Life of the individual parts and maintenance cycles can be actively monitored for periodic replacement or calibration to avoid serious risks. Periodic reports about bot health can be collected and spare parts can be made available to quickly replace if contingency measures are required.
 
#### 15) DOCUMENTATION AND APPROVALS

 The people mentioned in this part of the document have reviewed and agree with the information available in this document. Changes to this test plan will be reviewed, coordinated and approved by the undersigned representatives

   | Document Approved by  | Date Approved    |
   | :-------------------- | :--------------- |
   | Dr.Gwen Johnson, Director of Software, MaidBot|       |

