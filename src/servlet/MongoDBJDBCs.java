package servlet;

import com.mongodb.MongoClient;
import com.mongodb.ServerAddress;
import com.mongodb.client.MongoDatabase;

public class MongoDBJDBCs{
	
	  private final static String HOST = "localhost";
	   private final static int PORT = 27017;

	   public final static String DATABASE = "easygo";
	   public final static String COLLECTION = "tb_comment";
	   public static synchronized MongoClient getCon() throws Exception {
		 
		 return new MongoClient(new ServerAddress(HOST, PORT));
	}  
}