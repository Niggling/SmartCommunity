class CookieManager {
  static String? authToken; // 存储Cookie值的静态变量
  static void setAuthToken(String value) {
    authToken = value;
  }

  static String? getAuthToken() {
    return authToken;
  }
}

