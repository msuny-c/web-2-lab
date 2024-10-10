package ru.itmo.app;

public class PointValidator {
    public static boolean validate(PointData point) {
        return validateX(point.x()) && validateY(point.y()) && validateR(point.r());
    }
    public static boolean inArea(PointData point) {
        return inCircle(point) || inRectangle(point) || inTriangle(point);
    }
    private static boolean inCircle(PointData point) {
        return point.x() <= 0 && point.y() >= 0 && Math.pow(point.x(), 2) + Math.pow(point.y(), 2) <= Math.pow(point.r(), 2);  
    }
    private static boolean inRectangle(PointData point) {
        return point.x() >= 0 && point.y() <= 0 && point.x() <= point.r() && point.y() >= -point.r() / 2;
    }
    private static boolean inTriangle(PointData point) {
        return point.x() >= 0 && point.x() <= point.r() / 2 && point.y() >= 0 && point.y() <= point.r() && point.y() <= -2 * point.x() + point.r();
    }
    private static boolean validateX(double x) {
        return x == Math.ceil(x) && -4 <= x && x <= 4;
    }
    private static boolean validateY(double y) {
        return -5 < y && y < 3;
    }
    private static boolean validateR(double r) {
        return r == Math.ceil(r) && 1 <= r && r <= 5;
    }
}
