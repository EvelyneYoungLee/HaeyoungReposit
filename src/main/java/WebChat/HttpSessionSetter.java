package WebChat;

import javax.servlet.http.HttpSession;
import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;

public class HttpSessionSetter extends ServerEndpointConfig.Configurator{

	@Override
	public void modifyHandshake(ServerEndpointConfig sec, HandshakeRequest request, HandshakeResponse response) {
		// HandShakeRequest는 우리가 Web에서 쓰는 request가 아니다, 임시 객체
		HttpSession hsession = (HttpSession)request.getHttpSession();
		sec.getUserProperties().put("HttpSession", hsession);
	}
	
}
