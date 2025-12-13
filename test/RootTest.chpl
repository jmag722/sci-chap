module RootTest {
  use UnitTest;
  import SciChap.Root;

  proc bisect_poly2(test: borrowed Test) throws {
    var func = proc(in x: real): real {return (x-3.0)**4-10;};
    var actual = Root.bisect(func, 4.0, 25.0);
    test.assertEqual(actual, 3.0);
  }

  proc main() throws {
    UnitTest.main();
  }
}