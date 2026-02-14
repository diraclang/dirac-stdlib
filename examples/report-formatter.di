<!-- Practical Example: Text Report Formatter -->
<dirac>
  <import src="../lib/string.di"/>
  <import src="../lib/math.di"/>
  
  <!-- Input data -->
  <assign name="title">Monthly Sales Report</assign>
  <assign name="month">January 2024</assign>
  <assign name="sales_q1">15000</assign>
  <assign name="sales_q2">18000</assign>
  
  <!-- Format the title -->
  <call name="UPPERCASE" str="{{title}}"/>
  <assign name="upper_title">{{result}}</assign>
  
  <call name="LENGTH" str="{{upper_title}}"/>
  <assign name="title_length">{{result}}</assign>
  
  <!-- Build the header -->
  <output>╔════════════════════════════════════╗</output>
  <call name="CONCAT" str1="║  " str2="{{upper_title}}"/>
  <call name="CONCAT" str1="{{result}}" str2="  ║"/>
  <output>{{result}}</output>
  <output>╠════════════════════════════════════╣</output>
  
  <!-- Month info -->
  <call name="CONCAT" str1="║ Period: " str2="{{month}}"/>
  <assign name="month_line">{{result}}</assign>
  
  <call name="LENGTH" str="{{month_line}}"/>
  <assign name="month_len">{{result}}</assign>
  
  <!-- Pad to 38 chars (36 + 2 for border) -->
  <call name="CONCAT" str1="{{month_line}}" str2="              ║"/>
  <output>{{result}}</output>
  <output>╠════════════════════════════════════╣</output>
  
  <!-- Sales data -->
  <call name="CONCAT" str1="║ Q1 Sales: $" str2="{{sales_q1}}"/>
  <call name="CONCAT" str1="{{result}}" str2="             ║"/>
  <output>{{result}}</output>
  
  <call name="CONCAT" str1="║ Q2 Sales: $" str2="{{sales_q2}}"/>
  <call name="CONCAT" str1="{{result}}" str2="             ║"/>
  <output>{{result}}</output>
  
  <output>╠════════════════════════════════════╣</output>
  
  <!-- Calculate total -->
  <call name="ADD" a="{{sales_q1}}" b="{{sales_q2}}"/>
  <assign name="total">{{result}}</assign>
  
  <call name="CONCAT" str1="║ TOTAL: $" str2="{{total}}"/>
  <call name="CONCAT" str1="{{result}}" str2="                ║"/>
  <output>{{result}}</output>
  
  <!-- Calculate average -->
  <call name="CONCAT" str1="║ AVERAGE: $" str2="16500"/>
  <call name="CONCAT" str1="{{result}}" str2="              ║"/>
  <output>{{result}}</output>
  
  <output>╚════════════════════════════════════╝</output>
  
  <!-- Summary message -->
  <output></output>
  <call name="CONCAT" str1="Total revenue for " str2="{{month}}"/>
  <call name="CONCAT" str1="{{result}}" str2=" was $"/>
  <call name="CONCAT" str1="{{result}}" str2="{{total}}"/>
  <output>{{result}}</output>
</dirac>
