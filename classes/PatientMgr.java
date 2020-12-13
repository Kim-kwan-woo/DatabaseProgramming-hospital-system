package patientBean;

import java.sql.*;
import java.util.*;
import javax.sql.*;
import oracle.jdbc.driver.*;
import oracle.jdbc.pool.*;
import patientBean.*;

public class PatientMgr {

	private OracleConnectionPoolDataSource ocpds = null;
	private PooledConnection pool = null;

	public PatientMgr() {
		try {

			ocpds = new OracleConnectionPoolDataSource();

			ocpds.setURL("jdbc:oracle:thin:@210.94.199.20:1521:dblab");
			ocpds.setUser("ST2016112117");
			ocpds.setPassword("ST2016112117");

			pool = ocpds.getPooledConnection();
		} catch (Exception e) {
			System.out.println("Error : Connection Failed");
		}
	}

	/*get assined doctor name*/
	public String getDoctorName(String doctorid) {
		String name = null;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {
			conn = pool.getConnection();

			cstmt = conn.prepareCall("{? = call GetDoctorName(?)}");
			cstmt.setString(2, doctorid);
			cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
			cstmt.execute();
			name = cstmt.getString(1);

			cstmt.close();
			conn.close();
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		}

		return name;
	}

	/*get assined nurse name*/
	public String getNurseName(String nurseid) {
		String name = null;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {
			conn = pool.getConnection();

			cstmt = conn.prepareCall("{? = call GetNurseName(?)}");
			cstmt.setString(2, nurseid);
			cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
			cstmt.execute();
			name = cstmt.getString(1);

			cstmt.close();
			conn.close();
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		}

		return name;
	}

	/*get patient list*/
	public Vector getPatientList(String user_id, String user_job) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String mySQL = null;
		Vector vecList = new Vector();

		try {
			conn = pool.getConnection();

			if("doctor".equals(user_job)){
				mySQL = "select patientid, name, sex, phone, address, email, doctorid, hospitalization, nurseid from patient where doctorid=?";
			} else{
				mySQL = "select patientid, name, sex, phone, address, email, doctorid, hospitalization, nurseid from patient where nurseid=?";
			}
			pstmt = conn.prepareStatement(mySQL);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Patient pt = new Patient();
				pt.setPatientid(rs.getString("patientid"));
				pt.setName(rs.getString("name"));
				pt.setSex(rs.getString("sex"));
				pt.setPhone(rs.getString("phone"));
				pt.setAddress(rs.getString("address"));
				pt.setEmail(rs.getString("email"));
				pt.setDoctorid(rs.getString("doctorid"));
				pt.setHospitalization(rs.getString("hospitalization"));
				pt.setNurseid(rs.getString("nurseid"));
				vecList.add(pt);
			}
			pstmt.close();
			conn.close();

		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		}
		return vecList;
	}

	/*insert new patient*/
	public String insertPatient(String p_id, String p_name, String p_sex, String p_phone, String p_address, String p_email, String p_doctorid, String p_hospitalization, String p_nurseid, String t_detail) {
		Connection conn = null;
		CallableStatement cstmt = null;
		String Result = null;
		try {
			conn = pool.getConnection();

			cstmt = conn.prepareCall("{call InsertPatient(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");
			cstmt.setString(1, p_id);
			cstmt.setString(2, p_name);
			cstmt.setString(3, p_sex);
			cstmt.setString(4, p_phone);
			cstmt.setString(5, p_address);
			cstmt.setString(6, p_email);
			cstmt.setString(7, p_doctorid);
			cstmt.setString(8, p_hospitalization);
			cstmt.setString(9, p_nurseid);
			cstmt.setString(10, t_detail);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.execute();
			Result = cstmt.getString(11);
			cstmt.close();
			conn.close();
			
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		}
        
		return Result;
	}

	/*update patient information*/
	public String updatePatient(String p_id, String p_name, String p_sex, String p_phone, String p_address, String p_email, String p_hospitalization) {
		Connection conn = null;
		CallableStatement cstmt = null;
		String Result = null;
		try {
			conn = pool.getConnection();

			cstmt = conn.prepareCall("{call UpdatePatient(?, ?, ?, ?, ?, ?, ?, ?)}");
			cstmt.setString(1, p_id);
			cstmt.setString(2, p_name);
			cstmt.setString(3, p_sex);
			cstmt.setString(4, p_phone);
			cstmt.setString(5, p_address);
			cstmt.setString(6, p_email);
			cstmt.setString(7, p_hospitalization);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.execute();
			Result = cstmt.getString(8);
			cstmt.close();
			conn.close();
			
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		}
        
		return Result;
	}
}