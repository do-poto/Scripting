<#
  .SYNOPSIS
  Requests news from the premade news dashboards.

  .DESCRIPTION
  Search-News searches for a news feed of top 10 articles matching a given
  query to the "NewsAPI.ai". It gives the URL of the article, as well as
  the title of it.

  .PARAMETER articleFeedURI
  Parameter that specifies which news feed is to be asked for given articles.
  Due to my API free version limitations currently available feeds are
  Cyber security
  URI: cb5a7d53-f31f-4dff-b77a-84c2d2f9979c
  Renewable energy
  URI: 240f6a12-b9d8-40a6-b1c6-a220e31d08de

  .INPUTS
  None. You can't pipe objects to Search-News.ps1.

  .OUTPUTS
  Outputs the URL of top 10 articles matching the feed requirements and 
  the titles of given articles.

  .EXAMPLE
  PS> .\Search-News.ps1 
  Give URI of the topic you want to search for: cb5a7d53-f31f-4dff-b77a-84c2d2f9979c
#>

#function that calls NewsAPI.ai
function Request-News{
    #params declaration
    param([Parameter(mandatory=$true)][String]$articleFeedURI)
    #URI to the API
    $URI = "https://eventregistry.org/api/v1/article/getArticlesForTopicPage"
    
    #creation of request header
    $headers=@{} 
    #filling out request header info
    $headers.add("Content-Type", "application/json")
    
    #creation of request body
    $body=@{}    
    #filling out request body
    $body.add("uri", $articleFeedURI)    
    $body.add("infoArticleBodyLen", -1)    
    $body.add("resultType", "articles")    
    $body.add("articlesSortBy", "fq")    
    $body.add("apiKey", "[KEY]")
    $body.add("articlesCount", "10")  

    #API call
    $response = Invoke-WebRequest -Uri $URI -Method GET -Headers $headers -Body $body 
    #formatting output of API response
    $response -split{$_ -eq ","} | Select-String -Pattern "url" -Context 0,1
}

#Ask for URI number request
$arg1 = Read-Host "Give URI of the topic you want to search for"
#Generated news for feed URI
Request-News -articleFeedURI $arg1 
