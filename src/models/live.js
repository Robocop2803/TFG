const mongoose = require('mongoose');
const { Schema } = mongoose;

const LiveSchema = new Schema({
    user: { type: String, required: true},
    type: { type: String, required: true},
    date: { type: String, required: true},
    content: {type: Array }
});

module.exports = mongoose.model('Live', LiveSchema);