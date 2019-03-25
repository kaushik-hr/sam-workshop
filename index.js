exports.handler = async (event, context) => {
  console.log('Event', event);
  console.log('Context', context);

  return {
    statusCode: 200,
    body: JSON.stringify({
      event: event,
      context: context,
    }),
  };
};
