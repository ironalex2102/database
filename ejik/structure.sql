create table if not exists "speciality"
(
    "id"             uuid primary key default gen_random_uuid(),
    "specialityName" text not null
);

create table if not exists "employee"
(
    "id"           uuid primary key default gen_random_uuid(),
    "firstName"    text not null,
    "lastName"     text not null,
    "patronymic"   text not null,
    "position"     text  null,
    "email"        text  null
        constraint email_pattern
            check (email ~ '^[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+$')
        unique,
    "phone"        text null
        constraint phone_pattern
            check ( phone ~ '^\+[1-9]\d{1,14}$' ),
    "link"         text null
        constraint link_pattern
            check ( link ~
                    '^https?://(www\.)?[-a-zA-Z0-9@:%._+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()!@:%_+.~#?&\\/=]*)$' )
);

create table if not exists "speciality_employee"
(
    "specialityId" uuid references "speciality" on update cascade on delete set null,
    "employeeId"   uuid references "employee" on update cascade on delete set null,
    constraint speciality_employee_pkey primary key ("specialityId", "employeeId")
);

create table if not exists "certificate"
(
    "id"                     uuid primary key default gen_random_uuid(),
    "employeeId"             uuid not null references "employee",
    "certificateName"        text not null,
    "certificateDescription" text not null,
    "office"                 text not null
);

create table if not exists "employee_certificate"
(
    "employeeId"    uuid references "employee" on update cascade on delete set null,
    "certificateId" uuid references "certificate" on update cascade on delete set null

);

create table if not exists "software"
(
    "id"        uuid primary key default gen_random_uuid(),
    "link"      text null
        constraint link_pattern
            check ( link ~
                    '^https?://(www\.)?[-a-zA-Z0-9@:%._+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()!@:%_+.~#?&\\/=]*)$' ),
    "subjectId" uuid not null references "subject"


);

create table if not exists "attachmentType"
(
    "id"       uuid primary key default gen_random_uuid(),
    "typeName" text not null
);

create table if not exists "attachment"
(
    "id"     uuid primary key default gen_random_uuid(),
    "tupeId" uuid not null references "attachmentType",
    "link"   text null
        constraint link_pattern
            check ( link ~
                    '^https?://(www\.)?[-a-zA-Z0-9@:%._+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()!@:%_+.~#?&\\/=]*)$' )

);

create table if not exists "page"
(
    "id"           uuid primary key default gen_random_uuid(),
    "attachmentId" uuid not null references "attachment",
    "link"         text null
        constraint link_pattern
            check ( link ~
                    '^https?://(www\.)?[-a-zA-Z0-9@:%._+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()!@:%_+.~#?&\\/=]*)$' )

);