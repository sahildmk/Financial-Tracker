import '../Custom_Widgets/jobCard.dart';
import 'package:hive/hive.dart';

part 'job.g.dart';

@HiveType(typeId: 0)
class Job {
  @HiveField(0)
  String name;
  @HiveField(1)
  double rateOfPay;
  @HiveField(2)
  String payFreq;
  @HiveField(3)
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