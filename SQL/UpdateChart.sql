/*진료 내용을 수정*/
CREATE OR REPLACE PROCEDURE UpdateChart(v_p_id IN VARCHAR2,
	v_d_id IN VARCHAR2,
	v_detail IN VARCHAR2,
	v_date IN VARCHAR2,
	result OUT VARCHAR2)
IS
	no_change EXCEPTION;
	too_long_text EXCEPTION;
	
	tDetail treatment.treatmentdetail%TYPE;
	CURSOR find_detail(v_pid treatment.patientid%TYPE, v_did treatment.doctorid%TYPE) IS
	SELECT treatmentdetail
	FROM treatment
	WHERE patientid= v_pid and doctorid = v_did and treatmentdate = TO_DATE(v_date, 'YYYY-MM-DD');
BEGIN
	/*변경된 내용 없음 에러 처리*/
	OPEN find_detail(v_p_id, v_d_id);
	FETCH find_detail INTO tDetail;
	CLOSE find_detail;
	IF(v_detail = tDetail) THEN
		RAISE no_change;
	END IF;

	/*입력된 진료 내용 길이 확인*/
	IF(LENGTH(v_detail) > 50) THEN
		RAISE too_long_text;
	END IF;

	/*진료 내용 수정*/
	UPDATE treatment
	SET treatmentdetail = v_detail
	WHERE patientid = v_p_id and doctorid = v_d_id and treatmentdate = TO_DATE(v_date, 'YYYY-MM-DD');
	commit;

	result := '진료 내용을 수정하였습니다.';
EXCEPTION
	WHEN no_change THEN
		result := '변경된 내용이 없습니다.';
	WHEN too_long_text THEN
		result := '진료 내용이 너무 깁니다. 50자 이내로 작성해 주세요.';
	WHEN OTHERS THEN
		result := SQLCODE;
END;
/