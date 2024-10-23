package ru.itmo.app;

import java.util.Map;

public interface IHeaderCounter<T extends Number> {
    void increment(String header);
    Map<String, T> getMap();
}
