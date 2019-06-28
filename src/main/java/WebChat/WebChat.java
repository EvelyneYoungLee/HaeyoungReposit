package WebChat;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;


@ServerEndpoint(value="/chat", configurator = HttpSessionSetter.class) // 미리 만들어둔 Configuration extends class의 설정을 여기서 쓰겠다는 뜻
public class WebChat {

	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
	//하나의 Collection에 사용자 정보를 담을 것이고, 이 하나의 컬렉션을 계속 쓸것이기 때문에 static으로 쓴다
	//그런데 이 때 Session은 Http의 Session이 아니라 WebSocket의 Session이다
	//동기화 처리를 위해 synchronizedSet을 사용한다

	private String id;

	@OnMessage
	public void onMessage(String message, Session session) throws Exception{

		synchronized(clients) { // concurrent modification Exception을 박지하기 위해
			for(Session each : clients) {
				System.out.println(message);

				each.getBasicRemote().sendText(this.id+" 님의 메세지 : "+message);

			}
		}
	}

	@OnOpen // 함수의 이름은 아무거나 설정해도 상관없지만, @OnOpen Annotation은 반드시 붙어야  WebSocket이 실행시킨다
	public void onOpen(Session session, EndpointConfig ec) {
		HttpSession hsession = (HttpSession)ec.getUserProperties().get("HttpSession");
		this.id = (String)hsession.getAttribute("userId");
		System.out.println(this.id + " 님이 채팅에 접속하였습니다.");
		//System.out.println(session.getUserProperties().get("javax.websocket.endpoint.remoteAddress"));
		clients.add(session);
	}

	@OnClose // 연결이 종료되었을 때 HashSet에서 지우는 작업
	public void onClose(Session session) {
		clients.remove(session);
	}

}
