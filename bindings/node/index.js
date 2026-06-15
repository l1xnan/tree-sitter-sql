const path = require("path");
const root = require("path").join(__dirname, "..", "..");

const wasmPath = path.join(root, "tree-sitter-sql.wasm");
module.exports = require("tree-sitter").Language.load(wasmPath);

try {
  module.exports.nodeTypeInfo = require("../../src/node-types.json");
} catch (_) {}
