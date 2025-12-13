/*
 Root-finding algorithms
 */
module Root {
  use Math;

  /*
   */
  proc bisect(const func, in xLower: real, in xUpper: real,
              const maxIters:int=100, const absTol:real=0.0,
              const relTol:real=1e-15): real throws {
    if maxIters < 0 || absTol < 0 || relTol < 0 {
      throw new owned Error("maxIters, absTol, relTol must be nonnegative.");
    }
    var fLower: real = func(xLower);
    var fUpper: real = func(xUpper);
    select sgn(fLower * fUpper) {
      when 1 do throw new owned Error("Initial bounded values have same sign.");
      when 0 do return if fLower == 0.0 then xLower else xUpper;
      otherwise;
    }
    var xRootOld: real = xLower;
    var xRoot: real;
    var fRoot: real;
    var absEps: real;
    for 0..#maxIters {
      xRoot = 0.5 * (xLower + xUpper);
      fRoot = func(xRoot);
      absEps = abs(xRoot - xRootOld);
      if abs(fRoot) <= absTol || absEps < absTol || absEps/abs(xRoot) < relTol {
        return xRoot;
      }
      select sgn(fLower * fRoot) {
        when 1 {
          xLower = xRoot;
          fLower = fRoot;
        }
        when -1 do xUpper = xRoot;
        otherwise do throw new owned Error("Should not get here!");
      }
      xRootOld = xRoot;
    }
    throw new owned Error("Max iterations exceeded");
  }
}