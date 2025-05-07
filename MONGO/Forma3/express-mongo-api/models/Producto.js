const mongoose = require('mongoose');
const itemSchema = new mongoose.Schema({
  nombre: {
    type: String,
    required: true
  },
    descripcion: String,
    creadoEn: {
        type: Date,
        default: Date.now
    },
  precio: {
    type: Number,
    required: true
    }
});

module.exports = mongoose.model('Producto', itemSchema);