package doctorBean;

import java.sql.*;
import java.util.*;
import javax.sql.*;
import oracle.jdbc.driver.*;
import oracle.jdbc.pool.*;
import doctorBean.*;

public class DoctorMgr {

	private OracleConnectionPoolDataSource ocpds = null;
	private PooledConnection pool = null;

	public DoctorMgr() {
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

	/*find maximum dnum(department number)*/
	public int getMaxDnum() {
		int maxDnum = 0;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {
			conn = pool.getConnection();
			cstmt = conn.prepareCall("{? = call max_dnum}");
			cstmt.registerOutParameter(1, java.sql.Types.INTEGER);
			cstmt.execute();
			maxDnum = cstmt.getInt(1);

			cstmt.close();
			conn.close();
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		}

		return maxDnum;
	}

	/*get doctorid's department number*/
	public int getDnumber(String d_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int dnumber = 0;

		try {
			conn = pool.getConnection();

			String mySQL = "select dnum from doctor where doctorid=?";
			pstmt = conn.prepareStatement(mySQL);
			pstmt.setString(1, d_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dnumber = rs.getInt("dnum");
			}
			pstmt.close();
			conn.close();

		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		}
		return dnumber;
	}

	/*check input doctorid is head doctorid in he's department*/
	public boolean isHeadDoctor(int dnum, String d_id) {
		String doctorID = "";
		boolean check = false;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {
			conn = pool.getConnection();

			cstmt = conn.prepareCall("{? = call getHeadDoctor(?)}");
			cstmt.setInt(2, dnum);
			cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
			cstmt.execute();
			doctorID = cstmt.getString(1);

			if(d_id.equals(doctorID)){
				check = true;
			}
			cstmt.close();
			conn.close();
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		}

		return check;
	}

	/*get department name from dnumber(department number)*/
	public String getDname(int dnumber) {
		String dname = null;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {
			conn = pool.getConnection();

			cstmt = conn.prepareCall("{? = call find_dname(?)}");
			cstmt.setInt(2, dnumber);
			cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
			cstmt.execute();
			dname = cstmt.getString(1);

			cstmt.close();
			conn.close();
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		}

		return dname;
	}

	/*get all doctor list*/
	public Vector getDoctorList(int dnumber) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector vecList = new Vector();

		try {
			conn = pool.getConnection();

			String mySQL = "select doctorid, name, sex, phone, email, dnum from doctor where dnum=?";
			pstmt = conn.prepareStatement(mySQL);
			pstmt.setInt(1, dnumber);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Doctor dr = new Doctor();
				dr.setDoctorid(rs.getString("doctorid"));
				dr.setName(rs.getString("name"));
				dr.setSex(rs.getString("sex"));
				dr.setPhone(rs.getString("phone"));
				dr.setEmail(rs.getString("email"));
				dr.setDnum(rs.getInt("dnum"));
				vecList.add(dr);
			}
			pstmt.close();
			conn.close();

		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		}
		return vecList;
	}

	/*insert new doctor*/
	public String insertDoctor(String d_id, String d_name, String d_sex, String d_phone, String d_email, String d_password, int d_dnum) {
		Connection conn = null;
		CallableStatement cstmt = null;
		String Result = null;
		try {
			conn = pool.getConnection();

			cstmt = conn.prepareCall("{call InsertDoctor(?, ?, ?, ?, ?, ?, ?, ?)}");
			cstmt.setString(1, d_id);
			cstmt.setString(2, d_name);
			cstmt.setString(3, d_sex);
			cstmt.setString(4, d_phone);
			cstmt.setString(5, d_email);
			cstmt.setString(6, d_password);
			cstmt.setInt(7, d_dnum);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.execute();
			Result = cstmt.getString(8);
			cstmt.close();
			conn.close();
			
		} catch (SQLException ex) {
			if (ex.getErrorCode() == 20002) Result="-20002"; //short password
        			else if (ex.getErrorCode() == 20003) Result="-20003"; //spacing word
        			else if (ex.getErrorCode() == 20004) Result="-20004"; //wrong sex input
			else Result="20006"; //other error
		}
        
		return Result;
	}
}
