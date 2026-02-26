function toggleMore(btn) {
  const menu = btn.nextElementSibling;
  document.querySelectorAll('.more-menu.open').forEach(m => {
    if (m !== menu) m.classList.remove('open');
  });
  menu.classList.toggle('open');
}

document.addEventListener('click', function(e) {
  if (!e.target.closest('.more-wrap')) {
    document.querySelectorAll('.more-menu.open').forEach(m => m.classList.remove('open'));
  }
});

window.toggleMore = toggleMore;
