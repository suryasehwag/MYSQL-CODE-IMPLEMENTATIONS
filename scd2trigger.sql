/*THIS SCRIPT WAS PROVIDED IN  MYSQL SERVER STYLE CONVERT THIS TO SQL SERVER STYLE BY SUBSTITUTING CORRESPONDING KEY

WORDS*/

USE DESTINATION;

CREATE TABLE `details` (
  `name` varchar(10) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `salary` decimal(8,0) DEFAULT NULL,
  `effective_from_date` date NOT NULL,
  `effective_to_date` date DEFAULT NULL,
  `status` varchar(1) NOT NULL DEFAULT 'Y',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
)

/*CREATING THE TRIGGER ON INSERT FOR SOURCE SUCH THAT WHENEVER INSERT HAPPENS IN SOURCE TABLE SAME INSERT HAPPENS 

IN DESTINATION TABLE*/


USE SOURCE;
DELIMITER $$
CREATE TRIGGER scd_2 AFTER INSERT ON `details` FOR EACH ROW
insert into destination.details(name,age,salary,effective_from_date)  values(NEW.name,NEW.age,NEW.salary,curdate())
$$
delimiter ;


/*NOW CREATE THE TRIGGER ON UPDATE FOR SOURCE SUCH THAT WHENEVER A RECORD UPDATE HAPPENS THEN THE PREVIOUS INSERTED

CORRESPONDING PRIMARY KEY RECORD SHOULD BE HAVING CURRENT EFFECTIVE TO DATE THEN INSERT THE UPDATED RECORD AS NEW

RECORD */


DROP TRIGGER SCD_2U;
USE SOURCE;
DELIMITER $$
CREATE TRIGGER scd_2u before UPDATE ON `details` FOR EACH ROW
update destination.details set effective_to_date=curdate(),status='n' where name=NEW.name and effective_to_date is null
$$
delimiter ;


DROP TRIGGER SCD_2U1;
USE SOURCE;
DELIMITER $$
CREATE TRIGGER scd_2u1 AFTER UPDATE ON `details` FOR EACH ROW
insert into destination.details(name,age,salary,effective_from_date) values(NEW.name,NEW.age,NEW.salary,curdate())
$$
delimiter ;

insert into source.details values('surya',23,1200);

update source.details set salary=2500;





