/*환자의 정보를 수정(업데이트)*/
CREATE OR REPLACE PROCEDURE UpdatePatient(v_p_id IN VARCHAR2,
	v_name IN VARCHAR2,
	v_sex IN VARCHAR2,
	v_phone IN VARCHAR2,
	v_address IN VARCHAR2,
	v_email IN VARCHAR2,
	v_hospitalization IN VARCHAR2,
	result OUT VARCHAR2)
IS
	no_change EXCEPTION;
	null_value EXCEPTION;
	too_long_text EXCEPTION;
	invalid_sex_value EXCEPTION;
	invalid_hospitalization_value EXCEPTION;

	v_pname patient.name%TYPE;
	v_psex patient.sex%TYPE;
	v_pphone patient.phone%TYPE;
	v_paddress patient.address%TYPE;
	v_pemail patient.email%TYPE;
	v_phospitalization patient.hospitalization%TYPE;

	CURSOR find_patient_info(pid patient.patientid%TYPE) IS
	SELECT name, sex, phone, address, email, hospitalization
	FROM patient
	WHERE patientid = pid;
BEGIN
	/*변경된 내용이 없을 경우*/
	OPEN find_patient_info(v_p_id);
	FETCH find_patient_info INTO v_pname, v_psex, v_pphone, v_paddress, v_pemail, v_phospitalization;
	CLOSE find_patient_info;

	IF(v_name = v_pname and v_sex = v_psex and v_phone = v_pphone and v_address = v_paddress and v_email = v_pemail and v_hospitalization = v_phospitalization) THEN
		RAISE no_change;
	END IF;

	/*입력된 정보 길이 확인*/
	IF(LENGTH(v_name) > 3 or LENGTH(v_phone) > 11 or LENGTH(v_address) > 10 or LENGTH(v_email) > 20) THEN
		RAISE too_long_text;
	END IF;

	/*null 값 에러*/
	IF(v_name IS null or v_sex IS null or v_phone IS null or v_address IS null or v_email IS null or v_hospitalization IS null) THEN
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

	/*환자 정보 수정*/
	UPDATE patient
	SET name = v_name, sex = v_sex, phone = v_phone, address = v_address, email = v_email, hospitalization = v_hospitalization
	WHERE patientid = v_p_id;
	commit;

	result := '환자 정보가 수정되었습니다.';
EXCEPTION
	--입력된 정보가 너무 긴 경우 에러
	WHEN too_long_text THEN
		result := '20002';
	WHEN no_change THEN
		result := '변경된 정보가 없습니다.';
	WHEN null_value THEN
		result := '입력된 내용중 빈칸이 존재합니다. 모든 내용을 입력해주세요.';
	WHEN invalid_sex_value THEN
		result := '성별 정보가 올바르지 않습니다. M 또는 F를 입력하세요.';
	WHEN invalid_hospitalization_value THEN
		result := '입원 정보가 올바르지 않습니다. O 또는 X를 입력하세요.';
	WHEN OTHERS THEN
		result := SQLCODE;
END;
/
