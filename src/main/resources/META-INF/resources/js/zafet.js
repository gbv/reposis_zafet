function replaceMaskedEmails() {
  document.querySelectorAll("span.madress").forEach(span => {
    const address = span.textContent.replace(" [at] ", "@");
    const link = document.createElement("a");
    link.href = `mailto:${address}`;
    link.textContent = address;
    span.replaceWith(link);
  });
}

function ignoreEmptyFieldsOnSubmit(event) {
  const form = event.currentTarget;
  const inputs = form.querySelectorAll('input');
  inputs.forEach(input => {
    if (!input.value) {
      input.dataset.nameBackup = input.name;
      input.removeAttribute('name');
    }
  });
  // Restore field names after the form is submitted
  // setTimeout ensures this runs after the submit event completes
  setTimeout(() => {
    inputs.forEach(input => {
      if (input.dataset.nameBackup) {
        input.name = input.dataset.nameBackup;
        delete input.dataset.nameBackup;
      }
    });
  }, 0);
}

function randomizeBackground() {
  const images = [
    "210318_BIB_HdBA_005.jpg",
    "210318_BIB_HdBA_007.jpg",
    "210318_BIB_HdBA_010.jpg",
    "210318_BIB_HdBA_011.jpg",
    "210318_BIB_HdBA_012.jpg",
    "210318_BIB_HdBA_013.jpg",
    "210318_BIB_HdBA_015.jpg",
    "210318_BIB_HdBA_016.jpg",
    "210318_BIB_HdBA_017.jpg",
    "210318_BIB_HdBA_019.jpg",
    "210318_BIB_HdBA_021.jpg"
  ];
  const randomImage = images[Math.floor(Math.random() * images.length)];
  document.querySelectorAll("body > section").forEach(section => {
    section.style.backgroundImage = `url('${webApplicationBaseURL}/images/figures/${randomImage}')`;
  });
}

function removeGenreOptions(values) {
  const select = document.querySelector("select#genre");
  if (!select) {
    return;
  }
  Array.from(select.options).forEach(option => {
    if (values.includes(option.value)) {
      option.remove();
    }
  });
}

function setupGenreObserver(values) {
  const observer = new MutationObserver(() => {
    removeGenreOptions(values);
  });
  observer.observe(document.body, {childList: true, subtree: true});
  return observer;
}

function init() {
  const genresToRemove = ["series", "journal"];
  setupGenreObserver(genresToRemove);
  document.querySelector('form.searchfield_box')?.addEventListener('submit', ignoreEmptyFieldsOnSubmit);
  replaceMaskedEmails();
  randomizeBackground();
  removeGenreOptions(genresToRemove);
}

document.addEventListener("DOMContentLoaded", init);
