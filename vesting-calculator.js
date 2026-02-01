/**
 * Helper to calculate vesting milestones for UI display
 */
function calculateVested(total, start, duration, now) {
    if (now < start) return 0;
    if (now >= start + duration) return total;
    
    const elapsed = now - start;
    return (total * elapsed) / duration;
}

const totalTokens = 1000000; // 1 million
const startTime = Math.floor(Date.now() / 1000);
const oneYear = 365 * 24 * 60 * 60;

console.log("Tokens vested after 6 months:", calculateVested(totalTokens, startTime, oneYear, startTime + (oneYear / 2)));
