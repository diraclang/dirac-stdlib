<dirac>
<subroutine name="play-youtube" 
            description="Search and play a video on YouTube by title" 
            param-title="string:required:The video title or search query">
  <!-- Build YouTube search URL -->
  <eval name="url">
    return 'https://www.youtube.com/results?search_query=' + encodeURIComponent(title)
  </eval>
 
  
  <output>🎵 Opening YouTube search: <variable name="title" />
</output>
  
  <!-- Open in default browser (works on macOS) -->
  <system>open <variable name="url" /></system>
</subroutine>

<subroutine name="play-youtube-music" 
            description="Search and play music on YouTube Music by title or artist" 
            param-query="string:required:Song title, artist, or search query">
  <eval name="url">
    return 'https://music.youtube.com/search?q=' + encodeURIComponent(query)
  </eval>
  
  <output>🎶 Opening YouTube Music: <variable name="query" />
</output>
  
  <system>open <variable name="url" /></system>
</subroutine>

<subroutine name="open-website" 
            description="Open any website URL in the default browser" 
            param-url="string:required:The full URL to open (with https://)">
  <output>🌐 Opening: <variable name="url" />
</output>
  
  <system>open <variable name="url" /></system>
</subroutine>
</dirac>
