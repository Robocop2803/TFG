const mongoose = require('mongoose');
// mongoose.connect('mongodb://localhost/logxdb', {
//     useCreateIndex: true,
//     useNewUrlParser: true,
//     useFindAndModify: false
// })
mongoose.connect('mongodb+srv://logxdb:Retamar1a@logx-wypso.mongodb.net/test?retryWrites=true&w=majority', {useNewUrlParser: true})
 .then(db => console.log('DB connected'))
 .catch(err => console.log(err));