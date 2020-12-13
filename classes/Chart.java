package chartBean;

public class Chart {
	private String doctorid;
	private String patientid;
	private String treatment_date;
	private String treatment_detail;

	public Chart() {
		doctorid = null;
		patientid = null;
		treatment_date= null;
		treatment_detail= null;
	}

	public void setDoctorid(String doctorid) {
		this.doctorid = doctorid;
	}

	public void setPatientid(String patientid) {
		this.patientid = patientid;
	}

	public void setTreatmentDate(String treatment_date) {
		this.treatment_date = treatment_date;
	}

	public void setTreatmentDetail(String treatment_detail) {
		this.treatment_detail = treatment_detail;
	}

	public String getDoctorid() {
		return doctorid;
	}

	public String getPatientid() {
		return patientid;
	}
	
	public String getTreatmentDate() {
		return treatment_date;
	}

	public String getTreatmentDetail() {
		return treatment_detail;
	}
}