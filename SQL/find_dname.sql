/*부서 번호를 입력받아 부서의 이름을 반환한다.*/
CREATE OR REPLACE FUNCTION find_dname
	(v_dnum IN NUMBER)
	RETURN VARCHAR
IS
	v_dname h_dept.dname%TYPE;
BEGIN
	SELECT dname
	INTO v_dname
	FROM h_dept
	where dnum = v_dnum;
RETURN v_dname;
END;
/