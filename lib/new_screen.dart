import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/new_detail.dart';

import 'package:url_launcher/url_launcher.dart';

import 'backend/Api_call.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({super.key});

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  @override
  late Future<List> news;
  String errorImg =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGkAznCVTAALTD1o2mAnGLudN9r-bY6klRFB35J2hY7gvR9vDO3bPY_6gaOrfV0IHEIUo&usqp=CAU';
  void initState() {
    // TODO: implement initState
    super.initState();
    // news = APICall().fetchnNew("business");
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
          backgroundColor: const Color(0xFF0D011B),
          appBar: AppBar(
            elevation: 2,
            backgroundColor: const Color(0xFF0D011B),
            surfaceTintColor: const Color(0xFF0D011B),
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
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(45),
              child: TabBar(
                labelColor: Colors.white,
                dividerColor: Colors.white38,
                dividerHeight: 1,
                // padding: EdgeInsets.only(bottom: 10),
                isScrollable: true,
                //  indicatorPadding: EdgeInsets.all(10),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.yellow,
                indicatorWeight: 3.5,
                tabAlignment: TabAlignment.start,
                labelPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                unselectedLabelStyle:
                    TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                labelStyle:
                    TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                tabs: [
                  Text("Business"),
                  Text("Entertainment"),
                  Text("General"),
                  // Text("Health"),
                  Text("Science"),
                  Text("Technology"),
                  Text("Sports")
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              NewDetail("business"),
              NewDetail("entertainment"),
              NewDetail("general"),
              // NewDetail("health"),
              NewDetail("science"),
              NewDetail("technology"),
              NewDetail("sports"),
            ],
          )),
    );
  }

  void _showBottomSheet(
      String image, String title, String dec, String url, Map newZ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            // controller: scrollController,
            child: Container(
              // margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color(0xFF0D011B),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        height: 250,
                        width: double.maxFinite,
                        foregroundDecoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(image), fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: SizedBox(
                            width: 350,
                            child: Text(
                              title,
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          dec,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NewZDetail(newZ: newZ)));
                              // if (await canLaunch(url)) {
                              //   await launch(url);
                              // } else {
                              //   throw 'Could not launch $url';
                              // }
                            },
                            child: const Text("Read More >>",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.yellow,
                                    fontWeight: FontWeight.w500)))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Widget NewDetail(String newType) {
    return Expanded(
        child: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<List>(
        future: APICall().fetchnNew(newType),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            _showBottomSheet(
                                snapshot.data![index]['urlToImage'] ?? errorImg,
                                snapshot.data![index]['title'],
                                snapshot.data![index]['description'] ?? "",
                                snapshot.data![index]['url'],
                                snapshot.data![index]);
                          },
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: snapshot.data![index]['urlToImage'] ??
                                    errorImg,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(
                                  color: Colors.yellow,
                                ),
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: 75,
                                  height: 75,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 270,
                                    child: Text(
                                      snapshot.data![index]['title'],
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        snapshot.data![index]['publishedAt'],
                                        style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        width: 80,
                                      ),
                                      SizedBox(
                                          width: 80,
                                          child: Text(
                                            snapshot.data![index]['source']
                                                ['name'],
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.yellow,
                                                fontWeight: FontWeight.w500),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        const Divider(
                          color: Colors.white38,
                          thickness: .4,
                        )
                      ],
                    ),
                  );
                });
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.yellow,
            ));
          }
        },
      ),
    ));
  }
}
