DROP DATABASE IF EXISTS Doc_Office;
CREATE DATABASE Doc_Office;

USE Doc_Office;

DROP TABLE IF EXISTS DOCTOR_AUDIT;
CREATE TABLE DOCTOR_AUDIT (
MedicID varchar(6) not null,
Dr_F_Name varchar(15) not null,
Dr_L_Name varchar(15) not null, 
AuditAction varchar(15),
Specialty varchar (20),
DateOfModification date, 
CONSTRAINT pk_DOCTOR_AUDIT primary key (MedicID)
);

DROP TABLE IF EXISTS DOCTOR;
CREATE TABLE DOCTOR (
  DoctorID varchar(6) not null,
  F_Name varchar(15) not null,
  L_Name varchar(15) not null,
  DocSSN int not null,
  DocPhone varchar(10),
  Dr_Specialty varchar(20),
  CONSTRAINT pk_DOCTOR primary key (DoctorID),
  CONSTRAINT fk_DOCTOR_ID foreign key(DoctorID)
  References DOCTOR_AUDIT(MedicID)
);

DROP TABLE IF EXISTS PATIENT;
CREATE TABLE PATIENT (
  SSN  int not null, 
  Patient_F_Name varchar(15) not null, 
  Patient_L_Name varchar(15) not null,
  PatientPhone varchar(10),
  CONSTRAINT pk_PATIENT primary key (SSN)
);

DROP TABLE IF EXISTS GIVES_PRESCRIPTION;
CREATE TABLE GIVES_PRESCRIPTION(
PrescriptionID int not null,
Dr_Prescribed varchar(6) not null,
PatientSSN int not null,
Note varchar(30),
CONSTRAINT pk_GIVES_PRESCRIPTION primary key(PrescriptionID, Dr_Prescribed, PatientSSN),
CONSTRAINT fk_GIVES_PRESCRIPTION_ID foreign key(Dr_Prescribed)
References DOCTOR_AUDIT(MedicID),
CONSTRAINT fk_GIVES_PRESCRIPTION_SSN foreign key(PatientSSN)
References PATIENT(SSN)
);

DROP TABLE IF EXISTS PRESCRIPTIONS;
CREATE TABLE PRESCRIPTIONS (
PrescriptionID int not null,
MedicineID int not null,
Med_Name varchar(30) not null,
Dosage int,
SSN_Prescribed int not null,
CONSTRAINT pk_PRESCRIPTIONS primary key (PrescriptionID),
CONSTRAINT fk_PRESCRIPTIONS_SSN foreign key (SSN_Prescribed)
References PATIENT(SSN),
CONSTRAINT fk_PRESCRIPTIONS foreign key (PrescriptionID)
References GIVES_PRESCRIPTION(PrescriptionID)
);

DROP TABLE IF EXISTS ASSIGNS_TEST;
CREATE TABLE ASSIGNS_TEST(
TestID varchar(4) not null,
Doc_Assigned varchar(6) not null,
Tested_SSN int not null,
Note varchar(30),
CONSTRAINT pk_ASSIGNS_TEST primary key (TestID, Doc_Assigned, Tested_SSN),
CONSTRAINT fk_ASSIGNS_TEST_DOC foreign key(Doc_Assigned)
References DOCTOR_AUDIT(MedicID),
CONSTRAINT fk_ASSIGNS_TEST_PATIENT foreign key(Tested_SSN)
References PATIENT(SSN)
);

DROP TABLE IF EXISTS TESTS;
CREATE TABLE TESTS (
TestID varchar(4) not null,
Test_Name varchar(30),
CONSTRAINT pk_TESTS primary key (TestID),
CONSTRAINT fk_TESTS foreign key (TestID)
References ASSIGNS_TEST(TestID)
);

DROP TABLE IF EXISTS VISIT;
CREATE TABLE VISIT (
VisitID int not null,
DoctorID varchar(6) not null,
SSN  int not null,
F_Name  varchar(15) not null, 
L_Name  varchar(15) not null,
PatientPhone varchar(10) not null,
Reason varchar(30),
CONSTRAINT pk_VISIT primary key (VisitID),
CONSTRAINT fk_VISIT_DR foreign key (DoctorID)
References DOCTOR_AUDIT(MedicID),
CONSTRAINT fk_VISIT_PATIENT foreign key (SSN)
References PATIENT(SSN)
);

Alter Table DOCTOR_AUDIT ADD INDEX specialty_index (Specialty);
Alter table DOCTOR
ADD CONSTRAINT fk_DOCTOR_SPECIALTY foreign key (Dr_Specialty) references 
DOCTOR_AUDIT(Specialty);

Alter Table DOCTOR_AUDIT ADD INDEX drfname_index (Dr_F_Name);
Alter table DOCTOR
ADD CONSTRAINT fk_DOCTOR_F_NAME foreign key (F_Name) references 
DOCTOR_AUDIT(Dr_F_Name);

Alter Table DOCTOR_AUDIT ADD INDEX drlname_index (Dr_L_Name);
Alter table DOCTOR
ADD CONSTRAINT fk_DOCTOR_L_NAME foreign key (L_Name) references 
DOCTOR_AUDIT(Dr_L_Name);

Alter Table PATIENT ADD INDEX patientfname_index (Patient_F_Name);
Alter table VISIT
ADD CONSTRAINT fk_PATIENT_F_NAME foreign key (F_Name) references 
PATIENT(Patient_F_Name);

Alter Table PATIENT ADD INDEX patientlname_index (Patient_L_Name);
Alter table VISIT
ADD CONSTRAINT fk_PATIENT_L_NAME foreign key (L_Name) references 
PATIENT(Patient_L_Name);

INSERT INTO `DOCTOR_AUDIT` (`MedicID`,`Dr_F_Name`,`Dr_L_Name`,`AuditAction`,`Specialty`,`DateOfModification`) VALUES 
 ("RO2015",'Robert','Stevens','"Updated"','Surgery','2002-09-07'),
 ("IV4244",	"Ivo",	"Robotnik",	"Updated","Physical Medicine",'2007-12-05'),
 ("ST2048",	"Steve","Gates",	"Added",	"Neurology",'2010-05-16'),
 ("PH3517",	"Phil",	"McGraw",	"Updated",	"Psychology",'2015-02-03'),
 ("AL9768",	"Alanah","Eudocia",	"Added","None",	'2021-04-28');
 
 
 
 INSERT INTO `DOCTOR` (`DoctorID`,`F_Name`,`L_Name`,`DocSSN`,`DocPhone`,`Dr_Specialty`) VALUES
("RO2015",	"Robert",	"Stevens",	585216246,	'6575798837',	"Surgery"),
("IV4244",	"Ivo",	"Robotnik",	832059685,	'6573909963',	"Physical Medicine"),
("ST2048",	"Steve",	"Gates",	266505148,	'6572097603',	"Neurology"),
("PH3517",	"Phil",	"McGraw",	556366330,	'6579939358',	"Psychology"),
("AL9768",	"Alanah",	"Eudocia",	410311087,	'6577798547',	"None");

INSERT INTO `PATIENT` (`SSN`,`Patient_F_Name`,`Patient_L_Name`,`PatientPhone`) VALUES
(832059685,	"Ivo",	"Robotnik",	'9518889546'),
(419894452,	"John",	"Doe",'2832776686'),
(402066282,	"Bob","Jenkins",'5715148995'),
(402297066,	"Rob","Jenkins",'5715148995'),
(856871644,	"Jesse","James",'3860326886'),
(736715855,	"Mary",	"Quinn",'5110121221'),
(969334152,	"Larry","Quinn",'5110121221'),
(645740147,	"Sarah","Quinn",'5110121221'),
(766014902,	"Nisha","Grete",'1509563446'),
(556366330,	"Phil",	"McGraw",'8592678477');

INSERT INTO `GIVES_PRESCRIPTION` (`PrescriptionID`,`Dr_Prescribed`,`PatientSSN`,`Note`) VALUES
(15154,	"RO2015",	402297066,	"One dose"),
(15155,	"RO2015",	402297066,	"One dose"),
(16377,	"IV4244",	856871644,	"None"),
(16529,	"IV4244",	556366330,	"None"),
(10473,	"ST2048",	736715855,	"None"),
(10474,	"ST2048",	969334152,	"None"),
(20445,	"AL9768",	766014902,	"None"),
(20540,	"AL9768",	832059685,	"None");


INSERT INTO `PRESCRIPTIONS` (`PrescriptionID`,`MedicineID`,`Med_Name`,`Dosage`,`SSN_Prescribed`) VALUES
(15154,	560,	"Vicodin",	1,	402066282),
(15155,	560,	"Vicodin",	1,	402297066),
(16377,	412,	"Ferrous Sulfate",	2,	856871644),
(16529,	455,	"Hygroton",	3,	556366330),
(10473,	660,	"Actron",	2,	736715855),
(10474,	660,	"Actron",	2,	969334152),
(20445,	917,	"Ofirmev",	1,	766014902),
(20540,	933,	"Tylonol",	4,	832059685);

INSERT INTO `ASSIGNS_TEST` (`TestID`,`Doc_Assigned`, `Tested_SSN`, `Note`) VALUES
("XR11",	"RO2015",	402066282,	"Final Test"),
("XR12",	"RO2015",	402297066,	"Final Test"),
("BT01",	"IV4244",	856871644,	"Low Iron Level"),
("BT02",	"IV4244",	556366330,	"High Pressure"),
("CT31",	"ST2048",	736715855,	"Severe Headache"),
("CT32","ST2048",	969334152,	"Severe Headache"),
("UT41",	"AL9768",	766014902,	"Urine Infection"),
("UT42",	"AL9768",	832059685,	"Annual Check");

INSERT INTO `TESTS`(`TestID`, `Test_Name`) VALUES
("XR11",	"X-Ray Bob"),
("XR12",	"X-Ray Rob"),
("BT01",	"Blood Test Jesse"),
("BT02",	"Blood Test Phil"),
("CT31",	"CT Scan Marry"),
("CT32",	"CT Scan Larry"),
("UT41",	"Urine Test Nisha"),
("UT42",	"Urine Test Ivo");

INSERT INTO `VISIT` (`VisitID`,`DoctorID`,`SSN`,`F_Name`,`L_Name`,`PatientPhone`,`Reason`) VALUES
(211015,	"RO2015",	402066282,	"Bob",	"Jenkins",	'5715148995',	"Final surgery"),
(211016,	"RO2015",	402297066,	"Rob",	"Jenkins",	'5715148995',	"Final surgery"),
(211022,	"IV4244",	856871644,	"Jesse",	"James",	'3860326886',	"Blood Problems"),
(211112,	"IV4244",	556366330,	"Phil",	"McGraw",	'8592678477',	"Blood Problems"),
(211125,	"ST2048",	736715855,	"Mary",	"Quinn",	'5110121221',	"Headaches for days"),
(211126,	"ST2048",	969334152,	"Larry",	"Quinn",	'5110121221',	"Headaches for days"),
(211129,	"AL9768",	766014902,	"Nisha",	"Grete",	'1509563446',	"Pain when urinating"),
(211130,	"AL9768",	832059685,	"Ivo",	"Robotnik",	'9518889546',	"Annual check-up"),
(211209,	"PH3517",	645740147,	"Sarah",	"Quinn",	'5110121221',	"Anxiety"),
(211215,	"AL9768",	419894452,	"John",	"Doe",	'2832776686',	"Black Poop");

-- CREATE TRIGGER specialtyTrigger 
-- AFTER INSERT
-- ON
-- DOCTOR_AUDIT
-- FOR EACH ROW
-- BEGIN

-- END
