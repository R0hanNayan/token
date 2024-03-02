import React, { useState } from "react";
import { token } from "../../../declarations/token";

function Faucet() {

  const [message, setMessage] = useState("Gimme gimme");
  const [isDisabled, setDisabled] = useState(false);

  async function handleClick(event) {
    setDisabled(true);
    setMessage(await token.payOut());
    // setDisabled(false);
  }

  return (
    <div className="blue window">
      <h2>
        <span role="img" aria-label="tap emoji">
          🚰
        </span>
        Faucet
      </h2>
      <label>Get your free NOV coins here! Claim 10,000 NOV coins to your account.</label>
      <p className="trade-buttons">
        <button id="btn-payout" onClick={handleClick} disabled={isDisabled}>
          {message}
        </button>
      </p>
    </div>
  );
}

export default Faucet;
