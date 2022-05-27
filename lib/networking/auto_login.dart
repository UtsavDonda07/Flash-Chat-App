import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
class AuthController {
  //take user login data
  static late String myEmail;
  static late String myPassword;
  static login(String email,String password){
    myEmail=email;
    myPassword=password;
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!authcontroller!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
print(myEmail);
print(myPassword);
    //save user data in storage
    setEmail();
    setPassword();
  }
  static getEmail() async{
      SharedPreferences pref= await SharedPreferences.getInstance();
      var saveEmail= pref.getString("saveEmail");
      return saveEmail;
    }
  static  setEmail() async{
      SharedPreferences pref= await SharedPreferences.getInstance();
      pref.setString("saveEmail", myEmail);
    }

  static  getPassward() async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    dynamic? savePassword= pref.getString("savePassword");
    return savePassword;
  }
  static setPassword() async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    pref.setString("savePassword", myPassword);
  }
      static logout() async{
       myEmail=="null";
       myPassword="null";
      }


}