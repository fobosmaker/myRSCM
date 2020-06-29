import 'package:myrscm/src/model/billing_model.dart';
import 'package:myrscm/src/model/default_model.dart';
import 'package:myrscm/src/model/queue_model.dart';
import 'package:myrscm/src/model/list_data_model.dart';
import 'package:myrscm/src/model/verification_model.dart';
import 'package:myrscm/src/provider/billing_provider.dart';
import 'package:myrscm/src/provider/queue_provider.dart';
import 'package:myrscm/src/provider/user_provider.dart';

import 'appointment_provider.dart';

class Repository{
  static final userAPIProvider = UserProvider();
  static final billingAPIProvider = BillingProvider();
  static final appointmentAPIProvider = AppointmentProvider();
  static final queueAPIProvider = QueueProvider();

/*USER API*/
  //Login
  Future<VerificationModel> login(String username, String password) => userAPIProvider.login(username,password);
  //Verification
  Future<VerificationModel> verification(String mrn, String birthdate) => userAPIProvider.verification(mrn,birthdate);
  //Registrasi
  Future<DefaultModel> registration(String patientId, String username, String password) => userAPIProvider.registrasi(patientId,username,password);
  //Change Password
  Future<DefaultModel> changePassword(String patientId, String password) => userAPIProvider.change_password(patientId,password);
/*!USER API*/

/*BILLING API*/
  //Get data billing
  Future<BillingModel> fetchDataBilling(String patientId) => billingAPIProvider.getDataBilling(patientId);
  //Get more data on card
  Future<BillingDataMoreModel> fetchcard(String patientId, String orgId, int totalData) => billingAPIProvider.getMoreBillingDetail(patientId, orgId, totalData);
/*!BILLING API*/

/*APPOINTMENT API*/
  //Get list poli
  Future<List<DefaultRowModel>> fetchPoli() => appointmentAPIProvider.getPoli();
  //Get list jadwal dokter
  Future<List<DefaultRowModel>> fetchJadwalDokter(String date, String poliId) => appointmentAPIProvider.getJadwalDokter(date, poliId);
/*!APPOINTMENT API*/

/*QUEUE API*/
  //Get data patient queue
  Future<QueueModel> fetchQueue(String patientId) => queueAPIProvider.getDataQueue(patientId);
/*!QUEUE API*/
}