function centerTable(table) {
  table.style.left = '50%';
  if (window.innerHeight < table.getBoundingClientRect().height) {
    table.style.top = '10px';
    table.style.transform = 'translateX(-50%)';
  } else {
    table.style.top = '50%';
    table.style.transform = 'translate(-50%, -50%)';
  }
};

function possiblePositions(table) {
  const rect = table.getBoundingClientRect();
  return [
    { right: `${window.innerWidth - rect.left + 10}px`, bottom: `${window.innerHeight - rect.top + 10}px` },
    { left: `${rect.right + 10}px`, bottom: `${window.innerHeight - rect.top + 10}px` }, 
    { left: `${rect.right + 10}px`, top: `${rect.bottom + 10}px` },
    { right: `${window.innerWidth - rect.left + 10}px`, top: `${rect.bottom + 10}px` }
  ];
};

function isOverlapping(table, tables) {
  const rect1 = table.getBoundingClientRect();
  for (let i = 0; i < tables.length; i++) {
    const rect2 = tables[i].getBoundingClientRect();
    if (!(rect1.right < rect2.left || 
          rect1.left > rect2.right || 
          rect1.bottom < rect2.top || 
          rect1.top > rect2.bottom)) {
      return true;
    };
  };
  return false;
}

function isPositionAvailable(table, tables, position) {
  for (const [key, value] of Object.entries(position)) {
    table.style[key] = value;
  };
  const rect = table.getBoundingClientRect();
  if (rect.top < 0 || rect.left < 0) {
    return false;
  };
  if (isOverlapping(table, tables)) {
    return false;
  };
  return true;
};

function placeTables(tables) {
  centerTable(tables[0]);
  let positions = possiblePositions(tables[0]);
  for (let i = 1; i < tables.length; i++) {
    for (let n = 0; n < positions.length; n++) {
      const otherTables = Array.from(tables).filter((table, index) => index !== i)
      if (isPositionAvailable(tables[i], otherTables, positions[0])) {
        break;
      } else {
        positions.shift();
      };
    };
    const position = positions.shift();
    for (const [key, value] of Object.entries(position)) {
      tables[i].style[key] = value;
    }
    positions = positions.concat(possiblePositions(tables[i]));
  }
}

export function setTablePositions() {
  document.addEventListener('DOMContentLoaded', function() {
    const tables = document.getElementsByTagName('table');
    placeTables(tables);
  });
}
