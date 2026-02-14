<!-- Practical Example: URL Builder -->
<dirac>
  <import src="../lib/string.di"/>
  
  <!-- Build a URL from components -->
  <assign name="protocol">https</assign>
  <assign name="domain">api.example.com</assign>
  <assign name="path">users/search</assign>
  <assign name="query_name">John Doe</assign>
  
  <!-- URL encode the name (replace spaces) -->
  <call name="REPLACE" str="{{query_name}}" search=" " replace="%20"/>
  <assign name="encoded_name">{{result}}</assign>
  
  <!-- Build the URL step by step -->
  <call name="CONCAT" str1="{{protocol}}" str2="://"/>
  <assign name="url">{{result}}</assign>
  
  <call name="CONCAT" str1="{{url}}" str2="{{domain}}"/>
  <assign name="url">{{result}}</assign>
  
  <call name="CONCAT" str1="{{url}}" str2="/"/>
  <assign name="url">{{result}}</assign>
  
  <call name="CONCAT" str1="{{url}}" str2="{{path}}"/>
  <assign name="url">{{result}}</assign>
  
  <call name="CONCAT" str1="{{url}}" str2="?name="/>
  <assign name="url">{{result}}</assign>
  
  <call name="CONCAT" str1="{{url}}" str2="{{encoded_name}}"/>
  <assign name="url">{{result}}</assign>
  
  <!-- Output the result -->
  <output>Built URL:</output>
  <output>{{url}}</output>
  
  <!-- Validate the URL -->
  <call name="INCLUDES" str="{{url}}" search="https://"/>
  <assign name="is_secure">{{result}}</assign>
  
  <output></output>
  <output>Is Secure (HTTPS): {{is_secure}}</output>
  
  <!-- Extract the domain -->
  <call name="INDEXOF" str="{{url}}" search="://"/>
  <assign name="protocol_end">{{result}}</assign>
  
  <call name="SUBSTRING" str="{{url}}" start="8" length="15"/>
  <output>Domain: {{result}}</output>
</dirac>
