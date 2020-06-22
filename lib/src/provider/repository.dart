import 'package:myrscm/src/model/billing_model.dart';
import 'package:myrscm/src/model/default_model.dart';
import 'package:myrscm/src/model/verification_model.dart';
import 'package:myrscm/src/provider/billing_provider.dart';
import 'package:myrscm/src/provider/user_provider.dart';

class Repository{
  static final userAPIProvider = UserProvider();
  static final billingAPIProvider = BillingProvider();

/*USER API*/
  //Verification
  Future<VerificationModel> verification(String mrn, String birthdate) => userAPIProvider.verification(mrn,birthdate);
  //Registrasi
  Future<DefaultModel> registration(String patientId, String username, String password) => userAPIProvider.registrasi(patientId,username,password);
/*!USER API*/

/*BILLING API*/
  //Get data billing
  Future<BillingModel> fetchDataBilling(String patientId) => billingAPIProvider.getDataBilling(patientId);
  //Get more data on card
  Future<BillingDataMoreModel> fetchcard(String patientId, String orgId, int totalData) => billingAPIProvider.getMoreBillingDetail(patientId, orgId, totalData);
/*!BILLING API*/

/*APPOINTMENT API*/

/*!APPOINTMENT API*/
}