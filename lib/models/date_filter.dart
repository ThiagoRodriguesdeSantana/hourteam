class DateFilter {
  DateTime dateInit;
  DateTime dateEnd;

  void setDateInitFromString(String date) {
    var dateSplit = date.split("/");

    if (dateSplit.length >= 3) {
      var day = int.parse(dateSplit[0]);
      var month = int.parse(dateSplit[1]);
      var year = int.parse(dateSplit[2]);

      this.dateInit = new DateTime(year, month, day);
    }
  }

  void setDateEndFromString(String date) {
    var dateSplit = date.split("/");

    if (dateSplit.length >= 3) {
      var day = int.parse(dateSplit[0]);
      var month = int.parse(dateSplit[1]);
      var year = int.parse(dateSplit[2]);

      this.dateEnd = new DateTime(year, month, day);
    }
  }
}
