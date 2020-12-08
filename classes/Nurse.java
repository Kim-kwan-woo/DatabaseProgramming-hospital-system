package nurseBean;

public class Nurse {
	private String nurseid;
	private String name;
	private String sex;
	private String phone;
	private String email;
	private String assignedwork;
	private int dnum;
	private String password;

	public Nurse() {
		nurseid = null;
		name = null;
		sex = null;
		phone = null;
		email = null;
		assignedwork = null;
		dnum = 0;
		password = null;
	}

	public void setNurseid(String nurseid) {
		this.nurseid = nurseid;
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

	public void setAssignedWork(String assignedwork) {
		this.assignedwork = assignedwork;
	}

	public void setDnum(int dnum) {
		this.dnum = dnum;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNurseid() {
		return nurseid;
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
	
	public String getAssignedWork() {
		return assignedwork;
	}

	public int getDnum() {
		return dnum;
	}

	public String getPassword() {
		return password;
	}
}