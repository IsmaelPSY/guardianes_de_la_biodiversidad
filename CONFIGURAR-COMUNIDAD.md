# Configurar la Comunidad

La página `comunidad.html` usa Supabase para cuentas, perfiles, fotos, publicaciones y comentarios. Las publicaciones nuevas quedan en revisión y solo aparecen en el foro después de ser aprobadas por una cuenta administradora.

## Conectar Supabase

1. Crea un proyecto en Supabase.
2. En SQL Editor, ejecuta el contenido completo de `supabase-community.sql`. El esquema también añade la moderación si ya ejecutaste una versión anterior: las publicaciones existentes quedan pendientes para que un administrador las revise.
3. En Project Settings > API, copia el Project URL y la publishable key (o la anon key heredada) en `supabase-config.js`.
4. En Authentication > URL Configuration, configura como Site URL el sitio público y agrega como Redirect URL la dirección pública de `comunidad.html`. Si usas GitHub Pages de proyecto, conserva la ruta del repositorio; no pongas solo el dominio `github.io`.
5. Confirma que el proveedor Email está habilitado en Authentication. El flujo de registro informa a los usuarios que deben confirmar el correo cuando Supabase lo solicite.

Nunca publiques una secret key o `service_role` en este repositorio. La publishable/anon key está diseñada para estar en el navegador y queda restringida por las políticas RLS del esquema.

## Nombrar administradores

1. Registra la cuenta del administrador desde `comunidad.html` y confirma el correo.
2. En Supabase SQL Editor ejecuta esto, sustituyendo el correo de ejemplo por el correo exacto de esa cuenta:

   ```sql
   insert into public.community_admins (user_id)
   select id from auth.users where lower(email) = lower('admin@ejemplo.com')
   on conflict (user_id) do nothing;
   ```

3. Cierra sesión y vuelve a iniciar sesión en la web. Aparecerá el panel **Revisión de publicaciones**.

Solo el equipo de confianza debe agregarse a `community_admins`. No pongas la identidad de los administradores en archivos JavaScript públicos.

## Flujo del foro

- Cualquier visitante puede leer publicaciones aprobadas.
- Las personas registradas pueden enviar recomendaciones, acciones, noticias, eventos y avistamientos. Todo nuevo envío queda en estado pendiente, aunque alguien manipule el formulario del navegador.
- Los administradores pueden aprobar o rechazar cada envío desde la cola privada. Al aprobarlo aparece en el foro público.
- Quien publicó puede ver sus envíos pendientes o rechazados y retirar los que siguen pendientes.
- Solo las cuentas registradas pueden comentar y reportar publicaciones aprobadas.
- Las fotos y los perfiles publicados son visibles para visitantes. Comparte solo material autorizado y evita datos personales.

Los reportes de publicaciones quedan en `community_reports` para revisión desde Supabase. Las imágenes de perfil admiten JPG, PNG o WebP hasta 4 MB; las imágenes de publicaciones hasta 5 MB.

## Publicar

Publica juntos `index.html`, `comunidad.html`, `supabase-config.js`, `supabase-community.sql` (como documentación/esquema) y las carpetas de imágenes del sitio. La activación requiere además ejecutar SQL y completar las URL/keys en el panel y el archivo de configuración.
