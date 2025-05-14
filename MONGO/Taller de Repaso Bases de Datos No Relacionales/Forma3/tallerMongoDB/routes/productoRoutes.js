const express = require('express');
const router = express.Router();
const Producto = require('../models/producto');

// Ruta para insertar productos
router.get('/insertar', async (req, res) => {
  const productos = [
    { nombre: "Computador", precio: 1500, categoria: "Electrónica" },
    { nombre: "Cama", precio: 1000, categoria: "Hogar" },
    { nombre: "Vestido de flores", precio: 500, categoria: "Ropa" },
    { nombre: "Bufanda", precio: 300, categoria: "Ropa" },
    { nombre: "Mesita de noche", precio: 1200, categoria: "Hogar" }
  ];

  try {
    await Producto.insertMany(productos);
    res.send("Productos insertados correctamente.");
  } catch (error) {
    res.status(500).send("Error al insertar productos: " + error.message);
  }
});

// Ruta para obtener todos los productos
router.get('/consultarProd', async (req, res) => {
  try {
    const productos = await Producto.find(); // Consulta todos los usuarios
    res.json(productos); // Envía la lista como JSON
  } catch (error) {
    res.status(500).send("Error al obtener usuarios: " + error.message);
  }
});

// Ruta para obtener todos los productos con precio mayor a $100
router.get('/mayores100', async (req, res) => {
  try {
    const productos = await Producto.find({ precio: { $gt: 100 } });
    res.json(productos);
  } catch (error) {
    res.status(500).send("Error al obtener productos: " + error.message);
  }
});

// Ruta para ordenar productos por precio descendente (usando JavaScript)
router.get('/ordenarDesc', async (req, res) => {
  try {
    const productos = await Producto.find(); // Obtiene todos los productos
    const productosOrdenados = productos.sort((a, b) => b.precio - a.precio); 
    res.json(productosOrdenados);
  } catch (error) {
    res.status(500).send("Error al ordenar productos: " + error.message);
  }
});

// Ruta para añadir el campo enStock: true a todos los productos
router.get('/enStock', async (req, res) => {
  try {
    const resultado = await Producto.updateMany({}, 
      { $set: { enStock: true } }
    );

    res.send(`Productos actualizados: ${resultado.modifiedCount}`);
  } catch (error) {
    res.status(500).send("Error al actualizar productos: " + error.message);
  }
});

// Ruta para poner enStock: false a productos con precio > 500
router.get('/actStock', async (req, res) => {
  try {
    const resultado = await Producto.updateMany(
      { precio: { $gt: 500 } },       
      { $set: { enStock: false } }      
    );

    res.send(`Productos actualizados: ${resultado.modifiedCount}`);
  } catch (error) {
    res.status(500).send("Error al actualizar productos: " + error.message);
  }
});

// Ruta para eliminar productos con precio menor a $50
router.get('/eliminar50', async (req, res) => {
  try {
    const resultado = await Producto.deleteMany({ precio: { $lt: 50 } });
    res.send(`Productos eliminados: ${resultado.deletedCount}`);
  } catch (error) {
    res.status(500).send("Error al eliminar productos: " + error.message);
  }
});

module.exports = router;
