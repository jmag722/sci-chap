/*
  Array: Basic array operations.
 */
module Array {

  /*
  Computes difference between array elements

  :arg arr: input array

  :returns: Array of size `arr.size - 1`
  :rtype: [] T
  */
  proc diff(const ref arr: [?D] ?T): [0..<D.size-1] T
            where (D.rank == 1 && isNumeric(T)) {
    return arr[D.first+1..] - arr[..<D.last];
  }

  /*
  Determines if array is strictly increasing or decreasing

  :arg x: input array

  :returns: true if all elements strictly increasing or decreasing, else false
  :rtype: bool
  */
  proc isMonotonic(const ref x: [?D] ?T): bool
                   where (isNumeric(T) && !isComplex(T)) {
    if D.size < 2 then return true;
    const h: [0..<D.size - 1] real = diff(x);
    return (&& reduce (h > 0)) || (&& reduce (h < 0));
  }

  /*
  Creates linearly spaced array of elements

  :arg start: starting value
  :arg end: ending value
  :arg num: number of points in array
  :arg endpoint: if true, includes `end` in returned array, else excluded

  :returns: linearly spaced array of elements
  :rtype: [] T
  */
  proc linspace(in start: ?T, in end: T, in num: int,
                in endpoint: bool=true): [0..<num] T
                where (isNumeric(T) && !isIntegral(T)) {
    var arr: [0..<num] T;
    const divisor: int = if endpoint && num > 1 then num - 1 else num;
    const increment: T = (end - start) / divisor;
    forall i in arr.domain {
      arr[i] = i * increment + start;
    }
    return arr;
  }
}