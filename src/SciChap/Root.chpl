/*
  Root-finding algorithms
 */
module Root {
  use IO;
  use Math;

  /*
    Find root of function with bisection method. For a continuous function
    with proper inputs, convergence is guaranteed.

    Reference:
    Chapra, S. C., & Canale, R. P. (2015). Bracketing Methods. In
    "Numerical Methods for Engineers" (7th ed., pp. 127-135).
    McGraw-Hill Education.

    :arg func: function for which root will be obtained on the given interval
    :type func: proc

    :arg xLower: lower bound
    :type xLower: real

    :arg xUpper: upper bound
    :type xUpper: real

    :arg tol: relative tolerance
    :type tol: real

    :returns: converged root
    :rtype: real

    :throws IllegalArgumentError: Non-positive input tolerance

    :throws IllegalArgumentError: Initial upper and lower bounds values have the
    same sign (meaning zero or more than 1 root).
   */
  proc bisect(const func, in xLower: real, in xUpper: real,
              const tol:real=1e-15): real throws {
    if tol <= 0 {
      throw new owned IllegalArgumentError("Tolerance must be positive.");
    }
    var fLower: real = func(xLower);
    var fUpper: real = func(xUpper);
    select sgn(fLower * fUpper) {
      when 1 do throw new owned IllegalArgumentError(
        "Initial bounded values have same sign.");
      when 0 do return if fLower == 0.0 then xLower else xUpper;
      otherwise;
    }
    var xRootOld: real = xLower;
    var xRoot: real;
    var fRoot: real;
    var maxIters: int = ceil(log2((xUpper - xLower) / tol)): int;
    for 1..maxIters {
      xRoot = 0.5 * (xLower + xUpper);
      fRoot = func(xRoot);
      select sgn(fLower * fRoot) {
        when 1 {
          xLower = xRoot;
          fLower = fRoot;
        }
        when -1 do xUpper = xRoot;
        otherwise do return xRoot;
      }
      xRootOld = xRoot;
    }
    assert(abs((xRoot - xRootOld) / xRoot) <= tol);
    return xRoot;
  }
}