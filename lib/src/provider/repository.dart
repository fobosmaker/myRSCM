import 'package:myrscm/src/model/billing_model.dart';
import 'package:myrscm/src/model/login_model.dart';
import 'package:myrscm/src/provider/billing_provider.dart';
import 'package:myrscm/src/provider/user_provider.dart';

class Repository{
  static final userAPIProvider = UserProvider();
  static final billingAPIProvider = BillingProvider();

/*USER API*/
  //LOGIN
  Future<LoginModel> login(String username, String password) => userAPIProvider.login(username,password);
/*!USER API*/

/*BILLING API*/
  //Get data billing
  Future<BillingModel> fetchDataBilling(String patientId) => billingAPIProvider.getDataBilling(patientId);
  //Get more data on card
  Future<BillingDataMoreModel> fetchcard(String patientId, String orgId, int totalData) => billingAPIProvider.getMoreBillingDetail(patientId, orgId, totalData);
/*!BILLING API*/
}