'use strict';
const stripe = require('stripe')('sk_test_wxFE2IlwkcY8L4WSGITVGAc4');

/**
 * A set of functions called "actions" for `Card`
 */

module.exports = {
  
  index: async ctx => {
    const customerId = ctx.request.querystring;
    const paymentMethodsData = await stripe.paymentMethods.list({'customer': customerId, 'type':'card'});
    const cardData = paymentMethodsData.data;
    ctx.send(cardData);
    // ctx.send('He;;o world');
  },

  add: async ctx => {
    const {customer, source} = ctx.request.body;
    const cardData = await stripe.paymentMethods.attach(source, {customer});
    ctx.send(cardData);
  }
};
