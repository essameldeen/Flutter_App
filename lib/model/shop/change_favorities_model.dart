class ChangeFavoritiesModel {
  bool? status;

  ChangeFavoritiesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }
}
