package patientBean;

public class Patient {
	private String patientid;
	private String name;
	private String sex;
	private String phone;
	private String address;
	private String email;
	private String doctorid;
	private String hospitalization;
	private String nurseid;

	public Patient() {
		patientid = null;
		name = null;
		sex = null;
		phone = null;
		address = null;
		email = null;
		doctorid = null;
		hospitalization = null;
		nurseid = null;
	}

	public void setPatientid(String patientid) {
		this.patientid = patientid;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setDoctorid(String doctorid) {
		this.doctorid = doctorid;
	}

	public void setHospitalization(String hospitalization) {
		this.hospitalization = hospitalization;
	}

	public void setNurseid(String nurseid) {
		this.nurseid = nurseid;
	}
	
	public String getPatientid() {
		return patientid;
	}

	public String getName() {
		return name;
	}

	public String getSex() {
		return sex;
	}

	public String getPhone() {
		return phone;
	}

	public String getAddress() {
		return address;
	}

	public String getEmail() {
		return email;
	}

	public String getDoctorid() {
		return doctorid;
	}

	public String getHospitalization() {
		return hospitalization;
	}

	public String getNurseid() {
		return nurseid;
	}
}