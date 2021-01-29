---
layout: default
title: Home
nav_order: 1
permalink: /
---
<head>
<link rel="shortcut icon" type="image/x-icon" href="favicon.ico">
</head>

# Welcome to the DEST Dataset

<br>
Hover over the interactive map to explore the DEST metadata.
<div id="key"></div>

<script>
/* map key */
var key = document.getElementById("key");
key
  .createElement("div")
  .setAttribute("style",
    "width: 200px; float: right;
     border: solid; border-width: 2px; border-radius: 5px;
     padding: 5px;"
  );
key.html(
  "• DGN" + "<br>" +
  "• DrosEU" + "<br>" +
  "• DrosRTEC"
);
</script>

{% include map.html %}

<img src="/assets/images/map-timeline.png" style="width:100%">
