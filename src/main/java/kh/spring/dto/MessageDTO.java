package kh.spring.dto;

public class MessageDTO {
	private int seq;
	private String name;
	private String message;
	public MessageDTO() {
		super();
	}
	public MessageDTO(int seq, String name, String message) {
		super();
		this.seq = seq;
		this.name = name;
		this.message = message;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}

}
