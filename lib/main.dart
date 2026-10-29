import 'package:flutter/material.dart';

void main() => runApp(QteaLiveApp());

class QteaLiveApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LiveSwipePage(),
    );
  }
}

class LiveSwipePage extends StatefulWidget {
  @override
  _LiveSwipePageState createState() => _LiveSwipePageState();
}

class _LiveSwipePageState extends State<LiveSwipePage> {
  int diamonds = 1000;
  List<Map> hosts = [
    {"name": "@Qtea Bandung - Kaos Oversize", "img": "https://picsum.photos/seed/qtea1/1080/1920", "price": "85k"},
    {"name": "@Host Qtea Cihampelas LIVE", "img": "https://picsum.photos/seed/qtea2/1080/1920", "price": "95k"},
    {"name": "@Qtea Distro - Best Seller", "img": "https://picsum.photos/seed/qtea3/1080/1920", "price": "120k"},
  ];

  void sendGift(String gift, int cost) {
    if(diamonds >= cost) {
      setState(() => diamonds -= cost);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Kirim $gift - Sisa diamond $diamonds'), backgroundColor: Colors.pink));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: hosts.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              // Full screen image - kayak Momo Live
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Image.network(hosts[index]["img"], fit: BoxFit.cover),
              ),
              // Top bar
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(20)),
                        child: Row(children: [Icon(Icons.live_tv, color: Colors.red, size: 16), SizedBox(width: 6), Text("LIVE • ${hosts.length} viewers", style: TextStyle(color: Colors.white))]),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(20)),
                        child: Text("💎 $diamonds", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),
              // Bottom overlay
              Positioned(
                bottom: 0, left: 0, right: 0,
                child: Container(
                  height: 200,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black87])
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(hosts[index]["name"], style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("Kaos QTEA ${hosts[index]["price"]} - Checkout di live dapat diskon!", style: TextStyle(color: Colors.white70)),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          _giftBtn("🌹", 10),
                          _giftBtn("🏎‍🟀", 100),
                          _giftBtn("🏰", 500),
                          Spacer(),
                          ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.shopping_bag), label: Text("Beli ${hosts[index]["price"]}"), style: ElevatedButton.styleFrom(backgroundColor: Colors.pink))
                        ],
                      )
                    ],
                  ),
                ),
              ),
              // Right like buttons
              Positioned(
                right: 12, bottom: 220,
                child: Column(children: [
                  Icon(Icons.favorite, color: Colors.white, size: 36),
                  SizedBox(height: 16),
                  Icon(Icons.comment, color: Colors.white, size: 32),
                  SizedBox(height: 16),
                  Icon(Icons.share, color: Colors.white, size: 32),
                ]),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _giftBtn(String emoji, int cost) {
    return GestureDetector(
      onTap: () => sendGift(emoji, cost),
      child: Container(
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(12)),
        child: Column(children: [Text(emoji, style: TextStyle(fontSize: 22)), Text("$cost", style: TextStyle(color: Colors.white, fontSize: 10))]),
      ),
    );
  }
}
