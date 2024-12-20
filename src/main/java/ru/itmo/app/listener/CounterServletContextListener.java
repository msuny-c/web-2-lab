package ru.itmo.app.listener;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import ru.itmo.app.model.HeaderCounter;

@WebListener
public class CounterServletContextListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent event) {
        var context = event.getServletContext();
        context.setAttribute("counter", new HeaderCounter());
    }
}
