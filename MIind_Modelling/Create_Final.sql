-- Script to create Database Brain
DROP DATABASE IF EXISTS Brain;

CREATE DATABASE Brain;
Use Brain;

-- Table for address of the user
CREATE TABLE `Address` (
AddressID int NOT NULL AUTO_INCREMENT,
address varchar(255) NOT NULL DEFAULT '',
address2 varchar(255),
city varchar(255),
state varchar(255),
zip int,
PRIMARY KEY (AddressID)
);

-- Table for User
CREATE TABLE User (
userID int NOT NULL AUTO_INCREMENT,
userName varchar(255) NOT NULL DEFAULT '',
userGender ENUM('M','F') NOT NULL,
userAge int(150) NOT NULL DEFAULT '0',
addressID int NOT NULL DEFAULT '0',
PRIMARY KEY(userID),
FOREIGN KEY (addressID) REFERENCES Address(AddressID)
);


-- Table for Filters used
CREATE TABLE `Filter` (
filterID int NOT NULL AUTO_INCREMENT,
filterType varchar(255) NOT NULL DEFAULT '',
frequency varchar(255) NOT NULL DEFAULT '',            
samplingRate varchar(255)  NOT NULL DEFAULT '',      
PRIMARY KEY (filterID)
);


-- Table for amplifiers used
CREATE TABLE `Amplifier` (
amplifierID int NOT NULL AUTO_INCREMENT,
amplifierOutputVolt varchar(255),
amplifierInputInMilliVolt varchar(255),
amplificationFactor int(30),
PRIMARY KEY (amplifierID)
);


-- Table for signals collected
CREATE TABLE `Signal` (
signalID int NOT NULL AUTO_INCREMENT,
signalName varchar(255) NOT NULL DEFAULT '',
PRIMARY KEY (signalID)
);



-- Table for Electrode
CREATE TABLE `Electrode` (
ElectrodeID int NOT NULL AUTO_INCREMENT,
ElectrodeName varchar(255) NOT NULL DEFAULT '',
LobeName varchar(255) NOT NULL DEFAULT '',
imagingDepth int NOT NULL DEFAULT '0',
PRIMARY KEY (ElectrodeID)
);

-- Table for Emotion
CREATE TABLE EMOTION(
emotionID int NOT NULL DEFAULT 0,
emotionName varchar(20),
PRIMARY KEY(emotionID)
);



-- Table for EEGData Collected
CREATE TABLE EEGData (
eegdataID int NOT NULL AUTO_INCREMENT,
userID int NOT NULL DEFAULT '0',
filterID int,
amplifierID int,
FP1 decimal(6,4) NOT NULL DEFAULT '0',
signalFP1 int NOT NULL DEFAULT '0',
FP2 decimal(6,4) NOT NULL DEFAULT '0',
signalFP2 int NOT NULL DEFAULT '0',
AF3 decimal(6,4) NOT NULL DEFAULT '0',
signalAF3 int NOT NULL DEFAULT '0',
AF4 decimal(6,4) NOT NULL DEFAULT '0',
signalAF4 int NOT NULL DEFAULT '0',
FC1 decimal(6,4) NOT NULL DEFAULT '0',
signalFC1 int NOT NULL DEFAULT '0',
FC2 decimal(6,4) NOT NULL DEFAULT '0',
signalFC2 int NOT NULL DEFAULT '0',
C3 decimal(6,4) NOT NULL DEFAULT '0',
signalC3 int NOT NULL DEFAULT '0',
C4 decimal(6,4) NOT NULL DEFAULT '0',
signalC4 int NOT NULL DEFAULT '0',
P3 decimal(6,4) NOT NULL DEFAULT '0',
signalP3 int NOT NULL DEFAULT '0',
P4 decimal(6,4) NOT NULL DEFAULT '0',
signalP4 int NOT NULL DEFAULT '0',
F3 decimal(6,4) NOT NULL DEFAULT '0',
signalF3 int NOT NULL DEFAULT '0',
F4 decimal(6,4) NOT NULL DEFAULT '0',
signalF4 int NOT NULL DEFAULT '0',
F7 decimal(6,4) NOT NULL DEFAULT '0',
signalF7 int NOT NULL DEFAULT '0',
F8 decimal(6,4) NOT NULL DEFAULT '0',
signalF8 int NOT NULL DEFAULT '0',
`timeStamp` datetime,
PRIMARY KEY(eegdataID),
FOREIGN KEY (userID) REFERENCES user(userID),
FOREIGN KEY (filterID) REFERENCES filter(filterID),
FOREIGN KEY (amplifierID) REFERENCES amplifier(amplifierID),
Foreign key (signalFP1) references `signal`(signalID),
Foreign key (signalFP2) references `signal`(signalID),
Foreign key (signalAF3) references `signal`(signalID),
Foreign key (signalAF4) references `signal`(signalID),
Foreign key (signalC3) references `signal`(signalID),
Foreign key (signalC4) references `signal`(signalID),
Foreign key (signalp3) references `signal`(signalID),
Foreign key (signalp4) references `signal`(signalID),
Foreign key (signalfc1) references `signal`(signalID),
Foreign key (signalfc2) references `signal`(signalID),
Foreign key (signalf3) references `signal`(signalID),
Foreign key (signalF4) references `signal`(signalID),
Foreign key (signalF7) references `signal`(signalID),
Foreign key (signalF8) references `signal`(signalID)
);

-- drop table eegresultdata;
-- Table for processed EEGData
CREATE TABLE EEGresultData (
eegdataID int NOT NULL AUTO_INCREMENT,
userID int NOT NULL DEFAULT '0',
FP1FP2 decimal(6,4) NOT NULL DEFAULT '0',
signalFP1FP2 int NOT NULL DEFAULT '0',
AF3AF4 decimal(6,4) NOT NULL DEFAULT '0',
signalAF3AF4 int NOT NULL DEFAULT '0',
c3c4 decimal(6,4) NOT NULL DEFAULT '0',
signalc3c4 int NOT NULL DEFAULT '0',
p3p4 decimal(6,4) NOT NULL DEFAULT '0',
signalp3p4 int NOT NULL DEFAULT '0',
fc1fc2 decimal(6,4) NOT NULL DEFAULT '0',
signalfc1fc2 int NOT NULL DEFAULT '0',
f3f4 decimal(6,4) NOT NULL DEFAULT '0',
signalf3f4 int NOT NULL DEFAULT '0',
f7f8 decimal(6,4) NOT NULL DEFAULT '0',
signalF7F8 int NOT NULL DEFAULT '0',
emotion int,
`timeStamp` datetime,
PRIMARY KEY(eegdataID),
FOREIGN KEY (userID) REFERENCES user(userID),
Foreign key (signalFP1FP2) references `signal`(signalID),
Foreign key (signalAF3AF4) references `signal`(signalID),
Foreign key (signalc3c4) references `signal`(signalID),
Foreign key (signalp3p4) references `signal`(signalID),
Foreign key (signalfc1fc2) references `signal`(signalID),
Foreign key (signalf3f4) references `signal`(signalID),
Foreign key (signalF7F8) references `signal`(signalID),
Foreign key (emotion) references emotion(emotionID)
);
-- drop table PredefinedSetEEG;
-- Table for predefined set of emotions with the EEG Data
CREATE TABLE PredefinedSetEEG (
predefinedID int NOT NULL AUTO_INCREMENT,
Emotion varchar(50) NOT NULL ,
minFP1FP2 decimal(6,4) NOT NULL ,
maxFP1FP2 decimal(6,4) NOT NULL,
minAF3AF4 decimal(6,4) NOT NULL ,
maxAF3AF4 decimal(6,4) NOT NULL ,
minc3c4 decimal(6,4) NOT NULL ,
maxc3c4 decimal(6,4) NOT NULL ,
minp3p4 decimal(6,4) NOT NULL ,
maxp3p4 decimal(6,4) NOT NULL ,
minfc1fc2 decimal(6,4) NOT NULL ,
maxfc1fc2 decimal(6,4) NOT NULL ,
minf3f4 decimal(6,4) NOT NULL ,
maxf3f4 decimal(6,4) NOT NULL ,
minf7f8 decimal(6,4) NOT NULL ,
maxf7f8 decimal(6,4) NOT NULL ,
PRIMARY KEY(predefinedID)
);

-- Table for pattern of neurons connection(connectome)
CREATE TABLE NeuronConnection (
connectomeId int NOT NULL AUTO_INCREMENT,
userid int,
connectome varchar(1000),
`timestamp` datetime,
PRIMARY KEY(connectomeId),
foreign key (userid) references user(userid)
);


-- Table for collecting GSR_EMG Data
CREATE TABLE GsrEmgData (
dataID int NOT NULL AUTO_INCREMENT,
userID int NOT NULL default '0',
GSRValue decimal(6,4) NOT NULL default '0.00',
EMGValue decimal(6,4) NOT NULL default '0.00',
emotionState INT DEFAULT 0,
`timeStamp` DATETIME,
PRIMARY KEY (dataID),
foreign key (userID) references user(userid),
foreign key (emotionstate) references emotion(emotionid)
/*,
FOREIGN KEY (userID) REFERENCES User(userID)*/
);


-- Table for predefined set of emotions with GSR_EMG Data
CREATE TABLE PredefinedSetGsrEmg (
predefinedID int NOT NULL AUTO_INCREMENT,
EmotionState varchar(256),
GSRMin decimal(6,4) NOT NULL default '0.00',
GSRMax decimal(6,4) NOT NULL default '0.00',
EMGMax decimal(6,4) NOT NULL default '0.00',
EMGMin decimal(6,4) NOT NULL default '0.00',
PRIMARY KEY (predefinedID)
);


-- Table for ECG_data
CREATE TABLE ECG_Data (
dataID int NOT NULL AUTO_INCREMENT,
userID int(255) NOT NULL DEFAULT '0',
frequency decimal(10,2) NOT NULL DEFAULT '0',
amplitude decimal(10,2) NOT NULL DEFAULT '0',
`timeStamp` datetime,
PRIMARY KEY (dataID),
foreign key (userid) references user(userid)
);

/*
-- Table for ECG_data
CREATE TABLE ECGResultData (
dataID int NOT NULL AUTO_INCREMENT,
userID int(255) NOT NULL DEFAULT '0',
frequency decimal(10,2) NOT NULL DEFAULT '0',
amplitude decimal(10,2) NOT NULL DEFAULT '0',
`timeStamp` datetime,
PRIMARY KEY (dataID)
);*/



-- Table for PredefinedSet_ECG
CREATE TABLE PredefinedSet_ECG(
predefinedID int NOT NULL AUTO_INCREMENT,
frequencyMax decimal(10,2) NOT NULL DEFAULT '0',
frequencyMin decimal(10,2) NOT NULL DEFAULT '0',
amplitudeMax decimal(10,2) NOT NULL DEFAULT '0',
amplitudeMin decimal(10,2) NOT NULL DEFAULT '0',
emotionState char(10) NOT NULL DEFAULT '0',
PRIMARY KEY (predefinedID)
);




-- Table for findinhg final emotion for user considering all the three signals for a particular time
CREATE TABLE USEREmotionMatch (
userID int NOT NULL DEFAULT 0,
`timeStamp` datetime,
EmotionStateEEG INT,
EmotionStateECG INT,
EmotionStateGSREMG INT,
FinalEmotion INT,
PRIMARY KEY (userID,`timeStamp`),
foreign key (userID) references user(userID),
foreign key (EmotionStateEEG) references emotion(emotionID),
foreign key (EmotionStateECG) references emotion(emotionID),
foreign key (EmotionStateGSREMG) references emotion(emotionID),
foreign key (FinalEmotion) references emotion(emotionID)
);

















