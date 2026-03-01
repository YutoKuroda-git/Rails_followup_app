function toggleMore(btn) {
  const menu = btn.nextElementSibling;
  document.querySelectorAll('.more-menu.open').forEach(m => {
    if (m !== menu) m.classList.remove('open');
  });
  menu.classList.toggle('open');
}

document.addEventListener("click", (e) => {
  if (!e.target.closest(".more-wrap")) {
    document.querySelectorAll('.more-menu.open').forEach(m => {
      m.classList.remove('open');
    });
  }
});

document.addEventListener("turbo:load", () => {
  document.querySelectorAll(".tbl-row[data-href]").forEach(row => {
    row.addEventListener("click", (e) => {
      if (!e.target.closest(".td-action")) {
        window.location.href = row.dataset.href;
      }
    });
  });
});

window.toggleMore = toggleMore;
