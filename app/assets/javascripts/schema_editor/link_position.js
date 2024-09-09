function svgCreator(namespace) {
  const svg = document.createElementNS(namespace, 'svg');
  svg.style.width = '5000px';
  svg.style.height = '5000px';
  svg.style.pointerEvents = 'none';
  document.body.insertAdjacentElement("afterbegin", svg);
}

export function setPathPositionAttribute(path, startX, startY, endX, endY) {
  const pathData = `M${startX},${startY} Q${(startX + endX) / 2},${Math.min(startY, endY)} ${endX},${endY}`;
  path.setAttribute('d', pathData);
}

function pathCreator(namespace, startX, startY, endX, endY, dataTable, dataColumn) {
  const path = document.createElementNS(namespace, 'path');
  setPathPositionAttribute(path, startX, startY, endX, endY);
  path.setAttribute('stroke', '#010');
  path.setAttribute('stroke-width', '2');
  path.setAttribute('fill', 'none');
  path.dataset.table = dataTable;
  path.dataset.column = dataColumn;
  return path;
}

export function getPositions(element) {
  const elementRect = element.getBoundingClientRect();
  const elementMiddleY = (elementRect.top + elementRect.bottom) / 2;
  return {
    right: elementRect.right, left: elementRect.left, middleY: elementMiddleY
  };
}

function hashConstructor(firstPosition, secondPosition) {
  return {
    result: Math.abs(firstPosition - secondPosition), startX: firstPosition, endX: secondPosition
  };
}

export function shortDistanceSelector(firstLeft, firstRight, secondLeft, secondRight) {
  const distances = [
    hashConstructor(firstLeft, secondLeft),
    hashConstructor(firstLeft, secondRight),
    hashConstructor(firstRight, secondRight),
    hashConstructor(firstRight, secondLeft)
  ];
  return distances.reduce((min, current) => {
    return current.result < min.result ? current : min;
  });
}

export function setLinks() {
  document.addEventListener('DOMContentLoaded', function() {
    const idColumns = Array.from(document.querySelectorAll('td[data-reference]'));
    const tableTitles = Array.from(document.querySelectorAll('th[data-table]'));
    const svgNamespace = 'http://www.w3.org/2000/svg';
    svgCreator(svgNamespace)
    const svg = document.querySelector('svg')

    idColumns.forEach((column) => {
      const reference = column.dataset.reference;
      const associatedTable = tableTitles.find((title) => reference === title.dataset.table);

      const columnPositions = getPositions(column);
      const tablePositions = getPositions(associatedTable);
      const shortDistance = shortDistanceSelector(
        columnPositions.left, columnPositions.right, tablePositions.left, tablePositions.right
      );

      const startX = shortDistance.startX;
      const startY = columnPositions.middleY;
      const endX = shortDistance.endX;
      const endY = tablePositions.middleY;
      const dataTable = column.dataset.reference;
      const dataColumn = `${column.dataset.table}/${column.dataset.column}`;

      svg.appendChild(pathCreator(svgNamespace, startX, startY, endX, endY, dataTable, dataColumn));
    });
  });
}
