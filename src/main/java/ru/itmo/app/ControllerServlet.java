package ru.itmo.app;

import java.io.IOException;

import com.fasterxml.jackson.databind.DatabindException;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/controller")
public class ControllerServlet extends HttpServlet {
    private ObjectMapper mapper = new ObjectMapper();
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) 
    throws ServletException, IOException {
        try {
            var point = mapper.readValue(request.getReader(), PointData.class);
            request.getServletContext().setAttribute("point", point);
            request.getRequestDispatcher("/check").forward(request, response);
        } catch (DatabindException exception) {
            response.setStatus(400);
        }
    }
}
