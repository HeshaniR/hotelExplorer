package com.lcg.dao;

import com.lcg.models.Hotel;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.util.List;

public interface HotelDAO {
    public void setDataSource(DataSource ds);

    public boolean insertHotel(Hotel hotel);

    public List<Hotel> listHotels(String type,String city);

    public String getLastId() throws SQLException, ClassNotFoundException;

}