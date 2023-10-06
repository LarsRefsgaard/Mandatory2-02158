//Skeleton implementation of an Alley class  using passing-the-baton
//Mandatory assignment 2
//Course 02158 Concurrent Programming, DTU,  Fall 2023

//Hans Henrik Lovengreen     Sep 26, 2023

public class BatonAlley extends Alley {
    int n_up, n_down, d_up, d_down, cars;
    Semaphore upSem, downSem, eSem;


    protected BatonAlley() {
        n_up = 0;
        n_down = 0;
        d_down = 0;
        d_up = 0;
        upSem = new Semaphore(0);
        downSem = new Semaphore(0);
        eSem = new Semaphore(1);
        

    
    }

    /* Block until car no. may enter alley */
    public void enter(int no) throws InterruptedException {
        if (no < 5) {
            eSem.P();
            if(n_down > 0){
                d_up++;
                eSem.V();
                upSem.P();
            }
            n_up++;
            cars++;
            if(d_up > 0){
                d_up--;
                upSem.V();
            } else {
                eSem.V();
            }

        } else {
            eSem.P();
            if(n_up > 0){
                d_down++;
                eSem.V();
                downSem.P();
            }
            n_down++;
            cars++;
            if(d_down > 0){
                d_down--;
                downSem.V();
            } else {
                eSem.V();
            }
        }

    }

    /* Register that car no. has left the alley */
    public void leave(int no) throws InterruptedException {
        if (no < 5) {

            eSem.P();
            n_up--;
            cars--;
            if(n_up == 0 && d_down > 0){
                d_down--;
                downSem.V();
            } else {
                eSem.V();
            }
           

        } else {

            eSem.P();
            n_down--;
            cars--;
            if(n_down == 0 && d_up > 0){
                d_up--;
                upSem.V();
            } else {
                eSem.V();
            }
            
           

        }
    }

}
