const express = require('express');
const router = express.Router();

const User = require('../models/user')

const passport = require('passport');
const { isAuthenticated } = require('../helpers/auth');

router.get('/users/signin', (req, res) => {
    res.render('users/signin');
});
router.get('/users/signup', (req, res) => {
    res.render('users/signup');
});

router.post('/users/signin', passport.authenticate('local', {
    successRedirect: '/ordenadores',
    failureRedirect: '/users/signin',
    failureFlash: true
}   ));
router.get('/login-check', isAuthenticated, (req, res) => {
    res.send('ok');
});

router.post('/users/signup', async (req, res) => {
    const { name, email, password, confirm_password} = req.body;
    const errors = [];
    if(name.length <= 0) {
        errors.push({text: 'Please Insert your Name'});
    }
    if(password != confirm_password) {
        errors.push({text: 'Password do not match'});
    }
    if(password.length < 4) {
        errors.push({text: 'Password must be at least 4 characters'});
    }
    if(errors.length > 0) {
        res.render('users/signup', {errors, name, email, password, confirm_password});
    } else {
        const emailUser = await User.findOne({email: email});

       if(emailUser != null) {
           req.flash('error_msg','email repetido');
           res.redirect('/users/signup');
       }else{
        const newUser = new User({name, email, password});
       newUser.password = await newUser.encryptPassword(password);
       await newUser.save();
       req.flash('success_msg', 'Estas registrado');
       res.redirect('/users/signin')
    }
    }
});

router.get('/users/logout',  (req, res) => {
    req.logOut();
    res.redirect('/');
})

module.exports = router;