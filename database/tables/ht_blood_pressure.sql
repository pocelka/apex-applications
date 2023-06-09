-- drop objects
declare
   l_cnt    pls_integer;
begin
   select count(*) into l_cnt from user_tables where table_name = upper('ht_blood_pressure');

   if (l_cnt > 0) then
      execute immediate 'drop table ht_blood_pressure cascade constraints purge';
   end if;
end;
/

-- create tables
create table ht_blood_pressure (
   id                   number generated by default on null as identity
                           constraint ht_blood_pressure__pk primary key,
   created              timestamp with time zone default current_timestamp not null,
   created_by           varchar2(255 char) default coalesce(sys_context('APEX$SESSION', 'APP_USER'), user) not null,
   systolic             number not null,
   diastolic            number not null,
   pulse                number not null,
   arrhythmia           varchar2(1 char) default 'N' not null,
   ignore_flg            varchar2(1 char) default 'N' not null,
   notes                varchar2(4000 char)
)
;

comment on table ht_blood_pressure is 'Contains data related to the blood pressure.';
comment on column ht_blood_pressure.id is 'Surrogate key.';
comment on column ht_blood_pressure.created is 'Date when record was inserted.';
comment on column ht_blood_pressure.created_by is 'Who created the record.';
comment on column ht_blood_pressure.systolic is 'Upper blood pressure.';
comment on column ht_blood_pressure.diastolic is 'Lower blood pressure.';
comment on column ht_blood_pressure.pulse is 'Pulse value during measurement.';
comment on column ht_blood_pressure.arrhythmia is 'Indicates whether arythmia was detected during measurement.';
comment on column ht_blood_pressure.ignore_flg is 'Indicates, if the row should be ignored.';
comment on column ht_blood_pressure.notes is 'Various notes if needed.';
