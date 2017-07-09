package com.lcg.mappers;

import com.lcg.models.Hotel;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class HotelMapper implements RowMapper<Hotel> {
    public Hotel mapRow(ResultSet rs, int rowNum) throws SQLException {
        Hotel hotel = new Hotel();
        hotel.setHotelId(rs.getString("hotelId"));
        hotel.setName(rs.getString("name"));
        hotel.setAddress(rs.getString("address"));
        hotel.setCity(rs.getString("city"));
        hotel.setLongitude(rs.getFloat("longitude"));
        hotel.setLatitude(rs.getFloat("latitude"));
        return hotel;
    }
}
