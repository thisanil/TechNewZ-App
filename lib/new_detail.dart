import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewZDetail extends StatelessWidget {
  final Map newZ;
  NewZDetail({super.key, required this.newZ});

  @override
  String errorImg =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGkAznCVTAALTD1o2mAnGLudN9r-bY6klRFB35J2hY7gvR9vDO3bPY_6gaOrfV0IHEIUo&usqp=CAU';
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D011B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D011B),
        surfaceTintColor: const Color(0xFF0D011B),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text.rich(TextSpan(
            text: "Tech",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.yellow),
            children: [
              TextSpan(
                text: "NewZ",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              )
            ])),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              height: 250,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(newZ['urlToImage'] ?? errorImg),
                    fit: BoxFit.cover),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    newZ['title'],
                    style: const TextStyle(
                        fontSize: 20,
                        letterSpacing: 0.5,
                        wordSpacing: 1,
                        color: Colors.yellow,
                        fontWeight: FontWeight.w500),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    newZ['description'],
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        letterSpacing: 0.5,
                        wordSpacing: 1,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    newZ['content'],
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        letterSpacing: 0.5,
                        wordSpacing: 1,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Author",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                  wordSpacing: 1,
                                  fontWeight: FontWeight.w500)),
                          Text(newZ["author"],
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.yellow,
                                  letterSpacing: 0.5,
                                  wordSpacing: 1,
                                  fontWeight: FontWeight.w500))
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Published By",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                  wordSpacing: 1,
                                  fontWeight: FontWeight.w500)),
                          Text(newZ["source"]['name'],
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.yellow,
                                  letterSpacing: 0.5,
                                  wordSpacing: 1,
                                  fontWeight: FontWeight.w500))
                        ],
                      )
                    ],
                  ),
                  TextButton(
                      onPressed: () async {
                        _launchURL(newZ['url']);
                      },
                      child: const Text("Read on offical site >>",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.yellow,
                              fontWeight: FontWeight.w500)))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _launchURL(String urL) async {
    var url = urL;
    if (await canLaunch(url)) {
      print('Launching URL...');
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}
