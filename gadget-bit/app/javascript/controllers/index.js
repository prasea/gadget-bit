// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import PriceFilterController from "./price_filter_controller"
application.register("price-filter", PriceFilterController)

import ProductSearchController from "./product_search_controller"
application.register("product-search", ProductSearchController)

import SignupValidationController from "./signup_validation_controller"
application.register("signup-validation", SignupValidationController)
