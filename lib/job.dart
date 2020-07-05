import 'jobCard.dart';

class Job {
  String name;
  double rateOfPay;
  String payFreq;
  JobCard jobCard;

  Job(String _name, double _rateOfPay, String _payFreq) {
    this.name = _name;
    this.rateOfPay = _rateOfPay;
    this.payFreq = _payFreq;
    this.jobCard = new JobCard(this.name, this.rateOfPay.toString(), this.payFreq);
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