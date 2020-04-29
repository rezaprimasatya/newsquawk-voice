const path = require('path');
const mustache = require('mustache');
const webpack = require('webpack');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const WriteFilePlugin = require('write-file-webpack-plugin');
const target = path.resolve(__dirname, 'dist');

module.exports = {
  entry: './src/index.coffee',
  output: {
    filename: 'main.js',
    path: target
  },
  plugins: [
    new CopyWebpackPlugin([{
      from: 'assets', to: target
    }]),
    new WriteFilePlugin
  ],
  module: {
    rules: [
      {
        test: /\.coffee$/,
        use: [ 'coffee-loader' ]
      }
    ]
  },
  resolve: {
    extensions: ['.js', '.ts']
  }
}
