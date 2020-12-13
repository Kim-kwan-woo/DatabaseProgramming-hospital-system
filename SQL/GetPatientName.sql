/*patientid를 입력받아 해당 환자의 이름을 반환한다.*/
CREATE OR REPLACE FUNCTION GetPatientName
	(v_patientid IN VARCHAR)
	RETURN VARCHAR
IS
	v_name patient.name%TYPE;
BEGIN
	SELECT name
	INTO v_name
	FROM patient
	where patientid = v_patientid;
RETURN v_name;
END;
/