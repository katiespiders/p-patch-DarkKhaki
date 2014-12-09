// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(function() {

  $(".checkout_form").submit(function(event) {
    event.preventDefault();
    var $form = $(this);
    $.ajax({
      url: "/library/checkout",
      type: "POST",
      data: $form.serialize(),
      success: function() {
        var item = $form.parents(".item_row");
        updateInventory(item);
      }
    });
    return false; // WHAT IS THIS SORCERY
  });
});

function updateInventory(item) {
  item_quantity = item.children(".item_quantity");
  quantity = item_quantity.html();
  new_quantity = quantity - 1;
  if(new_quantity === 0) {
    item.hide();
  }
  else {
    item_quantity.html(new_quantity);
  }
}
