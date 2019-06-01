const express = require('express');
const router = express.Router();

const Ordenador = require('../models/Ordenador');
const { isAuthenticated } = require('../helpers/auth');

  router.get('/ordenadores', isAuthenticated, async (req, res) => {
    const ordenadores = await Ordenador.find({user: req.user.email});
    res.render('data/ordenadores', { ordenadores });
  });
  router.get('/ordenadores/add', isAuthenticated, (req, res) => {
    res.render('data/new-ordenador');
});
//  router.post('/ordenadores/new-ordenador', isAuthenticated, async (req, res) => {
//    const {name,os}=req.body;    
//   
//        const newOrdenador = new Ordenador({name,os});
//        newOrdenador.user = req.user.id;
//        await newOrdenador.save();
//        req.flash('success_msg', 'Ordenador agregada correctamente');
//        res.redirect('/ordenadores');
//    });

    router.delete('/ordenadores/delete/:id', isAuthenticated, async (req, res) => {
        await Ordenador.findByIdAndDelete(req.params.id);
        req.flash('success_msg', 'Ordenador borrado  correctamente')
        res.redirect('/ordenadores');
    });
module.exports = router;