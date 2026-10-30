(() => {
  const code = (window.GOATCOUNTER_CODE || "").trim();
  if (!code) return;

  const origin = `https://${code}.goatcounter.com`;
  const script = document.createElement("script");
  script.async = true;
  script.src = "https://gc.zgo.at/count.js";
  script.dataset.goatcounter = `${origin}/count`;
  script.addEventListener("load", () => {
    window.guardianesAnalytics = {
      async getEventCount(path) {
        const response = await fetch(`${origin}/counter/${encodeURIComponent(path)}.json`, { cache: "no-store" });
        if (response.status === 404) return 0;
        if (!response.ok) throw new Error("GoatCounter no devolvió el contador.");
        const result = await response.json();
        const count = Number(String(result.count).replace(/\D/g, ""));
        if (!Number.isFinite(count)) throw new Error("El contador no tiene un valor válido.");
        return count;
      }
    };
    document.dispatchEvent(new Event("goatcounter:ready"));
  });
  document.head.append(script);
})();
