import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import '../models/song.dart';

final AudioPlayer mayPhat = AudioPlayer();

List<Song> dsPhat = [];
int viTriBai = -1;
List<Song> dsGanDay = [];
String? loiPhat;

Song? get baiDangPhat => (viTriBai >= 0 && viTriBai < dsPhat.length)
    ? dsPhat[viTriBai]
    : null;

bool get dangPhat => mayPhat.playing;

bool get dangTai =>
    mayPhat.processingState == ProcessingState.loading ||
    mayPhat.processingState == ProcessingState.buffering;

void khoiTaoAudio() {
  mayPhat.playerStateStream.listen((trangThai) {
    if (trangThai.processingState == ProcessingState.ready) {
      loiPhat = null;
    }
    if (trangThai.processingState == ProcessingState.completed) {
      baiTiepTheo(tuDong: true);
    }
  });
}

void _ghiNhanGanDay(Song bai) {
  dsGanDay.removeWhere((b) => b.id == bai.id);
  dsGanDay.insert(0, bai);
  if (dsGanDay.length > 10) {
    dsGanDay = dsGanDay.sublist(0, 10);
  }
}

int _lanMoBai = 0;

Future<void> _taiVaPhat() async {
  final bai = baiDangPhat;
  if (bai == null) return;
  final lanNay = ++_lanMoBai;
  _ghiNhanGanDay(bai);
  bai.luotNghe++;
  loiPhat = null;
  try {
    await mayPhat.stop();
    await mayPhat.setAsset(bai.audio);
    if (lanNay != _lanMoBai) return;
    mayPhat.play();
  } on PlayerInterruptedException {
    return;
  } catch (e) {
    if (lanNay != _lanMoBai) return;

    loiPhat = 'Chưa có file nhạc: ${bai.audio}';
    await mayPhat.stop();
    debugPrint('Không phát được ${bai.audio}: $e');
  }
}

Future<void> phatBai(Song bai, List<Song> ds) async {
  dsPhat = List.of(ds);
  final viTri = dsPhat.indexWhere((b) => b.id == bai.id);
  viTriBai = viTri >= 0 ? viTri : 0;
  if (viTri < 0) dsPhat.insert(0, bai);
  await _taiVaPhat();
}

Future<void> tamDungHoacPhat() async {
  if (mayPhat.playing) {
    await mayPhat.pause();
  } else {
    if (mayPhat.processingState == ProcessingState.completed) {
      await mayPhat.seek(Duration.zero);
    }
    mayPhat.play();
  }
}

Future<void> baiTiepTheo({bool tuDong = false}) async {
  if (dsPhat.isEmpty) return;

  if (tuDong && viTriBai >= dsPhat.length - 1) {
    await mayPhat.pause();
    await mayPhat.seek(Duration.zero);
    return;
  }

  viTriBai = (viTriBai + 1) % dsPhat.length;
  await _taiVaPhat();
}

Future<void> baiTruoc() async {
  if (dsPhat.isEmpty) return;

  if (mayPhat.position.inSeconds > 3) {
    await mayPhat.seek(Duration.zero);
    return;
  }
  viTriBai = (viTriBai - 1 + dsPhat.length) % dsPhat.length;
  await _taiVaPhat();
}

Future<void> tuaDen(Duration viTri) => mayPhat.seek(viTri);

double amLuong = 1;
double tocDo = 1;
Timer? _henGio;
DateTime? gioTat;

void henGioTat(int phut) {
  _henGio?.cancel();
  gioTat = DateTime.now().add(Duration(minutes: phut));
  _henGio = Timer(Duration(minutes: phut), () {
    mayPhat.pause();
    gioTat = null;
    _henGio = null;
  });
}

void huyHenGio() {
  _henGio?.cancel();
  _henGio = null;
  gioTat = null;
}

Future<void> doiAmLuong(double giaTri) async {
  amLuong = giaTri;
  await mayPhat.setVolume(giaTri);
}

Future<void> doiTocDo(double giaTri) async {
  tocDo = giaTri;
  await mayPhat.setSpeed(giaTri);
}
