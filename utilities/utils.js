//Get the connection to Heroku Database
let db = require('./sqlconn.js');

//We use this create the SHA256 hash
const crypto = require("crypto");

function sendEmail(from, receiver, subj, message) {
    const nodemailer = require('nodemailer');
    let transporter = nodemailer.createTransport({
        service:'gmail',
        auth: {
            user: process.env.EMAIL,
            pass:process.env.PASS
        }
    });
    let mailOptions = {
        from:from,
        to:receiver,
        subject:subj,
        text:message
    };
    transporter.sendMail(mailOptions, function (err, data) {
        if(err) {
            console.log('Error Occurs',err);
        } else {
            console.log('Email sent!!!',err);
        }
    });
}

/**
 * Method to get a salted hash.
 * We put this in its own method to keep consistency
 * @param {string} pw the password to hash
 * @param {string} salt the salt to use when hashing
 */
function getHash(pw, salt) {
    return crypto.createHash("sha256").update(pw + salt).digest("hex");
}

module.exports = {
    db, getHash, sendEmail
};