import 'package:flutter/material.dart';


// SPECIAL FEATURE 3:
// Custom ThemeExtension allows us to add our own theme colors
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

    // Checks if the current selected theme is dark.
    bool isDark = _themeMode == ThemeMode.dark;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Theme Demo',


      // SPECIAL FEATURE 1:
      // Material 3 generates a full light color scheme
      // using one seed color.
      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),

        // SPECIAL FEATURE 3:
        // Adds our own success color to the light theme.
        extensions: const [
          AppColors(
            success: Colors.green,
          ),
        ],
      ),


      // SPECIAL FEATURE 1:
      // Creates the dark Material 3 color scheme
      // using the same seed color.
      darkTheme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),

        // SPECIAL FEATURE 3:
        // Different success color for dark mode.
        extensions: const [
          AppColors(
            success: Colors.lightGreen,
          ),
        ],
      ),


      // Applies the currently selected theme.
      themeMode: _themeMode,


      home: Builder(
        builder: (context) {

          // SPECIAL FEATURE 4:
          // AnimatedTheme makes theme changes transition
          // smoothly instead of changing immediately.
          return AnimatedTheme(
            data: Theme.of(context),
            duration: const Duration(milliseconds: 500),

            child: Scaffold(

              appBar: AppBar(
                title: const Text('Theme Demo'),
              ),


              // PART 1:
              // The required layout uses a Column inside Center.
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [

                    // PART 1 + PART 2 TASK 1:
                    // AnimatedContainer creates the required
                    // circular container and animates its changes.
                    AnimatedContainer(

                      // PART 2 TASK 3:
                      // Animation lasts for half a second.
                      duration:
                          const Duration(milliseconds: 500),

                      width: 200,
                      height: 200,

                      // Adds spacing around the circle.
                      margin: const EdgeInsets.all(20),

                      decoration: BoxDecoration(

                        // PART 1:
                        // Grey in light mode and white in dark mode.
                        color: isDark
                            ? Colors.white
                            : Colors.grey,

                        // Makes the container circular.
                        shape: BoxShape.circle,
                      ),


                      // PART 1:
                      // Required text inside the circular container.
                      child: const Center(
                        child: Text(
                          'Mobile App Development Testing',

                          textAlign: TextAlign.center,

                          // Only the font size is set here.
                          // Text color is inherited from the theme.
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),


                    const SizedBox(height: 20),


                    // SPECIAL FEATURE 3:
                    // Reads the custom success color from
                    // the current AppColors ThemeExtension.
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


                    // PART 2 TASK 2 + TASK 4:
                    // The Row keeps the icon and switch
                    // next to each other.
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,

                      children: [

                        // PART 2 TASK 4:
                        // Shows a sun in light mode
                        // and a moon in dark mode.
                        Icon(
                          isDark
                              ? Icons.nightlight_round
                              : Icons.wb_sunny,

                          size: 30,
                        ),


                        const SizedBox(width: 10),


                        // PART 2 TASK 2:
                        // Switch changes between light
                        // and dark themes.
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