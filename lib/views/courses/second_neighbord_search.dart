import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tito/controllers/district_controler.dart';
import 'package:tito/views/courses/adress_district_course.dart';
import 'package:tito/views/courses/course_map_neighbord.dart';

import '../../components/constante.dart';
import '../../controllers/strict_adress_controller.dart';
import '../../controllers/strict_local_storage.dart';
import '../../models/api_response.dart';
import '../../models/district.dart';

class SecondNeighborhoodSearch extends SearchDelegate {
  FetchDistrictList _districtList = FetchDistrictList();

  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    assert(theme != null);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        brightness: colorScheme.brightness,
        backgroundColor: colorScheme.brightness == Brightness.dark
            ? appBlackColor
            : appBlackColor,
        iconTheme: theme.primaryIconTheme.copyWith(color: appBackground),
        textTheme: theme.textTheme,
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle: searchFieldStyle ?? theme.inputDecorationTheme.hintStyle,
            border: InputBorder.none,
          ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<District>>(
        future: _districtList.getDistrictList(query: query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: appColor,
              ),
            );
          }
          List<District>? data = snapshot.data;
          return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: GestureDetector(
                      onTap: () async {
                        ApiResponse response = await getStrictInfo(
                            int.parse("${data![index].id}"));
                        var adress = response.data as Map;
                        print(adress['id']);
                        addItemsOrderAdress(
                          adress['id'],
                        );
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AdressNeighboord()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: appBlackColor, width: 3),
                          color: appBackground,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(left: 10, right: 10, top: 15),
                              child: Column(
                                children: [
                                  Container(
                                    child: Text(
                                      "${data?[index].name}",
                                      maxLines: 2,
                                      style: GoogleFonts.poppins(
                                          color: appBlackColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 15, bottom: 12),
                              child: Icon(
                                Icons.location_on_rounded,
                                color: appColor,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      )),
                );
              });
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Chercher un restaurant ou une cave à vain'),
    );
  }
}
