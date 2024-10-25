package ru.itmo.app.model;

import java.util.Map;
import java.util.concurrent.*;

public class HeaderCounter implements IHeaderCounter<Long> {
    private final ConcurrentHashMap<String, Long> counter = new ConcurrentHashMap<>();
    public void increment(String header) {
        counter.put(header, counter.get(header) == null ? 1 : counter.get(header) + 1);
    }
    public Map<String, Long> getMap() {
        return counter;
    }
}
