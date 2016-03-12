---
title: Contact
author: Adam
layout: page
date: 2009-12-25
---

<form action="//formspree.io/adam@adamisrael.com" method="POST">
  <fieldset class="contact-info-group">

    <label><span>Your Name</span>
      <input type="text" name="name">
    </label>

    <label><span>Your Email</span>
      <input type="email" name="_replyto">
    </label>

    <label><span>Your Message</span>
      <textarea cols="50" name="message"></textarea>
    </label>

    <input type="text" name="_gotcha" style="display:none" />    
    <input type="submit" value="Send">
    <input type="hidden" name="_next" value="{{ % formspree thanks % }}" />
    <input type="hidden" name="_subject" value="Email Subject" />
  </fieldset>
</form>
