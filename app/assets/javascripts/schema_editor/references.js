function svgCreator(namespace, path) {
  const svg = document.createElementNS(namespace, 'svg');
  svg.style.zIndex = '-1';
  svg.style.position = 'absolute';
  svg.style.top = '0';
  svg.style.left = '0';
  svg.style.width = '100%';
  svg.style.height = '100%';
  svg.style.pointerEvents = 'none';
  svg.appendChild(path);
  document.body.appendChild(svg);
}

function pathCreator(namespace, startX, startY, endX, endY) {
  const path = document.createElementNS(namespace, 'path');
  const pathData = `M${startX},${startY} Q${(startX + endX) / 2},${Math.min(startY, endY) - 50} ${endX},${endY}`;
  path.setAttribute('d', pathData);
  path.setAttribute('stroke', 'black');
  path.setAttribute('fill', 'none');
  return path;
}

function getPositions(element) {
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

function shortDistanceSelector(firstLeft, firstRight, secondLeft, secondRight) {
  const distances = [
    hashConstructor(firstLeft, secondLeft),
    hashConstructor(firstLeft, secondRight),
    hashConstructor(firstRight, secondRight),
    hashConstructor(firstRight, secondLeft)
  ];
  const shortestDistance = distances.reduce((min, current) => {
    return current.result < min.result ? current : min;
  });
  return shortestDistance; 
}

document.addEventListener('DOMContentLoaded', function() {
  const idColumns = Array.from(document.querySelectorAll('td[data-reference]'));
  const tableTitles = Array.from(document.querySelectorAll('td[data-table]'));
  const svgNamespace = 'http://www.w3.org/2000/svg';

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

    svgCreator(svgNamespace, pathCreator(svgNamespace, startX, startY, endX, endY));
  });
});

