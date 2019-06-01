const mongoose = require('mongoose');
const { Schema } = mongoose;

const OrdenadorSchema = new Schema({
    name: { type: String, required: true},
    os: { type: String, required: true },
    user: { type: String, required: true },
    last_update: { type: String, required: true }
});

module.exports = mongoose.model('Ordenador', OrdenadorSchema)
