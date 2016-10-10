package ${packageName};


import org.junit.Test;
import org.junit.runner.RunWith; 
import static org.junit.Assert.assertEquals; 
import android.support.test.runner.AndroidJUnit4;
import android.test.suitebuilder.annotation.LargeTest;
import static android.support.test.espresso.Espresso.onView;
import static android.support.test.espresso.assertion.ViewAssertions.matches;
import static android.support.test.espresso.matcher.ViewMatchers.isDisplayed;
import static android.support.test.espresso.matcher.ViewMatchers.withText;

/**
 *   An instrumentation Test
 */

@RunWith(AndroidJUnit4.class)
@LargeTest
public class EspressoTest {

    @Test
    public void module_instrumentation_test_isCreated() throws Exception {
        onView(withText("Text")).check(matches(isDisplayed()));
    }
}