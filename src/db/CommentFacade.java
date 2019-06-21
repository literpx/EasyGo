package db;
import com.google.gson.Gson;
import com.mongodb.BasicDBObject;
import com.mongodb.Block;
import com.mongodb.MongoClient;
import com.mongodb.ServerAddress;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;

import bean.Comment;
import net.sf.json.JSONObject;
import servlet.MongoDBJDBCs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.logging.Logger;

import javax.management.Query;

//import javax.ejb.Stateless;
import org.bson.BsonDocument;
import org.bson.BsonRegularExpression;
import org.bson.Document;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Update;

//@Stateless
public class CommentFacade {

   private static final Logger LOGGER =
      Logger.getLogger(CommentFacade.class.getName());
   //private final static String HOST = "localhost";
  // private final static int PORT = 27017;

   public final static String DATABASE = "easygo";
   public final static String COLLECTION = "tb_comment";

   	private MongoClient mongoClient = MongoManager.getMongoClient();
   	private MongoCollection<Document> collection = mongoClient.getDatabase(DATABASE).getCollection(COLLECTION);
	         
   

   public int create(Comment c) {
	   int row=0;
	   collection =mongoClient.getDatabase(DATABASE).getCollection(COLLECTION);
      if  (c!=null) {
         Document d = new Document().append("cid", c.getCid())
        	.append("uid", c.getUid())
            .append("content", c.getContent())
            .append("pick",  new HashSet())
            .append("unpick",  new HashSet())
            .append("time", c.getTime())
            .append("childrenComment", new HashSet());
         collection.insertOne(d);
         row++;
      }
      return row;
   }

   public ArrayList<Comment> find(int cid) {
	   ArrayList<Comment> list = new ArrayList<Comment>();
	   collection =mongoClient.getDatabase(DATABASE).getCollection(COLLECTION);
     	FindIterable<Document> iter;
     	BasicDBObject query =new BasicDBObject();
     	query.put("cid", cid);
     	System.out.println(cid);
        iter = collection.find(query).sort(new BasicDBObject("time",-1));  ;
        iter.forEach(new Block<Document>() {
          @Override
          public void apply(Document doc) {
        	  String id=doc.getObjectId("_id").toString();
        	  doc.remove("_id");
        	  Comment comment=new Gson().fromJson(doc.toJson(), Comment.class);
        	  comment.set_id(id);
//        	  JSONObject jsonObject=JSONObject.fromObject(doc.toJson());
//        	  Comment comment=(Comment)JSONObject.toBean(jsonObject, Comment.class);
//        	  comment.set_id(doc.getObjectId("_id").toString());
        	  list.add(comment);
          }
       });

     return list;
  }
   public void updateComentPickOrNot(String rId,int uuId,String type,String pick) {         //参数为(cid,uid,pick or unpick)
	   collection =mongoClient.getDatabase(DATABASE).getCollection(COLLECTION);
	      BasicDBObject updateInfo =new BasicDBObject(type,new BasicDBObject(pick,uuId));
	      collection.updateOne(new BasicDBObject("_id",new ObjectId(rId)), updateInfo);
   }
   public void updateChildrenComentPickOrNot(String rId,int uid,int uuId,String type,String pick) {         //参数为(cid,uid,pick or unpick)
	   collection =mongoClient.getDatabase(DATABASE).getCollection(COLLECTION);
	      BasicDBObject updateInfo =new BasicDBObject(type,new BasicDBObject("childrenComment.$."+pick,uuId));
	      collection.updateOne(new BasicDBObject("_id",new ObjectId(rId)).append("childrenComment.uid", uid), updateInfo);
   }
   public void insertComentChildren(String rId,Comment c) {         //参数为(cid,评论bean)       增加子评论
	   collection =mongoClient.getDatabase(DATABASE).getCollection(COLLECTION);
	      Document d = new Document()
	          	  .append("uid", c.getUid())
	              .append("content", c.getContent())
	              .append("pick", new HashSet())
	              .append("unpick",  new HashSet())
	              .append("time", c.getTime());
	           //collection.insertOne(d);
	      
	      BasicDBObject updateInfo =new BasicDBObject("$push",new BasicDBObject("childrenComment",d));
	      collection.updateOne(new BasicDBObject("_id",new ObjectId(rId)), updateInfo);
	  }
   public void updateComentChildren(String rId,int uid,int inUid,String handle,String pick) {         //修改子评论点赞或者踩数量
	   collection =mongoClient.getDatabase(DATABASE).getCollection(COLLECTION);
	      BasicDBObject updateInfo =new BasicDBObject(handle,new BasicDBObject("childrenComment.$."+pick,inUid));
	      collection.updateOne(new BasicDBObject("_id",new ObjectId(rId)).append("childrenComment.uid", uid), updateInfo);
	  }
//   public List<Document> findAll(BasicDBObject query, String collName){
//		MongoCollection<Document> coll = this.mongoDatabase.getCollection(collName);
//		List<Document> result = new ArrayList<Document>();
//		FindIterable<Document> findIterable = coll.find(query);
//		MongoCursor<Document> mongoCursor = findIterable.iterator();
//		while(mongoCursor.hasNext()){
//			result.add(mongoCursor.next());
//		}
//		return result;
//	}

//   public void update(Comment c) {
//      MongoClient mongoClient = new
//         MongoClient(new ServerAddress(HOST, PORT));
//      MongoCollection<Document> collection =
//         mongoClient.getDatabase(DATABASE).getCollection(COLLECTION);
//      Document d = new Document();
//      d.append("id", c.getId())
//         .append("skillSet", c.getSkillSet())
//         .append("name", c.getName())
//         .append("email", c.getEmail())
//         .append("phone", c.getPhone())
//         .append("gender", c.getGender())
//         .append("lastDegree", c.getLastDegree())
//         .append("lastDesig", c.getLastDesig())
//         .append("expInYearMonth", c.getExpInYearMonth());
//      collection.updateOne(new Document("id", c.getId()),
//         new Document("$set", d));
//   }

//   public void delete(Comment c) {
//      MongoClient mongoClient = new
//         MongoClient(new ServerAddress(HOST, PORT));
//      MongoCollection<Document> collection =
//         mongoClient.getDatabase(DATABASE).getCollection(COLLECTION);
//      collection.deleteOne(new Document("id", c.getId()));
//   }

//   public List<Comment> find(String filter) {
//      List<Comment> list = new ArrayList<>();
//      MongoClient mongoClient =
//         new MongoClient(new ServerAddress(HOST, PORT));
//      MongoCollection<Document> collection =
//         mongoClient.getDatabase(DATABASE).getCollection(COLLECTION);
//      FindIterable<Document> iter;
//      if (filter == null || filter.trim().length() == 0) {
//         iter = collection.find();
//      } else {
//
//         BsonRegularExpression bsonRegex = new
//            BsonRegularExpression(filter);
//         BsonDocument bsonDoc = new BsonDocument();
//         bsonDoc.put("skillSet", bsonRegex);
//         iter = collection.find(bsonDoc);
//
//      }
//      iter.forEach(new Block<Document>() {
//         @Override
//         public void apply(Document doc) {
//            list.add(new Gson().fromJson(doc.toJson(), Comment.class));
//         }
//      });
//      return list;
//   }
}