const mongoose = require('mongoose');
const { Schema } = mongoose;

const TaskSchema = new Schema({
    id: { type: String},
    type: { type: String},
    values: { type: String}
});

module.exports = mongoose.model('Task', TaskSchema)
