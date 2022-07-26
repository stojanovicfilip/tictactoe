const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  email: {
    type: String,
    trim: true,
    required: true,
  },
  username: {
    type: String,
    trim: true,
    required: true,
  },
  socketID: {
    type: String,
    required: true,
  },
  xp: {
    type: Number,
    default: 0,
  },
  friends: [String],
  rooms: [String],
});

const userModel = mongoose.model('User', userSchema);

module.exports = userModel;
