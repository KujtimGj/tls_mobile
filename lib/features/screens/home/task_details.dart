import 'package:flutter/material.dart';
import 'package:tls/features/screens/home/task_start.dart';

class TaskDetails extends StatefulWidget {
  const TaskDetails({super.key});

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              size: 25,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          children: [
            const Text(
              "Televisions to fix",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              "Troubleshoot and fix the poor television reception in the living room.\n\nCheck cable connections, inspect the antenna for damage, and test alternate sources to isolate the problem. Realign or replace cables as needed, adjust the antenna position for better signal reception, and ensure all channels are accessible. Document the process and communicate findings to the homeowner, suggesting further action if necessary.",
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "Address,18 Nurnberg",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15),

            const Text(
              "Deadline",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.access_time_sharp,
                      size: 25,
                      color: Colors.grey[500],
                    ),
                    const Text(
                      " Deadline: 5 April",
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color(0xffe8ffeb),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    "On Progress",
                    style: TextStyle(
                        color: Color(0xff58dc6b),
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                )
              ],
            ),
            const SizedBox(height: 25),
            const Text(
              "Team Members",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Image.network(
                  "https://www.freelanceri-ks.com/static/media/5.6b92b8441c1a7c558218.png",
                  height: 50,
                ),
                const SizedBox(width: 10),
                Image.network(
                  "https://www.freelanceri-ks.com/static/media/4.97aa07241f899d4be54d.jpg",
                  height: 50,
                ),
                const SizedBox(width: 10),
                Image.network(
                  "https://www.freelanceri-ks.com/static/media/3.7ee4c4764f6fb00e2fc1.png",
                  height: 50,
                ),
                const SizedBox(width: 10),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey[300]),
                  child: const Center(
                    child: Icon(Icons.add),
                  ),
                )
              ],
            ),
            const SizedBox(height: 25),
            const Text(
              "Subtasks",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 80,
              width: size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                      value: false,
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return const Color(
                                0xff58dc6b); // The color when checkbox is selected
                          }
                          return Colors.transparent; // Use the default color
                        },
                      ),
                      onChanged: (value) {
                        setState(() {
                          value = false;
                        });
                      }),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Task one test",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "by Employee",
                        style: TextStyle(color: Colors.grey[400]),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 80,
              width: size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                      value: false,
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return const Color(
                                0xff58dc6b); // The color when checkbox is selected
                          }
                          return Colors.transparent; // Use the default color
                        },
                      ),
                      onChanged: (value) {
                        setState(() {
                          value = false;
                        });
                      }),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Task one test",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "by Employee",
                        style: TextStyle(color: Colors.grey[400]),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 55,
                    margin: const EdgeInsets.all(5),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        "Get Location",
                        style:
                            TextStyle(color: Color(0xff363636), fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const StartedTicket()));
                    },
                    child: Container(
                      height: 55,
                      margin: const EdgeInsets.all(5),
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                          color: const Color(0xff58dc6b),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text(
                          "Start ticket",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
