import 'package:flutter/material.dart';
import 'package:trivia_que_app/Screens/homepage.dart';

class Completed extends StatelessWidget {
  const Completed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 521, width: 400,
            child: Stack(
              children: [
                Container(
                  height: 340, width: 410,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(
                    child: CircleAvatar(
                      radius: 85,
                      backgroundColor: Colors.white.withOpacity(.3),
                      child: CircleAvatar(backgroundColor: Colors.white.withOpacity(.4), radius: 71,
                      child: CircleAvatar(
                        radius: 68,
                        backgroundColor: Colors.white,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Your score', style: TextStyle(fontSize: 20, color: Colors.green),
                              ),
                              RichText(
                                text: const TextSpan(text: '100', style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                              ),
                              children: [
                                TextSpan(
                                  text: ' pt', style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                  )
                                )
                              ],
                              ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 60,
                  left: 22,
                  child: Container(
                    height: 190, width: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 1),
                        ),
                      ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Row(
                                        children: [
                                          Container(
                                          height: 15, width: 15,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.green
                                           ),
                                        ),
                                        const Text('100', style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black
                                        ),)
                                        ],
                                      ),
                                    ),
                                    const Text('Completion')
                                  ],
                                ),
                                
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Row(
                                        children: [
                                          Container(
                                          height: 15, width: 15,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.green
                                           ),
                                        ),
                                        const Text('10', style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black
                                        ),)
                                        ],
                                      ),
                                    ),
                                    const Text('Total Questions')
                                  ],
                                ),
                                

                              ],),

                              const SizedBox(height: 25,)

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Row(
                                        children: [
                                          Container(
                                          height: 15, width: 15,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.green
                                           ),
                                        ),
                                        const Text(' 07', style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black
                                        ),)
                                        ],
                                      ),
                                    ),
                                    const Text('Correct')
                                  ],
                                ),
                                
                                Padding(
                                  padding: const EdgeInsets.only(right: 48.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Row(
                                          children: [
                                            Container(
                                            height: 15, width: 15,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.green
                                             ),
                                          ),
                                          const Text(' 03', style: TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red
                                          ),)
                                          ],
                                        ),
                                      ),
                                      const Text('Total Questions')
                                    ],
                                  ),
                                ),
                                

                              ],)
                          ],
                        ),
                      ),
                    ),
                  )),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => const HomePage()));
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 20,
                        child: Center(
                          child: Icon(Icons.refresh, size: 35, color: Colors.white,),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('Play again', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),)
                  ],),

                  Column(children: [
                    CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 20,
                      child: Center(
                        child: Icon(Icons.visibility_rounded, size: 35, color: Colors.white,),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('Review Answer', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),)
                  ],),

                  Column(children: [
                    CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 20,
                      child: Center(
                        child: Icon(Icons.share, size: 35, color: Colors.white,),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('Share', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),)
                  ],)
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}