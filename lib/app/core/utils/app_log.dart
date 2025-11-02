// Define an enum for log levels (optional but good practice)
import 'dart:developer';

enum LogLevel {
  debug,
  info,
  warning,
  error,
  // Add more levels if needed, e.g., severe
}

/// A utility class for centralized, level-specific application logging.
class AppLog {
  // --- Configuration ---
  static const LogLevel _minLogLevel = LogLevel.debug;
  static const String _defaultTag = 'APP';

  /// The core private logging function where the formatting and printing happens.
  static void _log(
      String message,
      LogLevel level, {
        String tag = _defaultTag,
        // Optional: Pass an error object for error logs
        Object? error,
      }) {
    // Check if the current log level is high enough to be displayed
    if (level.index < _minLogLevel.index) {
      return;
    }

    // Get current time for the timestamp
    String timestamp = DateTime.now().toIso8601String().substring(11, 23);

    // Format the output string
    String logOutput = '[$timestamp] [${level.name.toUpperCase()}] <$tag> $message';

    // Print the log. Use the standard print or dart:developer log for better tool support.
    log(logOutput);

    // If it's an error, you can also print the error object for a full stack trace.
    if (error != null) {
      log(error.toString());
    }

    // --- ENHANCEMENT: INTEGRATION ---
    // For 'error' or 'severe', you could add logic here to send the data
    // to an external crash reporting service like Sentry or Crashlytics.
  }

  // --- Public Static Methods (Your Desired Syntax) ---

  static void debug(String comment, {String tag = _defaultTag}) {
    _log(comment, LogLevel.debug, tag: tag);
  }

  static void info(String comment, {String tag = _defaultTag}) {
    _log(comment, LogLevel.info, tag: tag);
  }

  static void warning(String comment, {String tag = _defaultTag}) {
    _log(comment, LogLevel.warning, tag: tag);
  }

  static void error(String comment, {String tag = _defaultTag, Object? error}) {
    _log(comment, LogLevel.error, tag: tag, error: error);
  }
}