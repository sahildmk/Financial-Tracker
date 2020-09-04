import '../Custom_Widgets/jobCard.dart';

class Job {
  int jobID;
  String name;
  double rateOfPay;
  String payFreq;
  JobCard jobCard;

  Job(int jobID, String _name, double _rateOfPay, String _payFreq) {
    this.jobID = jobID;
    this.name = _name;
    this.rateOfPay = _rateOfPay;
    this.payFreq = _payFreq;
    this.jobCard =
        new JobCard(this.name, this.rateOfPay.toString(), this.payFreq, this);
  }

  int getID() {
    return this.jobID;
  }

  String getName() {
    return this.name;
  }

  double getRateOfPay() {
    return this.rateOfPay;
  }

  String getpayFreq() {
    return this.payFreq;
  }

  JobCard getJobCard() {
    return this.jobCard;
  }
}
