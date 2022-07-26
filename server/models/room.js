const mongoose = require('mongoose');
const gameSchema = require('./game');

const roomSchema = new mongoose.Schema({
  is_available: {
    type: Boolean,
    default: true,
  },
  available_until: {
    type: Date,
    default: () => Date.now() + 3 * 60 * 60 * 1000,
  },
  last_modified: {
    type: Date,
    default: Date.now,
  },
  games: [gameSchema],
  players: [String],
});

const roomModel = mongoose.model('Room', roomSchema);

module.exports = roomModel;
