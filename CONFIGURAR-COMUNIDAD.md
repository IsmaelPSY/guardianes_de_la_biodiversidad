CONFIGURAR LA COMUNIDAD

La página comunidad.html ya está preparada. Para que cuentas y publicaciones funcionen, necesita un proyecto de Supabase (plan gratuito disponible, sujeto a límites).

1. Crea un proyecto en Supabase.
2. Abre SQL Editor y ejecuta el contenido de supabase-community.sql.
3. En Project Settings > API, copia Project URL y publishable key (o anon key heredada) dentro de supabase-config.js.
   Nunca pongas en este archivo la secret key ni service_role.
4. En Authentication > URL Configuration, añade la dirección pública final del sitio como Site URL y redirect URL.
5. Publica juntos index.html, comunidad.html y supabase-config.js en el mismo alojamiento. La página principal incluye el enlace “Comunidad”.
6. Crea una cuenta, confirma el correo si se solicita y prueba perfil, publicación, foto, comentario y reporte.

Funcionamiento elegido
- Cualquier persona puede leer perfiles, publicaciones, comentarios e imágenes.
- Solo cuentas confirmadas pueden publicar, comentar y reportar.
- Las publicaciones aparecen de inmediato. Los reportes quedan en la tabla community_reports para revisión desde el panel de Supabase.
- Las imágenes son públicas. Comparte solo fotos propias o autorizadas y no incluyas datos privados.
- Foto de perfil: JPG, PNG o WebP, hasta 4 MB. Foto de publicación: hasta 5 MB.

El esquema aplica políticas Row Level Security para limitar las acciones de cada cuenta. La clave publishable se puede usar en el navegador cuando estas políticas están activas. La clave secreta jamás debe publicarse.
