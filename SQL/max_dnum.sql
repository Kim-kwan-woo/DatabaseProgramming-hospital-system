/*현재 부서 테이블에서 가장 큰 부서 번호를 찾아 반환한다.*/
CREATE OR REPLACE FUNCTION max_dnum
	RETURN NUMBER
IS
	maxDnum h_dept.dnum%TYPE;
	CURSOR cur IS
	SELECT MAX(dnum)
	FROM h_dept;
BEGIN
	OPEN cur;
	FETCH cur into maxDnum;
	CLOSE cur;
RETURN maxDnum;
END;
/