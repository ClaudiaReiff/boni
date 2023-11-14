/// API class contains endpoints for various API requests.
class API {
  /// Base URL for API requests.
  static const hostConnect = "https://tool-master.at/boni";

  /// Base URL for user-related API requests.
  static const hostConnectUser = "$hostConnect/user";

  /// API endpoint for validating email.
  static const validateEmail = "$hostConnect/user/validate_email.php";

  /// API endpoint for user sign up.
  static const signUp = "$hostConnect/user/signup.php";

  /// API endpoint for user login.
  static const login = "$hostConnect/user/login.php";

  /// API endpoint for getting trail information.
  static const getTrail = "$hostConnect/trail/get_trail.php";

  /// API endpoint to check-in to trail
  static const checkIn = "$hostConnect/trail/check_in.php";
}
