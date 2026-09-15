import 'package:flutter/material.dart';


// SPECIAL FEATURE 3:
// Custom ThemeExtension lets us create our own custom colors
// that are not already included in Flutter's ColorScheme.
class AppColors extends ThemeExtension<AppColors> {
  final Color success;

  const AppColors({
    required this.success,
  });

  @override
  AppColors copyWith({
    Color? success,
  }) {
    return AppColors(
      success: success ?? this.success,
    );
  }

  @override
  AppColors lerp(
    ThemeExtension<AppColors>? other,
    double t,
  ) {
    if (other is! AppColors) {
      return this;
    }

    return AppColors(
      success: Color.lerp(
        success,
        other.success,
        t,
      )!,
    );
  }
}


void main() {
  runApp(const RunMyApp());
}


class RunMyApp extends StatefulWidget {
  const RunMyApp({super.key});

  @override
  State<RunMyApp> createState() => _RunMyAppState();
}


class _RunMyAppState extends State<RunMyApp> {

  // Keeps track of the current theme.
  ThemeMode _themeMode = ThemeMode.light;


  @override
  Widget build(BuildContext context) {

    // Checks if dark mode is currently selected.
    bool isDark = _themeMode == ThemeMode.dark;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Theme Demo',


      // SPECIAL FEATURE 1:
      // Material 3 generates a complete light color palette
      // using one seed color.
      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),

        // SPECIAL FEATURE 3:
        // Adds our custom success color to the light theme.
        extensions: const [
          AppColors(
            success: Colors.green,
          ),
        ],
      ),


      // SPECIAL FEATURE 1:
      // Material 3 also generates a dark color palette
      // using the same seed color.
      darkTheme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),

        // SPECIAL FEATURE 3:
        // Custom success color for dark mode.
        extensions: const [
          AppColors(
            success: Colors.lightGreen,
          ),
        ],
      ),


      // Connects our current state to the app theme.
      themeMode: _themeMode,


      home: Builder(
        builder: (context) {

          // SPECIAL FEATURE 4:
          // AnimatedTheme makes the theme change smoothly
          // instead of changing themed colors immediately.
          return AnimatedTheme(
            data: Theme.of(context),
            duration: const Duration(milliseconds: 500),

            child: Scaffold(

              appBar: AppBar(
                title: const Text('Theme Demo'),
              ),


              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [

                    // PART 2 - TASK 1:
                    // AnimatedContainer automatically animates
                    // when its properties change.
                    AnimatedContainer(

                      // PART 2 - TASK 3:
                      // Half-second animation duration.
                      duration:
                          const Duration(milliseconds: 500),

                      width: 200,
                      height: 200,

                      decoration: BoxDecoration(

                        // Changes the circle color
                        // depending on the current theme.
                        color: isDark
                            ? Colors.white
                            : Colors.grey,

                        shape: BoxShape.circle,
                      ),
                    ),


                    const SizedBox(height: 20),


                    // SPECIAL FEATURE 3:
                    // Reads the custom success color
                    // from our AppColors ThemeExtension.
                    Text(
                      'Choose the Theme:',
                      style: TextStyle(
                        fontSize: 16,

                        color: Theme.of(context)
                            .extension<AppColors>()!
                            .success,
                      ),
                    ),


                    const SizedBox(height: 10),


                    // PART 2 - TASK 2 & TASK 4:
                    // Contains the dynamic icon and theme switch.
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,

                      children: [

                        // PART 2 - TASK 4:
                        // Shows the moon in dark mode
                        // and the sun in light mode.
                        Icon(
                          isDark
                              ? Icons.nightlight_round
                              : Icons.wb_sunny,

                          size: 30,
                        ),


                        const SizedBox(width: 10),


                        // PART 2 - TASK 2:
                        // Switches between light and dark themes.
                        Switch(
                          value: isDark,

                          onChanged: (bool value) {

                            setState(() {

                              _themeMode = value
                                  ? ThemeMode.dark
                                  : ThemeMode.light;

                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}