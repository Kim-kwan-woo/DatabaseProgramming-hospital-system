/*doctorid를 입력받아 해당 의사의 이름을 반환한다.*/
CREATE OR REPLACE FUNCTION GetDoctorName
	(v_doctorid IN VARCHAR)
	RETURN VARCHAR
IS
	v_name doctor.name%TYPE;
BEGIN
	SELECT name
	INTO v_name
	FROM doctor
	where doctorid = v_doctorid;
RETURN v_name;
END;
/