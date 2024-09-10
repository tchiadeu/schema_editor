import { shortDistanceSelector, setPathPositionAttribute, getPositions } from "./link_position";
import { updateAllTables } from "./update_position";

function findAssociatedPaths(table) {
  const headerName = table.querySelector('th').dataset.table;
  const fromHeaderPaths = Array.from(document.getElementsByTagName('path')).filter((path) => 
    path.dataset.table == headerName
  );
  const withReferencesColumns = Array.from(table.querySelectorAll('td[data-reference]'));
  const columnNames = withReferencesColumns.map((column) => {
    return `${column.dataset.table}/${column.dataset.column}`;
  });
  const fromColumnsPaths = Array.from(document.getElementsByTagName('path')).filter((path) =>
    columnNames.includes(path.dataset.column)
  );
  return fromHeaderPaths.concat(fromColumnsPaths);
}

function movePaths(paths) {
  paths.forEach((path) => {
    const pathTable = path.dataset.table;
    const pathColumn = path.dataset.column;
    const table = Array.from(document.querySelectorAll('th[data-table]')).find((th) =>
      th.dataset.table === pathTable
    );
    const column = Array.from(document.querySelectorAll('td[data-reference]')).find((td) =>
      `${td.dataset.table}/${td.dataset.column}` === pathColumn
    );
    const columnPositions = getPositions(column); 
    const tablePositions = getPositions(table); 
    const shortDistance = shortDistanceSelector(
      columnPositions.left, columnPositions.right, tablePositions.left, tablePositions.right
    );
    const startX = shortDistance.startX;
    const startY = columnPositions.middleY;
    const endX = shortDistance.endX;
    const endY = tablePositions.middleY;
    setPathPositionAttribute(path, startX, startY, endX, endY);
  })
}

function moveTables(tables) {
  tables.forEach((table) => {
    let isDragging = false;
    let startX, startY, initialLeft, initialTop;
    const header = table.querySelector('th');
    header.addEventListener('mousedown', (event) => {
      isDragging = true;
      table.style.zIndex = '5';
      table.style.transform = null;
      startX = event.clientX;
      startY = event.clientY;
      const tableRect = table.getBoundingClientRect();
      initialLeft = tableRect.left;
      initialTop = tableRect.top;
      document.body.style.userSelect = 'none';
    });
    document.addEventListener('mousemove', (event) => {
      if (!isDragging) return;
      const deltaX = event.clientX - startX;
      const deltaY = event.clientY - startY;
      const newLeft = initialLeft + deltaX;
      const newTop = initialTop + deltaY;
      table.style.left = `${newLeft}px`;
      table.style.top = `${newTop}px`;
      movePaths(findAssociatedPaths(table));
    });
    document.addEventListener('mouseup', () => {
      if (isDragging) {
        isDragging = false;
        document.body.style.userSelect = '';
        table.style.zIndex = null;
        updateAllTables(tables);
      };
    });
  });
}

export function dragAndDropTables() {
  document.addEventListener('DOMContentLoaded', function() {
    const tables = Array.from(document.getElementsByTagName('table'));
    moveTables(tables);
  });
}
