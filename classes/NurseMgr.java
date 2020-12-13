package nurseBean;

import java.sql.*;
import java.util.*;
import javax.sql.*;
import oracle.jdbc.driver.*;
import oracle.jdbc.pool.*;
import nurseBean.*;

public class NurseMgr {

	private OracleConnectionPoolDataSource ocpds = null;
	private PooledConnection pool = null;

	public NurseMgr() {
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

	/*find maximum dnum*/
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

	/*get department name*/
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

	/*get all nurse list*/
	public Vector getNurseList(int dnumber) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector vecList = new Vector();

		try {
			conn = pool.getConnection();

			String mySQL = "select nurseid, name, sex, phone, email, dnum from nurse where dnum=?";
			pstmt = conn.prepareStatement(mySQL);
			pstmt.setInt(1, dnumber);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Nurse nr = new Nurse();
				nr.setNurseid(rs.getString("Nurseid"));
				nr.setName(rs.getString("name"));
				nr.setSex(rs.getString("sex"));
				nr.setPhone(rs.getString("phone"));
				nr.setEmail(rs.getString("email"));
				nr.setDnum(rs.getInt("dnum"));
				vecList.add(nr);
			}
			pstmt.close();
			conn.close();

		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		}
		return vecList;
	}

	/*insert new nurse*/
	public String insertNurse(String n_id, String n_name, String n_sex, String n_phone, String n_email, String n_password, int n_dnum) {
		Connection conn = null;
		CallableStatement cstmt = null;
		String Result = null;
		try {
			conn = pool.getConnection();

			cstmt = conn.prepareCall("{call InsertNurse(?, ?, ?, ?, ?, ?, ?, ?)}");
			cstmt.setString(1, n_id);
			cstmt.setString(2, n_name);
			cstmt.setString(3, n_sex);
			cstmt.setString(4, n_phone);
			cstmt.setString(5, n_email);
			cstmt.setString(6, n_password);
			cstmt.setInt(7, n_dnum);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.execute();
			Result = cstmt.getString(8);
			cstmt.close();
			conn.close();
			
		} catch (SQLException ex) {
			if (ex.getErrorCode() == 20002) Result="-20002";
        			else if (ex.getErrorCode() == 20003) Result="-20003";
        			else if (ex.getErrorCode() == 20004) Result="-20004";
			else Result="20006";
		}
        
		return Result;
	}
}