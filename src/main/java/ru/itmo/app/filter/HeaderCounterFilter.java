package ru.itmo.app.filter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ru.itmo.app.model.IHeaderCounter;

import java.io.IOException;
import java.util.Objects;

@WebFilter("/*")
public class HeaderCounterFilter extends HttpFilter {
    @Override
    protected void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {
        var headers = request.getHeaderNames();
        var context = getServletContext();
        var map = (IHeaderCounter<?>) context.getAttribute("counter");
        if (!Objects.equals(request.getHeader("BadHeader"), "true")) {
            while (headers.hasMoreElements()) {
                map.increment(headers.nextElement());
            }
            chain.doFilter(request, response);
        } else {
            response.setStatus(400);
        }
    }
}

