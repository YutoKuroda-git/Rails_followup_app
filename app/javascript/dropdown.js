function toggleMore(btn) {
  const menu = btn.nextElementSibling;
  document.querySelectorAll('.more-menu.open').forEach(m => {
    if (m !== menu) m.classList.remove('open');
  });
  menu.classList.toggle('open');
}

function toggleUserMenu(btn) {
  const dropdown = btn.nextElementSibling;
  btn.classList.toggle('open');
  dropdown.classList.toggle('open');
}

document.addEventListener("click", (e) => {
  if (!e.target.closest(".user-menu")) {
    document.querySelectorAll('.user-dropdown.open').forEach(d => d.classList.remove('open'));
    document.querySelectorAll('.user-trigger.open').forEach(t => t.classList.remove('open'));
  }
  if (!e.target.closest(".more-wrap")) {
    document.querySelectorAll('.more-menu.open').forEach(m => m.classList.remove('open'));
  }
});

function initAvatarPreview() {
  const avatarInput = document.getElementById("avatar-upload");
  if (avatarInput) {
    avatarInput.addEventListener("change", (e) => {
      const file = e.target.files[0];
      if (!file) return;

      const reader = new FileReader();
      reader.onload = (ev) => {
        const avatar = document.querySelector(".acc-avatar");
        let img = avatar.querySelector(".acc-avatar-img");
        const icon = avatar.querySelector(".acc-avatar-icon");
        if (icon) icon.remove();
        if (!img) {
          img = document.createElement("img");
          img.className = "acc-avatar-img";
          avatar.insertBefore(img, avatar.firstChild);
        }
        img.src = ev.target.result;
      };
      reader.readAsDataURL(file);
    });
  }

  const removeInput = document.getElementById("remove-avatar");
  if (removeInput) {
    removeInput.closest(".acc-avatar-remove-btn").addEventListener("click", () => {
      const avatar = document.querySelector(".acc-avatar");
      const img = avatar.querySelector(".acc-avatar-img");
      if (img) img.remove();
      if (!avatar.querySelector(".acc-avatar-icon")) {
        const icon = document.createElement("span");
        icon.className = "material-symbols-outlined acc-avatar-icon";
        icon.textContent = "person";
        avatar.insertBefore(icon, avatar.firstChild);
      }
    });
  }
}

document.addEventListener("turbo:load", () => {
  document.querySelectorAll(".tbl-row[data-href]").forEach(row => {
    row.addEventListener("click", (e) => {
      if (!e.target.closest(".td-action")) {
        window.location.href = row.dataset.href;
      }
    });
  });

  initAvatarPreview();
});

document.addEventListener("DOMContentLoaded", initAvatarPreview);

window.toggleMore = toggleMore;
window.toggleUserMenu = toggleUserMenu;
