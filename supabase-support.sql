-- Contador permanente de apoyos: cada navegador puede apoyar una vez usando un ID aleatorio local.
-- Ejecuta este archivo completo en Supabase > SQL Editor.

create table if not exists public.initiative_supports (
  visitor_id uuid,
  created_at timestamptz not null default now()
);

-- Migra la versión anterior del esquema si ya se creó con user_id.
alter table public.initiative_supports add column if not exists visitor_id uuid;
update public.initiative_supports set visitor_id = gen_random_uuid() where visitor_id is null;
alter table public.initiative_supports alter column visitor_id set not null;
do $$
declare
  v_pk_name text;
begin
  select c.conname into v_pk_name
  from pg_constraint c
  where c.conrelid = 'public.initiative_supports'::regclass and c.contype = 'p';
  if v_pk_name is not null then
    execute format('alter table public.initiative_supports drop constraint %I', v_pk_name);
  end if;
  alter table public.initiative_supports add primary key (visitor_id);
end $$;
alter table public.initiative_supports drop column if exists user_id;

alter table public.initiative_supports enable row level security;
revoke all on public.initiative_supports from anon, authenticated;

drop function if exists public.get_initiative_support_count();
drop function if exists public.get_initiative_support_status();
drop function if exists public.support_initiative();

create or replace function public.get_initiative_support_status(p_visitor_id uuid)
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
declare
  v_supported boolean := false;
  v_total bigint;
begin
  select exists (select 1 from public.initiative_supports where visitor_id = p_visitor_id)
  into v_supported;
  select count(*) into v_total from public.initiative_supports;
  return jsonb_build_object('total', v_total, 'supported', v_supported);
end;
$$;

create or replace function public.support_initiative(p_visitor_id uuid)
returns jsonb
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_inserted boolean := false;
  v_total bigint;
begin
  if p_visitor_id is null then
    raise exception 'No se recibió el identificador anónimo del navegador.' using errcode = '22004';
  end if;

  insert into public.initiative_supports (visitor_id)
  values (p_visitor_id)
  on conflict (visitor_id) do nothing;
  v_inserted := found;

  select count(*) into v_total from public.initiative_supports;
  return jsonb_build_object('inserted', v_inserted, 'total', v_total);
end;
$$;

revoke all on function public.get_initiative_support_status(uuid) from public;
revoke all on function public.support_initiative(uuid) from public;
grant execute on function public.get_initiative_support_status(uuid) to anon, authenticated;
grant execute on function public.support_initiative(uuid) to anon, authenticated;
