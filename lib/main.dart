import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int soruIndex = 0;
  int dogruSayisi = 0;
  bool quizBittiMi = false;
  int kalanSure = 15;
  Timer? timer;

  List<Map<String, Object>> sorular = [
    {
      'soru': 'Flutter ile hangi platformlara uygulama geliştirilebilir?',
      'cevaplar': [
        {'secenek': 'Sadece Android', 'dogruMu': false},
        {'secenek': 'Sadece iOS', 'dogruMu': false},
        {'secenek': 'Web', 'dogruMu': false},
        {'secenek': 'Hepsi', 'dogruMu': true},
        {'secenek': 'Yalnızca masaüstü', 'dogruMu': false},
      ]
    },
    {
      'soru': 'Dart dilinde kullanılan koleksiyon türlerinden biri değildir:',
      'cevaplar': [
        {'secenek': 'List', 'dogruMu': false},
        {'secenek': 'Set', 'dogruMu': false},
        {'secenek': 'Map', 'dogruMu': false},
        {'secenek': 'Queue', 'dogruMu': true},
        {'secenek': 'Iterable', 'dogruMu': false},
      ]
    },
    {
      'soru': 'Flutter\'da görsel arayüz bileşenlerine ne ad verilir?',
      'cevaplar': [
        {'secenek': 'Modules', 'dogruMu': false},
        {'secenek': 'Components', 'dogruMu': false},
        {'secenek': 'Widgets', 'dogruMu': true},
        {'secenek': 'Blocks', 'dogruMu': false},
        {'secenek': 'Elements', 'dogruMu': false},
      ]
    },
    {
      'soru': 'Flutter\'da bir widget\'ın durumu değişebiliyorsa bu widget...',
      'cevaplar': [
        {'secenek': 'Stateless olur', 'dogruMu': false},
        {'secenek': 'Immutable olur', 'dogruMu': false},
        {'secenek': 'Reusable olur', 'dogruMu': false},
        {'secenek': 'Stateful olur', 'dogruMu': true},
        {'secenek': 'Contextless olur', 'dogruMu': false},
      ]
    },
    {
      'soru': 'Aşağıdakilerden hangisi Flutter\'da sayfa geçişi için kullanılır?',
      'cevaplar': [
        {'secenek': 'Navigator', 'dogruMu': true},
        {'secenek': 'RouteManager', 'dogruMu': false},
        {'secenek': 'PageView', 'dogruMu': false},
        {'secenek': 'Router', 'dogruMu': false},
        {'secenek': 'Scaffold', 'dogruMu': false},
      ]
    },
    {
      'soru': 'Flutter\'da en dış sarmalayıcı widget genellikle hangisidir?',
      'cevaplar': [
        {'secenek': 'MaterialApp', 'dogruMu': true},
        {'secenek': 'AppBar', 'dogruMu': false},
        {'secenek': 'Scaffold', 'dogruMu': false},
        {'secenek': 'Body', 'dogruMu': false},
        {'secenek': 'Main', 'dogruMu': false},
      ]
    },
    {
      'soru': 'Dart dilinde null güvenliğini sağlayan operatör hangisidir?',
      'cevaplar': [
        {'secenek': '==', 'dogruMu': false},
        {'secenek': '??', 'dogruMu': true},
        {'secenek': '!=', 'dogruMu': false},
        {'secenek': ':?', 'dogruMu': false},
        {'secenek': '&&', 'dogruMu': false},
      ]
    },
    {
      'soru': 'Flutter ile ilgili aşağıdakilerden hangisi yanlıştır?',
      'cevaplar': [
        {'secenek': 'Google tarafından geliştirilmiştir', 'dogruMu': false},
        {'secenek': 'Kotlin dili ile yazılır', 'dogruMu': true},
        {'secenek': 'Çoklu platform destekler', 'dogruMu': false},
        {'secenek': 'Dart dili kullanır', 'dogruMu': false},
        {'secenek': 'Widget tabanlıdır', 'dogruMu': false},
      ]
    },
    {
      'soru': 'Flutter\'da görsel düzenlemeler için hangi widget kullanılır?',
      'cevaplar': [
        {'secenek': 'Container', 'dogruMu': true},
        {'secenek': 'List', 'dogruMu': false},
        {'secenek': 'Main', 'dogruMu': false},
        {'secenek': 'Theme', 'dogruMu': false},
        {'secenek': 'Color', 'dogruMu': false},
      ]
    },
    {
      'soru': 'Flutter uygulamasında State yönetimi için kullanılan yöntem değildir:',
      'cevaplar': [
        {'secenek': 'Provider', 'dogruMu': false},
        {'secenek': 'BLoC', 'dogruMu': false},
        {'secenek': 'Riverpod', 'dogruMu': false},
        {'secenek': 'Redux', 'dogruMu': false},
        {'secenek': 'XML Binding', 'dogruMu': true},
      ]
    },
  ];

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    kalanSure = 15;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (kalanSure > 0) {
          kalanSure--;
        } else {
          ileriGec(); // süre bitince otomatik geç
        }
      });
    });
  }

  void ileriGec() {
    timer?.cancel();
    setState(() {
      if (soruIndex + 1 < sorular.length) {
        soruIndex++;
        startTimer();
      } else {
        quizBittiMi = true;
      }
    });
  }

  void cevapla(bool dogruMu) {
    if (dogruMu) dogruSayisi++;
    ileriGec();
  }

  void quizYenidenBaslat() {
    setState(() {
      soruIndex = 0;
      dogruSayisi = 0;
      quizBittiMi = false;
      startTimer();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7f1f8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Quiz Uygulaması", style: TextStyle(color: Colors.black)),
        elevation: 0,
      ),
      body: Center(
        child: quizBittiMi
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Quiz Tamamlandı!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Skorunuz: $dogruSayisi / ${sorular.length}"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: quizYenidenBaslat,
              child: Text("Yeniden Başla"),
            ),
          ],
        )
            : Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Soru ${soruIndex + 1}/${sorular.length}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Kalan Süre: $kalanSure saniye",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 30),
              Text(
                sorular[soruIndex]['soru'] as String,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ...(sorular[soruIndex]['cevaplar'] as List<Map<String, Object>>)
                  .map(
                    (cevap) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () =>
                        cevapla(cevap['dogruMu'] as bool),
                    child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(cevap['secenek'] as String),
                      ),
                    ),
                  ),
                ),
              )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
