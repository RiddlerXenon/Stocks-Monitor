class MaxMinGet {
  static getMaxMin(snapshotData) {
    int maxValT = 0;
    int minValT = 9999999999;
    double maxValP = 0;
    double minValP = 9999999999;

    for (var i = 0; i < snapshotData[1].length; i++) {
      if (snapshotData[1][i] < minValT) {
        minValT = snapshotData[1][i];
      }
      if (snapshotData?[1][i] > maxValT) {
        maxValT = snapshotData[1][i];
      }
    }
    for (var i = 0; i < snapshotData[0].length; i++) {
      if (snapshotData[0][i] < minValP) {
        minValP = snapshotData[0][i];
      }
      if (snapshotData[0][i] > maxValP) {
        maxValP = snapshotData[0][i];
      }
    }
    return [minValT.toDouble(), maxValT.toDouble(), minValP, maxValP];
  }
}
