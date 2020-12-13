package chartBean;

import java.sql.*;
import java.util.*;
import javax.sql.*;
import oracle.jdbc.driver.*;
import oracle.jdbc.pool.*;
import chartBean.*;

public class ChartMgr {

	private OracleConnectionPoolDataSource ocpds = null;
	private PooledConnection pool = null;

	public ChartMgr() {
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

	/*get patient name*/
	public String getPatientName(String patientid) {
		String name = null;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {
			conn = pool.getConnection();

			cstmt = conn.prepareCall("{? = call GetPatientName(?)}");
			cstmt.setString(2, patientid);
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

	/*get doctor name*/
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

	/*get treatment detail*/
	public String getTreatmentDetail(String p_id, String d_id, String t_date) {
		String detail = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String mySQL = null;

		try {
			conn = pool.getConnection();

			mySQL = "select treatmentdetail from treatment where patientid=? and doctorid=? and treatmentdate = TO_DATE(?, 'YYYY-MM-DD')";
			pstmt = conn.prepareStatement(mySQL);
			pstmt.setString(1, p_id);
			pstmt.setString(2, d_id);
			pstmt.setString(3, t_date);
			rs = pstmt.executeQuery();

			if(rs.next()){
				detail = rs.getString("treatmentdetail");
			}			

			pstmt.close();
			conn.close();
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		}

		return detail;
	}

	/*get chart list*/
	public Vector getChartList(String patient_id, String doctor_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String mySQL = null;
		Vector vecList = new Vector();

		try {
			conn = pool.getConnection();

			mySQL = "select patientid, doctorid, treatmentdate, treatmentdetail from treatment where patientid=? and doctorid=? order by treatmentdate";
			pstmt = conn.prepareStatement(mySQL);
			pstmt.setString(1, patient_id);
			pstmt.setString(2, doctor_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Chart ch = new Chart();
				ch.setPatientid(rs.getString("patientid"));
				ch.setDoctorid(rs.getString("doctorid"));
				ch.setTreatmentDate(rs.getString("treatmentdate").substring(0, 10));
				ch.setTreatmentDetail(rs.getString("treatmentDetail"));
				vecList.add(ch);
			}
			pstmt.close();
			conn.close();

		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		}
		return vecList;
	}

	/*update treatment detail*/
	public String updateTreatmentDetail(String p_id, String d_id, String t_detail, String t_date) {
		Connection conn = null;
		CallableStatement cstmt = null;
		String Result = null;
		try {
			conn = pool.getConnection();

			cstmt = conn.prepareCall("{call UpdateChart(?, ?, ?, ?, ?)}");
			cstmt.setString(1, p_id);
			cstmt.setString(2, d_id);
			cstmt.setString(3, t_detail);
			cstmt.setString(4, t_date);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.execute();
			Result = cstmt.getString(5);
			cstmt.close();
			conn.close();
			
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		}
        
		return Result;
	}

	/*insert new treatment*/
	public String insertTreatment(String p_id, String d_id, String t_detail) {
		Connection conn = null;
		CallableStatement cstmt = null;
		String Result = null;
		try {
			conn = pool.getConnection();

			cstmt = conn.prepareCall("{call InsertChart(?, ?, ?, ?)}");
			cstmt.setString(1, p_id);
			cstmt.setString(2, d_id);
			cstmt.setString(3, t_detail);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.execute();
			Result = cstmt.getString(4);
			cstmt.close();
			conn.close();
			
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		}
        
		return Result;
	}
}