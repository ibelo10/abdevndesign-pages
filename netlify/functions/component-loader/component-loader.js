const axios = require('axios');

exports.handler = async (event, context) => {
  try {
    const { component } = event.queryStringParameters;
    // Component loading logic here
    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ message: 'Component loaded successfully' })
    };
  } catch (error) {
    return { 
      statusCode: 500, 
      body: JSON.stringify({ error: 'Failed to load component' }) 
    };
  }
};
