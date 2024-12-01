import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({
    super.key,
    this.currentIndex=0,
    required this.children,
    required this.onSelected
  });

  final List<CustomBarItem> children;
  final Function(int) onSelected;
  final int currentIndex;

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  final List<Widget> _internalChildren = [];
  
  @override
  void initState(){
    super.initState();
    for(int i = 0; i < widget.children.length; i++){
      _internalChildren.add(
        Expanded(
          child: GestureDetector(
            onTap: () {
              widget.onSelected(i);
            },
            child: Container(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  widget.children[i],
                ],
              ),
            )
          ),
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _internalChildren,
      ),
    );
  }
}

class CustomBarItem extends StatelessWidget {
  const CustomBarItem({
    super.key,
    required this.child
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}