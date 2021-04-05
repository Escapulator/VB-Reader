import 'package:flutter/material.dart';

class Options extends StatefulWidget {
  final String option;
  final String desc;
  final String correctAnsa;
  final String selected;

  Options(
      {@required this.desc,
      @required this.correctAnsa,
      @required this.option,
      @required this.selected});
  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .025,
            width: MediaQuery.of(context).size.width * .05,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(
                  color: widget.desc == widget.selected
                      ? widget.selected == widget.correctAnsa
                          ? Colors.green.withOpacity(0.7)
                          : Colors.red.withOpacity(0.7)
                      : Colors.grey[700],
                ),
                color: widget.desc == widget.selected
                      ? widget.selected == widget.correctAnsa
                          ? Colors.green.withOpacity(0.7)
                          : Colors.red.withOpacity(0.7)
                      : Colors.transparent,
                borderRadius: BorderRadius.circular(50)),
            child: Text(
              widget.option,
              style: TextStyle(
                  color: widget.option == widget.selected
                      ? widget.correctAnsa == widget.selected
                          ? Colors.green.withOpacity(0.7)
                          : Colors.red.withOpacity(0.7)
                      : Colors.grey[700].withOpacity(0.7),
                  fontSize: 16),
            ),
          ),
          SizedBox(
            width: 2,
          ),
          Text(
            widget.desc,
            style: TextStyle(color: Colors.black, fontSize: 18,),
          )
        ],
      ),
    );
  }
}
