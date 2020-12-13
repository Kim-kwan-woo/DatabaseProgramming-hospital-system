/*새로운 간호사 정보를 insert*/
CREATE OR REPLACE PROCEDURE InsertNurse(v_n_id IN VARCHAR2,
	v_name IN VARCHAR2,
	v_sex IN VARCHAR2,
	v_phone IN VARCHAR2,
	v_email IN VARCHAR2,
	v_password IN VARCHAR2,
	v_dnum IN NUMBER,
	result OUT VARCHAR2)
IS
	null_value EXCEPTION;
	too_long_text EXCEPTION;
	invalid_sex_value EXCEPTION;
	same_nurse_id EXCEPTION;
	
	v_nid nurse.nurseid%TYPE;

	CURSOR find_same_nurse(n_id nurse.nurseid%TYPE) IS
	SELECT nurseid
	FROM nurse
	WHERE nurseid = n_id;
BEGIN
	/*입력된 정보 길이 확인*/
	IF(LENGTH(v_n_id) > 8 or LENGTH(v_name) > 3 or LENGTH(v_phone) > 11 or LENGTH(v_email) > 20 or LENGTH(v_password) > 8) THEN
		RAISE too_long_text;
	END IF;

	/*null 값 에러*/
	IF(v_n_id IS null or v_name IS null or v_sex IS null or v_phone IS null or v_email IS null or v_password IS null) THEN
		RAISE null_value;
	END IF;

	/*성별 입력 값 확인*/
	IF(v_sex != 'F' and v_sex != 'M') THEN
		RAISE invalid_sex_value;
	END IF;

	/*중복 간호사 아이디 확인*/
	OPEN find_same_nurse(v_n_id);
	FETCH find_same_nurse INTO v_nid;
	CLOSE find_same_nurse;
	IF (v_nid = v_n_id) THEN
		RAISE same_nurse_id;
	END IF;
	 
	/*신규 간호사 등록*/
	insert INTO nurse (nurseid, name, sex, phone, email, dnum, password)
	values (v_n_id, v_name, v_sex, v_phone, v_email, v_dnum, v_password); 
	commit;

	result := '신규 간호사를 등록했습니다.';
EXCEPTION
	--입력된 정보가 너무 긴 경우 에러
	WHEN too_long_text THEN
		result := '20005';
	WHEN null_value THEN
		result := '입력된 내용중 빈칸이 존재합니다. 모든 내용을 입력해주세요.';
	WHEN invalid_sex_value THEN
		result := '성별 정보가 올바르지 않습니다. M 또는 F를 입력하세요.';
	WHEN same_nurse_id THEN
		result := '이미 등록된 간호사 아이디 입니다.';
	WHEN OTHERS THEN
		result := SQLCODE;
END;
/