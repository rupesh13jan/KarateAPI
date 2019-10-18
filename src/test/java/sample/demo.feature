Feature: karate hello world example

  Scenario: payment ID fetch
    Given url 'http://onlinebookstorecognizant.us-east-2.elasticbeanstalk.com/addToCart'
    * def json1 =
      """
      {
       "user_id": 1,
       "book_id": 1          
      }
      """
    And request json1
    When method POST
    Then status 202
    And match response.OrderID[*].paymentStatus contains ["NotStarted"]
    * def partNumbers = karate.jsonPath(response,"$..paymentStatus")
    * def payID = karate.jsonPath(response,"$..paymentID")
    * print 'Payment Id:', payID[0]
    * print 'The Request1 is ',json1
    * print 'Response1 is: ',response
    * print 'Response is: ',partNumbers
    Given url 'http://onlinebookstorecognizant.us-east-2.elasticbeanstalk.com/buynow'
    And request { "user_id": 1, "book_id": 1, "paymentid":'#(payID[0])'}
    When method POST
    Then status 202
    * print 'The second response is: ' ,response
