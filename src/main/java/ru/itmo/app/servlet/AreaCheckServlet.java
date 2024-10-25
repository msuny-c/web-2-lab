package ru.itmo.app.servlet;

import java.io.IOException;
import java.util.ArrayList;

import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ru.itmo.app.model.HitResponse;
import ru.itmo.app.model.PointData;
import ru.itmo.app.util.PointValidator;

@WebServlet("/check")
public class AreaCheckServlet extends HttpServlet {
    private final ObjectMapper mapper = new ObjectMapper();
    @SuppressWarnings("unchecked")
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
    throws ServletException, IOException {
        var context = request.getServletContext();
        var point = (PointData) context.getAttribute("point");
        if (point == null || !PointValidator.validate(point)) {
            response.setStatus(400);
            return;
        }
        var result = new HitResponse(point.x(), point.y(), point.r(), PointValidator.inArea(point));
        var session = request.getSession();
        var results = (ArrayList<HitResponse>) session.getAttribute("results");
        results = results == null ? new ArrayList<>() : results;
        results.add(result);
        session.setAttribute("results", results);
        response.setContentType("application/json");
        mapper.writeValue(response.getWriter(), result);
    }
}
