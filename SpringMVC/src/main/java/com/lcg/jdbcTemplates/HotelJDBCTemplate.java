package com.lcg.jdbcTemplates;

import com.lcg.mappers.HotelMapper;
import com.lcg.dao.HotelDAO;
import com.lcg.models.Hotel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.util.List;



public class HotelJDBCTemplate implements HotelDAO {
    @Autowired
    HotelMapper hotelmap;

    private DataSource dataSource;
    private JdbcTemplate jdbcTemplateObject;

    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
        this.jdbcTemplateObject = new JdbcTemplate(dataSource);
    }

    public boolean insertHotel(Hotel hotel) {
        try {
            String SQL = "insert into hotels (hotelId,name,address,city,longitude,latitude) values (?,?,?,?,?,?)";
            jdbcTemplateObject.update(SQL,hotel.getHotelId(),hotel.getName(),hotel.getAddress(),hotel.getCity(),hotel.getLongitude(),hotel.getLatitude());
            return true;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
    }

    public List<Hotel> listHotels(String type,String text) {
        List<Hotel> hotels;
        String SQL;
        if(type.equals("name")){
            SQL = "select * from hotels where name LIKE ? ORDER BY name";
            hotels = jdbcTemplateObject.query(SQL,new Object[]{"%"+text+"%"},hotelmap);
        }else{
            SQL = "select * from hotels where city LIKE ? ORDER BY city";
            hotels = jdbcTemplateObject.query(SQL,new Object[]{"%"+text+"%"}, hotelmap);
        }
        return hotels;
    }


    public String getLastId() throws SQLException, ClassNotFoundException {
        String SQL = "select hotelId from hotels order by hotelId desc limit 1";
        List<String> strings = (List<String>) jdbcTemplateObject.queryForList(SQL, String.class);
        if (!strings.isEmpty())
            return strings.get(0).toString();
        else
            return "H000000000";
    }

}