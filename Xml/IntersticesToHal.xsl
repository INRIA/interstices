<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="#all">
    
    <xsl:output encoding="UTF-8" method="xml" indent="yes"/>
    
    
    <xsl:strip-space elements="*"/>
    
 
        
    <xsl:variable name="ListeAuteurs" select="document('ListeAuteurs.xml')"/>
    <xsl:variable name="ListeDomains" select="document('DomainesUnitToHal.xml')"/>
           
       <!-- <xsl:variable name="DocumentInterstices" select="dataset/data[@class='generated.DocumentInterstices']" />-->
          
    <xsl:template match="/">
       
        <TEI xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:hal="http://hal.archives-ouvertes.fr/"
            xsi:schemaLocation="http://www.tei-c.org/ns/1.0 https://api.archives-ouvertes.fr/documents/aofr-sword.xsd">
            <text>
                <body>
                    <listBibl>
       
        <xsl:apply-templates select="dataset/data[@class='generated.DocumentInterstices']" />

    
    </listBibl> 
    
    </body>
    </text>
    </TEI> 
        
    </xsl:template>
    
    <xsl:template match="data">
       
                        <biblFull>  
    
                            <publicationStmt>
                            <availability>
                                    <licence target="http://creativecommons.org/licenses/by-nc-nd/"/>
                                </availability>
                            </publicationStmt>
                            
                            <seriesStmt>
                                <idno type="stamp" n="INRIA-MECSCI">Inria - Médiation Scientifique en Sciences du Numérique</idno>
                            </seriesStmt>
                            
                            <notesStmt>
                                <note type="popular" n="1"/>
                                <note type="peer" n="1"/>
                                <note type="audience" n="2"/>
                               <!-- à supprimmer-->
                                <note type="commentary">Test Interstices </note>
                            </notesStmt>
                            
                            <sourceDesc>
                                <biblStruct>
                                    <analytic>
                                        <title xml:lang="fr">  <xsl:value-of select="field[@name='title']"/>     </title>                                   
                                        <title xml:lang="fr" type="sub"> <xsl:value-of select="field[@name='soustitre']"/> </title>
                                        <xsl:apply-templates select="field[@name='auteurs']/item[@id]" mode="auteur" />
                                        
                                        
                                        
                                    </analytic>
                                    
                                    <monogr>
                                        <idno type="halJournalId">21050</idno>
                                        <imprint>
                                        <!--traitement date à prendre en compte 10 premiers caractères -->
                                        <date type="datePub">  <xsl:value-of select="substring( field[@name='pdate'], 1, 10)"/></date>
                                        </imprint>
                                    </monogr>
                                    
                                    <ref type="seeAlso"><xsl:value-of select="@url" />  </ref>
                                </biblStruct>
                                </sourceDesc>
                            
                            <profileDesc>
                                <langUsage>
                                    <language ident="fr"/>
                                </langUsage>
                                <textClass>
                                    <keywords scheme="author">
                                    <xsl:apply-templates select="field[@name='motsCles']/item" mode="motscles" />   
                                    </keywords>
                                    <xsl:apply-templates select="./field/item" mode="domaine" />
                                    <classCode scheme="halTypology" n="ART"></classCode>
                                </textClass>
                                
                                <abstract xml:lang="fr"> <xsl:value-of select="field[@name='resume'][@abstract='true']"/> </abstract>
                            </profileDesc>         
                            </biblFull>  
                       
        

    </xsl:template>  
    
    <xsl:template match="item" mode="auteur">
        
    <xsl:variable name="ItemIdAuteur" select="@id" />    
    
    
    <author role="aut">
        
        <xsl:variable name="ItemIdAuteur" select="$ListeAuteurs/Auteurs/Auteur[@id=$ItemIdAuteur]" />  
        
        <xsl:if test="$ItemIdAuteur/IdHalAlpha!=''">
        <idno type="idhal">
                       
            <xsl:value-of select="$ItemIdAuteur/IdHalAlpha" />   </idno>
    </xsl:if>
        
        <xsl:choose>
            <xsl:when test="$ItemIdAuteur/IdAuteurAurehal!=''">
                <idno type="halauthor">
                    
                    <xsl:value-of select="$ItemIdAuteur/IdAuteurAurehal" />   </idno>
                
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>ERREUR champs IdAuteurAurehal vide</xsl:text>
                  </xsl:otherwise>
        </xsl:choose>
        
        <xsl:choose>
            <xsl:when test="$ItemIdAuteur/IdAffiliationAurehal!=''">
                <affiliation>
                    <xsl:attribute name="ref">#struct-<xsl:value-of select="$ItemIdAuteur/IdAffiliationAurehal" />  </xsl:attribute> </affiliation>
                
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>ERREUR champs IdAffiliationAurehal vide</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        
  
    </author>
        
    </xsl:template>
    
    <!--ajout des domaines -->       
    <xsl:template match="item" mode="domaine">
        <xsl:variable name="domainCode">
            <xsl:value-of select="substring-after(.,'Classification UNIT/')"></xsl:value-of>
        </xsl:variable>
        <xsl:if test="$domainCode!=''">
            <xsl:call-template name="addDomain">
                <xsl:with-param name="domain">
                    <xsl:value-of select="$domainCode"></xsl:value-of>
                </xsl:with-param>
            </xsl:call-template>
            
        </xsl:if>
    </xsl:template>
    <xsl:template match="DomaineHal">
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:template name="addDomain">
        <xsl:param name="domain"/>
        <classCode scheme="halDomain">
            <xsl:attribute name="n">
                <xsl:variable name="codeDomain">
                    <xsl:value-of select="substring-before(substring-after($domain,'/'),' ')"/>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="$ListeDomains/descendant::DomaineUnit[@id=$codeDomain]/CodeDomainesHal/DomaineHal">
                        <xsl:apply-templates select="$ListeDomains/descendant::DomaineUnit[@id=$codeDomain]/CodeDomainesHal/DomaineHal"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>ERREUR code inconnu = </xsl:text>
                        <xsl:value-of select="$codeDomain"></xsl:value-of>
                    </xsl:otherwise>
                </xsl:choose>
                
            </xsl:attribute>
        </classCode>
        
    </xsl:template>
    
    <xsl:template match="item" mode="motscles">
        <term xml:lang="fr"><xsl:value-of select="normalize-space(.)"/></term>
        
       
    </xsl:template>
</xsl:stylesheet>