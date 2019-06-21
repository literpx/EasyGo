package action;
import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArraySet;

import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.CloseReason;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.apache.commons.lang.StringUtils;

import bean.User;

//@ServerEndpoint注解中的内容是用户客户端websocket的连接url,例如ws://127.0.0.1:80/websocket/ws,
//结构形式为“ws：//ip:端口/项目名/指定的url”
@ServerEndpoint("/ws")
//@ServerEndpoint(value = "/ws", configurator = GetHttpSessionConfigurator.class)
public class SessionStatusWebSocket {
 
	private static int onlineCount = 0;
	// concurrent包的线程安全Set，用来存放每个客户端对应的webSocketSet对象。若要实现服务端与单一客户端通信的话，可以使用Map来存放，其中Key可以为用户标识
	private static CopyOnWriteArraySet<SessionStatusWebSocket> webSocketSet = new CopyOnWriteArraySet<SessionStatusWebSocket>();
	// 一个会话可能造成
	private static Map<String, SessionStatusWebSocket> socketNumb = new ConcurrentHashMap<String, SessionStatusWebSocket>();
	// 与某个客户端的连接会话，需要通过它来给客户端发送数据
	private Session session;
	// 整个会话
 
	/**
	 * 连接建立成功调用的方法
	 * 
	 * @param session
	 *            可选的参数。session为与某个客户端的连接会话，需要通过它来给客户端发送数据
	 */
	@OnOpen
	public void onOpen(Session session) {
		this.session = session;
		addOnlineCount(); // 连接数+1
		System.out.println("有新连接加入！当前连接数为：" + getOnlineCount());
	}
 
	/**
	 * 连接关闭调用的方法
	 */
	@OnClose
	public void onClose() {
		webSocketSet.remove(this); // 从set中删除
		subOnlineCount(); // 在线数减1
		System.out.println("有一连接关闭！当前连接数为：" + getOnlineCount());
	}
 
	/**
	 * 收到客户端消息后调用的方法
	 * 
	 * @param message
	 *            客户端发送过来的消息
	 * @param session
	 *            可选的参数
	 */
	@OnMessage
	public void onMessage(String message, Session session) {       
		try {
			
			if(message.substring(0, 3).equals("uid")) {
				String uid=message.substring(3);
				if(!StringUtils.isBlank(uid)) {
					System.out.println("uid:"+uid);
					socketNumb.put(uid, this);
					this.session.getBasicRemote().sendText("绑定成功");
				}
				
			}
			if(message.substring(0, 3).equals("发送到")) {  //用户给某用户发送信息的格式： "发送到uid&&&信息内容"，uid为对方id
				System.out.println(message);
				int index=message.indexOf("&&&");
				String uid=message.substring(3,index);
				if(!StringUtils.isBlank(uid)) {
					System.out.println("touid:"+uid);
					if(socketNumb.get(uid)!=null) {
						String msg=message.substring(index+3);
						socketNumb.get(uid).session.getBasicRemote().sendText(msg);
					}
					
				}
			}
			//sendMessage(message);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
 
	/**
	 * 发生错误时调用
	 * 
	 * @param session
	 * @param error
	 */
	@OnError
	public void onError(Session session, Throwable error) {
		System.out.println("发生错误");
		error.printStackTrace();
	}
 
	public void sendMessage(String message) throws IOException {
		
		this.session.getBasicRemote().sendText(message);
	}
 
	public static synchronized int getOnlineCount() {
		return onlineCount;
	}
 
	public static synchronized void addOnlineCount() {
		onlineCount = SessionStatusWebSocket.getOnlineCount();
		onlineCount++;
	}
 
	public static synchronized void subOnlineCount() {
		onlineCount = SessionStatusWebSocket.getOnlineCount();
		onlineCount--;
	}
}
