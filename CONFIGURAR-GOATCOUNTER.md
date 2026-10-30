# Configurar GoatCounter

GoatCounter agrega métricas de visitas al sitio y registra cada pulsación de **«Apoyo esta iniciativa»** como un evento. El evento también alimenta el contador público de clics; no se requiere una base de datos propia.

## Activación

1. Crea un sitio en [GoatCounter](https://www.goatcounter.com/).
2. En la dirección de seguimiento, identifica el código. Por ejemplo, en `https://guardianes-mdd.goatcounter.com/count`, el código es `guardianes-mdd`.
3. Abre `goatcounter-config.js` y reemplaza el valor vacío por ese código:

   ```js
   window.GOATCOUNTER_CODE = "guardianes-mdd";
   ```

4. Publica `goatcounter-config.js`, `goatcounter.js`, `index.html` y `comunidad.html` junto con el resto del sitio.
5. Visita la web y comprueba las visitas y el evento `apoyo-iniciativa` en el panel de GoatCounter.
6. En los ajustes del sitio de GoatCounter, activa **Allow adding visitor counts on your website** para que la página pueda leer y mostrar el total del evento.

El código público del sitio no es una API key. No coloques una API key privada en los archivos públicos.

## Sobre el contador de apoyo

El número muestra clics registrados, no personas verificadas. Una persona puede pulsar más de una vez y el botón no valida la identidad. La página suma el clic al instante en el navegador de quien lo pulsa; GoatCounter guarda el evento para que se acumule el total global. El contador público de GoatCounter puede tardar hasta cuatro horas en reflejar nuevos eventos. Si se necesita que todos vean un total compartido inmediatamente, hará falta guardar el número en un servicio con escritura/lectura en tiempo real, como Supabase.
