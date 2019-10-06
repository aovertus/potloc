import consumer from "./consumer"

consumer.subscriptions.create("ShopChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to the room!");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    var product = data.content;
    var row = $('#product_'+product.id+'');
    console.log('Receiving product', product);
    console.log('Receiving row', row == undefined);
    if(row == undefined) {
      $('table tr:last').after('<tr class='+product.class+' id='+product.id+'><td>'+product.store+'</td><td>'+product.model+'</td><td>'+product.quantity+'</td></tr>');
    } else {
      row.find('.quantity').text(product.quantity)
      row.removeClass()
      row.addClass(product.class)
    }
  }
});
