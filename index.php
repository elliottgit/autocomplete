<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Demo</title>
  <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.1/themes/base/minified/jquery-ui.min.css" type="text/css" /> 
</head>
<body>

    <form action='' method='post'>  
	<p><label>Product:</label><input type='text' name='product' value='' class='auto'></p>
	<p style="text-align: center;"><img src="home.jpg" alt="Home Image" width="450" height="400" /></p>  
    </form>
    <br>
    <hr />
    <p><strong> Author: Elliott Ning </strong></p>
    <p><strong> Date: 12/19/2017 </strong></p>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.10.1/jquery-ui.min.js"></script>
<script type="text/javascript">
$(function() {
        
        //autocomplete
        $(".auto").autocomplete({
                source: "search.php",
                minLength: 1
        });                             
});
</script>
</body>
</html>
