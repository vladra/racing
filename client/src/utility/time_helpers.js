const pad = (str, size = 2) => {
  let s = String(str);
  while (s.length < (size || 2)) { s = `0${s}`; }
  return s;
};

const msToTime = (ms, hideHours = false) => {
  if (!ms) return '-';
  const mm = Math.floor(ms % 1000);
  const s = Math.floor(ms / 1000 % 60);
  const m = Math.floor(ms / 1000 / 60 % 60);
  const h = Math.floor(ms / 1000 / 60 / 60 % 60);
  if (hideHours && h === 0) {
    return `${pad(m)}:${pad(s)}.${pad(mm, 3)}`;
  }
  return `${pad(h)}:${pad(m)}:${pad(s)}.${pad(mm, 3)}`;
};

const sortDriversByTime = (left, right) => {
  const lLaps = left.laps.length;
  const rLaps = right.laps.length;
  if (lLaps === rLaps) {
    return left.total_ms - right.total_ms;
  }
  return rLaps - lLaps;
};

export { msToTime, sortDriversByTime };
