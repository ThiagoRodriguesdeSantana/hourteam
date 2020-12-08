class TotalTime {
  int hour = 0;
  int min = 0;
  int sec = 0;

  TotalTime({DateTime time}) {
    if (time != null) {
      this.hour = time.hour;
      this.min = time.minute;
      this.sec = time.second;
    }
  }

  @override
  String toString() {
    return hour.toString().padLeft(2, "0") +
        ":" +
        min.toString().padLeft(2, "0") +
        ":" +
        sec.toString().padLeft(2, "0");
  }

  void sumTime(TotalTime secund) {
    this.sec = this.sec + secund.sec;
    this.min = this.min + secund.min;
    this.hour = this.hour + secund.hour;

    if (this.sec >= 60) {
      this.sec = this.sec - 60;
      this.min = this.min + 1;
      if (this.min >= 60) {
        this.min = this.min - 60;
        this.hour = this.hour + 1;
      }
    }
  }
}
