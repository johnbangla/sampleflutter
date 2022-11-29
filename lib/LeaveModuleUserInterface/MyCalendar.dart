import 'package:flutter/material.dart';
class MyCalendar extends StatefulWidget {
  const MyCalendar({super.key, required this.title});



  final String title;

  @override
  State<MyCalendar> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyCalendar> {
  // ignore: unnecessary_new
  DateTimeRange dtrange = new DateTimeRange(
      start: DateTime(2022, 11, 5), end: DateTime(2022, 12, 5));

  @override
  Widget build(BuildContext context) {
    final strt = dtrange.start;
    final dend = dtrange.end;
    final daydiff = dtrange.duration;

    Future pickDaterange() async {
      DateTimeRange? newdatetimerng = await showDateRangePicker(
          context: context,
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
          initialDateRange: dtrange);
      if (newdatetimerng == null) return;
      setState(() => (dtrange = newdatetimerng));
    }

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Date range',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 16),

                const SizedBox(width: 12),
                  IconButton(
                      icon: const Icon(Icons.volume_up),
                      onPressed: () {
                        pickDaterange();
                      }),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   
                    const SizedBox(height: 12),
                    Expanded(
                        child: ElevatedButton(
                      onPressed: pickDaterange,
                      child: Text('${strt.year}/${strt.month}/${strt.day}'),
                    )),
                    const SizedBox(width: 12),
                    Expanded(
                        child: ElevatedButton(
                            onPressed: (() => {}),
                            child:
                                Text('${dend.year}/${dend.month}/${dend.day}'))),
                    const SizedBox(height: 16),
                    Expanded(child: Text('${daydiff.inDays}days'))
                  ],
                ),
              ),
            ],
          ),
        )
        // This trailing comma makes auto-formatting nicer for build methods.

        );
  }
}


