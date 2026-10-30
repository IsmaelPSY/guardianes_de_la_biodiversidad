# Configurar GoatCounter

GoatCounter agrega métricas de visitas al sitio. El contador de **«Apoyo esta iniciativa»** se guarda de forma permanente en Supabase y limita cada cuenta autenticada a un apoyo.

## Activación

1. Crea un sitio en [GoatCounter](https://www.goatcounter.com/).
2. En la dirección de seguimiento, identifica el código. Por ejemplo, en `https://guardianes-mdd.goatcounter.com/count`, el código es `guardianes-mdd`.
3. Abre `goatcounter-config.js` y reemplaza el valor vacío por ese código:

   ```js
   window.GOATCOUNTER_CODE = "guardianes-mdd";
   ```

4. Publica `goatcounter-config.js`, `goatcounter.js`, `index.html` y `comunidad.html` junto con el resto del sitio.
5. Visita la web y comprueba las visitas en el panel de GoatCounter.

El código público del sitio no es una API key. No coloques una API key privada en los archivos públicos.

## Contador de apoyo en Supabase

Ejecuta el archivo `supabase-support.sql` completo en Supabase > SQL Editor. La web mostrará el total acumulado y permitirá apoyar sin iniciar sesión. El navegador conserva un identificador aleatorio en almacenamiento local y la clave primaria de la tabla impide que ese mismo identificador sume más de un apoyo, incluso si vuelve a pulsar.

El límite es por navegador, no por persona: borrar los datos del sitio, cambiar de navegador o usar otro dispositivo permite generar otro identificador. La IP no se utiliza porque puede ser compartida o cambiar y es un dato personal. Evita poner la clave `service_role` en la web; el sitio utiliza solamente la clave publishable.
