<!--
  Scheduled Log Monitoring with Telegram Alerts
  
  This script monitors a log file and sends Telegram alerts when issues are detected.
  
  Prerequisites:
  - Set TELEGRAM_BOT_TOKEN environment variable
  - Set TELEGRAM_CHAT_ID environment variable
  
  Usage:
  1. Update LOG_FILE variable below
  2. Run: dirac examples/telegram-monitor.di
  3. The script will check the log every 30 seconds
  4. Use :tasks to see running tasks, :stopall to stop
-->
<dirac>
  <!-- Configuration -->
  <defvar name="LOG_FILE" value="/var/log/system.log" />
  <defvar name="CHECK_INTERVAL" value="30" />
  <defvar name="ERROR_KEYWORDS" value="error|fatal|exception|fail" />
  
  <!-- Load telegram library -->
  <import src="../dirac-stdlib/lib/telegram.di" />
  
  <!-- Verify Telegram is configured -->
  <environment name="bot_token" var="TELEGRAM_BOT_TOKEN" />
  <environment name="chat_id" var="TELEGRAM_CHAT_ID" />
  
  <test-if test="$bot_token" eq="">
    <throw message="TELEGRAM_BOT_TOKEN not set. Run telegram-setup.di first." />
  </test-if>
  
  <test-if test="$chat_id" eq="">
    <throw message="TELEGRAM_CHAT_ID not set. Run telegram-setup.di first." />
  </test-if>
  
  <!-- Send startup notification -->
  <call name="send-telegram-alert" 
    level="info"
    title="Log Monitor Started"
    details="Monitoring: ${LOG_FILE}
Interval: ${CHECK_INTERVAL} seconds
Looking for: ${ERROR_KEYWORDS}" />
  
  <output>
===========================================
Log Monitor with Telegram Alerts
===========================================
Monitoring: <variable name="LOG_FILE" />
Check interval: <variable name="CHECK_INTERVAL" /> seconds

Commands:
  :tasks   - Show scheduled tasks
  :stopall - Stop monitoring
  :exit    - Exit shell

Telegram alerts configured ✅
===========================================
  </output>
  
  <!-- Initialize tracking variables -->
  <defvar name="last_check_time" value="0" />
  <defvar name="error_count" value="0" />
  
  <!-- Schedule monitoring task -->
  <schedule interval="${CHECK_INTERVAL}" name="log-monitor-telegram">
    <!-- Get current time -->
    <system output="current_time" trim="true">date +%s</system>
    
    <!-- Read recent log entries (last 100 lines) -->
    <system output="recent_logs" trim="true">tail -100 "${LOG_FILE}" 2>/dev/null || echo ""</system>
    
    <test-if test="$recent_logs" eq="">
      <output>[monitor] Warning: Could not read log file</output>
      <call name="send-telegram-alert" 
        level="warning"
        title="Log File Unreadable"
        details="Cannot access: ${LOG_FILE}" />
    </test-if>
    
    <!-- Search for error keywords -->
    <test-if test="$recent_logs" ne="">
      <system output="error_lines" trim="true">
        echo "<variable name="recent_logs" />" | grep -iE "<variable name="ERROR_KEYWORDS" />" | tail -5
      </system>
      
      <test-if test="$error_lines" ne="">
        <!-- Count errors -->
        <system output="error_count_new" trim="true">
          echo "<variable name="error_lines" />" | wc -l | tr -d ' '
        </system>
        
        <output>[monitor] Found <variable name="error_count_new" /> error(s) in logs</output>
        
        <!-- Send alert -->
        <call name="send-telegram-alert" 
          level="error"
          title="Errors Detected in Logs"
          details="Found ${error_count_new} error(s):

${error_lines}

Log file: ${LOG_FILE}" />
        
        <assign name="error_count">
          <expr eval="plus">
            <arg><variable name="error_count" /></arg>
            <arg><variable name="error_count_new" /></arg>
          </expr>
        </assign>
      </test-if>
      
      <test-if test="$error_lines" eq="">
        <output>[monitor] No errors found - all clear ✅</output>
      </test-if>
    </test-if>
    
    <assign name="last_check_time" value="${current_time}" />
  </schedule>
</dirac>
