//Abstract Gate class
//Mandatory assignment
//Course 02158 Concurrent Programming, DTU,  Fall 2023

//Hans Henrik Lovengreen     Sep 26, 2023

public abstract class Gate {

    public static Gate create() {
        return new SemGate(); // Change to select implementation
    }

    public abstract void pass() throws InterruptedException;

    public abstract void open();

    public abstract void close();
}
