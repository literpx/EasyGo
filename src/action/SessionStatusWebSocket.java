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

//@ServerEndpointע���е��������û��ͻ���websocket������url,����ws://127.0.0.1:80/websocket/ws,
//�ṹ��ʽΪ��ws��//ip:�˿�/��Ŀ��/ָ����url��
@ServerEndpoint("/ws")
//@ServerEndpoint(value = "/ws", configurator = GetHttpSessionConfigurator.class)
public class SessionStatusWebSocket {
 
	private static int onlineCount = 0;
	// concurrent�����̰߳�ȫSet���������ÿ���ͻ��˶�Ӧ��webSocketSet������Ҫʵ�ַ�����뵥һ�ͻ���ͨ�ŵĻ�������ʹ��Map����ţ�����Key����Ϊ�û���ʶ
	private static CopyOnWriteArraySet<SessionStatusWebSocket> webSocketSet = new CopyOnWriteArraySet<SessionStatusWebSocket>();
	// һ���Ự�������
	private static Map<String, SessionStatusWebSocket> socketNumb = new ConcurrentHashMap<String, SessionStatusWebSocket>();
	// ��ĳ���ͻ��˵����ӻỰ����Ҫͨ���������ͻ��˷�������
	private Session session;
	// �����Ự
 
	/**
	 * ���ӽ����ɹ����õķ���
	 * 
	 * @param session
	 *            ��ѡ�Ĳ�����sessionΪ��ĳ���ͻ��˵����ӻỰ����Ҫͨ���������ͻ��˷�������
	 */
	@OnOpen
	public void onOpen(Session session) {
		this.session = session;
		addOnlineCount(); // ������+1
		System.out.println("�������Ӽ��룡��ǰ������Ϊ��" + getOnlineCount());
	}
 
	/**
	 * ���ӹرյ��õķ���
	 */
	@OnClose
	public void onClose() {
		webSocketSet.remove(this); // ��set��ɾ��
		subOnlineCount(); // ��������1
		System.out.println("��һ���ӹرգ���ǰ������Ϊ��" + getOnlineCount());
	}
 
	/**
	 * �յ��ͻ�����Ϣ����õķ���
	 * 
	 * @param message
	 *            �ͻ��˷��͹�������Ϣ
	 * @param session
	 *            ��ѡ�Ĳ���
	 */
	@OnMessage
	public void onMessage(String message, Session session) {       
		try {
			
			if(message.substring(0, 3).equals("uid")) {
				String uid=message.substring(3);
				if(!StringUtils.isBlank(uid)) {
					System.out.println("uid:"+uid);
					socketNumb.put(uid, this);
					this.session.getBasicRemote().sendText("�󶨳ɹ�");
				}
				
			}
			if(message.substring(0, 3).equals("���͵�")) {  //�û���ĳ�û�������Ϣ�ĸ�ʽ�� "���͵�uid&&&��Ϣ����"��uidΪ�Է�id
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
	 * ��������ʱ����
	 * 
	 * @param session
	 * @param error
	 */
	@OnError
	public void onError(Session session, Throwable error) {
		System.out.println("��������");
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
