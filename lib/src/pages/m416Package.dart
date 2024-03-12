import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/getpackages.dart';





class Package extends StatefulWidget {
  const Package({Key key}) : super(key: key);

  @override
  _PackageState createState() => _PackageState();
}

class _PackageState extends State<Package> {

  GetPackages packages;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPackages();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //     width: MediaQuery.of(context).size.width / 1,
            //     height: MediaQuery.of(context).size.height /1.4,
            //     child: Stack(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: GridView.builder(
            //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //               crossAxisCount: 3,
            //               mainAxisSpacing: 6.0,
            //               crossAxisSpacing: 6.0,
            //               childAspectRatio: MediaQuery.of(context).size.width /
            //                   (MediaQuery.of(context).size.height / 1.5),
            //             ),
            //             itemCount: packages.data.length,
            //             itemBuilder: (context, index) {
            //               return Stack(
            //                 children: [
            //                   ClipRRect(
            //                     borderRadius: BorderRadius.circular(12.0),
            //                     child: InkWell(
            //                       onTap: () {
            //
            //                       },
            //                       child:Image(
            //                         image: NetworkImage('https://images.unsplash.com/photo-1607082349566-187342175e2f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8ZGlzY291bnR8ZW58MHx8MHx8&w=1000&q=80'),
            //                         height: double.infinity,
            //                         width: double.infinity,
            //                         fit: BoxFit.cover,
            //                       ),
            //                     ),
            //                   ),
            //                   ClipRRect(
            //                     borderRadius: BorderRadius.circular(12.0),
            //                     child:Container(
            //                       alignment: Alignment.bottomCenter,
            //                       /* background black light to dark gradient color */
            //                       child: Stack(
            //                         children: [
            //                           Container(
            //                             alignment: Alignment.bottomCenter,
            //                             height: 80,
            //                             decoration: BoxDecoration(
            //                               gradient: new LinearGradient(
            //                                 begin: const Alignment(0.0, -1.0),
            //                                 end: const Alignment(0.0, 0.6),
            //                                 colors: <Color>[
            //                                   const Color(0x8A000000).withOpacity(0.0),
            //                                   const Color(0x8A000000).withOpacity(0.9),
            //                                 ],
            //                               ),
            //                             ),
            //                           )
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //                   Container(
            //                     height: double.infinity,
            //                     width: 110.0,
            //                     decoration: BoxDecoration(
            //                       //gradient: Palette.storyGradient,
            //                       borderRadius: BorderRadius.circular(12.0),
            //                     ),
            //                   ),
            //                   Align(
            //                     alignment: Alignment.topLeft,
            //                     child: Padding(
            //                       padding: const EdgeInsets.all(8.0),
            //                       child: Column(
            //                         children: [
            //                           Text(
            //                             packages.data[index].userId,
            //                             style: const TextStyle(
            //                                 color: Colors.white,
            //                                 fontWeight: FontWeight.bold,
            //                                 fontSize: 20
            //                             ),
            //                             maxLines: 2,
            //                             overflow: TextOverflow.ellipsis,
            //                           ),
            //                           SizedBox(height: 10,),
            //                           Text(
            //                             packages.data[index].days,
            //                             style: const TextStyle(
            //                                 color: Colors.white,
            //                                 fontWeight: FontWeight.bold,
            //                                 fontSize: 16
            //                             ),
            //                             maxLines: 2,
            //                             overflow: TextOverflow.ellipsis,
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //                   Align(
            //                     alignment: Alignment.bottomRight,
            //                     child: Padding(
            //                       padding: const EdgeInsets.all(8.0),
            //                       child: Text(
            //                         packages.data[index].amount,
            //                         style: const TextStyle(
            //                             color: Colors.white,
            //                             fontWeight: FontWeight.bold,
            //                             fontSize: 20
            //                         ),
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                       ),
            //                     ),
            //                   ),
            //
            //
            //                 ],
            //
            //
            //               );
            //             },
            //           ),
            //         ),
            //       ],
            //     )
            // ),
          ],
        ),
      ),
    );
  }
  getPackages() async
  {
    try {
      var url = Uri.parse("http://m416.co/api/index.php/api_admin/getPackage");
      var response = await get(url);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        setState(() {
          packages = GetPackages.fromJson(jsonResponse);
        });
      }
    }
    catch(e) {
      print(e.toString());
    }
  }
}
