/*의사정보를 insert하기 전 오류 확인 트리거*/
CREATE OR REPLACE TRIGGER BeforeInsertDoctor
BEFORE INSERT ON doctor
FOR EACH ROW
DECLARE
	underflow_length EXCEPTION;
	invalid_value EXCEPTION;
	invalid_sex EXCEPTION;
	nLength NUMBER;
	nBlankName NUMBER := 0;
	nBlankSex NUMBER := 0;
	nBlankPhone NUMBER := 0;
	nBlankEmail NUMBER := 0;
	nBlankPassword NUMBER := 0;
	v_sex doctor.sex%TYPE;
BEGIN
	SELECT length(:new.password), instr(:new.name, ' '), instr(:new.sex, ' '), instr(:new.phone, ' '),  instr(:new.email, ' '), instr(:new.password, ' '), :new.sex
	INTO nLength, nBlankName, nBlankSex, nBlankPhone, nBlankEmail, nBlankPassword, v_sex
	FROM dual;

	/*암호 자리 수 확인(4자리 미만 오류)*/
	IF (nLength < 4) THEN
		RAISE underflow_length;
	/*모든 정보의 공백 확인(공백이 있을 시 오류)*/
	ELSIF (nBlankName > 0 or nBlankSex > 0 or nBlankPhone > 0 or nBlankEmail > 0 or nBlankPassword > 0 ) THEN
		RAISE invalid_value;
	/*입력된 성별 정보 확인 (M또는 F만 가능)*/
	ELSIF (v_sex != 'F' and v_sex != 'M') THEN
		RAISE invalid_sex;
	END IF;
EXCEPTION
	WHEN underflow_length THEN
		RAISE_APPLICATION_ERROR(-20002, '암호는 4자리 이상이어야 한다.');
	WHEN invalid_value THEN
		RAISE_APPLICATION_ERROR(-20003, '입력된 정보에 공백이 있습니다.');
	WHEN invalid_sex THEN
		RAISE_APPLICATION_ERROR(-20004, '성별은 M 또는 F를 입력해야 합니다.');
END;
/