// https://forums.getpebble.com/discussion/5792/sqrt-function
// - change internal variables to double
float pebblesqrt( float num ) {
  double a, p, e = 0.001, b;

  a = num;
  p = a * a;
  while( p - num >= e ) {
    b = ( a + ( num / a ) ) / 2;
    a = b;
    p = a * a;
  }

  return a;
}
