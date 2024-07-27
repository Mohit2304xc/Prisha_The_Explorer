import 'dart:convert';
import 'package:prishathe/Model/Usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SharedReferences {
  static Future<void> saveUser(UserModel userInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(userInfo);
    String userJsonData = jsonEncode(userInfo.toJson());
    await preferences.setString("currentUser", userJsonData);
  }

  static Future<void> saveDataInWishlist(String key,String course) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, course);
  }

  static Future<String?> readDataFromWishlist(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final data = preferences.getString(key);
    return data;
  }

  static Future<void> removeData(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(key);
  }

  static Future<UserModel> readUser() async {
    UserModel currentUserInfo;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userInfo = preferences.getString("currentUser");

    if(userInfo != null){
      Map<String,dynamic> userData = jsonDecode(userInfo);
      currentUserInfo = UserModel.fromJson(userData);
      return currentUserInfo;
    }
    else{
      print("user empty");
      return UserModel.empty();
    }
  }

  static Future<void> write(String key,String value)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString( key, value);
  }

  static Future<String?> read(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }

  static Future<void> isFirstTimeWrite(bool value)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool( "IsFirstTime", value);
  }

  static Future<bool?> isFirstTimeRead()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final result = preferences.getBool("IsFirstTime");
    return result;
  }

  static Future<List<Map<String, dynamic>>?> readCartItems() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? cartItemsJson = preferences.getStringList("cartItems");

    if (cartItemsJson != null) {
      return cartItemsJson.map((item) => jsonDecode(item) as Map<String, dynamic>).toList();
    }
    return null;
  }

  static Future<void> saveCartItems(List<Map<String, dynamic>> cartItems) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> cartItemsJson = cartItems.map((item) => jsonEncode(item)).toList();
    await preferences.setStringList("cartItems", cartItemsJson);
  }
}