<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    response.setHeader("Access-Control-Allow-Origin", "*");
     response.addHeader("Access-Control-Allow-Credentials", "true");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Remote control</title>
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.js"></script>
    </head>
    <body style="width: 300px">
        <div>
        <center>
        Distance:<div id="distance"></div>
        <button id="forward" name="forward">^</button>
        <br/>
        <button id="left" name="left">&lt;</button>
        <button id="right" name="right">&gt;</button>
        <br/>
        <button id="reverse" name="reverse">v</button>
        <br/>
        <button id="stop" name="stop">Stop</button>
        <br/>
        <button style="display: block" id="checkDistance" name="checkDistance">Check Distance</button>
        <br/>
        <button id="lookahead" name="lookahead">Look ahead</button>
        </center>
        </div>
    </body>
    
        <script type="text/javascript">
           $('#forward').click(function(){ 
                $.getJSON("http://192.168.1.51:8080/things/frente/5",
                        function(data) {
                            shouldCheckingDistance = true;
                       });   
            });
           $('#left').click(function(){ 
                $.getJSON("http://192.168.1.51:8080/things/direita/5",
                        function(data) {
                       });   
            });
           $('#right').click(function(){ 
                $.getJSON("http://192.168.1.51:8080/things/esquerda/5",
                        function(data) {

                       });   
            });
           $('#reverse').click(function(){ 
                $.getJSON("http://192.168.1.51:8080/things/re/5",
                        function(data) {

                       });   
            });
            function stop()
            {
                      $.getJSON("http://192.168.1.51:8080/things/parar",
                        function(data) {
                            shouldCheckingDistance = false;

                       });   
            }

           $('#lookahead').click(function(){ 
               $.getJSON("http://192.168.1.51:8080/things/servo/0",
                        function(data) {
                       });   
            });
            
           $('#stop').click(function(){ 
               stop();
            });


            var shouldCheckingDistance = true;
            function checkDistance(){
                if(shouldCheckingDistance)
                {
                    console.log("checking distance...");
                    $.getJSON('${pageContext.request.contextPath}/distance.htm', 
                    function(data) {
                        console.log("distance:"+data);
                        $('#distance').text(data);
                        //If less than 50cm stop
                        if(data < 50)
                         {
                             stop();
                         }
                        setTimeout(checkDistance,1000);
                    }).fail(function() {
                        console.log("distance check failed!");
                    });
                }else
                {
                   console.log("skipping distance check...");
                   $('#distance').text("");
                   setTimeout(checkDistance,1000);
                }   
            }
           checkDistance();
          $('#checkDistance').click(function(){ 
                    console.log("checking distance...");
                    $.get('${pageContext.request.contextPath}/distance.htm', 
                    function(data) {
                        console.log("distance:"+data);
                        $('#distance').text(data);
                    }).fail(function() {
                        console.log("distance check failed!");
                    }); 
            });
 
        </script>
    
    
</html>
