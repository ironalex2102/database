alter table "attachment"
    add column "checksum" text;
alter table "group"
    add column "universityId" text not null references "university";
alter table "software"
    add column "description" text;
alter table "attachment"
    add column "author" text null;
create table if not exists "university"
(
    "id"   uuid primary key default gen_random_uuid(),
    "name" text null


);