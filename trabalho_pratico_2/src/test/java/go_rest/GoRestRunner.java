package go_rest;

import com.intuit.karate.junit5.Karate;

class GoRestRunner {
    
    @Karate.Test
    Karate testGoRest() {
        return Karate.run("go_rest").relativeTo(getClass());
    }    

}