package com.lcg.controllers;

import com.google.gson.GsonBuilder;
import com.lcg.dao.IDGenerator;
import com.lcg.jdbcTemplates.HotelJDBCTemplate;
import com.lcg.models.Hotel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@Controller
public class HomeController {
    @Autowired
    Hotel hotel;
    @Autowired
    private HotelJDBCTemplate hotelContext;
    public String current;


    @RequestMapping(value = {"home", ""}, method = RequestMethod.GET)
    public String home(HttpServletRequest request) {
        current="home";
        request.getSession().setAttribute("current",current);
        return "home";
    }

    @RequestMapping(value = "add", method = RequestMethod.GET)
    public String addHotel(HttpServletRequest request) {
        current="add";
        request.getSession().setAttribute("current", current);
        return "addHotel";
    }

    @RequestMapping(value = "search", method = RequestMethod.GET)
    public String searchHotel(HttpServletRequest request) {
        current="search";
        request.getSession().setAttribute("current", current);
        return "searchHotel";
    }

    @RequestMapping(value = "add", method = RequestMethod.POST)
    public String addHotel(ModelMap model,HttpServletRequest request) throws SQLException, ClassNotFoundException, IOException, ServletException {
        String id = IDGenerator.idGenarator("H", hotelContext.getLastId());
        hotel.setHotelId(id);
        hotel.setName(request.getParameter("name"));
        hotel.setAddress(request.getParameter("address"));
        hotel.setCity(request.getParameter("city"));
        hotel.setLongitude(Float.parseFloat(request.getParameter("longitude")));
        hotel.setLatitude(Float.parseFloat(request.getParameter("latitude")));
        
        if (hotelContext.insertHotel(hotel)) {
            model.put("msg", "Details added Successfully!!!");
            return "addHotel";
        } else {
            request.setAttribute("hotel", hotel);
            model.put("msg", "Failed!!!");
            return "addHotel";
        }
    }

    @RequestMapping(value = "search", method = RequestMethod.POST)
    public ResponseEntity<String> searchHotels(HttpServletRequest request) {
        current="search";
        request.getSession().setAttribute("current", current);
        List<Hotel> hotels=hotelContext.listHotels(request.getParameter("type"),request.getParameter("text"));

        com.google.gson.Gson gson = new GsonBuilder().disableHtmlEscaping().create();
        String jsonString = gson.toJson(hotels);
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.add("Content-Type", "text/html; charset=utf-8");
        return new ResponseEntity<String>(jsonString, responseHeaders, HttpStatus.CREATED);
    }

}
