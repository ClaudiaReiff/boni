class API {
  static const hostConnect = "http://10.0.64.24/api";
  static const hostConnectUser = "$hostConnect/user";

  //SignUp
  static const validateEmail = "$hostConnect/user/validate_email.php";
  static const signUp = "$hostConnect/user/signup.php";
  static const login = "$hostConnect/user/login.php";

  //Trail
  static const getTrail = "$hostConnect/trail/get_trail.php";
  static const checkIn = "$hostConnect/trail/check_in.php";
}
