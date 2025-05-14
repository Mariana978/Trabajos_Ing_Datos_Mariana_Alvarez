const mongoose = require('mongoose');

const productoSchema = new mongoose.Schema({
  nombre: String,
  precio: Number,
  categoria: String,
  enStock: Boolean
});

module.exports = mongoose.model('Producto', productoSchema);
