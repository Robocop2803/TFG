const express = require('express');
const router = express.Router();

const Ordenador = require('../models/Ordenador');
const Live = require('../models/Live');
const Task = require('../models/Task');
const { isAuthenticated } = require('../helpers/auth');


 router.get('/ordenador/:id', isAuthenticated ,async (req, res) => {


    const ordenador = await Ordenador.findById(req.params.id)
    if(ordenador.user == req.user.email){
        const ordenadores = await Ordenador.find({user: req.user.email});
        res.render('ordenadores/ordenador', {ordenador, ordenadores});
    }else{
        res.redirect('/ordenadores');
    } 
 });

 router.get('/ordenador/:id/:data', isAuthenticated ,async (req, res) => {
     if(req.params.data == "process"||req.params.data == "services"|| req.params.data == "programs"){
        const ordenador = await Ordenador.findById(req.params.id)
        if(ordenador.user == req.user.email){
            const ordenadores = await Ordenador.find({user: req.user.email});
            //  const live = await Live.findOne({user: req.user.email, device: req.params.id}) .sort({date: 'desc'}) .limit(1);
            const live = await Live.findOne({user: req.user.email, device: req.params.id, type: req.params.data}) .sort({date: 'desc'}) .limit(1) ; 
            res.render('ordenadores/'+req.params.data, {ordenador, ordenadores, live});
        }else{
            res.redirect('/ordenadores');
        } 
     }else{
        res.redirect('/ordenador/'+req.params.id);
     }
 });

 router.post('/ordenador/:id/:type/:values', isAuthenticated , async (req, res) => {
    const ordenador = await Ordenador.findById(req.params.id);
    const ordenadores = await Ordenador.find({user: req.user.email});
    const newTask = new Task(req.params);
    await newTask.save();
    // const live = await Live.findOne({user: req.user.email, device: req.params.id}) .sort({date: 'desc'}) .limit(1) ;
    const live = await Live.findOne({user: req.user.email, device: req.params.id, type: req.params.type}) .sort({date: 'desc'}) .limit(1) ; 
// res.redirect(req.params.id);
    res.redirect('/ordenador/'+req.params.id+"/process");
    console.log("matar proceso "+req.params.values+" en "+req.params.id);
});

 module.exports = router;