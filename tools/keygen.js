const crypto = require('crypto');
const buf = crypto.randomBytes(256);

console.log(
  `${buf.length} bytes of random data: ${buf.toString('hex')}`);
