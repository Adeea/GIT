<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" exclude-result-prefixes="#all"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:wd="urn:com.workday/bsvc" xmlns:xtt="urn:com.workday/xtt"
    xmlns:peci="urn:com.workday/peci" xmlns:ptdf="urn:com.workday/peci/tdf"
    xmlns:fn="http://www.w3.org/2005/xpath-functions">
    
    <xsl:output omit-xml-declaration="yes"
        method="xml"
        indent="yes"/>
    
    <xsl:template match="peci:Workers_Effective_Stack">
        <Personer>
            <xsl:variable name="Company" select="peci:Summary/peci:Pay_Group_ID"/>
            <xsl:for-each select="peci:Worker">
                
                <xsl:variable name="Emp_ID" select="peci:Worker_Summary/peci:Employee_ID"/>
                <xsl:variable name="SSN" select="peci:Effective_Change[last()]/peci:Person_Identification/peci:National_Identifier[peci:National_ID_Type = 'SWE-PN']/peci:National_ID"/>
                <xsl:variable name="Last_Name" select="peci:Effective_Change[last()]/peci:Personal/peci:Legal_Name/peci:Last_Name"/>
                <xsl:variable name="First_Name" select="peci:Effective_Change[last()]/peci:Personal/peci:Legal_Name/peci:First_Name"/>
                <xsl:variable name="Work_Email" select="peci:Effective_Change[last()]/peci:Person_Communication/peci:Email[peci:Usage_Type='WORK']/peci:Email_Address"/>
                <xsl:variable name="Address_Line_1" select="normalize-space(peci:Effective_Change[last()]/peci:Person_Communication/peci:Address[peci:Usage_Type='HOME']/peci:Address_Line_1)"/>
                <xsl:variable name="Address_Line_2" select="normalize-space(peci:Effective_Change[last()]/peci:Person_Communication/peci:Address[peci:Usage_Type='HOME']/peci:Address_Line_2)"/>
                <xsl:variable name="Postal_Code" select="peci:Effective_Change[last()]/peci:Person_Communication/peci:Address[peci:Usage_Type='HOME']/peci:Postal_Code"/>
                <xsl:variable name="City" select="peci:Effective_Change[last()]/peci:Person_Communication/peci:Address[peci:Usage_Type='HOME']/peci:City"/>
                <xsl:variable name="Country" select="peci:Effective_Change[last()]/peci:Person_Communication/peci:Address[peci:Usage_Type='HOME']/peci:Country"/>
                <xsl:variable name="PFTE" select="peci:Effective_Change[last()]/peci:Position[peci:Primary_Job = '1' and not(peci:Position_End_Date)]/peci:Full_Time_Equivalent_Percentage"/>
                <xsl:variable name="SFTE" select="peci:Effective_Change[last()]/peci:Position[peci:Primary_Job = '1' and not(peci:Position_End_Date)]/peci:Full_Time_Equivalent_Percentage"/>
                <xsl:variable name="ScheduledWeeklyHours" select="peci:Effective_Change[last()]/peci:Position[peci:Primary_Job = '1' and not(peci:Position_End_Date)]/peci:Scheduled_Weekly_Hours"/>
                
                <xsl:variable name="HIR" select="peci:Effective_Change[peci:Derived_Event_Code='HIR']"/>
                <xsl:variable name="TER" select="peci:Effective_Change[peci:Derived_Event_Code='TERM']"/>
                <xsl:variable name="DTA" select="peci:Effective_Change[peci:Derived_Event_Code='DTA']"/>
                <xsl:variable name="PGI" select="peci:Effective_Change[peci:Derived_Event_Code='PGI']"/>
                <xsl:variable name="PGO" select="peci:Effective_Change[peci:Derived_Event_Code='PGO']"/>
                <xsl:variable name="PCI" select="peci:Effective_Change[peci:Derived_Event_Code='PCI']"/>
                <xsl:variable name="PCO" select="peci:Effective_Change[peci:Derived_Event_Code='PCO']"/>
				
				<xsl:variable name="Prior_Comp_Plan_Salary_Root" select="peci:Effective_Change[last()-1]/peci:Compensation_Plans/peci:Salary_and_Hourly_Plan"/>
				<xsl:variable name="Prior_Comp_Amount" select="peci:Effective_Change[last()-1]/peci:Compensation_Plans/peci:Salary_and_Hourly_Plan/peci:Amount"/>
                <xsl:variable name="Prior_Comp_Prorated_Amount" select="peci:Effective_Change[last()-1]/peci:Compensation_Plans/peci:Salary_and_Hourly_Plan/peci:Prorated_Amount"/>
                <xsl:variable name="Prior_Start_Date" select="peci:Effective_Change[last()-1]/peci:Compensation_Plans/peci:Salary_and_Hourly_Plan/peci:Start_Date"/>
                <xsl:variable name="Prior_End_Date" select="peci:Effective_Change[last()-1]/peci:Compensation_Plans/peci:Salary_and_Hourly_Plan/peci:End_Date"/>
				<xsl:variable name="Prior_Comp_Plan" select="peci:Effective_Change[last()-1]/peci:Compensation_Plans/peci:Salary_and_Hourly_Plan/peci:Compensation_Plan"/>
				<xsl:variable name="Prior_Frequency" select="peci:Effective_Change[last()-1]/peci:Compensation_Plans/peci:Salary_and_Hourly_Plan/peci:Frequency"/>
				
				<xsl:variable name="Prior_Comp_Amount_Allowance" select="peci:Effective_Change[last()-1]/peci:Compensation_Plans/peci:Allowance_Plan/peci:Amount"/>
                <xsl:variable name="Prior_Comp_Prorated_Amount_Allowance" select="peci:Effective_Change[last()-1]/peci:Compensation_Plans/peci:Allowance_Plan/peci:Prorated_Amount"/>
                <xsl:variable name="Prior_Start_Date_Allowance" select="peci:Effective_Change[last()-1]/peci:Compensation_Plans/peci:Allowance_Plan/peci:Start_Date"/>
                <xsl:variable name="Prior_End_Date_Allowance" select="peci:Effective_Change[last()-1]/peci:Compensation_Plans/peci:Allowance_Plan/peci:End_Date"/>
				<xsl:variable name="Prior_Comp_Plan_Allowance" select="peci:Effective_Change[last()-1]/peci:Compensation_Plans/peci:Allowance_Plan/peci:Compensation_Plan"/>
				<xsl:variable name="Prior_Frequency_Allowance" select="peci:Effective_Change[last()-1]/peci:Compensation_Plans/peci:Allowance_Plan/peci:Frequency"/>
                <xsl:variable name="Prior_Comp_Plan_Allowance_Root" select="peci:Effective_Change[last()-1]/peci:Compensation_Plans/peci:Allowance_Plan"/>
                
                <xsl:variable name="Prior_Effective_Moment" select="peci:Effective_Change[last()-1]/peci:Effective_Moment"/>
				
				
				<Person>
                    <FTG_NR>
                        <xsl:value-of select="$Company"/>
                    </FTG_NR>
                    <ANST_NR>
                        <xsl:value-of select="$Emp_ID"/>
                    </ANST_NR>
                    <xsl:if test="fn:exists(peci:Effective_Change[(peci:Derived_Event_Code='HIR' or peci:Derived_Event_Code='PGI' or peci:Derived_Event_Code='PGO') and peci:Person_Identification[peci:National_Identifier[peci:National_ID_Type = 'SWE-PN']]]) or 
                        fn:exists(peci:Effective_Change[peci:Derived_Event_Code='DTA' and peci:Person_Identification[@peci:isAdded='1' or @peci:isUpdated='1'][peci:National_Identifier[peci:National_ID_Type = 'SWE-PN'][@peci:isAdded='1' or @peci:isUpdated='1']]])">
                        <PERSNR>
                            <xsl:value-of select="$SSN"/>
                        </PERSNR>
                    </xsl:if>
                    
                    <xsl:if test="fn:exists(peci:Effective_Change[peci:Derived_Event_Code='HIR' or peci:Derived_Event_Code='PGI' and peci:Personal/peci:Legal_Name/peci:Last_Name]) or
                        fn:exists(peci:Effective_Change[peci:Derived_Event_Code='DTA' and peci:Personal[@peci:isUpdated='1']/peci:Legal_Name[@peci:isUpdated='1']/peci:Last_Name])">
                        <EFTERNAMN>
                            <xsl:value-of select="$Last_Name"/>
                        </EFTERNAMN>
                    </xsl:if>
                    
                    <xsl:if test="fn:exists(peci:Effective_Change[peci:Derived_Event_Code='HIR' or peci:Derived_Event_Code='PGI' and peci:Personal/peci:Legal_Name/peci:First_Name]) or
                        fn:exists(peci:Effective_Change[peci:Derived_Event_Code='DTA' and peci:Personal[@peci:isUpdated='1']/peci:Legal_Name[@peci:isUpdated='1']/peci:First_Name])">
                        <FORNAMN>
                            <xsl:value-of select="$First_Name"/>
                        </FORNAMN>
                    </xsl:if>
                    
                    <xsl:if test="fn:exists(peci:Effective_Change[peci:Derived_Event_Code='HIR' or peci:Derived_Event_Code='PGI' and peci:Person_Communication/peci:Email[peci:Usage_Type='WORK']/peci:Email_Address]) or
                        fn:exists(peci:Effective_Change[peci:Derived_Event_Code='DTA' and peci:Person_Communication[@peci:isAdded='1' or @peci:isUpdated='1']/peci:Email[peci:Usage_Type='WORK'][@peci:isAdded='1' or @peci:isUpdated='1']/peci:Email_Address])">
                        <EMAILADRESS>
                            <xsl:value-of select="$Work_Email"/>
                        </EMAILADRESS>
                    </xsl:if>
                    
                    <!-- Work Address -->
                    <xsl:if test="fn:exists(peci:Effective_Change/peci:Person_Communication/peci:Address[@peci:isAdded='1' or @peci:isUpdated='1'][peci:Usage_Type='HOME'])">
                        
                        <Adresser>
                            <Adress>
                                <ADRESSTYP>
                                    <xsl:text>Hemadress</xsl:text>
                                </ADRESSTYP>
                                <CO_ADRESS>
                                    <xsl:text>{blank}</xsl:text>
                                </CO_ADRESS>
                                <ADRESS>
                                    <xsl:value-of select="$Address_Line_1"/>
                                </ADRESS>
                                <ADRESS2>
                                    <xsl:value-of select="$Address_Line_2"/>
                                </ADRESS2>
                                <POSTNR>
                                    <xsl:value-of select="$Postal_Code"/>
                                </POSTNR>
                                <ORT>
                                    <xsl:value-of select="$City"/>
                                </ORT>
                                <LAND>
                                    <xsl:value-of select="$Country"/>
                                </LAND>
                            </Adress>
                        </Adresser>
                        
                    </xsl:if>
                    
                    <!-- Dependents Information -->
                    <xsl:if test="peci:Effective_Change/peci:Related_Person[@peci:isAdded='1']">
                        <Narstaende>
                            <xsl:for-each select="peci:Effective_Change/peci:Related_Person[@peci:isAdded='1']">
                                
                                <Narstaende>
                                    <NARSTAENDENAMN>
                                        <xsl:value-of select="peci:Legal_Name/peci:General_Display_Name"/>
                                    </NARSTAENDENAMN>
                                    <NARSTAENDEFODELSEDAG>
                                        <xsl:value-of select="format-date(peci:Birth_Date,'[Y0001]-[M01]-[D01]')"/>
                                    </NARSTAENDEFODELSEDAG>
                                </Narstaende>
                            </xsl:for-each>
                        </Narstaende>
                    </xsl:if>
                    
                    <xsl:if test="fn:exists(peci:Effective_Change/peci:Payment_Election[@peci:isAdded='1' or @peci:isUpdated='1'])">
                        <Bankkonton>
                            <Bankkonto>
                                <CLEARINGNUMMER>
                                    <xsl:value-of select="peci:Effective_Change[peci:Payment_Election[@peci:isAdded='1' or @peci:isUpdated='1']][last()]/peci:Payment_Election/peci:Bank_ID"/>
                                </CLEARINGNUMMER>
                                <CHECKSIFFRA>
                                    <xsl:value-of select="peci:Effective_Change[peci:Payment_Election[@peci:isAdded='1' or @peci:isUpdated='1']][last()]/peci:Payment_Election/peci:Check_Digit"/>
                                </CHECKSIFFRA>
                                <BANKKONTONUMMER>
                                    <xsl:value-of select="peci:Effective_Change[peci:Payment_Election[@peci:isAdded='1' or @peci:isUpdated='1']][last()]/peci:Payment_Election/peci:Account_Number"/>
                                </BANKKONTONUMMER>
                                <IBAN>
                                    <xsl:value-of select="peci:Effective_Change[peci:Payment_Election[@peci:isAdded='1' or @peci:isUpdated='1']][last()]/peci:Payment_Election/peci:IBAN"/>
                                </IBAN>
                                <BIC>
                                    <xsl:value-of select="peci:Effective_Change[peci:Payment_Election[@peci:isAdded='1' or @peci:isUpdated='1']][last()]/peci:Payment_Election/peci:BIC"/>
                                </BIC>
                            </Bankkonto>
                        </Bankkonton>
                    </xsl:if>
                    
                    <xsl:if test="fn:exists($HIR) or fn:exists($TER) or fn:exists(peci:Effective_Change[peci:Derived_Event_Code='DTA' and peci:Worker_Status/peci:Hire_Date[fn:exists(@peci:priorValue)]]) or fn:exists(peci:Effective_Change[(peci:Derived_Event_Code='DTA' and peci:Employee_Contract[@peci:isAdded='1' or @peci:isUpdated='1'])])">
                        <Anstallningar>
                            <Anstallning>
                                <xsl:if test="fn:exists($HIR)">
                                    <ANSTALLNINGSDATUM>
                                        <xsl:value-of select="format-date($HIR/peci:Worker_Status/peci:Hire_Date,'[Y0001]-[M01]-[D01]')"/>
                                    </ANSTALLNINGSDATUM>
                                </xsl:if>
                                <xsl:if test="fn:exists($TER)">
                                    <AVGANGSDATUM>
<!--                                        <xsl:variable name="Term_Date" select="format-date($TER/peci:Worker_Status/peci:Termination_Date,'[Y0001]-[M01]-[D01]')"/>-->
                                        <xsl:variable name="Term_Date" select="$TER/peci:Worker_Status/peci:Termination_Date"/>
                                     
                                        <xsl:value-of select="format-date(xs:date($Term_Date) + xs:dayTimeDuration('P1D'),'[Y0001]-[M01]-[D01]')"/>
                                    </AVGANGSDATUM>
                                    <AVGANGSORSAK>
                                        <xsl:value-of select="normalize-space($TER/peci:Worker_Status/peci:Primary_Termination_Reason)"/>
                                    </AVGANGSORSAK>
                                </xsl:if>
                                <xsl:for-each select="peci:Effective_Change/peci:Employee_Contract[@peci:isAdded='1' or @peci:isUpdated='1']">
                                    <Anstallningsform>
                                        <TILLTRADE>
                                            <xsl:value-of select="fn:format-date(peci:Start_Date,'[Y0001]-[M01]-[D01]')"/>
                                        </TILLTRADE>
                                        <ANSTALLNINGSFORM>
                                            <xsl:value-of select="peci:Contract_Type"/>
                                        </ANSTALLNINGSFORM>
                                    </Anstallningsform>
                                </xsl:for-each>
                            </Anstallning>
                        </Anstallningar>
                    </xsl:if>
                    <xsl:if test="peci:Effective_Change/peci:Position[@peci:isAdded='1'] or peci:Effective_Change/peci:Position[@peci:isUpdated='1']/peci:Position_End_Date[@peci:isAdded='1']">
                        <Befattningar>
                            <xsl:for-each select="peci:Effective_Change">
                                <xsl:variable name="Pos-EffectiveDate" select="peci:Effective_Moment"/>
                                <xsl:for-each select="peci:Position[@peci:isAdded='1' or @peci:isUpdated='1']">
                                    
                                    <xsl:if test="not(fn:exists(peci:Scheduled_Weekly_Hours[@peci:priorValue]) and fn:exists(peci:Full_Time_Equivalent_Percentage[@peci:priorValue]))">
                                        
                                        <Befattning>
                                            <xsl:attribute name="BEFATTNINGFOMDATUM"><xsl:value-of select="fn:format-dateTime($Pos-EffectiveDate,'[Y0001]-[M01]-[D01]')"/></xsl:attribute>
                                            <BEFATTNING><xsl:value-of select="peci:Job_Title"/></BEFATTNING>
                                            <BEFATTNINGTOMDATUM>
                                                <xsl:choose>
                                                    <xsl:when test="fn:exists(peci:Position_End_Date)">
                                                        <xsl:value-of select="fn:format-date(peci:Position_End_Date,'[Y0001]-[M01]-[D01]')"/>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:text>{blank}</xsl:text>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </BEFATTNINGTOMDATUM>
                                            <BEFATTNINGSSTATUS>
                                                <xsl:choose>
                                                    <xsl:when test="peci:Primary_Job='1'">
                                                        <xsl:text>H</xsl:text>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:text>U</xsl:text>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </BEFATTNINGSSTATUS>
                                        </Befattning>
                                        
                                    </xsl:if>
                                    
                                </xsl:for-each>
                                
                            </xsl:for-each>
                        </Befattningar>
                    </xsl:if>
                    
                    
                    <xsl:if test="peci:Effective_Change/peci:Position[@peci:isAdded='1' or @peci:isUpdated='1'][not(peci:Position_End_Date)]">
                        
                        <Arbetstider>
                            <!-- <xsl:for-each select="peci:Effective_Change[peci:Position[@peci:isAdded='1' or @peci:isUpdated='1'][peci:Primary_Job = '1' and not(peci:Position_End_Date)]]"> -->
                              <xsl:for-each select="peci:Effective_Change[peci:Position[@peci:isAdded='1' or @peci:isUpdated='1'][not(peci:Position_End_Date)]]">  
                                <xsl:variable name="Pos-EffectiveDate" select="peci:Effective_Moment"/>
                                <!-- <xsl:for-each select="peci:Position[@peci:isAdded='1' or @peci:isUpdated='1'][peci:Primary_Job = '1' and not(peci:Position_End_Date)]"> -->
								<xsl:for-each select="peci:Position[@peci:isAdded='1' or @peci:isUpdated='1'][not(peci:Position_End_Date)]">
                                    
                                    <xsl:if test="@peci:isAdded='1' or peci:Scheduled_Weekly_Hours[@peci:priorValue]">
                                        <Arbetstid>
                                            <xsl:attribute name="ARBETSTIDFRANTID">
                                                <xsl:value-of select="fn:format-dateTime($Pos-EffectiveDate,'[Y0001]-[M01]-[D01]')"/>
                                            </xsl:attribute>
                                            <VECKOARBETSTID>
                                                <xsl:value-of select="peci:Scheduled_Weekly_Hours"/>
                                            </VECKOARBETSTID>
                                        </Arbetstid>
                                        
                                    </xsl:if>
                                    <xsl:if test="@peci:isAdded='1' or peci:Full_Time_Equivalent_Percentage[@peci:priorValue]">
                                        <Arbetstid>
                                            <xsl:attribute name="ARBETSTIDFRANTID">
                                                <xsl:value-of select="fn:format-dateTime($Pos-EffectiveDate,'[Y0001]-[M01]-[D01]')"/>
                                            </xsl:attribute>
                                            <SYSSELSATTNINGSGRAD>
                                                <xsl:value-of select="number(peci:Full_Time_Equivalent_Percentage)*100"/>
                                            </SYSSELSATTNINGSGRAD>
                                        </Arbetstid>
                                    </xsl:if>
                                    
                                </xsl:for-each>
                            </xsl:for-each>
                            
                        </Arbetstider>    
                    </xsl:if>
                    
                    <xsl:if test="fn:exists(peci:Effective_Change/peci:Additional_Information/ptdf:Manager[@peci:isAdded='1'])
                        or fn:exists(peci:Effective_Change/peci:Additional_Information/ptdf:Manager[@peci:priorValue]) 
                        or fn:exists(peci:Effective_Change/peci:Additional_Information/ptdf:Production[@peci:isAdded='1']) 
                        or fn:exists(peci:Effective_Change/peci:Additional_Information/ptdf:Production[@peci:priorValue])
                        or fn:exists(peci:Effective_Change[peci:Derived_Event_Code='HIR'])
                        or fn:exists(peci:Effective_Change[peci:Derived_Event_Code='PGI'])">
                        
                        <Organisationer>
                            <xsl:for-each select="peci:Effective_Change[(peci:Derived_Event_Code='HIR' and peci:Additional_Information/ptdf:Production[@peci:isAdded='1']) or peci:Additional_Information/ptdf:Production[@peci:isAdded='1'] or peci:Additional_Information/ptdf:Production[@peci:priorValue]]">
                                
                                <Organisation>
                                    <xsl:attribute name="ORGANISATIONSFRANTID">
                                        <xsl:value-of select="fn:format-dateTime(peci:Effective_Moment,'[Y0001]-[M01]-[D01]')"/>
                                    </xsl:attribute>
                                    <AVDELNING>
                                        <xsl:choose>
                                            <xsl:when test="peci:Derived_Event_Code='HIR' and peci:Additional_Information/ptdf:Production[@peci:isAdded='1']"><xsl:value-of select="peci:Additional_Information/ptdf:Production"/></xsl:when>
                                            <xsl:otherwise><xsl:value-of select="peci:Additional_Information/ptdf:Production[@peci:isAdded='1' or exists(@peci:priorValue)]"/></xsl:otherwise>
                                        </xsl:choose>
                                    </AVDELNING>
                                </Organisation>
                                
                            </xsl:for-each>
                            <xsl:for-each select="peci:Effective_Change[(peci:Derived_Event_Code='HIR' and peci:Additional_Information/ptdf:Manager[@peci:isAdded='1']) or peci:Additional_Information/ptdf:Manager[@peci:isAdded='1'] or peci:Additional_Information/ptdf:Manager[@peci:priorValue]]">
                                
                                <Organisation>
                                    <xsl:attribute name="ORGANISATIONSFRANTID">
                                        <xsl:value-of select="fn:format-dateTime(peci:Effective_Moment,'[Y0001]-[M01]-[D01]')"/>
                                    </xsl:attribute>
                                    <ARBETSLEDARE>
                                        <xsl:choose>
                                            <xsl:when test="peci:Derived_Event_Code='HIR' and peci:Additional_Information/ptdf:Manager[@peci:isAdded='1']"><xsl:value-of select="normalize-space(peci:Additional_Information/ptdf:Manager)"/></xsl:when>
                                            <xsl:otherwise><xsl:value-of select="normalize-space(peci:Additional_Information/ptdf:Manager[@peci:isAdded='1' or exists(@peci:priorValue)])"/></xsl:otherwise>
                                        </xsl:choose>
                                    </ARBETSLEDARE>
                                </Organisation>
                                
                            </xsl:for-each>
                            <!--<Organisation>
                                <xsl:attribute name="ORGANISATIONSFRANTID">
                                    <xsl:text>To be Clarified</xsl:text>
                                </xsl:attribute>
                                <AVDELNING>
                                    <xsl:value-of select="peci:Effective_Change/peci:Additional_Information/ptdf:Production[@peci:isAdded='1' or exists(@peci:priorValue)]"/>
                                </AVDELNING>
                                <ARBETSLEDARE>
                                    <xsl:value-of select="peci:Effective_Change/peci:Additional_Information/ptdf:Manager[@peci:isAdded='1' or exists(@peci:priorValue)]"/>
                                </ARBETSLEDARE>
                            </Organisation>-->
                        </Organisationer>
                    </xsl:if>
                    
<!--   16/09/2024                   Code change START for checking the termination reason-->
                    <xsl:choose>
                        <xsl:when test="peci:Effective_Change[last()]/peci:Derived_Event_Code='TERM' and peci:Effective_Change[last()]/peci:Compensation/peci:Compensation_Change_Reason='Request_Compensation_Change_Base_Salary_Change_Brought_to_a_Minimum'">
      <!--   16/09/2024                   Code change END for checking the termination reason-->                   
						 
						 <!--   04/11/2024                   Code change START for checking the termination reason, if matches, print prior compensation values-->
					 
                            <FastaArter>
							<xsl:for-each select="$Prior_Comp_Plan_Salary_Root">
                                <xsl:variable name="This_Amount">
                                    <xsl:choose>
                                        <xsl:when test="exists($Prior_Comp_Prorated_Amount)">
                                            <xsl:value-of select="($Prior_Comp_Prorated_Amount)"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="($Prior_Comp_Amount)"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:variable>
                                <FastArt>
                                    <xsl:attribute name="DATUM_IN">
                                        <xsl:value-of select="fn:format-date($Prior_Start_Date,'[Y0001]-[M01]-[D01]')"/>
                                    </xsl:attribute>
                                    <LONEART>
                                        <xsl:value-of select="$Prior_Comp_Plan"/>
                                    </LONEART>
                                    <PRIS>
                                        <xsl:choose>
                                            <xsl:when test="$Prior_Comp_Plan = 'Hourly' and $Prior_Frequency='Annual'"><xsl:value-of select="fn:format-number($This_Amount div 12, '#.00')"/></xsl:when>
                                            <xsl:when test="$Prior_Comp_Plan = 'Hourly'"><xsl:value-of select="$This_Amount"/></xsl:when>
                                            <xsl:otherwise>0.00</xsl:otherwise>
                                        </xsl:choose>
                                    </PRIS>
                                    <BELOPP>
                                        <xsl:choose>
                                            <xsl:when test="($Prior_Comp_Plan != 'Hourly') and $Prior_Frequency='Annual'"><xsl:value-of select="fn:format-number($This_Amount div 12, '#.00')"/></xsl:when>
                                            <xsl:when test="($Prior_Comp_Plan != 'Hourly')"><xsl:value-of select="$This_Amount div 12"/></xsl:when>
                                            <xsl:otherwise>0.00</xsl:otherwise>
                                        </xsl:choose>
                                    </BELOPP>
                                    <DATUM_UT>
                                   
                                            <xsl:value-of select="format-date($Prior_End_Date,'[Y0001]-[M01]-[D01]')"/>
                                            
            
                                    </DATUM_UT>
                                    <FASTAARTER_TYP>
                                        <xsl:choose>
                                            <xsl:when test="$Prior_Comp_Plan = 'Hourly'"><xsl:text>P</xsl:text></xsl:when>
                                            <xsl:otherwise><xsl:text>A</xsl:text></xsl:otherwise>
                                        </xsl:choose>
                                    </FASTAARTER_TYP>
                                </FastArt>
							</xsl:for-each>
                                <xsl:if test="exists($Prior_Comp_Plan_Allowance_Root)">
                                    <xsl:for-each select="$Prior_Comp_Plan_Allowance_Root">
                                    <xsl:variable name="This_Amount_Allowance">
                                        <xsl:choose>
                                            <xsl:when test="exists($Prior_Comp_Prorated_Amount_Allowance)">
                                                <xsl:value-of select="($Prior_Comp_Prorated_Amount_Allowance)"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="($Prior_Comp_Amount_Allowance)"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:variable>
                                    <FastArt>
                                        <xsl:attribute name="DATUM_IN">
                                            <xsl:value-of select="fn:format-date($Prior_Start_Date_Allowance,'[Y0001]-[M01]-[D01]')"/>
                                        </xsl:attribute>
                                        <LONEART>
                                            <xsl:value-of select="$Prior_Comp_Plan_Allowance"/>
                                        </LONEART>
                                        <PRIS>
                                            <xsl:choose>
                                                <xsl:when test="$Prior_Comp_Plan_Allowance = 'Hourly' and $Prior_Frequency_Allowance='Annual'"><xsl:value-of select="fn:format-number($This_Amount_Allowance div 12, '#.00')"/></xsl:when>
                                                <xsl:when test="$Prior_Comp_Plan_Allowance = 'Hourly'"><xsl:value-of select="$This_Amount_Allowance"/></xsl:when>
                                                <xsl:otherwise>0.00</xsl:otherwise>
                                            </xsl:choose>
                                        </PRIS>
                                        <BELOPP>
                                            <xsl:choose>
                                                <xsl:when test="($Prior_Comp_Plan_Allowance != 'Hourly') and $Prior_Frequency_Allowance='Annual'"><xsl:value-of select="fn:format-number($This_Amount_Allowance div 12, '#.00')"/></xsl:when>
                                                <xsl:when test="($Prior_Comp_Plan_Allowance != 'Hourly')"><xsl:value-of select="$This_Amount_Allowance div 12"/></xsl:when>
                                                <xsl:otherwise>0.00</xsl:otherwise>
                                            </xsl:choose>
                                        </BELOPP>
                                        <DATUM_UT>
                                            
                                            <xsl:value-of select="format-date($Prior_End_Date_Allowance,'[Y0001]-[M01]-[D01]')"/>
                                            
                                            
                                        </DATUM_UT>
                                        <FASTAARTER_TYP>
                                            <xsl:choose>
                                                <xsl:when test="$Prior_Comp_Plan_Allowance = 'Hourly'"><xsl:text>P</xsl:text></xsl:when>
                                                <xsl:otherwise><xsl:text>A</xsl:text></xsl:otherwise>
                                            </xsl:choose>
                                        </FASTAARTER_TYP>
                                    </FastArt>
                                    </xsl:for-each>
                                    
                                </xsl:if>
								
                            </FastaArter>
						 
						 
						 <!--   04/11/2024                   Code change END for checking the termination reason, if matches, print prior compensation values-->
						 
                        </xsl:when>
                        <xsl:otherwise>
						 <!--   16/09/2024                   Code change START for checking the termination reason and if it NOT matches, print FastaArter node -->
                            <xsl:if test="peci:Effective_Change/peci:Compensation_Plans[@peci:isAdded='1' or @peci:isUpdated='1']">
                                
                                <FastaArter>
                                    <xsl:for-each select="peci:Effective_Change[peci:Compensation_Plans[@peci:isAdded='1' or @peci:isUpdated='1']]">
                                        <xsl:variable name="Pri" select="exists(peci:Position[last()]/peci:Primary_Job)"/>
                                        <xsl:variable name="PFTE" select="/peci:Workers_Effective_Stack/peci:Worker[peci:Worker_Summary/peci:Employee_ID=$Emp_ID]/peci:Effective_Change[last()]/peci:Position[peci:Primary_Job = '1' and not(peci:Position_End_Date)]/peci:Full_Time_Equivalent_Percentage[last()]"/>
                                        <xsl:variable name="SFTE" select="/peci:Workers_Effective_Stack/peci:Worker[peci:Worker_Summary/peci:Employee_ID=$Emp_ID]/peci:Effective_Change[last()]/peci:Position[last()]/peci:Full_Time_Equivalent_Percentage[last()] + /peci:Workers_Effective_Stack/peci:Worker[peci:Worker_Summary/peci:Employee_ID=$Emp_ID]/peci:Effective_Change[last()]/peci:Position[peci:Primary_Job = '1' and not(peci:Position_End_Date)]/peci:Full_Time_Equivalent_Percentage[last()]"/>
                                        <xsl:variable name="Su" select="(/peci:Workers_Effective_Stack/peci:Worker[peci:Worker_Summary/peci:Employee_ID=$Emp_ID]/peci:Effective_Change[last()]/peci:Compensation_Plans[1]/peci:Salary_and_Hourly_Plan[1]/peci:Amount + /peci:Workers_Effective_Stack/peci:Worker[peci:Worker_Summary/peci:Employee_ID=$Emp_ID]/peci:Effective_Change[last()]/peci:Compensation_Plans[last()]/peci:Salary_and_Hourly_Plan[last()]/peci:Amount)"/>         
                                        
                                       
                                        
                                        
                                        <xsl:variable name="Effective_Moment" select="peci:Effective_Moment"/>
                                        
                                     <xsl:if test="fn:exists(peci:Compensation_Plans[@peci:isUpdated='1']/peci:Position_End_Date[@peci:isAdded='1'])">
                                         
                                        <xsl:for-each select="peci:Compensation_Plans[@peci:isUpdated='1']/peci:Salary_and_Hourly_Plan">
                                            
                                            <xsl:call-template name="Compensation_Calc">
                                                <xsl:with-param name="Effective_moment" select="$Effective_Moment"/>
                                                <xsl:with-param name="Position_End" select="'True'"/>
                                            </xsl:call-template>
                                        </xsl:for-each>
                                        
                                        <xsl:for-each select="peci:Compensation_Plans[@peci:isUpdated='1']/peci:Allowance_Plan">
                                            <xsl:call-template name="Compensation_Calc">
                                                <xsl:with-param name="Effective_moment" select="$Effective_Moment"/>
                                                <xsl:with-param name="Position_End" select="True"/>
                                            </xsl:call-template>
                                        </xsl:for-each>
                                        
                                        </xsl:if>
                                        
                                        <xsl:if test="peci:Compensation_Plans[@peci:isUpdated='1' or @peci:isAdded='1']">
                                        
                                            <xsl:for-each select="peci:Compensation_Plans[@peci:isUpdated='1' or @peci:isAdded='1']/peci:Salary_and_Hourly_Plan">
                                            
                                            <xsl:call-template name="Compensation_Calc">
                                                <xsl:with-param name="Effective_moment" select="$Effective_Moment"/>
                                                <xsl:with-param name="Pri" select="$Pri"/>
                                                <xsl:with-param name="Su" select="$Su"/>
                                                <xsl:with-param name="SFTE" select="$SFTE"></xsl:with-param>
                                                <xsl:with-param name="PFTE" select="$PFTE"></xsl:with-param>
                                               
                                            </xsl:call-template>
                                        </xsl:for-each>
                                        
                                            <xsl:for-each select="peci:Compensation_Plans[@peci:isUpdated='1' or @peci:isAdded='1']/peci:Allowance_Plan">
                                            <xsl:call-template name="Compensation_Calc">
                                                <xsl:with-param name="Effective_moment" select="$Effective_Moment"/>
                                            </xsl:call-template>
                                        </xsl:for-each>
                                        
                                        </xsl:if>
                                        
                              
                                        
                                    </xsl:for-each>
                                </FastaArter>
                            </xsl:if>
                            <xsl:for-each select="peci:Effective_Change/peci:Compensation_One_Time_Payment[@peci:isAdded ='1' or @peci:isUpdated = '1']">
                                
                                <FastArt>
                                    <xsl:attribute name="DATUM_IN">
                                        <xsl:value-of select="fn:format-dateTime(../peci:Effective_Moment,'[Y0001]-[M01]-[D01]')"/>
                                    </xsl:attribute>
                                    <LONEART>
                                        <xsl:value-of select="peci:External_Payroll_Code"/>
                                    </LONEART>
                                    <BELOPP>
                                        <xsl:value-of select="peci:Amount"/>
                                    </BELOPP>
                                    <DATUM_UT>
                                        <xsl:text>{blank}</xsl:text>
                                    </DATUM_UT>
                                    <FASTAARTER_TYP>
                                        <xsl:text>A</xsl:text>
                                    </FASTAARTER_TYP>
                                </FastArt>
                                
                            </xsl:for-each>

                        </xsl:otherwise>
                    </xsl:choose>
                   <!--   16/09/2024                   Code change END for checking the termination reason and if it NOT matches, print FastaArter node -->
                    
                    
     <!--               <xsl:for-each select="peci:Effective_Change/peci:Compensation_One_Time_Payment[@peci:isAdded ='1' or @peci:isUpdated = '1']">
                        
                        <FastArt>
                            <xsl:attribute name="DATUM_IN">
                                <xsl:value-of select="fn:format-dateTime(../peci:Effective_Moment,'[Y0001]-[M01]-[D01]')"/>
                            </xsl:attribute>
                            <LONEART>
                                <xsl:value-of select="peci:External_Payroll_Code"/>
                            </LONEART>
                            <BELOPP>
                                <xsl:value-of select="peci:Amount"/>
                            </BELOPP>
                            <DATUM_UT>
                                <xsl:text>{blank}</xsl:text>
                            </DATUM_UT>
                            <FASTAARTER_TYP>
                                <xsl:text>A</xsl:text>
                            </FASTAARTER_TYP>
                        </FastArt>
                        
                    </xsl:for-each>-->

                </Person>
            </xsl:for-each>   
            
        </Personer>    
    </xsl:template>
    
    <xsl:template name="Cummulative_sum" match="/peci:Workers_Effective_Stack/peci:Worker/peci:Effective_Change/peci:Compensation_Plans">
        <tr>
            <td><xsl:value-of select="sum(preceding-sibling::peci:Compensation_Plans/peci:Salary_and_Hourly_Plan/peci:Amount) + peci:Amount"/></td></tr>
    </xsl:template>
    
    <xsl:template name='Compensation_Calc'>
        <xsl:param name="Effective_moment"/>
        <xsl:param name="Pri"/>
        <xsl:param name="PFTE"></xsl:param>
        <xsl:param name="Su"></xsl:param>
        <xsl:param name="SFTE"></xsl:param>
        <xsl:param name="Position_End"/>
        <xsl:variable name="Amount">
            <xsl:choose>
                <xsl:when test="exists(peci:Prorated_Amount)">
                    <xsl:value-of select="(peci:Prorated_Amount)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="(peci:Amount)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <FastArt>
            <xsl:attribute name="DATUM_IN">
                <xsl:value-of select="fn:format-date(peci:Start_Date,'[Y0001]-[M01]-[D01]')"/>
            </xsl:attribute>
            <LONEART>
                <xsl:value-of select="peci:Compensation_Plan"/>
            </LONEART>
            <!-- <fte>
                <xsl:choose>
                    <xsl:when test="($Pri)">
                        
                        
                        <xsl:value-of select="$PFTE"/>
                    </xsl:when>
                            
                        
                    <xsl:otherwise>
                        
                     <xsl:value-of select="$SFTE"/>
                        
                    </xsl:otherwise>
                </xsl:choose>
                
            </fte> --> 
            <PRIS>
                <xsl:choose>
                    <xsl:when test="($Pri)">
                        
                        
                        <xsl:choose>
                            <xsl:when test="(peci:Compensation_Plan = 'Hourly') and peci:Frequency='Annual'"><xsl:value-of select="fn:format-number($Amount div 12, '#.00')"/></xsl:when>
                            <xsl:when test="(peci:Compensation_Plan = 'Hourly')"><xsl:value-of select="$Amount div 12"/></xsl:when>
                            <xsl:otherwise>0.00</xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        
                        <xsl:choose>
                            <xsl:when test="(peci:Compensation_Plan = 'Hourly') and peci:Frequency='Annual'"><xsl:value-of select="fn:format-number($Su div 12, '#.00')"/></xsl:when>
                            <xsl:when test="(peci:Compensation_Plan = 'Hourly')"><xsl:value-of select=" $Su div 12"/></xsl:when>
                            <xsl:otherwise>0.00</xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
                <!--  <xsl:choose>
                    <xsl:when test="peci:Compensation_Plan = 'Hourly' and peci:Frequency='Annual'"><xsl:value-of select="fn:format-number($Amount div 12, '#.00')"/></xsl:when>
                    <xsl:when test="peci:Compensation_Plan = 'Hourly'"><xsl:value-of select="$Amount"/></xsl:when>
                    <xsl:otherwise>0.00</xsl:otherwise>
                </xsl:choose>-->
            </PRIS>
            <!--  /peci:Workers_Effective_Stack/peci:Worker/peci:Effective_Change/peci:Position[last()>=1]
            /peci:Workers_Effective_Stack/peci:Worker/peci:Effective_Change/peci:Position[last()]/peci:Primary_Job[last()]
            <xsl:if test="/peci:Workers_Effective_Stack/peci:Worker/peci:Effective_Change/peci:Position/peci:Primary_Job[last()=1]">-->
            <BELOPP>
                <xsl:choose>
                    <xsl:when test="($Pri)">
                
                
                    <xsl:choose>
                        <xsl:when test="(peci:Compensation_Plan != 'Hourly') and peci:Frequency='Annual'"><xsl:value-of select="fn:format-number($Amount div 12, '#.00')"/></xsl:when>
                        <xsl:when test="(peci:Compensation_Plan != 'Hourly')"><xsl:value-of select="$Amount div 12"/></xsl:when>
                        <xsl:otherwise>0.00</xsl:otherwise>
                    </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        
                        <xsl:choose>
                            <xsl:when test="(peci:Compensation_Plan != 'Hourly') and peci:Frequency='Annual'"><xsl:value-of select="fn:format-number($Su div 12, '#.00')"/></xsl:when>
                            <xsl:when test="(peci:Compensation_Plan != 'Hourly')"><xsl:value-of select=" $Su div 12"/></xsl:when>
                            <xsl:otherwise>0.00</xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
               <!--  <xsl:choose>
                    <xsl:when test="(peci:Compensation_Plan != 'Hourly') and peci:Frequency='Annual'"><xsl:value-of select="fn:format-number($Amount div 12, '#.00')"/></xsl:when>
                    <xsl:when test="(peci:Compensation_Plan != 'Hourly')"><xsl:value-of select="$Amount div 12"/></xsl:when>
                    <xsl:otherwise>0.00</xsl:otherwise>
                </xsl:choose>--> 
            </BELOPP>
            <DATUM_UT>
                <xsl:choose>
                    <xsl:when test="exists(peci:End_Date)"><xsl:value-of select="format-date(peci:End_Date,'[Y0001]-[M01]-[D01]')"/></xsl:when>
                    <xsl:when test="$Position_End = 'True'"><xsl:value-of select="format-dateTime($Effective_moment,'[Y0001]-[M01]-[D01]')"/></xsl:when>
                    <xsl:otherwise><xsl:text>{blank}</xsl:text></xsl:otherwise>
                </xsl:choose>
            </DATUM_UT>
            <FASTAARTER_TYP>
                <xsl:choose>
                    <xsl:when test="peci:Compensation_Plan = 'Hourly'"><xsl:text>P</xsl:text></xsl:when>
                    <xsl:otherwise><xsl:text>A</xsl:text></xsl:otherwise>
                </xsl:choose>
            </FASTAARTER_TYP>
        </FastArt>
    </xsl:template>
    
</xsl:stylesheet>