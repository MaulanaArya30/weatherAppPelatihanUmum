import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0xFF4A91FF), Color(0xFF47BFDF)],
              ),
            ),
            child: SvgPicture.asset('assets/vector.svg'),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(36, 50, 36, 36),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 28.0),
                    width: double.infinity,
                    height: 60,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: 40.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Search City',
                              hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.3),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (value) {
                              cityName = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context, cityName);
                    },
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        'Get Weather',
                        style: TextStyle(
                          letterSpacing: 1.0,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF444D71),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
