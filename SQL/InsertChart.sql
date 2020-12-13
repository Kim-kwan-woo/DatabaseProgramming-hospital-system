/*해당 환자의 새로운 진료 기록 추가*/
CREATE OR REPLACE PROCEDURE InsertChart(v_p_id IN VARCHAR2,
	v_d_id IN VARCHAR2,
	v_detail IN VARCHAR2,
	result OUT VARCHAR2)
IS
	null_value EXCEPTION;
	too_long_text EXCEPTION;
	same_date EXCEPTION;
	
	nSameDate NUMBER := 0;
	today VARCHAR2(20);
BEGIN
	/*오늘 날짜 불러오기*/
	today := TO_CHAR(SYSDATE,'YYYY-MM-DD');

	/*입력된 진료 내용 길이 확인*/
	IF(LENGTH(v_detail) > 50) THEN
		RAISE too_long_text;
	END IF;

	/*null 값 에러*/
	IF(v_detail IS null) THEN
		RAISE null_value;
	END IF;

	/*같은 날짜의 진료기록이 이미 등록되어 있는 경우*/
	SELECT COUNT(*)
	INTO nSameDate
	FROM treatment
	WHERE patientid= v_p_id and doctorid = v_d_id and treatmentdate = TO_DATE(today, 'YYYY-MM-DD');

	IF(nSameDate > 0) THEN
		RAISE same_date;
	END IF;

	/*진료 내용 등록*/
	insert INTO treatment (doctorid, patientid, treatmentdate, treatmentdetail)
	values (v_d_id, v_p_id, TO_DATE(today, 'YYYY-MM-DD'), v_detail); 
	commit;

	result := '진료 내용을 등록하였습니다.';
EXCEPTION
	WHEN too_long_text THEN
		result := '진료 내용이 너무 깁니다. 50자 이내로 작성해 주세요.';
	WHEN null_value THEN
		result := '진료 내용이 빈칸입니다. 진료 내용을 입력해주세요.';
	WHEN same_date THEN
		result := '이미 오늘 날짜에 등록된 진료 기록이 있습니다.';
	WHEN OTHERS THEN
		result := SQLCODE;
END;
/