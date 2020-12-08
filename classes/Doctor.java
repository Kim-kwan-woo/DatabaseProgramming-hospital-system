package doctorBean;

public class Doctor {
	private String doctorid;
	private String name;
	private String sex;
	private String phone;
	private String email;
	private int dnum;
	private String password;

	public Doctor() {
		doctorid = null;
		name = null;
		sex = null;
		phone = null;
		email = null;
		dnum = 0;
		password = null;
	}

	public void setDoctorid(String doctorid) {
		this.doctorid = doctorid;
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

	public void setEmail(String email) {
		this.email = email;
	}

	public void setDnum(int dnum) {
		this.dnum = dnum;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getDoctorid() {
		return doctorid;
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

	public String getEmail() {
		return email;
	}

	public int getDnum() {
		return dnum;
	}

	public String getPassword() {
		return password;
	}
}