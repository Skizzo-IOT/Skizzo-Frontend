import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skizzo/cubit/tcp_cubit.dart';

class Joystick extends StatelessWidget {
  const Joystick({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade600.withOpacity(0.5),
      ),
      width: 200,
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Expanded(
                    child: JoystickButton(
                      icon: Icons.arrow_drop_up,
                      onTapDown: () {
                        BlocProvider.of<TcpCubit>(context).directionY += 1;
                        BlocProvider.of<TcpCubit>(context).sendDirection();
                      },
                      onTapCancel: () {
                        BlocProvider.of<TcpCubit>(context).directionY -= 1;
                        BlocProvider.of<TcpCubit>(context).sendDirection();
                      },
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: JoystickButton(
                      icon: Icons.arrow_left,
                      onTapDown: () {
                        BlocProvider.of<TcpCubit>(context).directionX -= 1;
                        BlocProvider.of<TcpCubit>(context).sendDirection();
                      },
                      onTapCancel: () {
                        BlocProvider.of<TcpCubit>(context).directionX += 1;
                        BlocProvider.of<TcpCubit>(context).sendDirection();
                      },
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: JoystickButton(
                      icon: Icons.arrow_right,
                      onTapDown: () {
                        BlocProvider.of<TcpCubit>(context).directionX += 1;
                        BlocProvider.of<TcpCubit>(context).sendDirection();
                      },
                      onTapCancel: () {
                        BlocProvider.of<TcpCubit>(context).directionX -= 1;
                        BlocProvider.of<TcpCubit>(context).sendDirection();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Spacer(),
                  Expanded(
                    child: JoystickButton(
                      icon: Icons.arrow_drop_down,
                      onTapDown: () {
                        BlocProvider.of<TcpCubit>(context).directionY -= 1;
                        BlocProvider.of<TcpCubit>(context).sendDirection();
                      },
                      onTapCancel: () {
                        BlocProvider.of<TcpCubit>(context).directionY += 1;
                        BlocProvider.of<TcpCubit>(context).sendDirection();
                      },
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class JoystickButton extends StatefulWidget {
  final IconData icon;
  final Function onTapDown;
  final Function onTapCancel;

  const JoystickButton({
    Key? key,
    required this.icon,
    required this.onTapDown,
    required this.onTapCancel,
  }) : super(key: key);

  @override
  State<JoystickButton> createState() => _JoystickButtonState();
}

class _JoystickButtonState extends State<JoystickButton> {
  bool pressAttention = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          pressAttention = true;
          widget.onTapDown();
        });
      },
      onTapUp: (_) {
        setState(() {
          pressAttention = false;
          widget.onTapCancel();
        });
      },
      onTapCancel: () {
        setState(() {
          pressAttention = false;
          widget.onTapCancel();
        });
      },
      child: CircleAvatar(
        backgroundColor: pressAttention ? Colors.grey.shade600 : Colors.grey,
        child: Icon(widget.icon, size: 60),
        radius: 80,
      ),
    );
  }
}
