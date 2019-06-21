package db;
import org.bson.Document;
 
import com.mongodb.MongoClient;
import com.mongodb.MongoClientOptions;
import com.mongodb.ServerAddress;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
 
public class MongoManager {
	private static MongoClient mongoClient = null;
 
	private MongoManager() {
	}
 
	@SuppressWarnings("resource")
	public static MongoClient getMongoClient() {
		if (mongoClient == null) {
			synchronized (MongoClient.class) {
				if (mongoClient == null) {
					ServerAddress serverAddress = new ServerAddress("localhost", 27017);
					mongoClient = new MongoClient(serverAddress);
					MongoClientOptions options = MongoClientOptions.builder().maxWaitTime(2000)
							.maxConnectionLifeTime(2000).maxConnectionIdleTime(2000).build();
				}
			}
		}
		return mongoClient;
	}
	public static void closeMongoCollection(MongoClient mongoClient) {
		if (mongoClient != null) {
			mongoClient.close();
		}
	}
}
