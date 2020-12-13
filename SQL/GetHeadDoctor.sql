/*해당 부서의 과장의 id를 가져온다.*/
CREATE OR REPLACE FUNCTION GetHeadDoctor
	(v_dnum IN NUMBER)
	RETURN VARCHAR
IS
	v_headid h_dept.dheadid%TYPE;
BEGIN
	SELECT dheadid
	INTO v_headid
	FROM h_dept
	where dnum = v_dnum;
RETURN v_headid;
END;
/