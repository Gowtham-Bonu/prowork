// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//=require "animated.headline"
//=require "contact"
//=require "jquery.ajaxchimp.min"
//=require "jquery.form"
//=require "jquery.magnific-popup"
//=require "jquery.nice-select.min"
//=require "jquery.paroller.min"
//=require "jquery.scrollUp.min"
//=require "jquery.slicknav.min"
//=require "jquery.sticky"
//=require "jquery.validate.min"
//= require cocoon
//=require "mail-script"
//=require "slick.min"
//=require "main"
//=require "one-page-nav-min"
//=require "owl.carousel.min"
//=require "plugins"
//=require "popper.min"
//=require "price_rangs"
//=require "wow.min"

import "@hotwired/turbo-rails"
import "controllers"
import "popper"

document.querySelectorAll('form').forEach(function (el) {
  el.dataset.turbo = false
})