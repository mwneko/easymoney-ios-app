# IPSE-assignment 2
 AccountBook application named easyMoney written in Xcode 10

# Background
This is the second assignment for IPhone Software Engineering.   
The aim of this assignment is to continue to improve prototype and report based on Assignment 1  

# Contribution
s3765724-Bowen Lu(Lia): UI Test & Report & Cocoa Framework  
s3699777-Qiaochu Wang(outstanding-neko): Front-end & Design UI  
s3699534-Yong Guo(Jeffery): Back-end & unit test  

# Install
Hardware: Mac  
Programming language: Xcode10 & Swift 4  
System: MacOs  
ios: 12.0

# Introduction
Based on xcode v.10 and MVVM, this application uses swift 4, Deployment Target ios 12, and realizes the basic accounting function:  
1. Main scene can view all bills that show in reverse order, including monthly summary  
2. Click a single Bill to jump to the details page, and you can edit part of the content in this scene  
3. Sliding delete  
4. Add new bill for two types: spending & income  
5. Profie scene can check the student information and changes the avatar  

# API Server
The category data for billing comes from the REST API  
Use: AWS DynamoDB + AWS Lambda + API Gateway  

# Data Persistence
Core Data

# Change Log
### v1.0.0
Implements core Data storage  
feat/1-coredata -- Jeffery  
***
### v2.0.0
Implement the basic storyborad style
feat/2-mainStory -- Outsanidng/mwneko  
### v2.1.0
Implement the tableview custome style  
feat/2.1-tableview -- Outsanidng/mwneko  
### v2.2.0
Implement the autolayout constraints for masterview/billsview  
feat/2.2-autolayout-for-masterview -- Outsanidng/mwneko  
### v2.4.0
Implement new style for storyboard  
feat/2.4-new-storyBoard -- Outsanidng/mwneko  
### v2.5.0
implement detail view style  
feat/2.5-detail-view -- Outsanidng/mwneko  
***
### v3.0.0
Implement basic student profiles function  
feat/3-studentProfiles -- Lia  
### v3.1.0
Implement cocoa Framework(take photo/select photo)  
feat/3.1-cocoaFramework -- Lia  
***
### v4.0.0
Implement detail data display  
feat/4-showDetail -- Jeffery  
***
### v5.0.0
Implement all core data CRUD  
update display data in reserse order  
feat/5-finishCoreDataCRUD -- Jeffery  
***
### v6.0.0
Implement MVVM  
feat/6-MVVM -- Jeffery  
***
### v7.0.0
Implement autolayout for all scene  
feat/7-Autolayout -- Outsanidng/mwneko  
### v7.1.0
Implement adaptive layout for all lanscape  
feat/7.1-AdaptiveLayout -- Outsanidng/mwneko  
### v7.2.0 
Implement split detail style  
feat/7.2-split-detail -- Outsanidng/mwneko  
### v7.3.0
Modify the style  
feat/7.3-final-page -- Outsanidng/mwneko  
### v7.4.0
Fix up tab Bar style  
feat/7.4-fixup-tabBar -- Outsanidng/mwneko  
***
### v8.0.0
Implement alert
feat/8-alertErrorMessage -- Jeffery  
### v8.1.0
Implement monthly summary  
feat/8.1-showSummary -- Jeffery  
### v8.2.0
Implement student profile storage  
feat/8.2-studentProfile -- Jeffery  
***
### v9.0.0
Implement UI test  
feat/9-UITest -- Lia（already delete）  
new update  
feat/9.1-UITest -- Lia  
***
### v10.0.0
Implement Unit test  
feat/10-UnitTest -- Jeffery  
***
### Submit version
Lastest update:   
1.Fixed issues with the Plus series not working properly in landscape  
2.Fixed issues with X series landscape split screen incorrect  
3.Fixed issues with Camera, now user only can choose take photo cannot choose take video  
4.Updated all tests  
5.Adjust font size of the Master Scene  
6.Update input validation, limit amount is seven digits  
7.Fixed issues with detail scene size class

# Usage guidance
Test vedio  
Mockup Links: https://web.microsoftstream.com/video/d280ea52-12fc-42f6-a4b7-47cdc2f8e848  
Real iPhone 6 Plus Links: https://web.microsoftstream.com/video/6e87c1df-ff4f-48af-909d-d1c6a3662593  

UI Test  
if you find almost test be fail, please check simulator keyboard Settings  
Use like that:
![image](https://github.com/rmit-S2-2020-iPhone/a1-s3699534_s3765724_s3699777/blob/master/screenShot/UItest%20setting.jpeg)

