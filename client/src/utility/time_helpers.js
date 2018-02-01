const pad = function(str, size = 2) {
  let s = String(str);
  while (s.length < (size || 2)) {s = "0" + s;}
  return s;
}

const msToTime = (ms) => {
  if (!ms) return '-';
  const mm = Math.floor(ms % 1000);
  const s = Math.floor(ms / 1000 % 60);
  const m = Math.floor(ms / 1000 / 60 % 60);
  const h = Math.floor(ms / 1000 / 60 / 60 % 60);
  return `${pad(h)}:${pad(m)}:${pad(s)}:${pad(mm, 3)}`;
};

export { msToTime };
