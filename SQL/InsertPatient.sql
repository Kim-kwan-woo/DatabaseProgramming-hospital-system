/*신규 환자 등록*/
CREATE OR REPLACE PROCEDURE InsertPatient(v_p_id IN VARCHAR2,
	v_name IN VARCHAR2,
	v_sex IN VARCHAR2,
	v_phone IN VARCHAR2,
	v_address IN VARCHAR2,
	v_email IN VARCHAR2,
	v_doctorid IN VARCHAR2,
	v_hospitalization IN VARCHAR2,
	v_nurseid IN VARCHAR2,
	v_detail IN VARCHAR2,
	result OUT VARCHAR2)
IS
	null_value EXCEPTION;
	too_long_text EXCEPTION;
	invalid_sex_value EXCEPTION;
	invalid_hospitalization_value EXCEPTION;
	same_patient_id EXCEPTION;
	
	v_pid patient.patientid%TYPE;
	v_dnum doctor.dnum%TYPE;
	v_nid nurse.nurseid%TYPE;
	today VARCHAR2(20);

	CURSOR find_same_patient(p_id patient.patientid%TYPE) IS
	SELECT patientid
	FROM patient
	WHERE patientid = p_id;
BEGIN
	/*오늘 날짜 불러오기*/
	today := TO_CHAR(SYSDATE,'YYYY-MM-DD');

	/*입력된 정보 길이 확인*/
	IF(LENGTH(v_p_id) > 8 or LENGTH(v_name) > 3 or LENGTH(v_phone) > 11 or LENGTH(v_address) > 10 or LENGTH(v_email) > 20 or LENGTH(v_nurseid) > 8 or LENGTH(v_detail) > 50) THEN
		RAISE too_long_text;
	END IF;

	/*null 값 에러*/
	IF(v_p_id IS null or v_name IS null or v_sex IS null or v_phone IS null or v_address IS null or v_email IS null or v_hospitalization IS null or v_nurseid IS null or v_detail IS null) THEN
		RAISE null_value;
	END IF;

	/*성별 입력 값 확인*/
	IF(v_sex != 'F' and v_sex != 'M') THEN
		RAISE invalid_sex_value;
	END IF;

	/*입원 정보 입력 값 확인*/
	IF(v_hospitalization != 'O' and v_hospitalization != 'X') THEN
		RAISE invalid_hospitalization_value;
	END IF;

	/*중복 환자 아이디 확인*/
	OPEN find_same_patient(v_p_id);
	FETCH find_same_patient INTO v_pid;
	CLOSE find_same_patient;
	IF (v_pid = v_p_id) THEN
		RAISE same_patient_id;
	END IF;

	/*담당 간호사 존재 여부 확인*/
	SELECT dnum
	INTO v_dnum
	FROM doctor
	WHERE doctorid = v_doctorid;

	SELECT nurseid
	INTO v_nid
	FROM nurse
	WHERE nurseid = v_nurseid and dnum = v_dnum;

	/*신규 환자 등록*/
	insert INTO patient (patientid, name, sex, phone, address, email, doctorid, hospitalization, nurseid)
	values (v_p_id, v_name, v_sex, v_phone, v_address, v_email, v_doctorid, v_hospitalization, v_nurseid); 
	commit;

	/*최초 진료 정보 등록*/
	insert INTO treatment (doctorid, patientid, treatmentdate, treatmentdetail)
	values (v_doctorid, v_p_id, TO_DATE(today, 'YYYY-MM-DD'), v_detail); 
	commit;

	result := '신규 환자를 등록했습니다.';
EXCEPTION
	--입력된 정보가 너무 긴 경우 에러
	WHEN too_long_text THEN
		result := '20002';
	WHEN null_value THEN
		result := '입력된 내용중 빈칸이 존재합니다. 모든 내용을 입력해주세요.';
	WHEN invalid_sex_value THEN
		result := '성별 정보가 올바르지 않습니다. M 또는 F를 입력하세요.';
	WHEN invalid_hospitalization_value THEN
		result := '입원 정보가 올바르지 않습니다. O 또는 X를 입력하세요.';
	WHEN same_patient_id THEN
		result := '이미 등록된 환자 아이디 입니다.';
	WHEN NO_DATA_FOUND THEN
		result := '해당 부서에 담당 간호사 정보가 없습니다.';
	WHEN OTHERS THEN
		result := SQLCODE;
END;
/