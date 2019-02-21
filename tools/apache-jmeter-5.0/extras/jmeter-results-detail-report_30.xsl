<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<!--
   Licensed to the Apache Software Foundation (ASF) under one or more
   contributor license agreements.  See the NOTICE file distributed with
   this work for additional information regarding copyright ownership.
   The ASF licenses this file to You under the Apache License, Version 2.0
   (the "License"); you may not use this file except in compliance with
   the License.  You may obtain a copy of the License at
 
       http://www.apache.org/licenses/LICENSE-2.0
 
   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
-->

	<!-- 
	Stylesheet for processing 3.0 output format test result files 
	To uses this directly in a browser, add the following to the JTL file as line 2:
	<?xml-stylesheet type="text/xsl" href="../extras/jmeter-results-detail-report_30.xsl"?>
	and you can then view the JTL in a browser.Edit by ZHC
-->

	<xsl:output method="html" indent="yes" encoding="UTF-8" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" />
	<xsl:param    name="titleReport" select="'Interface Test Results'"/>

	<xsl:template match="testResults">
		<html>
			<head>
				<title>
					<xsl:value-of select="$titleReport" />
				</title>
				<style type="text/css">
				body {
					font:normal 68% verdana,arial,helvetica;
					color:#000000;
				}
				table tr td, table tr th {
					font-size: 68%;
				}
				table.details tr th{
				    color: #ffffff;
					font-weight: bold;
					text-align:center;
					background:#2674a6;
					white-space: nowrap;
				}
				table.details tr td{
					background:#eeeee0;
					white-space: nowrap;
				}
				h1 {
					margin: 0px 0px 5px; font: 165% verdana,arial,helvetica
				}
				h2 {
					margin-top: 1em; margin-bottom: 0.5em; font: bold 125% verdana,arial,helvetica
				}
				h3 {
					margin-bottom: 0.5em; font: bold 115% verdana,arial,helvetica
				}
				.Failure {
					font-weight:bold; color:red;
				}
				.LongTime {
					font-weight:bold; color:#ff9900;
				}


				img
				{
				  border-width: 0px;
				}

				.expand_link
				{
				   position=absolute;
				   right: 0px;
				   width: 27px;
				   top: 1px;
				   height: 27px;
				}

				.page_details
				{
				   display: none;
				}

                .page_details_expanded
                {
                    display: block;
                    display/* hide this definition from  IE5/6 */: table-row;
                }


				</style>
				<script language="JavaScript">
					<![CDATA[
	                function expand(details_id)
				   	{
				      
				    	document.getElementById(details_id).className = "page_details_expanded";
				   	}
				   
				   	function collapse(details_id)
				   	{
				      
				      	document.getElementById(details_id).className = "page_details";
				   	}
				   
				   	function change(details_id)
				   	{
				   		var _dataType=document.getElementById(details_id+"_image").getAttribute('data-type');
				      	if(_dataType=='expand')
				      	{
				         	<!-- document.getElementById(details_id+"_image").src = "collapse.png";  -->
				         	document.getElementById(details_id+"_image").src = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAQMAAAAlPW0iAAAABGdBTUEAALGPC/xhBQAAAAFzUkdCAK7OHOkAAAAGUExURSZ0pv///xB+eSAAAAARSURBVAjXY2DABuR/gBA2AAAzpwIvNQARCgAAAABJRU5ErkJggg==";
				         	expand(details_id);
				         	document.getElementById(details_id+"_image").setAttribute('data-type','collapse');
				      	}
				      	else
				      	{
				        	<!-- document.getElementById(details_id+"_image").src = "expand.png"; -->
				        	document.getElementById(details_id+"_image").src = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAQMAAAAlPW0iAAAABGdBTUEAALGPC/xhBQAAAAFzUkdCAK7OHOkAAAAGUExURSZ0pv///xB+eSAAAAAWSURBVAjXY2CAAcYGBJL/AULIIjAAAJJrBjcL30J5AAAAAElFTkSuQmCC";
				         	collapse(details_id);
				         	document.getElementById(details_id+"_image").setAttribute('data-type','expand');
				      	} 
	                }
				]]>
				</script>
			</head>
			<body>	
				<xsl:call-template name="summary" />
				<hr size="1" width="95%" align="center" />

			</body>
		</html>
	</xsl:template>
	<xsl:template name="summary">
		<h2>Summary</h2>
		<table align="center" class="details" border="0" cellpadding="5" cellspacing="2" width="95%">
			<tr valign="top">				
				<th># Test Case</th>
				<th>Samples</th>
				<th>Success</th>
				<th>Failures</th>
				<th>Success Rate</th>
			</tr>
			<tr valign="top">
				<xsl:variable name="allThreadCount" select= "count(/testResults/*[not(@tn=preceding-sibling::*/@tn)]/@tn)"/>
				<xsl:variable name="allCount" select="count(/testResults/*)" />				
				<xsl:variable name="allFailureCount" select="count(/testResults/*[attribute::s='false'])" />
				<xsl:variable name="allSuccessCount" select="count(/testResults/*[attribute::s='true'])" />
				<xsl:variable name="allSuccessPercent" select="$allSuccessCount div $allCount" />	
				<td align="center">
					<xsl:value-of select="$allThreadCount" />
				</td>
				<td align="center">
					<xsl:value-of select="$allCount" />
				</td>
				<td align="center">
					<xsl:value-of select="$allSuccessCount" />
				</td>
				<xsl:choose>
					<xsl:when test="$allFailureCount &gt; 0">
						<td align="center" style="font-weight:bold">
							<font color="red">
								<xsl:value-of select="$allFailureCount" />
							</font>
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td align="center">
							<xsl:value-of select="$allFailureCount" />
						</td>
					</xsl:otherwise>
				</xsl:choose>	
				<td align="center">
					<xsl:call-template name="display-percent">
						<xsl:with-param name="value" select="$allSuccessPercent" />
					</xsl:call-template>
				</td>		
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="display-percent">
		<xsl:param name="value" />
		<xsl:value-of select="format-number($value,'0.00%')" />
	</xsl:template>

</xsl:stylesheet>
