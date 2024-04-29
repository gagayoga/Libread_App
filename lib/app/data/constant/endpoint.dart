class Endpoint {
  static const String baseUrlApi =
      // "http://192.168.4.184:8000/api/users/";
      "http://192.168.43.21:8000/api/users/";

  // Authenticated
  static const String register = "${baseUrlApi}registrasi";
  static const String login = "${baseUrlApi}login";
  static const String logout = "${baseUrlApi}logout";
  static const String getDataProfile = "${baseUrlApi}get-profile";
  static const String updateProfile = "${baseUrlApi}update/profile";
  static const String updatePassword = "${baseUrlApi}update/password";

  // Buku
  static const String buku = "${baseUrlApi}buku";
  static const String bukuNew = "${baseUrlApi}buku/new";
  static const String detailBuku = "${baseUrlApi}buku/detail";
  static const String searchBook = "${baseUrlApi}buku/search";
  static const String bukuPopular = "${baseUrlApi}popular/buku";

  // Koleksi Buku
  static const String koleksiBuku = "${baseUrlApi}koleksi";
  static const String deleteKoleksi = "${baseUrlApi}";
  static const String historyPeminjaman = "${baseUrlApi}pinjam";

  // Ulasan Buku
  static const String ulasanBuku = "${baseUrlApi}ulasan";

  // Peminjamn
  static const String pinjamBuku = "${baseUrlApi}pinjam";
  static const String detailPeminjaman = "${baseUrlApi}detail/pinjam";
  static const String updatePeminjaman = "${baseUrlApi}update-peminjaman/";
}