/*nurseid를 입력받아 해당 간호사의 이름을 반환한다.*/
CREATE OR REPLACE FUNCTION GetNurseName
	(v_nurseid IN VARCHAR)
	RETURN VARCHAR
IS
	v_name nurse.name%TYPE;
BEGIN
	SELECT name
	INTO v_name
	FROM nurse
	where nurseid = v_nurseid;
RETURN v_name;
END;
/