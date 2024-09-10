function createData(data, table) {
  const tableName = table.querySelector('th').innerText;
  const tableRect = table.getBoundingClientRect();
  data.positions[tableName] = { top: tableRect.top, left: tableRect.left };
}

function fetchData(data) {
  const url = '/schema_editor/positions';
  const csrf = document.querySelector('meta[name="csrf-token"]').content;
  fetch(url, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrf
    },
    body: JSON.stringify(data)
  });
}

export function updateAllTables(tables) {
  let data = { custom_positions: true, positions: {} };
  tables.forEach((table) => {
    createData(data, table);
  });
  fetchData(data);
}
