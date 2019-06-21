package db;

import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class Conn {
    private static Connection con;
    private Statement stmt;
    private ResultSet rs;
    private PreparedStatement ps = null;

    private static final String drivername ="com.mysql.jdbc.Driver";
    private static final String url = "jdbc:mysql://127.0.0.1:3306/easygo_java";

    public static synchronized Connection getCon() throws Exception {
        try {
            Class.forName(drivername);
            con = DriverManager.getConnection(url,"root","");
            return con;
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            throw e;
        }
    }



    public Statement getStmtread() {    
        try {
            con = getCon();
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                       ResultSet.CONCUR_READ_ONLY);
            return stmt;
        } catch (Exception e) {
            System.err.println(e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

  
    public ResultSet getRs(String sql) {      //select
        try {
            stmt = getStmtread();
            rs = stmt.executeQuery(sql);
            
            return rs;
        } catch (Exception e) {
            System.err.println(e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public ResultSet getPs(String sql,HashMap<Integer,Object> params) {      //select
    	try {
			ps = con.prepareStatement(sql);
			
			for (Map.Entry<Integer, Object> entry : params.entrySet()) { 
				System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue()); 
				if (entry.getValue() instanceof Integer) {
					  ps.setInt(entry.getKey(),(int) entry.getValue());
				}else if (entry.getValue() instanceof String){
					  ps.setString(entry.getKey(),(String) entry.getValue());
				}else if (entry.getValue() instanceof Float) {
					ps.setFloat(entry.getKey(),(float) entry.getValue());
				}else if (entry.getValue() instanceof Long) {
					ps.setLong(entry.getKey(),(long) entry.getValue());
				}else if (entry.getValue() instanceof Double) {
					ps.setDouble(entry.getKey(), (double) entry.getValue());
				}else if (entry.getValue() instanceof Boolean) {
					 ps.setBoolean(entry.getKey(),(boolean) entry.getValue());
				}else if (entry.getValue() instanceof Date) {
//				    Date d = (Date) param;
//				    prepStatement.setDate(i + 1, (Date) param);
					 ps.setTime(entry.getKey(),(Time) entry.getValue());
				}
			}
			rs=ps.executeQuery();
			return rs;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return null;
    }
    public int getUpdatePs(String sql,HashMap<Integer,Object> params) { 
    	int row=-1;
    	try {
			ps = con.prepareStatement(sql);
			for (Map.Entry<Integer, Object> entry : params.entrySet()) { 
				System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue()); 
				if (entry.getValue() instanceof Integer) {
					ps.setInt(entry.getKey(),(int) entry.getValue());
				}else if (entry.getValue() instanceof String){
					ps.setString(entry.getKey(),(String) entry.getValue());
				}else if (entry.getValue() instanceof Float) {
					ps.setFloat(entry.getKey(),(float) entry.getValue());
				}else if (entry.getValue() instanceof Long) {
					ps.setLong(entry.getKey(),(long) entry.getValue());
				}else if (entry.getValue() instanceof Double) {
					ps.setDouble(entry.getKey(), (double) entry.getValue());
				}else if (entry.getValue() instanceof Boolean) {
					ps.setBoolean(entry.getKey(),(boolean) entry.getValue());
				}else if (entry.getValue() instanceof Date) {
					ps.setTime(entry.getKey(),(Time) entry.getValue());
				}
			}
			row= ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return row;
    }
    public Statement getStmt() {
        try {
            con = getCon();
            stmt = con.createStatement();
            return stmt;
        } catch (Exception e) {
            System.err.println(e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public int getUpdate(String sql) {      //ÕýÉ¾¸ÄÓï¾ä
        try {
            stmt = getStmt();
            return stmt.executeUpdate(sql);        
        } catch (Exception e) {
            System.err.println(e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }
    
   
    public synchronized void close() {
        try {
            if (rs != null) {
                rs.close();
                rs = null;
            }
        } catch (Exception e) {
            System.err.println(e.getMessage());
            e.printStackTrace();
        }
        try {
            if (stmt != null) {
                stmt.close();
                stmt = null;
            }
        } catch (Exception e) {
            System.err.println(e.getMessage());
            e.printStackTrace();
        }
        try {
            if (con != null) {
                con.close();
                con = null;
            }
        } catch (Exception e) {
            System.err.println(e.getMessage());
            e.printStackTrace();
        }
    }
}