import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user_application/styles/colors.dart';
import 'package:user_application/styles/fonts.dart';
import 'package:user_application/widgets/back_button.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

  Future<String?> _getLatestApplicationId() async {
    if (user == null) {
      throw Exception("No user is logged in.");
    }

    final querySnapshot = await _firestore
        .collection('users')
        .doc(user!.uid)
        .collection('visa_applications')
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
    }

    return null;
  }

  Future<List<Map<String, dynamic>>> _getVisaStatusHistory(
      String applicationId) async {
    if (user == null) {
      throw Exception("No user is logged in.");
    }

    final querySnapshot = await _firestore
        .collection('users')
        .doc(user!.uid)
        .collection('visa_applications')
        .doc(applicationId)
        .collection('visa_status')
        .doc(applicationId)
        .collection('history')
        .orderBy('timestamp', descending: true)
        .get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  String _timeAgo(DateTime dateTime) {
    final duration = DateTime.now().difference(dateTime);
    if (duration.inDays > 0) {
      return '${duration.inDays} days ago';
    } else if (duration.inHours > 0) {
      return '${duration.inHours} hours ago';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes} minutes ago';
    } else {
      return 'just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                DripCloseButton(onTap: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                }),
                SizedBox(width: 20),
                Text("Visa Status",
                    style: heading1Style.copyWith(color: Colors.white)),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "Here you can check the status of your visa application and get updates on its progress. We'll keep you posted every step of the way.",
              style: paragraph1Style.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 20),

            // Visa Status Content
            Expanded(
              child: FutureBuilder<String?>(
                future: _getLatestApplicationId(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final applicationId = snapshot.data;

                  if (applicationId == null) {
                    return Center(
                      child: Text('No visa application found.',
                          style: heading1Style.copyWith(color: Colors.white)),
                    );
                  }

                  return FutureBuilder<List<Map<String, dynamic>>>(
                    future: _getVisaStatusHistory(applicationId),
                    builder: (context, statusSnapshot) {
                      if (statusSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        );
                      }

                      if (statusSnapshot.hasError) {
                        return Center(
                          child: Text('Error: ${statusSnapshot.error}',
                              style: TextStyle(color: Colors.white)),
                        );
                      }

                      final statusHistory = statusSnapshot.data;

                      if (statusHistory == null || statusHistory.isEmpty) {
                        return Center(
                          child: Text('No visa status found.',
                              style:
                                  heading1Style.copyWith(color: Colors.white)),
                        );
                      }

                      return ListView.builder(
                        itemCount: statusHistory.length,
                        itemBuilder: (context, index) {
                          final status = statusHistory[index];
                          //final statusCode = status['status_code'];
                          final statusMessage = status['status_message'];
                          final timestamp =
                              (status['timestamp'] as Timestamp?)?.toDate();
                          final author = status['author'];
                          final comments = status['comments'];

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                color: tertiaryColor,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 23, horizontal: 17),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Status",
                                          style: paragraph2Style.copyWith(
                                              color: Colors.black)),
                                      Text(
                                        "$statusMessage".toUpperCase(),
                                        style: paragraph1Style.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff387048)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 23, horizontal: 17),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Last Updated",
                                      style: paragraph2Style.copyWith(
                                          color: Color(0xffC5E3CD)),
                                    ),
                                    if (timestamp != null)
                                      Text(
                                        "${_timeAgo(timestamp)}",
                                        style: paragraph1Style.copyWith(
                                            color: Colors.white),
                                      ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Color(0xff777777).withOpacity(0.34),
                                thickness: 0.3,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 23, horizontal: 17),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Updated by",
                                      style: paragraph2Style.copyWith(
                                          color: Color(0xffC5E3CD)),
                                    ),
                                    if (timestamp != null)
                                      Text(
                                        "$author",
                                        style: paragraph1Style.copyWith(
                                            color: Colors.white),
                                      ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Color(0xff777777).withOpacity(0.34),
                                thickness: 0.3,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 23, horizontal: 17),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Comment",
                                      style: paragraph2Style.copyWith(
                                          color: Color(0xffC5E3CD)),
                                    ),
                                    if (comments != null)
                                      Text(
                                        "$comments",
                                        style: paragraph1Style.copyWith(
                                            color: Colors.white),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
