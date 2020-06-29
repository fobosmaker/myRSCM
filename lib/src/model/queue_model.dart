class QueueModel{
  PatientQueue data;
  QueueModel({this.data});
}

class PatientQueue{
  String encounterNumber;
  String queueNumber;
  String orgName;
  PatientQueue({this.encounterNumber, this.queueNumber, this.orgName});
}