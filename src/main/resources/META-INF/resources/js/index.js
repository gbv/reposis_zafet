document.addEventListener('DOMContentLoaded', () => {
  document.getElementById('project-searchMainPage')?.addEventListener('submit', ignoreEmptyFieldsOnSubmit);

  fetch('../api/v1/search?q=objectType:mods AND state:published&rows=0&wt=json')
    .then(response => response.json())
    .then(data => {
      const input = document.getElementById('project-searchInput');
      if (!input) {
        return;
      }
      const count = data?.response?.numFound ?? 0;
      input.placeholder = `Suche in ${count.toLocaleString('de-DE')} Dokumenten`;
    })
    .catch(err => {
      console.error('Search API Fehler:', err);
    });
});
