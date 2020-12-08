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
}