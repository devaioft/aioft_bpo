// import 'package:flutter/material.dart';
// import 'package:call_log/call_log.dart';

// class CallHistory extends StatefulWidget {
//   const CallHistory({Key? key}) : super(key: key);

//   static const routeName = '/callhistory';

//   @override
//   State<CallHistory> createState() => _CallHistoryState();
// }

// class _CallHistoryState extends State<CallHistory> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Call History'),
//       ),
//       body: FutureBuilder(
//           future: CallLog.get(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData)
//               return Center(child: CircularProgressIndicator());

//             // List<CallLogEntry>? entries = snapshot.data;
//             return Scrollbar(
//               child: ListView.builder(
//                 itemBuilder: (context, index) {
//                   // var entry = entries[index];
//                   var mono = TextStyle(fontFamily: 'monospace');
//                   return Column(
//                     children: <Widget>[
//                       Divider(),
//                       Text('F. NUMBER: ${entry.formattedNumber}', style: mono),
//                       Text('NUMBER   : ${entry.number}', style: mono),
//                       Text('NAME     : ${entry.name}', style: mono),
//                       Text('TYPE     : ${entry.callType}', style: mono),
//                       Text(
//                           'DATE     : ${DateTime.fromMillisecondsSinceEpoch(entry.timestamp)}',
//                           style: mono),
//                       Text('DURATION :  ${entry.duration}', style: mono),
//                     ],
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                   );
//                 },
//                 itemCount: entries.length,
//               ),
//             );
//           }),
//     );
//   }
// }
