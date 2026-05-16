/*==============================================================*/
/* DBMS name:      Sybase SQL Anywhere 12                       */
/* Created on:     5/16/2026 12:22:47 AM                        */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_MEMBERSH_IS_A_MEMBERSH') then
    alter table "MEMBERSHIP"
       delete foreign key FK_MEMBERSH_IS_A_MEMBERSH
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_MEMBERSH_PROCESSED_LIBRARIA') then
    alter table "MEMBERSHIP"
       delete foreign key FK_MEMBERSH_PROCESSED_LIBRARIA
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_MEMBERSH_SIGNED_USER') then
    alter table "MEMBERSHIP"
       delete foreign key FK_MEMBERSH_SIGNED_USER
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_USER_BELONGS_T_USERCATE') then
    alter table "USER"
       delete foreign key FK_USER_BELONGS_T_USERCATE
end if;

drop index if exists LIBRARIAN.LIBRARIAN_PK;

drop table if exists LIBRARIAN;

drop index if exists "MEMBERSHIP".PROCESSED_BY_FK;

drop index if exists "MEMBERSHIP".IS_A_FK;

drop index if exists "MEMBERSHIP".SIGNED_FK;

drop index if exists "MEMBERSHIP".MEMBERSHIP_PK;

drop table if exists "MEMBERSHIP";

drop index if exists MEMBERSHIPTYPE.MEMBERSHIPTYPE_PK;

drop table if exists MEMBERSHIPTYPE;

drop index if exists "USER".BELONGS_TO_FK;

drop index if exists "USER".USER_PK;

drop table if exists "USER";

drop index if exists USERCATEGORY.USERCATEGORY_PK;

drop table if exists USERCATEGORY;

/*==============================================================*/
/* Table: LIBRARIAN                                             */
/*==============================================================*/
create table LIBRARIAN 
(
   FIRST_NAME           char(30)                       null,
   LAST_NAME            char(30)                       null,
   PHONE_NUMBER         char(10)                       null,
   EMPLOYEE_ID          char(10)                       not null,
   constraint PK_LIBRARIAN primary key (EMPLOYEE_ID)
);

/*==============================================================*/
/* Index: LIBRARIAN_PK                                          */
/*==============================================================*/
create unique index LIBRARIAN_PK on LIBRARIAN (
EMPLOYEE_ID ASC
);

/*==============================================================*/
/* Table: "MEMBERSHIP"                                          */
/*==============================================================*/
create table "MEMBERSHIP" 
(
   MEMBERSHIP_ID        char(10)                       not null,
   TYPE_ID              char(10)                       not null,
   USER_ID              char(10)                       not null,
   EMPLOYEE_ID          char(10)                       not null,
   MEMBERSHIP_DATE      date                           null,
   constraint PK_MEMBERSHIP primary key (MEMBERSHIP_ID, TYPE_ID)
);

/*==============================================================*/
/* Index: MEMBERSHIP_PK                                         */
/*==============================================================*/
create unique index MEMBERSHIP_PK on "MEMBERSHIP" (
MEMBERSHIP_ID ASC,
TYPE_ID ASC
);

/*==============================================================*/
/* Index: SIGNED_FK                                             */
/*==============================================================*/
create index SIGNED_FK on "MEMBERSHIP" (
USER_ID ASC
);

/*==============================================================*/
/* Index: IS_A_FK                                               */
/*==============================================================*/
create index IS_A_FK on "MEMBERSHIP" (
TYPE_ID ASC
);

/*==============================================================*/
/* Index: PROCESSED_BY_FK                                       */
/*==============================================================*/
create index PROCESSED_BY_FK on "MEMBERSHIP" (
EMPLOYEE_ID ASC
);

/*==============================================================*/
/* Table: MEMBERSHIPTYPE                                        */
/*==============================================================*/
create table MEMBERSHIPTYPE 
(
   TYPE_ID              char(10)                       not null,
   TYPE_NAME            char(256)                      null,
   PRICE                decimal(10,2)                  null,
   DURATIONWEEKS        integer                        null,
   constraint PK_MEMBERSHIPTYPE primary key (TYPE_ID)
);

/*==============================================================*/
/* Index: MEMBERSHIPTYPE_PK                                     */
/*==============================================================*/
create unique index MEMBERSHIPTYPE_PK on MEMBERSHIPTYPE (
TYPE_ID ASC
);

/*==============================================================*/
/* Table: "USER"                                                */
/*==============================================================*/
create table "USER" 
(
   USER_ID              char(10)                       not null,
   CATEGORY_ID          char(10)                       null,
   FIRST_NAME           char(30)                       not null,
   LAST_NAME            char(30)                       not null,
   ADDRESS              char(200)                      null,
   DOB                  date                           null,
   PHONE_NUMBER         numeric                        not null,
   constraint PK_USER primary key (USER_ID)
);

/*==============================================================*/
/* Index: USER_PK                                               */
/*==============================================================*/
create unique index USER_PK on "USER" (
USER_ID ASC
);

/*==============================================================*/
/* Index: BELONGS_TO_FK                                         */
/*==============================================================*/
create index BELONGS_TO_FK on "USER" (
CATEGORY_ID ASC
);

/*==============================================================*/
/* Table: USERCATEGORY                                          */
/*==============================================================*/
create table USERCATEGORY 
(
   CATEGORY_ID          char(10)                       not null,
   CATEGORY_NAME        char(256)                      not null,
   constraint PK_USERCATEGORY primary key (CATEGORY_ID)
);

/*==============================================================*/
/* Index: USERCATEGORY_PK                                       */
/*==============================================================*/
create unique index USERCATEGORY_PK on USERCATEGORY (
CATEGORY_ID ASC
);

alter table "MEMBERSHIP"
   add constraint FK_MEMBERSH_IS_A_MEMBERSH foreign key (TYPE_ID)
      references MEMBERSHIPTYPE (TYPE_ID)
      on update restrict
      on delete restrict;

alter table "MEMBERSHIP"
   add constraint FK_MEMBERSH_PROCESSED_LIBRARIA foreign key (EMPLOYEE_ID)
      references LIBRARIAN (EMPLOYEE_ID)
      on update restrict
      on delete restrict;

alter table "MEMBERSHIP"
   add constraint FK_MEMBERSH_SIGNED_USER foreign key (USER_ID)
      references "USER" (USER_ID)
      on update restrict
      on delete restrict;

alter table "USER"
   add constraint FK_USER_BELONGS_T_USERCATE foreign key (CATEGORY_ID)
      references USERCATEGORY (CATEGORY_ID)
      on update restrict
      on delete restrict;

