
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'iamadmin';
GRANT ALL ON BRAIN TO admin@localhost;

CREATE USER 'mahi1'@'localhost' IDENTIFIED BY 'viewer';
GRANT SELECT ON BRAIN.* TO mahi1@localhost ;

CREATE USER 'aiss1'@'localhost' IDENTIFIED BY 'analyst';
GRANT INSERT,UPDATE,SELECT ON BRAIN.* TO aiss1@localhost;


CREATE USER 'mahi'@'localhost' IDENTIFIED BY 'guntur';
CREATE USER 'aiss'@'localhost' IDENTIFIED BY 'coimbatore';
CREATE USER 'venk'@'localhost' IDENTIFIED BY 'chennai';
 
GRANT ALL ON brain.* TO 'mahi'@'localhost';

grant select on brain.EEGresultData to aiss@localhost;
grant select on brain.ECGResultData to aiss@localhost;
grant select on brain.GsrEmgData to aiss@localhost;
grant insert on brain.USEREmotionMatch to aiss@localhost;


GRANT Select ON brain.* TO 'venk'@'localhost';

show grants for 'admin'@'localhost';
show grants for 'mahi1'@'localhost';
show grants for 'aiss1'@'localhost';
show grants for 'mahi'@'localhost';
show grants for 'aiss'@'localhost';
show grants for 'venk'@'localhost';

REVOKE ALL PRIVILEGES ON Brain.* FROM admin@localhost;




-- ***************** creating different roles   **************


CREATE ROLE 'administrator', 'EEGdataAnalyst';

-- grant privilege to role
grant all
on brain.*
to administrator;

grant select
on brain.EEGData
to EEGdataAnalyst;

show grants for EEGdataAnalyst;
show grants for administrator;


-- grant role to user
create user abi@localhost 
identified by 'abipassword';	

create user anu@localhost 
identified by 'anupassword';	

select * from mysql.user;

grant EEGdataAnalyst to abi@localhost;
grant administrator to anu@localhost;