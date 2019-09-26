/* Script to insert data into database Brain */

Use Brain;


-- Inserting data into Adddress table
INSERT INTO Address VALUES (101,"12 Smith street", "12B cold Street", "Boston ","MA", 098664);
INSERT INTO Address VALUES (102,"89 alley street", "", "Boston ","NY", 012324);
INSERT INTO Address VALUES (103,"12 venom street", "", "Boston ","MN", 123894);
INSERT INTO Address VALUES (104,"12 kala street", "", "Boston ","MN", 887967);
INSERT INTO Address VALUES (105,"12 Smith street", "1B old Street", "Boston ","CA", 456834);
INSERT INTO Address VALUES (106,"62 loba street", "", "Boston ","OH", 785646);
INSERT INTO Address VALUES (107,"1 Black street", "12B eve Street", "Boston ","MA", 078984);
INSERT INTO Address VALUES (108,"78 Boylston street", "", "Boston ","MA", 01894);
INSERT INTO Address VALUES (109,"14MN Smith street", "", "Boston ","TX", 01234);
INSERT INTO Address VALUES (110,"104A sand street", "", "Boston ","CA", 017876);

-- Inserting data into User table
INSERT INTO User VALUES (1,'mahi', 'F' ,'25',101);
INSERT INTO User VALUES (2,'aiss', 'F' ,'23',102);
INSERT INTO User VALUES (3,'venk', 'M' ,'27',103);
INSERT INTO User VALUES (4,'abi', 'F' ,'15',104);
INSERT INTO User VALUES (5,'anu', 'F' ,'75',105);
INSERT INTO User VALUES (6,'balu', 'm' ,'59',106);
INSERT INTO User VALUES (7,'banu', 'F' ,'56',107);
INSERT INTO User VALUES (8,'don', 'm' ,'11',108);
INSERT INTO User VALUES (9,'ennie', 'F' ,'9',109);
INSERT INTO User VALUES (10,'mennie', 'm' ,'42',110);




--       ***************************************************************** INSERT EEG DATA START  ***************************************************


INSERT INTO `Filter` VALUES (401,'LOW PASS','20 Hz', '500 samples per second'  ); 
INSERT INTO `Filter` VALUES (402,'LOW PASS','40 Hz', '500 samples per second'  );  
INSERT INTO `Filter` VALUES(403,'LOW PASS','100 Hz', '500 samples per second'  ); 
INSERT INTO `Filter` VALUES (404,'LOW PASS','150 Hz', '500 samples per second'  );


INSERT INTO amplifier VALUES (501,'-3.3 to +3.3','-1 to 1',3300); -- AF= (output  VOLTAGE/ input VOLTAGE)
INSERT INTO amplifier VALUES (502,'-4.7 to +4.7','-1 to 1',4700);
INSERT INTO amplifier VALUES (503,'-12 to +12','-1 to 1',12000);
INSERT INTO amplifier VALUES (504,'-24 to +24','-1 to 1',24000);

-- Inserting Data into PredefinedSetEEG
INSERT INTO PredefinedSetEEG VALUES(1001,'HAPPY', 1.2,2,1,3,4,5,1,2,1.3,1.5,3,4,1,2);
INSERT INTO PredefinedSetEEG VALUES(1002,'SAD', -2,-1.2,-3,-1,-5,0,-2,-1,-1.5,-1.3,-4,-3,-2,-1);
INSERT INTO PredefinedSetEEG VALUES(1003,'FEAR', -3,-2,3,4,-5,0,1,1.4,1.3,5.5,3,3.4,1.6,2);
INSERT INTO PredefinedSetEEG VALUES(1004,'ANGER', 3,4,-4,-3,-5,0,1,2,1.3,2.4,3.2,4.4,1.2,2);


-- Inserting different types of signals in signal table
INSERT INTO `signal` values(1001,'Alpha');
INSERT INTO `signal` values(1002,'Beta');
INSERT INTO `signal` values(1003,'Gamma');
INSERT INTO `signal` values(1004,'Theta');

INSERT INTO EMOTION values (0,'UNIDENTIFIED');
INSERT INTO EMOTION values (1,'HAPPY');
INSERT INTO EMOTION values (2,'SAD');
INSERT INTO EMOTION values (3,'ANGER');
INSERT INTO EMOTION values (4,'FEAR');

-- Function to determine the signal id
delimiter $$
create function gt_signal (input_signal varchar(20))
	returns int
begin
	return (select signalID from `signal` where signalname=input_signal);
end;
$$
delimiter ; 


-- Function to find asymmerty index
drop function IF EXISTS gt_div ;
delimiter $$
create function gt_div (input_num1 decimal(6,4),input_num2 decimal(6,4))
	returns decimal(6,4)
begin
	return input_num1/input_num2;
end;
$$
delimiter ;

-- Function to determine emotionName
drop function IF EXISTS emotionNameCalc;
delimiter $$
CREATE function emotionNameCalc(FP1FP2 decimal,AF3AF4 decimal,c3c4 decimal,p3p4 decimal,fc1fc2 decimal, F3F4 decimal, f7f8 decimal, 
SignalFP1FP2 int, SignalAF3AF4 int,Signalc3c4 int,Signalp3p4 int,Signalfc1fc2 int,SignalF3F4 int, Signalf7f8 int)
returns int
BEGIN

  DECLARE HAPPY INT DEFAULT 0;
    DECLARE SAD INT DEFAULT 0;
    DECLARE FEAR INT DEFAULT 0;
    DECLARE ANGER INT DEFAULT 0;
    Declare val varchar(80);
    DECLARE EMOTIONID INT DEFAULT 0;
    
	if FP1FP2 > (select minFP1FP2 from PredefinedSetEEG where emotion = 'HAPPY') AND FP1FP2 <(select maxFP1FP2 from PredefinedSetEEG where emotion = 'HAPPY') AND SignalFP1FP2 = gt_signal('Alpha') 
		Then set HAPPY = HAPPY+14.25;
        
     else if FP1FP2 > (select minFP1FP2 from PredefinedSetEEG where emotion = 'SAD') AND FP1FP2 <(select maxFP1FP2 from PredefinedSetEEG where emotion = 'SAD') AND SignalFP1FP2 = gt_signal('Alpha') 
			Then set SAD = SAD+14.25;
            
	else if FP1FP2 > (select minFP1FP2 from PredefinedSetEEG where emotion = 'FEAR') AND FP1FP2 <(select maxFP1FP2 from PredefinedSetEEG where emotion = 'FEAR') AND SignalFP1FP2 = gt_signal('Alpha') 
				Then set FEAR = FEAR + 14.25;
                
	else if FP1FP2 > (select minFP1FP2 from PredefinedSetEEG where emotion = 'ANGER') AND FP1FP2 <(select maxFP1FP2 from PredefinedSetEEG where emotion = 'ANGER') AND SignalFP1FP2 = gt_signal('Alpha') 
				Then set ANGER = ANGER + 14.25;
                end if;
                end if;
                end if;
                end if;
                
	if AF3AF4 > (select minAF3AF4 from PredefinedSetEEG where emotion = 'HAPPY') AND AF3AF4 <(select maxAF3AF4 from PredefinedSetEEG where emotion = 'HAPPY') AND SignalAF3AF4 = gt_signal('Alpha') 
		Then set HAPPY = HAPPY+14.25;
        
     else if AF3AF4 > (select minAF3AF4 from PredefinedSetEEG where emotion = 'SAD') AND AF3AF4 <(select maxAF3AF4 from PredefinedSetEEG where emotion = 'SAD') AND SignalAF3AF4 = gt_signal('Alpha') 
			Then set SAD = SAD+14.25;
            
	else if AF3AF4 > (select minAF3AF4 from PredefinedSetEEG where emotion = 'FEAR') AND AF3AF4 <(select maxAF3AF4 from PredefinedSetEEG where emotion = 'FEAR') AND SignalAF3AF4 = gt_signal('Alpha') 
				Then set FEAR = FEAR + 14.25;
                
	else if AF3AF4 > (select minAF3AF4 from PredefinedSetEEG where emotion = 'ANGER') AND AF3AF4 <(select maxAF3AF4 from PredefinedSetEEG where emotion = 'ANGER') AND SignalAF3AF4 = gt_signal('Alpha') 
				Then set ANGER = ANGER + 14.25;
                end if;
                end if;
                end if;
                end if;
                
	if c3c4 > (select minc3c4 from PredefinedSetEEG where emotion = 'HAPPY') AND c3c4 <(select maxc3c4 from PredefinedSetEEG where emotion = 'HAPPY') AND Signalc3c4 = gt_signal('Alpha') 
		Then set HAPPY = HAPPY+14.25;
        
     else if c3c4 > (select minc3c4 from PredefinedSetEEG where emotion = 'SAD') AND c3c4 <(select maxc3c4 from PredefinedSetEEG where emotion = 'SAD') AND Signalc3c4 = gt_signal('Alpha') 
			Then set SAD = SAD+14.25;
            
	else if c3c4 > (select minc3c4 from PredefinedSetEEG where emotion = 'FEAR') AND c3c4 <(select maxc3c4 from PredefinedSetEEG where emotion = 'FEAR') AND Signalc3c4 = gt_signal('Alpha') 
				Then set FEAR = FEAR + 14.25;
                
	else if c3c4 > (select minc3c4 from PredefinedSetEEG where emotion = 'ANGER') AND c3c4 <(select maxc3c4 from PredefinedSetEEG where emotion = 'ANGER') AND Signalc3c4 = gt_signal('Alpha') 
				Then set ANGER = ANGER + 14.25;
                end if;
                end if;
                end if;
                end if;
                
	if p3p4 > (select minp3p4 from PredefinedSetEEG where emotion = 'HAPPY') AND p3p4 <(select maxp3p4 from PredefinedSetEEG where emotion = 'HAPPY') AND Signalp3p4 = gt_signal('Alpha')
		Then set HAPPY = HAPPY+14.25;
        
     else if p3p4 > (select minp3p4 from PredefinedSetEEG where emotion = 'SAD') AND p3p4 <(select maxp3p4 from PredefinedSetEEG where emotion = 'SAD') AND Signalp3p4 = gt_signal('Alpha') 
			Then set SAD = SAD+14.25;
            
	else if p3p4 > (select minp3p4 from PredefinedSetEEG where emotion = 'FEAR') AND p3p4 <(select maxp3p4 from PredefinedSetEEG where emotion = 'FEAR') AND Signalp3p4 = gt_signal('Alpha') 
				Then set FEAR = FEAR + 14.25;
                
	else if p3p4 > (select minp3p4 from PredefinedSetEEG where emotion = 'ANGER') AND p3p4 <(select maxp3p4 from PredefinedSetEEG where emotion = 'ANGER') AND Signalp3p4 = gt_signal('Alpha') 
				Then set ANGER = ANGER + 14.25;
                end if;
                end if;
                end if;
                end if;
                
	if fc1fc2 > (select minfc1fc2 from PredefinedSetEEG where emotion = 'HAPPY') AND fc1fc2 <(select maxfc1fc2 from PredefinedSetEEG where emotion = 'HAPPY') AND Signalfc1fc2 = gt_signal('Alpha') 
		Then set HAPPY = HAPPY+14.25;
        
     else if fc1fc2 > (select minfc1fc2 from PredefinedSetEEG where emotion = 'SAD') AND fc1fc2 <(select maxfc1fc2 from PredefinedSetEEG where emotion = 'SAD') AND Signalfc1fc2 = gt_signal('Alpha') 
			Then set SAD = SAD+14.25;
            
	else if fc1fc2 > (select minfc1fc2 from PredefinedSetEEG where emotion = 'FEAR') AND fc1fc2 <(select maxfc1fc2 from PredefinedSetEEG where emotion = 'FEAR') AND Signalfc1fc2 = gt_signal('Alpha') 
				Then set FEAR = FEAR + 14.25;
                
	else if fc1fc2 > (select minFP1FP2 from PredefinedSetEEG where emotion = 'ANGER') AND FP1FP2 <(select maxfc1fc2 from PredefinedSetEEG where emotion = 'ANGER') AND Signalfc1fc2 = gt_signal('Alpha') 
				Then set ANGER = ANGER + 14.25;
                end if;
                end if;
                end if;
                end if;
                
	if F3F4 > (select minF3F4 from PredefinedSetEEG where emotion = 'HAPPY') AND F3F4 <(select maxF3F4 from PredefinedSetEEG where emotion = 'HAPPY')  AND SignalF3F4 = gt_signal('Alpha') 
		Then set HAPPY = HAPPY+14.25;
        
     else if F3F4 > (select minF3F4 from PredefinedSetEEG where emotion = 'SAD') AND F3F4 <(select maxF3F4 from PredefinedSetEEG where emotion = 'SAD') AND SignalF3F4 = gt_signal('Alpha') 
			Then set SAD = SAD+14.25;
            
	else if F3F4 > (select minF3F4 from PredefinedSetEEG where emotion = 'FEAR') AND F3F4 <(select maxF3F4 from PredefinedSetEEG where emotion = 'FEAR') AND SignalF3F4 = gt_signal('Alpha') 
				Then set FEAR = FEAR + 14.25;
                
	else if F3F4 > (select minF3F4 from PredefinedSetEEG where emotion = 'ANGER') AND F3F4 <(select maxF3F4 from PredefinedSetEEG where emotion = 'ANGER') AND SignalF3F4 = gt_signal('Alpha') 
				Then set ANGER = ANGER + 14.25;
                end if;
                end if;
                end if;
                end if;
                
	if f7f8 > (select minf7f8 from PredefinedSetEEG where emotion = 'HAPPY') AND f7f8 <(select maxf7f8 from PredefinedSetEEG where emotion = 'HAPPY') AND Signalf7f8 = gt_signal('Alpha') 
		Then set HAPPY = HAPPY+14.25;
        
	else if f7f8 > (select minf7f8 from PredefinedSetEEG where emotion = 'SAD') AND f7f8 <(select maxf7f8 from PredefinedSetEEG where emotion = 'SAD') AND Signalf7f8 = gt_signal('Alpha') 
		Then set SAD = SAD+14.25;
        
	else if f7f8 > (select minf7f8 from PredefinedSetEEG where emotion = 'FEAR') AND f7f8 <(select maxf7f8 from PredefinedSetEEG where emotion = 'FEAR') AND Signalf7f8 = gt_signal('Alpha') 
		Then set FEAR = FEAR + 14.25;
        
	else if f7f8 > (select minf7f8 from PredefinedSetEEG where emotion = 'ANGER') AND f7f8 <(select maxf7f8 from PredefinedSetEEG where emotion = 'ANGER') AND Signalf7f8 = gt_signal('Alpha') 
		Then set ANGER = ANGER + 14.25;
		end if;
        end if;
        end if;
        end if;
			
            if HAPPY>SAD AND HAPPY> FEAR And HAPPY > ANGER
            then set val ='HAPPY';
            else if SAD>HAPPY and SAD>FEAR and SAD > ANGER 
            then set val = 'SAD';
            else if FEAR>HAPPY and FEAR>SAD and FEAR>ANGER
            then set val = 'FEAR';
            else if ANGER>HAPPY and ANGER>FEAR and ANGER>SAD
            then set val = 'ANGER';
            else set val = 'UNIDENTIFIED';
            end if;
            end if;
            end if;
            end if;
            
             RETURN RETURNEMOTIONID(val);
            
END
$$ ;

-- Function to return emotion id for a given emotion name for a given emotion name from emotion table
DELIMITER $$
CREATE FUNCTION RETURNEMOTIONID(VAL VARCHAR(25))
RETURNS INT

BEGIN
		RETURN (SELECT EMOTIONID FROM EMOTION WHERE EMOTIONNAME = VAL);
END
$$;

-- Function to return emotion name for a given emotion id for a given emotion name from emotion table
DELIMITER $$
CREATE FUNCTION RETURNEMOTIONNAME(VAL INT)
RETURNS VARCHAR(25)

BEGIN
		RETURN (SELECT EMOTIONNAME FROM EMOTION WHERE EMOTIONID = VAL);
END
$$;


-- Inserting Data into EEGresultData using trigger tr_eeg_result_data
drop trigger IF EXISTS tr_eeg_result_data;
DELIMITER $$
CREATE TRIGGER tr_eeg_result_data
AFTER INSERT
ON eegdata
FOR EACH ROW
BEGIN
       declare valfp1fp2 decimal;
       declare valAF3AF4 decimal;
       declare valc3c4 decimal;
       declare valp3p4 decimal;
       declare valfc1fc2 decimal;
       declare valf7f8 decimal;
       declare valf3f4 decimal;
       
       set valfp1fp2 = gt_div(NEW.FP1,NEW.FP2);
       set valAF3AF4 = gt_div(NEW.AF3,NEW.AF4);
       set valc3c4 = gt_div(NEW.C3,NEW.C4);
       set valp3p4 = gt_div(NEW.P3,NEW.P4);
       set valfc1fc2 = gt_div(NEW.FC1,NEW.FC2);
       set valf7f8 = gt_div(NEW.F7,NEW.F8);
       set valf3f4 = gt_div(NEW.F3,NEW.F4);

	INSERT INTO EEGresultData
    VALUES (NEW.eegdataID,NEW.userID,valfp1fp2, NEW.signalFP1, valAF3AF4, NEW.signalAF3, 
    valc3c4, NEW.signalC3 , valp3p4, NEW.signalP3 ,valfc1fc2, NEW.signalFC1 ,
    valf3f4, NEW.signalF3 ,valf7f8, NEW.signalF7, 
    emotionNameCalc(valfp1fp2, valAF3AF4, valc3c4, valp3p4, valfc1fc2, valf3f4, valf7f8, 
    NEW.signalFP1,NEW.signalAF3,NEW.signalC3,NEW.signalP3,NEW.signalFC1,NEW.signalF3,NEW.signalF7) ,NEW.`timeStamp`);

END;
$$,
DELIMITER ;

-- select * from EEGData;
select * from EEGresultData;

-- Inserting Data into EEGData table
-- INSERT INTO EEGData VALUES(1000001,4.4235,gt_signal('Alpha'),4.8902,gt_signal('Alpha'),2.65,gt_signal('Alpha'),6.236,gt_signal('Alpha'),-2.543,gt_signal('Alpha'),0.452,gt_signal('Alpha'),2.2563,gt_signal('Alpha'),2.426,gt_signal('Alpha'),5.5357,gt_signal('Alpha'),-1.543,gt_signal('Alpha'),-5.345,gt_signal('Alpha'),7.453,gt_signal('Alpha'),5.735,gt_signal('Alpha'),-5.538,gt_signal('Alpha'),-8.347,gt_signal('Alpha'),CURRENT_TIMESTAMP());
INSERT INTO EEGData VALUES(1,1,401,501,6.4855,gt_signal('Alpha'),-0.8352,gt_signal('Alpha'),4.0965,gt_signal('Alpha'),1.7523,gt_signal('Alpha'),0.353,gt_signal('Alpha'),0.642,gt_signal('Alpha'),8.154,gt_signal('Alpha'),5.75100,gt_signal('Alpha'),8.234,gt_signal('Alpha'),-1.458,gt_signal('Alpha'),-0.045,gt_signal('Alpha'),5.324,gt_signal('Alpha'),4.213,gt_signal('Alpha'),-2.135,gt_signal('Alpha'),'2019-04-02 23:54:11');
INSERT INTO EEGData VALUES(null,9,401,502,4.1537,gt_signal('Alpha'),4.286,gt_signal('Alpha'),-1.726,gt_signal('Alpha'),4.178,gt_signal('Alpha'),0.087,gt_signal('Alpha'),6.271,gt_signal('Alpha'),.0324,gt_signal('Alpha'),5.716,gt_signal('Alpha'),-2.478,gt_signal('Alpha'),10.248,gt_signal('Alpha'),4.892,gt_signal('Alpha'),5.327,gt_signal('Alpha'),-2.125,gt_signal('Alpha'),-1.245,gt_signal('Alpha'),'2019-04-03 23:54:11');
INSERT INTO EEGData VALUES(null,3,402,502,3.4197,gt_signal('Alpha'),-1.426,gt_signal('Alpha'),-2.6575,gt_signal('Alpha'),1.2716,gt_signal('Alpha'),-1.7264,gt_signal('Alpha'),1.1942,gt_signal('Alpha'),2.0042,gt_signal('Alpha'),5.1723,gt_signal('Alpha'),-1.440,gt_signal('Alpha'),2.0054,gt_signal('Alpha'),2.2143,gt_signal('Alpha'),1.1156,gt_signal('Alpha'),2.1462,gt_signal('Alpha'),0.5403,gt_signal('Alpha'),'2019-04-04 23:54:11');
INSERT INTO EEGData VALUES(null,4,402,502,15.2189,gt_signal('Alpha'),7.1143,gt_signal('Alpha'),0.0045,gt_signal('Alpha'),1.22,gt_signal('Alpha'),-7.57,gt_signal('Alpha'),-.315,gt_signal('Alpha'),2.4156,gt_signal('Alpha'),2.14896,gt_signal('Alpha'),8.2519,gt_signal('Alpha'),-7.2536,gt_signal('Alpha'),-5.1429,gt_signal('Alpha'),2.0016,gt_signal('Alpha'),-1.5550,gt_signal('Alpha'),1.2419,gt_signal('Alpha'),'2019-04-05 23:54:11');
INSERT INTO EEGData VALUES(null,2,403,503,2.4158,gt_signal('Alpha'),4.1249,gt_signal('Alpha'),-4.1792,gt_signal('Alpha'),4.1276,gt_signal('Alpha'),1.1149,gt_signal('Alpha'),7.4138,gt_signal('Alpha'),14.22890,gt_signal('Alpha'),2.4419,gt_signal('Alpha'),-5.2249,gt_signal('Alpha'),-2.2275,gt_signal('Alpha'),-4.2298,gt_signal('Alpha'),5.3489,gt_signal('Alpha'),-2.1235,gt_signal('Alpha'),2.0103,gt_signal('Alpha'),'2019-04-06 23:54:11');
INSERT INTO EEGData VALUES(null,5,402,502,1.2403,gt_signal('Alpha'),-1.0795,gt_signal('Alpha'),5.1426,gt_signal('Alpha'),1.4462,gt_signal('Alpha'),0.4400,gt_signal('Alpha'),2.11364,gt_signal('Alpha'),1.4413,gt_signal('Alpha'),0.1289,gt_signal('Alpha'),4.1887,gt_signal('Alpha'),-1.4286,gt_signal('Alpha'),7.2246,gt_signal('Alpha'),4.2198,gt_signal('Alpha'),4.1279,gt_signal('Alpha'),3.1429,gt_signal('Alpha'),'2019-04-07 23:54:11');
INSERT INTO EEGData VALUES(null,7,401,501,3.1052,gt_signal('Alpha'),7.123,gt_signal('Alpha'),.4123,gt_signal('Alpha'),-.4193,gt_signal('Alpha'),2.0014,gt_signal('Alpha'),2.1856,gt_signal('Alpha'),.01284,gt_signal('Alpha'),5.2288,gt_signal('Alpha'),4.3326,gt_signal('Alpha'),8.4625,gt_signal('Alpha'),-.4456,gt_signal('Alpha'),7.0123,gt_signal('Alpha'),3.1199,gt_signal('Alpha'),7.2654,gt_signal('Alpha'),'2019-04-08 23:54:11');
INSERT INTO EEGData VALUES(null,6,402,502,13.4197,gt_signal('Alpha'),-1.426,gt_signal('Alpha'),-2.6575,gt_signal('Alpha'),1.2716,gt_signal('Alpha'),-1.7264,gt_signal('Alpha'),1.1942,gt_signal('Alpha'),2.0042,gt_signal('Alpha'),5.1723,gt_signal('Alpha'),-1.440,gt_signal('Alpha'),2.0054,gt_signal('Alpha'),2.2143,gt_signal('Alpha'),1.1156,gt_signal('Alpha'),2.1462,gt_signal('Alpha'),0.5403,gt_signal('Alpha'),'2019-04-09 23:54:11');
INSERT INTO EEGData VALUES(null,10,402,502,5,gt_signal('Alpha'),3,gt_signal('Alpha'),5,gt_signal('Alpha'),3,gt_signal('Alpha'),5,gt_signal('Alpha'),3,gt_signal('Alpha'),5,gt_signal('Alpha'),3,gt_signal('Alpha'),5,gt_signal('Alpha'),3,gt_signal('Alpha'),5,gt_signal('Alpha'),3,gt_signal('Alpha'),5,gt_signal('Alpha'),3,gt_signal('Alpha'),'2019-04-10 23:54:11');
INSERT INTO EEGData VALUES(null,1,401,501,6.4855,gt_signal('Alpha'),-0.8352,gt_signal('Alpha'),4.0965,gt_signal('Alpha'),1.7523,gt_signal('Alpha'),0.353,gt_signal('Alpha'),0.642,gt_signal('Alpha'),8.154,gt_signal('Alpha'),5.75100,gt_signal('Alpha'),8.234,gt_signal('Alpha'),-1.458,gt_signal('Alpha'),-0.045,gt_signal('Alpha'),5.324,gt_signal('Alpha'),4.213,gt_signal('Alpha'),-2.135,gt_signal('Alpha'),'2019-04-02 23:54:12');
INSERT INTO EEGData VALUES(null,1,401,501,6.4855,gt_signal('Alpha'),-0.8352,gt_signal('Alpha'),4.0965,gt_signal('Alpha'),1.7523,gt_signal('Alpha'),0.353,gt_signal('Alpha'),0.642,gt_signal('Alpha'),8.154,gt_signal('Alpha'),5.75100,gt_signal('Alpha'),8.234,gt_signal('Alpha'),-1.458,gt_signal('Alpha'),-0.045,gt_signal('Alpha'),5.324,gt_signal('Alpha'),4.213,gt_signal('Alpha'),-2.135,gt_signal('Alpha'),'2019-04-02 23:54:13');


-- Inserting Data into NeuronConnection table
INSERT INTO NeuronConnection VALUES(100001,1,'a10_d37_b45_k34', '2019-04-02 23:54:11');
INSERT INTO NeuronConnection VALUES(100002,9,'z104_e7_k645_h9409', '2019-04-03 23:54:11');
INSERT INTO NeuronConnection VALUES(100003,3,'r67_v543_m3213_h874_o762', '2019-04-04 23:54:11');
INSERT INTO NeuronConnection VALUES(100004,4,'u5342_y763_h76_j8_p89_h32_t12', '2019-04-05 23:54:11');
INSERT INTO NeuronConnection VALUES(100005,2,'i37_s54_b32_l405_m83', '2019-04-06 23:54:11');
INSERT INTO NeuronConnection VALUES(100006,5,'b621_w762_v42_k34', '2019-04-07 23:54:11');
INSERT INTO NeuronConnection VALUES(100007,7,'b90_j723_h981_c404', '2019-04-08 23:54:11');
INSERT INTO NeuronConnection VALUES(100008,6,'x762_w93_i981_q91', '2019-04-09 23:54:11');
INSERT INTO NeuronConnection VALUES(100009,10,'q987_b712_p8215_z83013', '2019-04-10 23:54:11');


--       ***************************************************************** INSERT EEG DATA END  ******************************************************





--       ******************************************************************INSERT ECG DATA START*****************************************************************

INSERT INTO PredefinedSet_ECG VALUES(101, 40,10,  0.25,0.2,'HAPPY');
INSERT INTO PredefinedSet_ECG VALUES(102, 10,0,   0.2,0.0,'SAD');
INSERT INTO PredefinedSet_ECG VALUES(103, 100,40, 1.5,0.3,'FEAR');
INSERT INTO PredefinedSet_ECG VALUES(104, 120,100,3.5,1.5,'ANGER');



-- Inserting Data into ECG_Data
INSERT INTO ECG_Data VALUES (201,1,30,0.24,'2019-04-02 23:54:11'); 
INSERT INTO ECG_Data VALUES ( 202,9,5,0.1,'2019-04-03 23:54:11');
INSERT INTO ECG_Data VALUES ( 203,3,50,0.4,'2019-04-04 23:54:11');
INSERT INTO ECG_Data VALUES ( 204,4,70,0.4,'2019-04-05 23:54:11');
INSERT INTO ECG_Data VALUES ( 205,2,50,0.94,'2019-04-06 23:54:11'); -- HAPPY error freq
INSERT INTO ECG_Data VALUES ( 206,5,30,0.19,'2019-04-07 23:54:11'); -- HAPPY error Amp
INSERT INTO ECG_Data VALUES ( 207,7,5,9.9,'2019-04-08 23:54:11'); --  SAD
INSERT INTO ECG_Data VALUES ( 208,6,50,0.5,'2019-04-09 23:54:11'); -- FEAR
INSERT INTO ECG_Data VALUES ( 209,10,90,5.5,'2019-04-10 23:54:11'); -- ANGER
INSERT INTO ECG_Data VALUES (210,1,30,0.24,'2019-04-02 23:54:12'); 
INSERT INTO ECG_Data VALUES (211,1,30,0.24,'2019-04-02 23:54:13'); 



DROP FUNCTION IF EXISTS emotionStateDetectECG
DELIMITER $$
CREATE FUNCTION emotionStateDetectECG(frequency decimal(6,4),amplitude decimal(6,4))
RETURNS INT
BEGIN
Declare state varchar(256);

IF (frequency>(SELECT frequencyMin FROM PredefinedSet_ECG WHERE EmotionState='HAPPY') && frequency<(SELECT frequencyMax FROM PredefinedSet_ECG WHERE EmotionState='HAPPY')
         &&
	  amplitude>(SELECT amplitudeMin FROM PredefinedSet_ECG WHERE EmotionState='HAPPY') && amplitude<(SELECT amplitudeMax FROM PredefinedSet_ECG WHERE EmotionState='HAPPY'))
  THEN SET state = 'HAPPY';
ELSE IF (frequency>(SELECT frequencyMin FROM PredefinedSet_ECG WHERE EmotionState='SAD') && frequency<(SELECT frequencyMax FROM PredefinedSet_ECG WHERE EmotionState='SAD')
         &&
	  amplitude>(SELECT amplitudeMin FROM PredefinedSet_ECG WHERE EmotionState='SAD') && amplitude<(SELECT amplitudeMax FROM PredefinedSet_ECG WHERE EmotionState='SAD'))
  THEN SET state = 'SAD';
ELSE IF (frequency>(SELECT frequencyMin FROM PredefinedSet_ECG WHERE EmotionState='FEAR') && frequency<(SELECT frequencyMax FROM PredefinedSet_ECG WHERE EmotionState='FEAR')
         &&
	  amplitude>(SELECT amplitudeMin FROM PredefinedSet_ECG WHERE EmotionState='FEAR') && amplitude<(SELECT amplitudeMax FROM PredefinedSet_ECG WHERE EmotionState='FEAR'))
  THEN SET state = 'FEAR';
ELSE IF (frequency>(SELECT frequencyMin FROM PredefinedSet_ECG WHERE EmotionState='ANGER') && frequency<(SELECT frequencyMax FROM PredefinedSet_ECG WHERE EmotionState='ANGER')
         &&
	  amplitude>(SELECT amplitudeMin FROM PredefinedSet_ECG WHERE EmotionState='ANGER') && amplitude<(SELECT amplitudeMax FROM PredefinedSet_ECG WHERE EmotionState='ANGER'))
  THEN SET state = 'ANGER';
ELSE 
 SET state = 'UNIDENTIFIED';
END IF;
END IF;
END IF;
END IF;

RETURN RETURNEMOTIONID(state);

END
$$ 
DELIMITER ;







create view ECGResultData
as
SELECT dataID,userID,`timeStamp`,frequency,amplitude,emotionStateDetectECG(frequency,amplitude) AS emotionState
FROM ECG_Data;

select * from ECGResultData;

/*
INSERT INTO ECGResultData
SELECT * FROM ECGEmotionCal;
*/

--       ******************************************************************INSERT ECG DATA END*****************************************************************




--       ******************************************************************INSERT GSR EMG DATA START*****************************************************************

-- Inserting data into predefined set for GSR and EMG emotion recognition pattern
INSERT INTO PredefinedSetGsrEmg VALUES(101,'HAPPY', 0.72,2.5,1.25,1.13);
INSERT INTO PredefinedSetGsrEmg VALUES(102,'SAD', -0.75,-0.15,0.58,0.07);
INSERT INTO PredefinedSetGsrEmg VALUES(103,'FEAR', 0.45,1.25,-0.18,-0.88);
INSERT INTO PredefinedSetGsrEmg VALUES(104,'ANGER', -1.5,-0.95,-1.25,-2.35);


-- Function to determine the emotion state of the signal values obtained from GSR EMG
-- DROP FUNCTION IF EXISTS emotionStateDetect
DELIMITER $$
CREATE FUNCTION emotionStateDetect(gsr decimal(6,4),emg decimal(6,4))
 RETURNS INT
BEGIN
Declare state varchar(80);

IF (gsr>(SELECT GSRMin FROM PredefinedSetGsrEmg WHERE EmotionState='HAPPY') && gsr<(SELECT GSRMax FROM PredefinedSetGsrEmg WHERE EmotionState='HAPPY')
         &&
	  emg>(SELECT EMGMin FROM PredefinedSetGsrEmg WHERE EmotionState='HAPPY') && emg<(SELECT EMGMax FROM PredefinedSetGsrEmg WHERE EmotionState='HAPPY'))
  THEN SET state = 'HAPPY';
ELSE IF (gsr>(SELECT GSRMin FROM PredefinedSetGsrEmg WHERE EmotionState='SAD') && gsr<(SELECT GSRMax FROM PredefinedSetGsrEmg WHERE EmotionState='SAD')
         &&
	  emg>(SELECT EMGMin FROM PredefinedSetGsrEmg WHERE EmotionState='SAD') && emg<(SELECT EMGMax FROM PredefinedSetGsrEmg WHERE EmotionState='SAD'))
  THEN SET state = 'SAD';
ELSE IF (gsr>(SELECT GSRMin FROM PredefinedSetGsrEmg WHERE EmotionState='FEAR') && gsr<(SELECT GSRMax FROM PredefinedSetGsrEmg WHERE EmotionState='FEAR')
         &&
	  emg>(SELECT EMGMin FROM PredefinedSetGsrEmg WHERE EmotionState='FEAR') && emg<(SELECT EMGMax FROM PredefinedSetGsrEmg WHERE EmotionState='FEAR'))
  THEN SET state = 'FEAR';
ELSE IF (gsr>(SELECT GSRMin FROM PredefinedSetGsrEmg WHERE EmotionState='ANGER') && gsr<(SELECT GSRMax FROM PredefinedSetGsrEmg WHERE EmotionState='ANGER')
         &&
	  emg>(SELECT EMGMin FROM PredefinedSetGsrEmg WHERE EmotionState='ANGER') && emg<(SELECT EMGMax FROM PredefinedSetGsrEmg WHERE EmotionState='ANGER'))
  THEN SET state = 'ANGER';
ELSE 
   SET state = 'UNIDENTIFIED';
END IF;
END IF;
END IF;
END IF;

RETURN RETURNEMOTIONID(state);

END
$$ 
DELIMITER ;


truncate table GsrEmgData;
-- Inserting data into gsr emg table
INSERT INTO GsrEmgData VALUES (301,1,0.68,-0.19,emotionStateDetect(GSRValue,EMGValue),'2019-04-02 23:54:11');
INSERT INTO GsrEmgData VALUES (302,9,-0.25,0.48,emotionStateDetect(GSRValue,EMGValue),'2019-04-03 23:54:11');
INSERT INTO GsrEmgData VALUES (304,3,1.06,-0.26,emotionStateDetect(GSRValue,EMGValue),'2019-04-04 23:54:11');
INSERT INTO GsrEmgData VALUES (303,4,-1.25,-1.29,emotionStateDetect(GSRValue,EMGValue),'2019-04-05 23:54:11');
INSERT INTO GsrEmgData VALUES (305,2,-0.92,-2.15,emotionStateDetect(GSRValue,EMGValue),'2019-04-06 23:54:11');
INSERT INTO GsrEmgData VALUES (306,5,2.17,1.19,emotionStateDetect(GSRValue,EMGValue),'2019-04-07 23:54:11');
INSERT INTO GsrEmgData VALUES (307,7,1.09,1.16,emotionStateDetect(GSRValue,EMGValue),'2019-04-08 23:54:11');
INSERT INTO GsrEmgData VALUES (308,6,-0.44,0.62,emotionStateDetect(GSRValue,EMGValue),'2019-04-09 23:54:11');
INSERT INTO GsrEmgData VALUES (309,10,0.46,-0.86,emotionStateDetect(GSRValue,EMGValue),'2019-04-10 23:54:11');
INSERT INTO GsrEmgData VALUES (310,10,-1.48,-1.98,emotionStateDetect(GSRValue,EMGValue),'2019-04-11 23:54:11');
INSERT INTO GsrEmgData VALUES (311,1,0.68,-0.19,emotionStateDetect(GSRValue,EMGValue),'2019-04-02 23:54:12');
INSERT INTO GsrEmgData VALUES (312,1,0.68,-0.19,emotionStateDetect(GSRValue,EMGValue),'2019-04-02 23:54:13');



-- ******************************************************************  INSERT GSR EMG DATA END   ******************************************************************

INSERT INTO Electrode VALUES(1,'FP1','Fronto-polar',275);
INSERT INTO Electrode VALUES(2,'FP2','Fronto-polar',275);
INSERT INTO Electrode VALUES(3,'AF3','Preaurical-frontal',175);
INSERT INTO Electrode VALUES(4,'AF4','Preaurical-frontal',175);
INSERT INTO Electrode VALUES(5,'FC1','Fronto-central',200);
INSERT INTO Electrode VALUES(6,'FC2','Fronto-central',200);
INSERT INTO Electrode VALUES(7,'C3','Central',300);
INSERT INTO Electrode VALUES(8,'C4','Central',300);
INSERT INTO Electrode VALUES(9,'P3','Parietal',225);
INSERT INTO Electrode VALUES(10,'P4','Parietal',225);
INSERT INTO Electrode VALUES(11,'F3','Frontal',375);
INSERT INTO Electrode VALUES(12,'F4','Frontal',375);
INSERT INTO Electrode VALUES(13,'F7','Frontal',550);
INSERT INTO Electrode VALUES(14,'F8','Frontal',550);


-- Inserting Data into USEREmotionMatch table averaging the emotion from all 3 techniques

drop view IF EXISTS EEG_ECG_EMG;

create view EEG_ECG_EMG 
as
select EEGresultData.userID,EEGresultData.timeStamp,
EEGresultData.emotion as emotionEEG,
ECGResultData.emotionState as emotionECG,
GsrEmgData.emotionState as emotionGSREMG
FROM
((EEGresultData INNER JOIN ECGResultData ON EEGresultData.userID=ECGResultData.userID AND EEGresultData.timeStamp=ECGResultData.timeStamp)
INNER JOIN GsrEmgData ON ECGResultData.userID=GsrEmgData.userID AND ECGResultData.timeStamp=GsrEmgData.timeStamp);

select * from EEG_ECG_EMG;



-- Function to determine the emotion state from all 3 techniques
-- DROP FUNCTION IF EXISTS FinalemotionDetect
DELIMITER $$
CREATE FUNCTION FinalemotionDetect(EEGemotion varchar(256),ECGemotion varchar(256),GSREMGemotion varchar(256))
 RETURNS INT
BEGIN
Declare state varchar(256);
DECLARE HAPPY int;
DECLARE SAD int;
DECLARE ANGER int;
DECLARE FEAR int;
DECLARE UNIDENTIFIED int;



SET HAPPY =0,SAD=0,ANGER=0,FEAR=0,UNIDENTIFIED=0;

IF (EEGemotion='HAPPY')
  THEN SET HAPPY=HAPPY+1;
ELSE IF (EEGemotion='SAD')
  THEN SET SAD=SAD+1;
ELSE IF (EEGemotion='FEAR')
  THEN SET FEAR=FEAR+1;
ELSE IF (EEGemotion='ANGER')
  THEN SET ANGER=ANGER+1;
ELSE 
   SET UNIDENTIFIED = UNIDENTIFIED+1;
END IF;
END IF;
END IF;
END IF;

IF (ECGemotion='HAPPY')
  THEN SET HAPPY=HAPPY+1;
ELSE IF (ECGemotion='SAD')
  THEN SET SAD=SAD+1;
ELSE IF (ECGemotion='FEAR')
  THEN SET FEAR=FEAR+1;
ELSE IF (ECGemotion='ANGER')
  THEN SET ANGER=ANGER+1;
ELSE 
   SET UNIDENTIFIED = UNIDENTIFIED+1;
END IF;
END IF;
END IF;
END IF;

IF (GSREMGemotion='HAPPY')
  THEN SET HAPPY=HAPPY+1;
ELSE IF (GSREMGemotion='SAD')
  THEN SET SAD=SAD+1;
ELSE IF (GSREMGemotion='FEAR')
  THEN SET FEAR=FEAR+1;
ELSE IF (GSREMGemotion='ANGER')
  THEN SET ANGER=ANGER+1;
ELSE 
   SET UNIDENTIFIED = UNIDENTIFIED+1;
END IF;
END IF;
END IF;
END IF;


IF(HAPPY>SAD && HAPPY>FEAR && HAPPY>ANGER && HAPPY>UNIDENTIFIED)
  THEN RETURN RETURNEMOTIONID('HAPPY');
ELSE IF(SAD>HAPPY && SAD>FEAR && SAD>ANGER && SAD>UNIDENTIFIED)
  THEN RETURN RETURNEMOTIONID('SAD');
ELSE IF(FEAR>HAPPY && FEAR>SAD && FEAR>ANGER && FEAR>UNIDENTIFIED)
  THEN RETURN RETURNEMOTIONID('FEAR');
 ELSE IF(ANGER>HAPPY && ANGER>SAD && ANGER>FEAR && ANGER>UNIDENTIFIED)
  THEN RETURN RETURNEMOTIONID('ANGER');
 ELSE IF(UNIDENTIFIED>HAPPY && UNIDENTIFIED>SAD && UNIDENTIFIED>FEAR && UNIDENTIFIED>ANGER)
  THEN RETURN RETURNEMOTIONID('UNIDENTIFIED');
ELSE
   RETURN RETURNEMOTIONID('UNIDENTIFIED');
END IF;
END IF;
END IF;
END IF;
END IF;

END
$$ 
DELIMITER ;



-- Inserting data into userEmotionMatch table
INSERT INTO USEREmotionMatch
SELECT userID,`timeStamp`,emotionEEG,emotionECG,emotionGSREMG,
FinalemotionDetect(RETURNEMOTIONNAME(emotionEEG),RETURNEMOTIONNAME(emotionECG),RETURNEMOTIONNAME(emotionGSREMG)) as FinalEmotion 
FROM EEG_ECG_EMG;

-- select * from USEREmotionMatch;

