function getEnvironmentVariables() {
    return activity.payload.deployment.variables.reduce(
      (vars, { name, value }) => ({
        ...vars,
        [name]: value,
      }),
      {}
    );
  }
  
  const ENV_VARIABLES = getEnvironmentVariables();
  
  /**
   * Sends a color-coded formatted message to Slack.
   *
   * You must first configure a Platform.sh variable named "SLACK_URL".
   * That is the group and channel to which the message will be sent.
   *
   * To control what events it will run on, use the --events switch in
   * the Platform.sh CLI.
   *
   * @param {string} title
   *   The title of the message block to send.
   * @param {string} message
   *   The message body to send.
   */
  function sendSlackMessage(title, message) {
    const url = ENV_VARIABLES.SLACK_URL;
  
    if (!url) {
      throw new Error("You must define a SLACK_URL project variable.");
    }
  
    const messageTitle =
      title + (new Date().getDay() === 5) ? " (On a Friday! :calendar:)" : "";
  
    const color = activity.result === "success" ? "#66c000" : "#ff0000";
  
    const body = {
      attachments: [
        {
          title: messageTitle,
          text: message,
          color: color,
        },
      ],
    };
  
    const resp = fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(body),
    });
  
    if (!resp.ok) {
      console.log("Sending slack message failed: " + resp.body.text());
    }
  }
  
  sendSlackMessage(activity.text, activity.log);
  