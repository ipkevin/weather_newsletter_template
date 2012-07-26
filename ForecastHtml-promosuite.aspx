<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="WXCData" %>
<!-- Header -->
<% // set up date

	DateTime dt = DateTime.Now;
	String date;
	date = dt.ToString("f");
%>
<html>
<head>
<title>7 Day Weather Forecast - CityNews Toronto</title>
<meta name="viewport" content="width=device-with, user-scalable=yes">
<style>
tr.bottomborder td {border-bottom: 1pt solid black}
</style>
</head>
<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0"  marginheight="0">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td bgcolor="#000000">
    
        <table width="600" class="container" border="0" cellpadding="0" cellspacing="0" bgcolor="#000000">
            <tr>
                <td colspan="2" bgcolor="#000000" align="center"><a href="http://itunes.apple.com/ca/app/citynews/id422910003?mt=8&ls=1"></a></td>
          </tr>
            <tr bgcolor="#000000">
                <td width="50%"><a href="http://www.citytv.com/toronto/citynews" target="_blank">
              <img src="http://site.citytv.com/newsletter/citynews/images/2010/citynews2010_v01_03.gif" border="0" alt="" class="mobile_img"></a></td>
              <td width="50%" height="80" valign="middle"><a href="http://itunes.apple.com/ca/app/citynews/id422910003?mt=8&ls=1">
                <img src="http://citytv.rdmmedia.topscms.com/images/9e/8f/d09d4aea420b9a5c28cbc2162a26.jpeg" height="60" width="300" class="mobile_img" alt="" border="0"/>
              </a></td>
            </tr>
                <tr>
                <td width="50%"><img src="http://site.citytv.com/newsletter/citynews/images/spacer.gif" width="1" height="5" alt=""></td>
            </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#002f59">
        <table width="600" class="header_bar" border="0" cellspacing="0" cellpadding="0" bgcolor="#002f59" height="32">
          <tr>
            <td width="50%"><span style="font-family:Arial, Helvetica, sans-serif; color:#FFFFFF; font-weight:bold; padding-left:15px">CityNews Weather Alert</span></td>
            <td width="50%" align="right">
                <span style="font-family:Arial, Helvetica, sans-serif; color:#FFFFFF; padding-right:15px; font-size:11px"><%=date%></span>
            </td>
          </tr>
      </table>
    </td>
  </tr>
</table>




<table style="font-family:Arial, Helvetica, sans-serif; font-size: 10px; color: #333333;" width="600" class="container" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td>
    
<!-- Beginning of Weather Content -->

<% 

WXCObject[] forecast = WXCService.GetForecast("CYYZ");
StringBuilder feed = new StringBuilder();

feed.Append("<table align='left' width='580' border='0' cellpadding='0' cellspacing='0'>");

int iteration = 0; // tmuir
    
foreach(WXCObject weather in forecast) {
// new code - tmuir
// determine if we have reached 7 displayed days, or if the current day data is prior to current date
	if (iteration == 7 ) continue;
	if (weather.Date.Value < DateTime.Today) continue;
	iteration = iteration + 1;

//    if (weather.Date.Value == DateTime.Today) continue;

    feed.Append(string.Format("<tr class='bottomborder'><td align='center' style='color:#333333; font-size:12px;' height='70'><strong>{0}</strong><br>{1}</td>", weather.Date.Value.DayOfWeek.ToString().ToUpper(), weather.Date.Value.ToString("MMM d").ToUpper()));
	
	if (weather.TempLow == 0) {
		feed.Append(string.Format(@"
			<td align='center' height='70' style='color:#333333;'>
			<span style='color:#FF6600; font-size:12px;' class='mobile_text'><strong>HIGH:</strong> {0}&deg;C</span><br>
			<span style='color:#267C99; font-size:12px;' class='mobile_text'><strong>LOW:</strong> {1}&deg;C</span></td>", weather.TempHigh, "0"));
	} else {	
		feed.Append(string.Format(@"
			<td align='center' height='70' style='color:#333333;'>
			<span style='color:#FF6600; font-size:12px;' class='mobile_text'><strong>HIGH:</strong> {0}&deg;C</span><br>
			<span style='color:#267C99; font-size:12px;' class='mobile_text'><strong>LOW:</strong> {1}&deg;C</span></td>", weather.TempHigh, weather.TempLow));    
	}
	
    feed.Append(string.Format("<td><img src='{0}'></td><td>{1}</td>", weather.Icon, weather.Conditions));

	
}
feed.Append("</table>");

Response.Write(feed.ToString());
%>

<!-- Beginning of Weather Content -->

    </td>
  </tr>
</table>

<table width="600" class="container" height="75" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="75"><a href="http://www.citytv.com/toronto/citynews/weather" target="_blank"><img style="margin-left: 15px;" src="http://site.citytv.com/newsletter/citynews/images/2010/btn_fullforecast.jpg" border="0" class="mobile_img" alt="More Weather"/></a></td>
  </tr>
</table>




<!-- Footer -->
<table width="600" class="container" height="80" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>
    <td width="50%"><img src="http://weather.citytv.com/WXCData/Templates/Newsletter/images/rogersfooter_300.gif" class="mobile_img" / ></td>
    <td width="50%"><font color="#002f59" size="1" face="Arial,Verdana,Helvetica,Sans-Serif">&copy; 2009-2012 by Rogers Broadcasting Limited.<br>
    All rights reserved.</font></td>
  </tr>
</table>

</body>
</html>
