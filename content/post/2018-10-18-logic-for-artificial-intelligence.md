---
author: nmaynes1
categories:
- Concepts
date: "2018-10-18T21:08:52Z"
excerpt: A cheat sheet for some of the basic symbols and definitions used in AI logic.
guid: http://edgesandvertexes.com/?p=85
id: 85
image: /wp-content/uploads/2018/10/john-cameron-756646-unsplash-100x104.jpg
tags:
- cheat sheet
- logic
title: Logic for Artificial Intelligence
url: /2018/10/18/logic-for-artificial-intelligence/
---
<blockquote class="wp-block-quote">
  <p>
    &#8220;Logic has both seductive advantages and bothersome disadvantages.&#8221;
  </p>
  
  <cite>Patrick Winston, Artificial Intelligence, pp 283</cite>
</blockquote>

Logic in artificial intelligence can be used to help an agent create rules of inference. It provides a formal framework for creating if-then statements. Formal logic statements can be difficult for beginners because of the symbols and vocabulary used. Below is a cheat sheet for some of the basic symbols and definitions.

<table class="wp-block-table">
  <tr>
    <td>
      Symbol
    </td>
    
    <td>
      Definition
    </td>
  </tr>
  
  <tr>
    <td>
      ∧
    </td>
    
    <td>
      Logical conjunction. In most instances it will be used as an AND operator.
    </td>
  </tr>
  
  <tr>
    <td>
      ∨
    </td>
    
    <td>
      Logical disjunction.  In most instances it will be used as an ORoperator.
    </td>
  </tr>
  
  <tr>
    <td>
      ∀
    </td>
    
    <td>
      Universal quantifier. Placed in front of a statement that includes ALL entities in the agent&#8217;s universe. 
    </td>
  </tr>
  
  <tr>
    <td>
      ∃
    </td>
    
    <td>
      Existential quantifier. Placed in front of a statement where it applies to at least one entity in the agent&#8217;s universe.
    </td>
  </tr>
  
  <tr>
    <td>
      ¬
    </td>
    
    <td>
      Negation. The statement is only true if the condition is false.
    </td>
  </tr>
</table>

<table class="wp-block-table">
  <tr>
    <td>
      Word
    </td>
    
    <td>
      Definition
    </td>
  </tr>
  
  <tr>
    <td>
      Conjunction
    </td>
    
    <td>
      And. Means the truth of a set of operands is true if and only if all of its operands are true. Symbol used to represent this operator is typically ∧ or &.
    </td>
  </tr>
  
  <tr>
    <td>
      Conjuct
    </td>
    
    <td>
      An operand of a conjunction.
    </td>
  </tr>
  
  <tr>
    <td>
      Disjunction
    </td>
    
    <td>
      Or. Means the truth of a set of operands is true if and only if one or more of its operands is true.
    </td>
  </tr>
  
  <tr>
    <td>
      Disjunct
    </td>
    
    <td>
      An operand of a disjunct. 
    </td>
  </tr>
  
  <tr>
    <td>
      Predicates
    </td>
    
    <td>
      A boolean valued function or a relationship. A ∧ B = True or A and B have a specific relationship.
    </td>
  </tr>
  
  <tr>
    <td>
      <em>modus ponus</em>
    </td>
    
    <td>
      The rule of inference. Given A is true and B is true then (A and B) is true
    </td>
  </tr>
  
  <tr>
    <td>
      monotonic
    </td>
    
    <td>
      A property that states a &#8220;function is monotonic if, for every combination of inputs, switching one of the inputs from false to true can only cause the output to switch from false to true and not from true to false&#8221;
    </td>
  </tr>
</table>

Logic focuses on using knowledge in a provable and correct way. When it is used in AI it does not prove out that the claims are true. If an agent is taught that all birds can fly, it will be able to use logic to infer that a dog is not a bird. However, it will run into problems when classifying a penguin. 

It is important to keep in mind that logic is a weak representation of certain kinds of knowledge. The difference between water and ice is an example of knowledge that would be difficult to represent using logic. Determining how good a &#8220;deal&#8221; is would also be better suited to a different knowledge representation. If dealing with a change of state or ranking options, using a different knowledge system would be more appropriate.