import '../../modules/shop_app/login/login_screen.dart';
import '../network/local /cach_helper.dart';
import 'components.dart';

const String API_KEY="13530e0d940a4aceb51f4bf1134e1736";
const String GET_DATA="v2/top-headlines";
const String SEARCH="v2/everything";
const String BUSINESS_CATEGORY="business";
const String SPORTS_CATEGORY="sports";
const String SCIENCE_CATEGORY="science";
const String COUNTRY="eg";

String?  token="";

void signOut(context){
  CacheHelper.clearData("token").then((value) {
    if (value == true) {
      navigateToAndFinish(context, ShopLoginScreen());
    }
  });
}