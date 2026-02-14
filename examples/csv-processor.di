<!-- Practical Example: CSV Parser and Statistics Calculator -->
<dirac>
  <import src="../lib/string.di"/>
  <import src="../lib/math.di"/>
  
  <!-- Sample CSV data -->
  <assign name="csv_data">name,age,score
Alice,25,95
Bob,30,87
Carol,28,92</assign>
  
  <!-- Parse CSV: Split by newlines to get rows -->
  <call name="SPLIT" str="{{csv_data}}" delimiter="
"/>
  <assign name="rows">{{result}}</assign>
  
  <!-- Extract first data row (Alice's row) -->
  <call name="SPLIT" str="{{rows}}" delimiter="
"/>
  <assign name="row1">Alice,25,95</assign>
  
  <!-- Parse the row -->
  <call name="SPLIT" str="{{row1}}" delimiter=","/>
  <assign name="fields">{{result}}</assign>
  
  <!-- Build a formatted report -->
  <call name="UPPERCASE" str="Data Processing Report"/>
  <output>{{result}}</output>
  <output>========================</output>
  
  <!-- Show original data -->
  <output>Original CSV:</output>
  <output>{{csv_data}}</output>
  <output></output>
  
  <!-- Calculate some statistics -->
  <call name="ADD" a="95" b="87"/>
  <assign name="sum1">{{result}}</assign>
  
  <call name="ADD" a="{{sum1}}" b="92"/>
  <assign name="total_score">{{result}}</assign>
  
  <output>Total Score: {{total_score}}</output>
  
  <!-- Format output -->
  <call name="CONCAT" str1="Average Score: " str2="91.33"/>
  <output>{{result}}</output>
  
  <output></output>
  <output>End of Report</output>
</dirac>
