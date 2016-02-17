import framework.*;
import org.junit.*;
import java.util.LinkedList;
import java.util.Arrays;
import java.util.stream.IntStream;
import org.junit.rules.Timeout;


public class EarthquakeTester {

    @Rule
    public Timeout globalTimeout = Timeout.seconds(10);

	private static final int pts = 2;

	//==================================================================

	private void checkHz(MaxHzReport expected, MaxHzReport actual) {
		Assert.assertEquals(expected.day, actual.day);
		Assert.assertEquals(expected.maxReading, actual.maxReading, 0.0);
	}

	private void checkLists(LinkedList<MaxHzReport> expected, LinkedList<MaxHzReport> actual) {
		Assert.assertEquals(expected.size(), actual.size());
		IntStream.range(0, expected.size()).forEach(i -> checkHz(expected.get(i), actual.get(i)));
	}

	//==================================================================
	// Test setup for 4.1.a

	@Test
	public void noSkips1_1() {
		TestHelper.createTest("dailyMaxForMonth - No missing days (a): Solution 1", "Only 1 month in list input").addTheme(TestTheme.JAVA_PROGAMMING, pts).setup();
		noSkips1(new Earthquake1());
	}

	@Test
	public void noSkips1_2() {
		TestHelper.createTest("dailyMaxForMonth - No missing days (a): Solution 2", "Only 1 month in list input").addTheme(TestTheme.JAVA_PROGAMMING, pts).setup();
		noSkips1(new Earthquake2());
	}

	public void noSkips1(IEarthquakeProbs solution) {

		// Input
		LinkedList<Double> input = new LinkedList<Double>(Arrays.asList(20151028.0, 200.0, 150.0, 175.0, 20151029.0, 0.002, 0.03, 20151030.0, 82.0, 0.05, 34.0, 121.0));

		// Expected output
		MaxHzReport a = new MaxHzReport(28, 200.0);
		MaxHzReport b = new MaxHzReport(29, 0.03);
		MaxHzReport c = new MaxHzReport(30, 121.0);
		LinkedList<MaxHzReport> output = new LinkedList<MaxHzReport>(Arrays.asList(a, b, c));
		
		// Actual output
		LinkedList<MaxHzReport> actual = solution.dailyMaxForMonth(input, 10);
		
		// Test
		checkLists(output, actual);
	}

	//==================================================================
	// Test setup for 4.1.b.

	@Test
	public void noSkips2_1() {
		TestHelper.createTest("dailyMaxForMonth - No missing days (b): Solution 1", ">1 month in list input")
				  .addTheme(TestTheme.JAVA_PROGAMMING, pts).setup();
		noSkips2(new Earthquake1());
	}

	@Test
	public void noSkips2_2() {
		TestHelper.createTest("dailyMaxForMonth - No missing days (b): Solution 2", ">1 month in list input")
				  .addTheme(TestTheme.JAVA_PROGAMMING, pts).setup();
		noSkips2(new Earthquake2());
	}

	public void noSkips2(IEarthquakeProbs solution) {

		// Input
		LinkedList<Double> input = new LinkedList<Double>(Arrays.asList(20151029.0, 0.002, 0.03, 20151030.0, 82.0, 0.05, 34.0, 121.0, 20151031.0, 202.0, 145.0, 0.004, 11.0, 20151101.0, 14.0, 0.7, 20151201.0, 0.23, 144.0, 128.0, 20151202.0, 120.0, 0.0, 0.1, 3.0));

		// Expected output
		MaxHzReport a = new MaxHzReport(29, 0.03);
		MaxHzReport b = new MaxHzReport(30, 121.0);
		MaxHzReport c = new MaxHzReport(31, 202.0);
		LinkedList<MaxHzReport> output = new LinkedList<MaxHzReport>(Arrays.asList(a, b, c));
		
		// Actual output
		LinkedList<MaxHzReport> actual = solution.dailyMaxForMonth(input, 10);
		
		// Test
		checkLists(output, actual);
	}

	//==================================================================
	// Test setup for 4.1.c.

	@Test
	public void noSkips3_1() {
		TestHelper.createTest("dailyMaxForMonth - No missing days (c): Solution 1", "Month input is not in list input")
			      .addTheme(TestTheme.JAVA_PROGAMMING, pts).setup();
	 	noSkips3(new Earthquake1());
	}

	@Test
	public void noSkips3_2() {
		TestHelper.createTest("dailyMaxForMonth - No missing days (c): Solution 2", "Month input is not in list input")
			      .addTheme(TestTheme.JAVA_PROGAMMING, pts).setup();
	 	noSkips3(new Earthquake2());
	}

	public void noSkips3(IEarthquakeProbs solution) {
		
		// Input
		LinkedList<Double> input = new LinkedList<Double>(Arrays.asList(20151101.0, 14.0, 0.7, 20151201.0, 0.23, 144.0, 128.0, 20151202.0, 120.0, 0.0, 0.1, 3.0));

		// Expected output
		LinkedList<MaxHzReport> output = new LinkedList<MaxHzReport>();
		
		// Actual output
		LinkedList<MaxHzReport> actual = solution.dailyMaxForMonth(input, 10);
		
		// Test
		checkLists(output, actual);
	}

	//==================================================================
	// Test setup for 4.1.d.

	@Test
	public void noSkips4_1() {
		TestHelper.createTest("dailyMaxForMonth - No missing days (d.1): Solution 1", "With 0 as max value")
				  .addTheme(TestTheme.JAVA_PROGAMMING, pts).setup();
		noSkips4(new Earthquake1());
	}

	@Test
	public void noSkips4_2() {
		TestHelper.createTest("dailyMaxForMonth - No missing days (d.1): Solution 2", "With 0 as max value")
				  .addTheme(TestTheme.JAVA_PROGAMMING, pts).setup();
		noSkips4(new Earthquake2());
	}

	public void noSkips4(IEarthquakeProbs solution) {
		
		// Input
		LinkedList<Double> input = new LinkedList<Double>(Arrays.asList(20151028.0, -5.0, -110.0, 0.0, -23.0, 20151029.0, 0.002, 0.03, 20151030.0, 82.0, 0.05, 34.0, 121.0));

		// Expected output
		MaxHzReport a = new MaxHzReport(28, 0.0);
		MaxHzReport b = new MaxHzReport(29, 0.03);
		MaxHzReport c = new MaxHzReport(30, 121.0);
		LinkedList<MaxHzReport> output = new LinkedList<MaxHzReport>(Arrays.asList(a, b, c));
		
		// Actual output
		LinkedList<MaxHzReport> actual = new Earthquake1().dailyMaxForMonth(input, 10);
		
		// Test
		checkLists(output, actual);
	}

	@Test
	public void noSkips5_1() {
		TestHelper.createTest("dailyMaxForMonth - No missing days (d.2): Solution 1", "With 0 as max value")
				  .addTheme(TestTheme.JAVA_PROGAMMING, pts).setup();
		noSkips5(new Earthquake1());
	}

	@Test
	public void noSkips5_2() {
		TestHelper.createTest("dailyMaxForMonth - No missing days (d.2): Solution 2", "With 0 as max value")
				  .addTheme(TestTheme.JAVA_PROGAMMING, pts).setup();
		noSkips5(new Earthquake2());
	}

	public void noSkips5(IEarthquakeProbs solution) {
		
		// Input
		LinkedList<Double> input = new LinkedList<Double>(Arrays.asList(20151028.0, 200.0, 150.0, 175.0, 20151029.0, -5.0, -110.0, 0.0, -23.0, 20151030.0, 82.0, 0.05, 34.0, 121.0));

		// Expected output
		MaxHzReport a = new MaxHzReport(28, 200.0);
		MaxHzReport b = new MaxHzReport(29, 0.0);
		MaxHzReport c = new MaxHzReport(30, 121.0);
		LinkedList<MaxHzReport> output = new LinkedList<MaxHzReport>(Arrays.asList(a, b, c));

		// Actual output
		LinkedList<MaxHzReport> actual = solution.dailyMaxForMonth(input, 10);
		
		// Test
		checkLists(output, actual);
	}

	//==================================================================
	// Test setup for 4.2.a

	@Test
	public void withSkips1_1() {
		TestHelper.createTest("dailyMaxForMonth - With missing days (a): Solution 1", "Only 1 month in list input")
				  .addTheme(TestTheme.JAVA_PROGAMMING, pts).setup();
		withSkips1(new Earthquake1());
	}

	@Test
	public void withSkips1_2() {
		TestHelper.createTest("dailyMaxForMonth - With missing days (a): Solution 2", "Only 1 month in list input")
				  .addTheme(TestTheme.JAVA_PROGAMMING, pts).setup();
		withSkips1(new Earthquake2());
	}

	public void withSkips1(IEarthquakeProbs solution) {
		
		// Input
		LinkedList<Double> input = new LinkedList<Double>(Arrays.asList(20151028.0, 200.0, 150.0, 175.0, 20151030.0, 82.0, 0.05, 34.0, 121.0, 20151031.0, 202.0, 145.0, 0.004, 11.0));

		// Expected output
		MaxHzReport a = new MaxHzReport(28, 200.0);
		MaxHzReport b = new MaxHzReport(30, 121.0);
		MaxHzReport c = new MaxHzReport(31, 202.0);
		LinkedList<MaxHzReport> output = new LinkedList<MaxHzReport>(Arrays.asList(a, b, c));
		
		// Actual output
		LinkedList<MaxHzReport> actual = solution.dailyMaxForMonth(input, 10);
		
		// Test
		checkLists(output, actual);
	}

	//==================================================================
	// Test setup for 4.2.b

	@Test
	public void withSkips2_1() {
		TestHelper.createTest("dailyMaxForMonth - With missing days (b): Solution 1", ">1 month in list input").addTheme(TestTheme.JAVA_PROGAMMING, pts).setup();
		withSkips2(new Earthquake1());
	}

	@Test
	public void withSkips2_2() {
		TestHelper.createTest("dailyMaxForMonth - With missing days (b): Solution 2", ">1 month in list input").addTheme(TestTheme.JAVA_PROGAMMING, pts).setup();
		withSkips2(new Earthquake2());
	}

	public void withSkips2(IEarthquakeProbs solution) {

		// Input
		LinkedList<Double> input = new LinkedList<Double>(Arrays.asList(20151028.0, 200.0, 150.0, 175.0, 20151030.0, 82.0, 0.05, 34.0, 121.0, 20151031.0, 202.0, 145.0, 0.004, 11.0, 20151101.0, 14.0, 0.7, 20151201.0, 0.23, 144.0, 128.0, 20151202.0, 120.0, 0.0, 0.1, 3.0));

		// Expected output
		MaxHzReport a = new MaxHzReport(28, 200.0);
		MaxHzReport b = new MaxHzReport(30, 121.0);
		MaxHzReport c = new MaxHzReport(31, 202.0);
		LinkedList<MaxHzReport> output = new LinkedList<MaxHzReport>(Arrays.asList(a, b, c));
		
		// Actual output
		LinkedList<MaxHzReport> actual = solution.dailyMaxForMonth(input, 10);
		
		// Test
		checkLists(output, actual);
	}

	//==================================================================
	// Test setup for 4.2.c

	@Test
	public void withSkips3_1() {
		TestHelper.createTest("dailyMaxForMonth - With missing days (c): Solution 1", ">= 2 days missing").addTheme(TestTheme.JAVA_PROGAMMING, pts).setup();
		withSkips3(new Earthquake1());
	}

	@Test
	public void withSkips3_2() {
		TestHelper.createTest("dailyMaxForMonth - With missing days (c): Solution 2", ">= 2 days missing").addTheme(TestTheme.JAVA_PROGAMMING, pts).setup();
		withSkips3(new Earthquake2());
	}

	public void withSkips3(IEarthquakeProbs solution) {
		
		// Input
		LinkedList<Double> input = new LinkedList<Double>(Arrays.asList(20151028.0, 200.0, 150.0, 175.0, 20151031.0, 202.0, 145.0, 0.004, 11.0, 20151101.0, 14.0, 0.7, 20151201.0, 0.23, 144.0, 128.0));

		// Expected output
		MaxHzReport a = new MaxHzReport(28, 200.0);
		MaxHzReport b = new MaxHzReport(31, 202.0);
		LinkedList<MaxHzReport> output = new LinkedList<MaxHzReport>(Arrays.asList(a, b));
		
		// Actual output
		LinkedList<MaxHzReport> actual = solution.dailyMaxForMonth(input, 10);
		
		// Test
		checkLists(output, actual);
	}

	//==================================================================
	// Test setup for 4.2.d

	@Test
	public void withSkips4_1() {
		TestHelper.createTest("dailyMaxForMonth - With missing days (d.1): Solution 1", "With 0 as max value").addTheme(TestTheme.JAVA_PROGAMMING, pts).setup();
		withSkips4(new Earthquake1());
	}

	@Test
	public void withSkips4_2() {
		TestHelper.createTest("dailyMaxForMonth - With missing days (d.1): Solution 2", "With 0 as max value").addTheme(TestTheme.JAVA_PROGAMMING, pts).setup();
		withSkips4(new Earthquake2());
	}

	public void withSkips4(IEarthquakeProbs solution) {
		
		// Input
		LinkedList<Double> input = new LinkedList<Double>(Arrays.asList(20151028.0, -5.0, -110.0, 0.0, -23.0, 20151030.0, 82.0, 0.05, 34.0, 121.0, 20151031.0, 202.0, 145.0, 0.004, 11.0));

		// Expected output
		MaxHzReport a = new MaxHzReport(28, 0.0);
		MaxHzReport b = new MaxHzReport(30, 121.0);
		MaxHzReport c = new MaxHzReport(31, 202.0);
		LinkedList<MaxHzReport> output = new LinkedList<MaxHzReport>(Arrays.asList(a, b, c));
		
		// Actual output
		LinkedList<MaxHzReport> actual = solution.dailyMaxForMonth(input, 10);
		
		// Test
		checkLists(output, actual);
	}

	@Test
	public void withSkips5_1() {
		TestHelper.createTest("dailyMaxForMonth - With missing days (d.2): Solution 1", "With 0 as max value").addTheme(TestTheme.JAVA_PROGAMMING, pts).setup();
		withSkips5(new Earthquake1());
	}

	@Test
	public void withSkips5_2() {
		TestHelper.createTest("dailyMaxForMonth - With missing days (d.2): Solution 2", "With 0 as max value").addTheme(TestTheme.JAVA_PROGAMMING, pts).setup();
		withSkips5(new Earthquake2());
	}

	public void withSkips5(IEarthquakeProbs solution) {
		
		// Input
		LinkedList<Double> input = new LinkedList<Double>(Arrays.asList(20151028.0, -5.0, -110.0, 0.0, -23.0, 20151030.0, 82.0, 0.05, 34.0, 121.0, 20151031.0, 202.0, 145.0, 0.004, 11.0, 20151101.0, 14.0, 0.7, 20151201.0, 0.23, 144.0, 128.0, 20151202.0, 120.0, 0.0, 0.1, 3.0));

		// Expected output
		MaxHzReport a = new MaxHzReport(28, 0.0);
		MaxHzReport b = new MaxHzReport(30, 121.0);
		MaxHzReport c = new MaxHzReport(31, 202.0);
		LinkedList<MaxHzReport> output = new LinkedList<MaxHzReport>(Arrays.asList(a, b, c));
		
		// Actual output
		LinkedList<MaxHzReport> actual = solution.dailyMaxForMonth(input, 10);
		
		// Test
		checkLists(output, actual);
	}

	//==================================================================
	// Test setup for 4.3.a

	@Test
	public void singleEntry1_1() {
		TestHelper.createTest("dailyMaxForMonth - One entry in input list (a): Solution 1", "Month input is in list input").addTheme(TestTheme.JAVA_PROGAMMING, pts).setup();
		singleEntry1(new Earthquake1());
	}

	@Test
	public void singleEntry1_2() {
		TestHelper.createTest("dailyMaxForMonth - One entry in input list (a): Solution 2", "Month input is in list input").addTheme(TestTheme.JAVA_PROGAMMING, pts).setup();
		singleEntry1(new Earthquake2());
	}

	public void singleEntry1(IEarthquakeProbs solution) {

		// Input
		LinkedList<Double> input = new LinkedList<Double>(Arrays.asList(20151028.0, 200.0, 150.0, 175.0));

		// Expected output
		MaxHzReport a = new MaxHzReport(28, 200.0);
		LinkedList<MaxHzReport> output = new LinkedList<MaxHzReport>(Arrays.asList(a));
		
		// Actual output
		LinkedList<MaxHzReport> actual = solution.dailyMaxForMonth(input, 10);
		
		// Test
		checkLists(output, actual);
	}

	//==================================================================
	// Test setup for 4.3.b

	@Test
	public void singleEntry2_1() {
		TestHelper.createTest("dailyMaxForMonth - One entry in input list (b): Solution 1", "Month input is not in list input").addTheme(TestTheme.JAVA_PROGAMMING, pts).setup();
		singleEntry2(new Earthquake1());
	}

	@Test
	public void singleEntry2_2() {
		TestHelper.createTest("dailyMaxForMonth - One entry in input list (b): Solution 2", "Month input is not in list input").addTheme(TestTheme.JAVA_PROGAMMING, pts).setup();
		singleEntry2(new Earthquake2());
	}

	public void singleEntry2(IEarthquakeProbs solution) {
		
		// Input
		LinkedList<Double> input = new LinkedList<Double>(Arrays.asList(20151202.0, 120.0, 0.0, 0.1, 3.0));

		// Expected output
		LinkedList<MaxHzReport> output = new LinkedList<MaxHzReport>();
		
		// Actual output
		LinkedList<MaxHzReport> actual = solution.dailyMaxForMonth(input, 10);
		
		// TEst
		checkLists(output, actual);
	}

	//==================================================================
	// Test setup for 4.4.a

	@Test
	public void emptyInput_1() {
		TestHelper.createTest("dailyMaxForMonth - Empty Input: Solution 1", "No values in input list").addTheme(TestTheme.JAVA_PROGAMMING, pts).setup();
		emptyInput(new Earthquake1());
	}

	@Test
	public void emptyInput_2() {
		TestHelper.createTest("dailyMaxForMonth - Empty Input: Solution 2", "No values in input list").addTheme(TestTheme.JAVA_PROGAMMING, pts).setup();
		emptyInput(new Earthquake2());
	}

	public void emptyInput(IEarthquakeProbs solution) {

		// Input
		LinkedList<Double> input = new LinkedList<Double>();

		// Expected output
		LinkedList<MaxHzReport> output = new LinkedList<MaxHzReport>();
		
		// Actual output
		LinkedList<MaxHzReport> actual = solution.dailyMaxForMonth(input, 10);
		
		// Test
		checkLists(output, actual);
	}
}
