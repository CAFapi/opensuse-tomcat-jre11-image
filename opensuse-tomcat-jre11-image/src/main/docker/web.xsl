<?xml version="1.0" encoding="utf-8"?>
<!--

    Copyright 2017-2020 Micro Focus or one of its affiliates.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

         http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" encoding="UTF-8" indent="yes" />

    <!-- Copy the entire xml file -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="comment()">
        <xsl:choose>
            <!-- Uncomment httpHeaderSecurity filter -->
            <xsl:when test="contains(., '&lt;filter&gt;') and contains(., 'httpHeaderSecurity')">
                <xsl:value-of disable-output-escaping="yes" select="." />
            </xsl:when>
            <!-- Uncomment httpHeaderSecurity filter mapping, adding FORWARD as dispatcher -->
            <xsl:when test="contains(., '&lt;filter-mapping&gt;') and contains(., 'httpHeaderSecurity')">
                <xsl:text disable-output-escaping="yes">
    &lt;filter-mapping&gt;
        &lt;filter-name&gt;httpHeaderSecurity&lt;/filter-name&gt;
        &lt;url-pattern&gt;/*&lt;/url-pattern&gt;
        &lt;dispatcher&gt;REQUEST&lt;/dispatcher&gt;
        &lt;dispatcher&gt;FORWARD&lt;/dispatcher&gt;
    &lt;/filter-mapping&gt;
                </xsl:text>
            </xsl:when>
            <!-- Ignore all other comments -->
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="." />
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>