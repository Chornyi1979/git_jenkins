import com.example.Application;
import org.junit.Test;
import static org.junit.Assert.*;

public class AppTest {
  
  @Test
  public void testApp() {
    Application myApp = newApplication();
    
    String result = myApp.getStatus();
    
    assertEquals("OK", result);
  }
  
}
