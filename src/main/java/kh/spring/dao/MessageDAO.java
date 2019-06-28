package kh.spring.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import kh.spring.dto.MessageDTO;

@Component
public class MessageDAO {

	@Autowired
	private JdbcTemplate template;

	public int insert(MessageDTO dto) throws Exception{
		String sql = "insert into message values(message_seq.nextval, ?, ?)";
		int result = template.update(sql,dto.getName(),dto.getMessage());

		return result;
	}

	public List<MessageDTO> selectAll() throws Exception{
		String sql = "select * from message";
		List<MessageDTO> list = template.query(sql, new RowMapper<MessageDTO>() {
			@Override
			public MessageDTO mapRow(ResultSet rs, int rn) throws SQLException {
				MessageDTO dto = new MessageDTO(rs.getInt(1),rs.getString(2),rs.getString(3));
				return dto;
			}			
		});
		return list;
	}
}
