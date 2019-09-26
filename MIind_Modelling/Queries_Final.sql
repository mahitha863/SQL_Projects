select * from PredefinedSetEEG;

select * from EEGData;

select * from EEGresultData;

select * from ECG_Data;

select * from ECGResultData;

select * from GsrEmgData;

select *from USEREmotionMatch;


-- view to show all emotions and neuron connections together which can be used to retrieve data easily
create view readyToRetrieve
as
select USEREmotionMatch.userId,USEREmotionMatch.timeStamp,FinalEmotion as emotion,NeuronConnection.connectome
FROM USEREmotionMatch INNER JOIN NeuronConnection
ON USEREmotionMatch.userId=NeuronConnection.userID AND USEREmotionMatch.timeStamp=NeuronConnection.timeStamp;

select * FROM readyToRetrieve;


-- Procedure for finding an emotion for a user at a particular time
DROP PROCEDURE IF EXISTS findEmotion;
DELIMITER $$
CREATE PROCEDURE findEmotion(IN user INT, IN `time` dateTime, OUT emotionId INT)
BEGIN
    
	select FinalEmotion  FROM USEREmotionMatch WHERE userID=user AND `timeStamp`=`time`;
    SET emotionId = FinalEmotion;
    
END $$
DELIMITER ;

call findEmotion(1, '2019-04-02 23:54:11', @e);



-- Procedure for finding a connectome for a user at a particular time
DROP PROCEDURE IF EXISTS findConnectome;
DELIMITER $$
CREATE PROCEDURE findConnectome(IN user INT, IN time dateTime, OUT connection varchar(256))
BEGIN
    
	select connectome FROM NeuronConnection WHERE userID=user AND timeStamp=time;
    SET connection = connectome;
    
END $$
DELIMITER ;

call findConnectome(1, '2019-04-02 23:54:11', @connectome);



-- creating backup table for ECG_Data
CREATE TABLE ECG_Data_backup (
dataID int NOT NULL AUTO_INCREMENT,
userID int(255) NOT NULL DEFAULT '0',
frequency decimal(10,2) NOT NULL DEFAULT '0',
amplitude decimal(10,2) NOT NULL DEFAULT '0',
`timeStamp` datetime,
PRIMARY KEY (dataID),
foreign key (userid) references user(userid)
);

-- trigger to fill ECG_Data_backup table
DROP TRIGGER IF EXISTS tr_ECG_Data_backup;

DELIMITER $$
CREATE TRIGGER tr_ECG_Data_backup
BEFORE DELETE 
ON ECG_Data
FOR EACH ROW
BEGIN
	INSERT INTO ECG_Data_backup
    VALUES (OLD.dataID, OLD.userID, 
    OLD.frequency, OLD.amplitude, OLD.timeStamp);
END;
$$

-- creating backup table for NeuronConnection
CREATE TABLE NeuronConnection_backup (
connectomeId int NOT NULL AUTO_INCREMENT,
userid int,
connectome varchar(1000),
`timestamp` datetime,
PRIMARY KEY(connectomeId),
foreign key (userid) references user(userid)
);


-- trigger for filling NeuronConnection_backup table
DROP TRIGGER IF EXISTS tr_NeuronConnection_backup;-

DELIMITER $$
CREATE TRIGGER tr_NeuronConnection_backup
BEFORE DELETE 
ON NeuronConnection
FOR EACH ROW
BEGIN
	INSERT INTO NeuronConnection_backup
    VALUES (OLD.connectomeId, OLD.userid, 
    OLD.connectome, OLD.timeStamp);
END;
$$


-- creating backup table for USEREmotionMatch
CREATE TABLE USEREmotionMatch_backup (
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


-- trigger to fill USEREmotionMatch_backup table
DROP TRIGGER IF EXISTS tr_USEREmotionMatch_backup;

DELIMITER $$
CREATE TRIGGER tr_USEREmotionMatch_backup
BEFORE DELETE 
ON USEREmotionMatch
FOR EACH ROW
BEGIN
	INSERT INTO USEREmotionMatch_backup
    VALUES ( OLD.userid,OLD.timeStamp, OLD.EmotionStateEEG,
    OLD.EmotionStateECG,OLD.EmotionStateGSREMG,OLD.FinalEmotion );
END;
$$


-- check users who felt happy
select count(*) from user U
inner join useremotionmatch e on u.userid = e.userid
inner join emotion emo on e.finalemotion = emo.emotionid
where emo.emotionname = 'HAPPY';

-- check which amplifiers are used when user felt happy
select * from amplifier amp
inner join eegdata eeg on amp.amplifierid = eeg.amplifierid
inner join eegresultdata eegresult on eegresult.eegdataID = eeg.eegdataid
inner join useremotionmatch us on us.emotionstateeeg = eegresult.emotion
inner join emotion emo on us.finalemotion = emo.emotionid
where emo.emotionname = 'happy';

