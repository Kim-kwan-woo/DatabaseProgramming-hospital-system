
CREATE TABLE DOCTOR
(
	DoctorID              VARCHAR2(8)  NOT NULL ,
	Name                  VARCHAR2(6)  NOT NULL ,
	Sex                   CHAR(1)  NOT NULL  CONSTRAINT  Sex_Valid_Value_907817562 CHECK (Sex IN ('F', 'M')),
	Phone                 VARCHAR2(11)  NOT NULL ,
	Email                 VARCHAR2(20)  NOT NULL ,
	DNum                  NUMBER(2)  NOT NULL ,
	Password              VARCHAR2(8)  NOT NULL 
);



CREATE UNIQUE INDEX XPKDOCTOR ON DOCTOR
(DoctorID  ASC);



ALTER TABLE DOCTOR
	ADD CONSTRAINT  XPKDOCTOR PRIMARY KEY (DoctorID);



CREATE UNIQUE INDEX XAK1DOCTOR ON DOCTOR
(Email  ASC);



ALTER TABLE DOCTOR
ADD CONSTRAINT  XAK1DOCTOR UNIQUE (Email);



CREATE TABLE H_DEPT
(
	DNum                  NUMBER(2)  NOT NULL ,
	DName                 VARCHAR2(10)  NOT NULL ,
	DLocation             VARCHAR2(20)  NULL ,
	DheadId               VARCHAR2(8)  NOT NULL 
);



CREATE UNIQUE INDEX XPKH_DEPT ON H_DEPT
(DNum  ASC);



ALTER TABLE H_DEPT
	ADD CONSTRAINT  XPKH_DEPT PRIMARY KEY (DNum);



CREATE UNIQUE INDEX XAK1H_DEPT ON H_DEPT
(DName  ASC);



ALTER TABLE H_DEPT
ADD CONSTRAINT  XAK1H_DEPT UNIQUE (DName);



CREATE TABLE NURSE
(
	NurseID               VARCHAR2(8)  NOT NULL ,
	Name                  VARCHAR2(6)  NOT NULL ,
	Sex                   CHAR(1)  NOT NULL  CONSTRAINT  Sex_Valid_Value_166837161 CHECK (Sex IN ('F', 'M')),
	Phone                 VARCHAR2(11)  NOT NULL ,
	Email                 VARCHAR2(20)  NOT NULL ,
	DNum                  NUMBER(2)  NOT NULL ,
	Password              VARCHAR2(8)  NOT NULL 
);



CREATE UNIQUE INDEX XPKNURSE ON NURSE
(NurseID  ASC);



ALTER TABLE NURSE
	ADD CONSTRAINT  XPKNURSE PRIMARY KEY (NurseID);



CREATE UNIQUE INDEX XAK1NURSE ON NURSE
(Email  ASC);



ALTER TABLE NURSE
ADD CONSTRAINT  XAK1NURSE UNIQUE (Email);



CREATE TABLE PATIENT
(
	PatientID             VARCHAR2(8)  NOT NULL ,
	Name                  VARCHAR2(6)  NOT NULL ,
	Sex                   CHAR(1)  NOT NULL  CONSTRAINT  Sex_Valid_Value_841169051 CHECK (Sex IN ('F', 'M')),
	Phone                 VARCHAR2(11)  NOT NULL ,
	Address               VARCHAR2(20)  NULL ,
	Email                 VARCHAR2(20)  NOT NULL ,
	DoctorID              VARCHAR2(8)  NOT NULL ,
	Hospitalization       CHAR(1)   DEFAULT  'X' NOT NULL  CONSTRAINT  Hospitalization_Val_1348087249 CHECK (Hospitalization IN ('O', 'X')),
	NurseID               VARCHAR2(8)  NULL 
);



CREATE UNIQUE INDEX XPKPATIENT ON PATIENT
(PatientID  ASC);



ALTER TABLE PATIENT
	ADD CONSTRAINT  XPKPATIENT PRIMARY KEY (PatientID);



CREATE UNIQUE INDEX XAK1PATIENT ON PATIENT
(Email  ASC);



ALTER TABLE PATIENT
ADD CONSTRAINT  XAK1PATIENT UNIQUE (Email);



CREATE TABLE TREATMENT
(
	DoctorID              VARCHAR2(8)  NOT NULL ,
	PatientID             VARCHAR2(8)  NOT NULL ,
	TreatmentDate         DATE  NOT NULL ,
	TreatmentDetail       VARCHAR2(100)  NOT NULL 
);



CREATE UNIQUE INDEX XPKTREATMENT ON TREATMENT
(DoctorID  ASC,PatientID  ASC,TreatmentDate  ASC);



ALTER TABLE TREATMENT
	ADD CONSTRAINT  XPKTREATMENT PRIMARY KEY (DoctorID,PatientID,TreatmentDate);



ALTER TABLE DOCTOR
	ADD (CONSTRAINT  Doctor_Assign FOREIGN KEY (DNum) REFERENCES H_DEPT(DNum));



ALTER TABLE NURSE
	ADD (CONSTRAINT  Nurse_Assign FOREIGN KEY (DNum) REFERENCES H_DEPT(DNum));



ALTER TABLE PATIENT
	ADD (CONSTRAINT  Responsibility_Doctor FOREIGN KEY (DoctorID) REFERENCES DOCTOR(DoctorID));



ALTER TABLE PATIENT
	ADD (CONSTRAINT  Care_Nurse FOREIGN KEY (NurseID) REFERENCES NURSE(NurseID) ON DELETE SET NULL);



ALTER TABLE TREATMENT
	ADD (CONSTRAINT  Treat_Doctor FOREIGN KEY (DoctorID) REFERENCES DOCTOR(DoctorID));



ALTER TABLE TREATMENT
	ADD (CONSTRAINT  Treated_Paitient FOREIGN KEY (PatientID) REFERENCES PATIENT(PatientID));



CREATE  TRIGGER tI_DOCTOR BEFORE INSERT ON DOCTOR for each row
-- ERwin Builtin Sun Dec 13 09:03:24 2020
-- INSERT trigger on DOCTOR 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Sun Dec 13 09:03:24 2020 */
    /* H_DEPT Assign DOCTOR on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="0000ec1c", PARENT_OWNER="", PARENT_TABLE="H_DEPT"
    CHILD_OWNER="", CHILD_TABLE="DOCTOR"
    P2C_VERB_PHRASE="Doctor_Assign", C2P_VERB_PHRASE="Assigned", 
    FK_CONSTRAINT="Doctor_Assign", FK_COLUMNS="DNum" */
    SELECT count(*) INTO NUMROWS
      FROM H_DEPT
      WHERE
        /* %JoinFKPK(:%New,H_DEPT," = "," AND") */
        :new.DNum = H_DEPT.DNum;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert DOCTOR because H_DEPT does not exist.'
      );
    END IF;


-- ERwin Builtin Sun Dec 13 09:03:24 2020
END;
/

CREATE  TRIGGER tD_DOCTOR AFTER DELETE ON DOCTOR for each row
-- ERwin Builtin Sun Dec 13 09:03:24 2020
-- DELETE trigger on DOCTOR 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Sun Dec 13 09:03:24 2020 */
    /* DOCTOR Responsibility PATIENT on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0001e563", PARENT_OWNER="", PARENT_TABLE="DOCTOR"
    CHILD_OWNER="", CHILD_TABLE="PATIENT"
    P2C_VERB_PHRASE="Responsibility_Doctor", C2P_VERB_PHRASE="allocated", 
    FK_CONSTRAINT="Responsibility_Doctor", FK_COLUMNS="DoctorID" */
    SELECT count(*) INTO NUMROWS
      FROM PATIENT
      WHERE
        /*  %JoinFKPK(PATIENT,:%Old," = "," AND") */
        PATIENT.DoctorID = :old.DoctorID;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete DOCTOR because PATIENT exists.'
      );
    END IF;

    /* ERwin Builtin Sun Dec 13 09:03:24 2020 */
    /* DOCTOR Treat TREATMENT on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="DOCTOR"
    CHILD_OWNER="", CHILD_TABLE="TREATMENT"
    P2C_VERB_PHRASE="Treat_Doctor", C2P_VERB_PHRASE="Treated", 
    FK_CONSTRAINT="Treat_Doctor", FK_COLUMNS="DoctorID" */
    SELECT count(*) INTO NUMROWS
      FROM TREATMENT
      WHERE
        /*  %JoinFKPK(TREATMENT,:%Old," = "," AND") */
        TREATMENT.DoctorID = :old.DoctorID;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete DOCTOR because TREATMENT exists.'
      );
    END IF;


-- ERwin Builtin Sun Dec 13 09:03:24 2020
END;
/

CREATE  TRIGGER tU_DOCTOR AFTER UPDATE ON DOCTOR for each row
-- ERwin Builtin Sun Dec 13 09:03:24 2020
-- UPDATE trigger on DOCTOR 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Sun Dec 13 09:03:24 2020 */
  /* DOCTOR Responsibility PATIENT on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00034a05", PARENT_OWNER="", PARENT_TABLE="DOCTOR"
    CHILD_OWNER="", CHILD_TABLE="PATIENT"
    P2C_VERB_PHRASE="Responsibility_Doctor", C2P_VERB_PHRASE="allocated", 
    FK_CONSTRAINT="Responsibility_Doctor", FK_COLUMNS="DoctorID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.DoctorID <> :new.DoctorID
  THEN
    SELECT count(*) INTO NUMROWS
      FROM PATIENT
      WHERE
        /*  %JoinFKPK(PATIENT,:%Old," = "," AND") */
        PATIENT.DoctorID = :old.DoctorID;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update DOCTOR because PATIENT exists.'
      );
    END IF;
  END IF;

  /* ERwin Builtin Sun Dec 13 09:03:24 2020 */
  /* DOCTOR Treat TREATMENT on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="DOCTOR"
    CHILD_OWNER="", CHILD_TABLE="TREATMENT"
    P2C_VERB_PHRASE="Treat_Doctor", C2P_VERB_PHRASE="Treated", 
    FK_CONSTRAINT="Treat_Doctor", FK_COLUMNS="DoctorID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.DoctorID <> :new.DoctorID
  THEN
    SELECT count(*) INTO NUMROWS
      FROM TREATMENT
      WHERE
        /*  %JoinFKPK(TREATMENT,:%Old," = "," AND") */
        TREATMENT.DoctorID = :old.DoctorID;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update DOCTOR because TREATMENT exists.'
      );
    END IF;
  END IF;

  /* ERwin Builtin Sun Dec 13 09:03:24 2020 */
  /* H_DEPT Assign DOCTOR on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="H_DEPT"
    CHILD_OWNER="", CHILD_TABLE="DOCTOR"
    P2C_VERB_PHRASE="Doctor_Assign", C2P_VERB_PHRASE="Assigned", 
    FK_CONSTRAINT="Doctor_Assign", FK_COLUMNS="DNum" */
  SELECT count(*) INTO NUMROWS
    FROM H_DEPT
    WHERE
      /* %JoinFKPK(:%New,H_DEPT," = "," AND") */
      :new.DNum = H_DEPT.DNum;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update DOCTOR because H_DEPT does not exist.'
    );
  END IF;


-- ERwin Builtin Sun Dec 13 09:03:24 2020
END;
/


CREATE  TRIGGER tD_H_DEPT AFTER DELETE ON H_DEPT for each row
-- ERwin Builtin Sun Dec 13 09:03:24 2020
-- DELETE trigger on H_DEPT 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Sun Dec 13 09:03:24 2020 */
    /* H_DEPT Assign NURSE on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0001db11", PARENT_OWNER="", PARENT_TABLE="H_DEPT"
    CHILD_OWNER="", CHILD_TABLE="NURSE"
    P2C_VERB_PHRASE="Nurse_Assign", C2P_VERB_PHRASE="Assigned", 
    FK_CONSTRAINT="Nurse_Assign", FK_COLUMNS="DNum" */
    SELECT count(*) INTO NUMROWS
      FROM NURSE
      WHERE
        /*  %JoinFKPK(NURSE,:%Old," = "," AND") */
        NURSE.DNum = :old.DNum;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete H_DEPT because NURSE exists.'
      );
    END IF;

    /* ERwin Builtin Sun Dec 13 09:03:24 2020 */
    /* H_DEPT Assign DOCTOR on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="H_DEPT"
    CHILD_OWNER="", CHILD_TABLE="DOCTOR"
    P2C_VERB_PHRASE="Doctor_Assign", C2P_VERB_PHRASE="Assigned", 
    FK_CONSTRAINT="Doctor_Assign", FK_COLUMNS="DNum" */
    SELECT count(*) INTO NUMROWS
      FROM DOCTOR
      WHERE
        /*  %JoinFKPK(DOCTOR,:%Old," = "," AND") */
        DOCTOR.DNum = :old.DNum;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete H_DEPT because DOCTOR exists.'
      );
    END IF;


-- ERwin Builtin Sun Dec 13 09:03:24 2020
END;
/

CREATE  TRIGGER tU_H_DEPT AFTER UPDATE ON H_DEPT for each row
-- ERwin Builtin Sun Dec 13 09:03:24 2020
-- UPDATE trigger on H_DEPT 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Sun Dec 13 09:03:24 2020 */
  /* H_DEPT Assign NURSE on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00020e70", PARENT_OWNER="", PARENT_TABLE="H_DEPT"
    CHILD_OWNER="", CHILD_TABLE="NURSE"
    P2C_VERB_PHRASE="Nurse_Assign", C2P_VERB_PHRASE="Assigned", 
    FK_CONSTRAINT="Nurse_Assign", FK_COLUMNS="DNum" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.DNum <> :new.DNum
  THEN
    SELECT count(*) INTO NUMROWS
      FROM NURSE
      WHERE
        /*  %JoinFKPK(NURSE,:%Old," = "," AND") */
        NURSE.DNum = :old.DNum;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update H_DEPT because NURSE exists.'
      );
    END IF;
  END IF;

  /* ERwin Builtin Sun Dec 13 09:03:24 2020 */
  /* H_DEPT Assign DOCTOR on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="H_DEPT"
    CHILD_OWNER="", CHILD_TABLE="DOCTOR"
    P2C_VERB_PHRASE="Doctor_Assign", C2P_VERB_PHRASE="Assigned", 
    FK_CONSTRAINT="Doctor_Assign", FK_COLUMNS="DNum" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.DNum <> :new.DNum
  THEN
    SELECT count(*) INTO NUMROWS
      FROM DOCTOR
      WHERE
        /*  %JoinFKPK(DOCTOR,:%Old," = "," AND") */
        DOCTOR.DNum = :old.DNum;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update H_DEPT because DOCTOR exists.'
      );
    END IF;
  END IF;


-- ERwin Builtin Sun Dec 13 09:03:24 2020
END;
/


CREATE  TRIGGER tI_NURSE BEFORE INSERT ON NURSE for each row
-- ERwin Builtin Sun Dec 13 09:03:24 2020
-- INSERT trigger on NURSE 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Sun Dec 13 09:03:24 2020 */
    /* H_DEPT Assign NURSE on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="0000ebe1", PARENT_OWNER="", PARENT_TABLE="H_DEPT"
    CHILD_OWNER="", CHILD_TABLE="NURSE"
    P2C_VERB_PHRASE="Nurse_Assign", C2P_VERB_PHRASE="Assigned", 
    FK_CONSTRAINT="Nurse_Assign", FK_COLUMNS="DNum" */
    SELECT count(*) INTO NUMROWS
      FROM H_DEPT
      WHERE
        /* %JoinFKPK(:%New,H_DEPT," = "," AND") */
        :new.DNum = H_DEPT.DNum;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert NURSE because H_DEPT does not exist.'
      );
    END IF;


-- ERwin Builtin Sun Dec 13 09:03:24 2020
END;
/

CREATE  TRIGGER tD_NURSE AFTER DELETE ON NURSE for each row
-- ERwin Builtin Sun Dec 13 09:03:24 2020
-- DELETE trigger on NURSE 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Sun Dec 13 09:03:24 2020 */
    /* NURSE Care PATIENT on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0000bffe", PARENT_OWNER="", PARENT_TABLE="NURSE"
    CHILD_OWNER="", CHILD_TABLE="PATIENT"
    P2C_VERB_PHRASE="Care_Nurse", C2P_VERB_PHRASE="Cared", 
    FK_CONSTRAINT="Care_Nurse", FK_COLUMNS="NurseID" */
    UPDATE PATIENT
      SET
        /* %SetFK(PATIENT,NULL) */
        PATIENT.NurseID = NULL
      WHERE
        /* %JoinFKPK(PATIENT,:%Old," = "," AND") */
        PATIENT.NurseID = :old.NurseID;


-- ERwin Builtin Sun Dec 13 09:03:24 2020
END;
/

CREATE  TRIGGER tU_NURSE AFTER UPDATE ON NURSE for each row
-- ERwin Builtin Sun Dec 13 09:03:24 2020
-- UPDATE trigger on NURSE 
DECLARE NUMROWS INTEGER;
BEGIN
  /* NURSE Care PATIENT on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="0001e600", PARENT_OWNER="", PARENT_TABLE="NURSE"
    CHILD_OWNER="", CHILD_TABLE="PATIENT"
    P2C_VERB_PHRASE="Care_Nurse", C2P_VERB_PHRASE="Cared", 
    FK_CONSTRAINT="Care_Nurse", FK_COLUMNS="NurseID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.NurseID <> :new.NurseID
  THEN
    UPDATE PATIENT
      SET
        /* %SetFK(PATIENT,NULL) */
        PATIENT.NurseID = NULL
      WHERE
        /* %JoinFKPK(PATIENT,:%Old," = ",",") */
        PATIENT.NurseID = :old.NurseID;
  END IF;

  /* ERwin Builtin Sun Dec 13 09:03:24 2020 */
  /* H_DEPT Assign NURSE on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="H_DEPT"
    CHILD_OWNER="", CHILD_TABLE="NURSE"
    P2C_VERB_PHRASE="Nurse_Assign", C2P_VERB_PHRASE="Assigned", 
    FK_CONSTRAINT="Nurse_Assign", FK_COLUMNS="DNum" */
  SELECT count(*) INTO NUMROWS
    FROM H_DEPT
    WHERE
      /* %JoinFKPK(:%New,H_DEPT," = "," AND") */
      :new.DNum = H_DEPT.DNum;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update NURSE because H_DEPT does not exist.'
    );
  END IF;


-- ERwin Builtin Sun Dec 13 09:03:24 2020
END;
/


CREATE  TRIGGER tI_PATIENT BEFORE INSERT ON PATIENT for each row
-- ERwin Builtin Sun Dec 13 09:03:24 2020
-- INSERT trigger on PATIENT 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Sun Dec 13 09:03:24 2020 */
    /* DOCTOR Responsibility PATIENT on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00020712", PARENT_OWNER="", PARENT_TABLE="DOCTOR"
    CHILD_OWNER="", CHILD_TABLE="PATIENT"
    P2C_VERB_PHRASE="Responsibility_Doctor", C2P_VERB_PHRASE="allocated", 
    FK_CONSTRAINT="Responsibility_Doctor", FK_COLUMNS="DoctorID" */
    SELECT count(*) INTO NUMROWS
      FROM DOCTOR
      WHERE
        /* %JoinFKPK(:%New,DOCTOR," = "," AND") */
        :new.DoctorID = DOCTOR.DoctorID;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert PATIENT because DOCTOR does not exist.'
      );
    END IF;

    /* ERwin Builtin Sun Dec 13 09:03:24 2020 */
    /* NURSE Care PATIENT on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="NURSE"
    CHILD_OWNER="", CHILD_TABLE="PATIENT"
    P2C_VERB_PHRASE="Care_Nurse", C2P_VERB_PHRASE="Cared", 
    FK_CONSTRAINT="Care_Nurse", FK_COLUMNS="NurseID" */
    UPDATE PATIENT
      SET
        /* %SetFK(PATIENT,NULL) */
        PATIENT.NurseID = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM NURSE
            WHERE
              /* %JoinFKPK(:%New,NURSE," = "," AND") */
              :new.NurseID = NURSE.NurseID
        ) 
        /* %JoinPKPK(PATIENT,:%New," = "," AND") */
         and PATIENT.PatientID = :new.PatientID;


-- ERwin Builtin Sun Dec 13 09:03:24 2020
END;
/

CREATE  TRIGGER tD_PATIENT AFTER DELETE ON PATIENT for each row
-- ERwin Builtin Sun Dec 13 09:03:24 2020
-- DELETE trigger on PATIENT 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Sun Dec 13 09:03:24 2020 */
    /* PATIENT Treated TREATMENT on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000f0c9", PARENT_OWNER="", PARENT_TABLE="PATIENT"
    CHILD_OWNER="", CHILD_TABLE="TREATMENT"
    P2C_VERB_PHRASE="Treated_Paitient", C2P_VERB_PHRASE="Treat", 
    FK_CONSTRAINT="Treated_Paitient", FK_COLUMNS="PatientID" */
    SELECT count(*) INTO NUMROWS
      FROM TREATMENT
      WHERE
        /*  %JoinFKPK(TREATMENT,:%Old," = "," AND") */
        TREATMENT.PatientID = :old.PatientID;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete PATIENT because TREATMENT exists.'
      );
    END IF;


-- ERwin Builtin Sun Dec 13 09:03:24 2020
END;
/

CREATE  TRIGGER tU_PATIENT AFTER UPDATE ON PATIENT for each row
-- ERwin Builtin Sun Dec 13 09:03:24 2020
-- UPDATE trigger on PATIENT 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Sun Dec 13 09:03:24 2020 */
  /* PATIENT Treated TREATMENT on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="000342a7", PARENT_OWNER="", PARENT_TABLE="PATIENT"
    CHILD_OWNER="", CHILD_TABLE="TREATMENT"
    P2C_VERB_PHRASE="Treated_Paitient", C2P_VERB_PHRASE="Treat", 
    FK_CONSTRAINT="Treated_Paitient", FK_COLUMNS="PatientID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.PatientID <> :new.PatientID
  THEN
    SELECT count(*) INTO NUMROWS
      FROM TREATMENT
      WHERE
        /*  %JoinFKPK(TREATMENT,:%Old," = "," AND") */
        TREATMENT.PatientID = :old.PatientID;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update PATIENT because TREATMENT exists.'
      );
    END IF;
  END IF;

  /* ERwin Builtin Sun Dec 13 09:03:24 2020 */
  /* DOCTOR Responsibility PATIENT on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="DOCTOR"
    CHILD_OWNER="", CHILD_TABLE="PATIENT"
    P2C_VERB_PHRASE="Responsibility_Doctor", C2P_VERB_PHRASE="allocated", 
    FK_CONSTRAINT="Responsibility_Doctor", FK_COLUMNS="DoctorID" */
  SELECT count(*) INTO NUMROWS
    FROM DOCTOR
    WHERE
      /* %JoinFKPK(:%New,DOCTOR," = "," AND") */
      :new.DoctorID = DOCTOR.DoctorID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update PATIENT because DOCTOR does not exist.'
    );
  END IF;

  /* ERwin Builtin Sun Dec 13 09:03:24 2020 */
  /* NURSE Care PATIENT on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="NURSE"
    CHILD_OWNER="", CHILD_TABLE="PATIENT"
    P2C_VERB_PHRASE="Care_Nurse", C2P_VERB_PHRASE="Cared", 
    FK_CONSTRAINT="Care_Nurse", FK_COLUMNS="NurseID" */
  SELECT count(*) INTO NUMROWS
    FROM NURSE
    WHERE
      /* %JoinFKPK(:%New,NURSE," = "," AND") */
      :new.NurseID = NURSE.NurseID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.NurseID IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update PATIENT because NURSE does not exist.'
    );
  END IF;


-- ERwin Builtin Sun Dec 13 09:03:24 2020
END;
/


CREATE  TRIGGER tI_TREATMENT BEFORE INSERT ON TREATMENT for each row
-- ERwin Builtin Sun Dec 13 09:03:24 2020
-- INSERT trigger on TREATMENT 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Sun Dec 13 09:03:24 2020 */
    /* DOCTOR Treat TREATMENT on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00021670", PARENT_OWNER="", PARENT_TABLE="DOCTOR"
    CHILD_OWNER="", CHILD_TABLE="TREATMENT"
    P2C_VERB_PHRASE="Treat_Doctor", C2P_VERB_PHRASE="Treated", 
    FK_CONSTRAINT="Treat_Doctor", FK_COLUMNS="DoctorID" */
    SELECT count(*) INTO NUMROWS
      FROM DOCTOR
      WHERE
        /* %JoinFKPK(:%New,DOCTOR," = "," AND") */
        :new.DoctorID = DOCTOR.DoctorID;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert TREATMENT because DOCTOR does not exist.'
      );
    END IF;

    /* ERwin Builtin Sun Dec 13 09:03:24 2020 */
    /* PATIENT Treated TREATMENT on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="PATIENT"
    CHILD_OWNER="", CHILD_TABLE="TREATMENT"
    P2C_VERB_PHRASE="Treated_Paitient", C2P_VERB_PHRASE="Treat", 
    FK_CONSTRAINT="Treated_Paitient", FK_COLUMNS="PatientID" */
    SELECT count(*) INTO NUMROWS
      FROM PATIENT
      WHERE
        /* %JoinFKPK(:%New,PATIENT," = "," AND") */
        :new.PatientID = PATIENT.PatientID;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert TREATMENT because PATIENT does not exist.'
      );
    END IF;


-- ERwin Builtin Sun Dec 13 09:03:24 2020
END;
/

CREATE  TRIGGER tU_TREATMENT AFTER UPDATE ON TREATMENT for each row
-- ERwin Builtin Sun Dec 13 09:03:24 2020
-- UPDATE trigger on TREATMENT 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Sun Dec 13 09:03:24 2020 */
  /* DOCTOR Treat TREATMENT on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00020a1b", PARENT_OWNER="", PARENT_TABLE="DOCTOR"
    CHILD_OWNER="", CHILD_TABLE="TREATMENT"
    P2C_VERB_PHRASE="Treat_Doctor", C2P_VERB_PHRASE="Treated", 
    FK_CONSTRAINT="Treat_Doctor", FK_COLUMNS="DoctorID" */
  SELECT count(*) INTO NUMROWS
    FROM DOCTOR
    WHERE
      /* %JoinFKPK(:%New,DOCTOR," = "," AND") */
      :new.DoctorID = DOCTOR.DoctorID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update TREATMENT because DOCTOR does not exist.'
    );
  END IF;

  /* ERwin Builtin Sun Dec 13 09:03:24 2020 */
  /* PATIENT Treated TREATMENT on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="PATIENT"
    CHILD_OWNER="", CHILD_TABLE="TREATMENT"
    P2C_VERB_PHRASE="Treated_Paitient", C2P_VERB_PHRASE="Treat", 
    FK_CONSTRAINT="Treated_Paitient", FK_COLUMNS="PatientID" */
  SELECT count(*) INTO NUMROWS
    FROM PATIENT
    WHERE
      /* %JoinFKPK(:%New,PATIENT," = "," AND") */
      :new.PatientID = PATIENT.PatientID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update TREATMENT because PATIENT does not exist.'
    );
  END IF;


-- ERwin Builtin Sun Dec 13 09:03:24 2020
END;
/

