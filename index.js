async function handler(event, context) {
  console.log('environment:', JSON.stringify(process.env, null, 2));
  console.log('event:', JSON.stringify(event, null, 2));

  return {
    hey: 'Jude!',
  };
}

module.exports = {
  handler,
};
