#enconding: utf-8
Feature: View data as a horizontal table

  As a software developer
  I want to present a list of similar data objects (same base class) as horizontal table
  In order to give users easier access to that information

  Example:
  * object_1 (attr_1, attr_2, attr_3)
  * object_2 (attr_1, attr_2, attr_3)

   ----------------------------------------------------
  | attr_1          | attr_2          |attr_3          |
  |----------------------------------------------------|
  | value_object_1  | value_object_1  | value_object_1 |
  | value_object_2  | value_object_2  | value_object_2 |
   ----------------------------------------------------

  Scenario: Simple table
    Given the following person exist:
      | Name           | Street              |
      | Max Mustermann | Musterstraße 1      |
      | Herbert Hurtig | Schnelle Straße 200 |
      | Peter Pause    | Gemütlicher Weg 2   |
    When I view them as a "horizontal_table"
    Then I see the following output:
    """
    ┏━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━┓
    ┃ Max Mustermann ┃ Musterstraße 1      ┃
    ┣━━━━━━━━━━━━━━━━╊━━━━━━━━━━━━━━━━━━━━━┫
    ┃ Herbert Hurtig ┃ Schnelle Straße 200 ┃
    ┣━━━━━━━━━━━━━━━━╊━━━━━━━━━━━━━━━━━━━━━┫
    ┃ Peter Pause    ┃ Gemütlicher Weg 2   ┃
    ┗━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━┛
    """

