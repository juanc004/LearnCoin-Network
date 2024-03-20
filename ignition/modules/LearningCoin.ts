import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const LearningCoinModule = buildModule("LearningCoinModule", (m) => {
  const learningCoin = m.contract("LearningCoin");
  return { learningCoin };
});

export default LearningCoinModule;
