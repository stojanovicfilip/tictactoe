const mongoose = require('mongoose');

const fieldSchema = new mongoose.Schema({
  available: {
    type: Boolean,
    default: false,
  },
  piece: {
    type: String,
    default: null,
  },
  player: {
    type: String,
    default: null,
  },
});

const piecesSchema = new mongoose.Schema({
  xs: {
    type: Number,
    default: 3,
  },
  s: {
    type: Number,
    default: 2,
  },
  m: {
    type: Number,
    default: 2,
  },
  l: {
    type: Number,
    default: 2,
  },
  xl: {
    type: Number,
    default: 1,
  },
});

const gameSchema = new mongoose.Schema({
  x: {
    type: String,
  },
  o: {
    type: String,
  },
  finished: {
    type: Boolean,
    default: false,
  },
  winner: {
    type: String,
  },
  table: [[fieldSchema]],
  player_turn: {
    type: String,
    required: true,
  },
  x_pieces: {
    type: piecesSchema,
  },
  y_pieces: {
    type: piecesSchema,
  },
});

module.exports = gameSchema;
