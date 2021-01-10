select system_users.id
        ,system_users.name as user_name
        ,system_users.friendly_name as user_friendly_name
        ,system_users.state
        ,users.site_role_id
        ,site_roles.name as site_role_name
        ,site_roles.display_name as display_name
        ,group_users.group_id
        ,groups.name as group_name
        ,users.login_at + '9 hour' as login_at --日本時間に調整
        ,system_users.created_at + '9 hour' as created_at --日本時間に調整
        ,system_users.updated_at + '9 hour' as updated_at --日本時間に調整
        ,cast(1 as numeric) as belong --所属グループカウント用
    from system_users
    left join users
      on system_users.id = users.system_user_id
    left join site_roles
      on users.site_role_id = site_roles.id
    left join group_users
      on system_users.id = group_users.user_id
     and group_users.group_id <> '2' --2=All Usersは除外
    left join groups
      on group_users.group_id = groups.id
   where (system_users.id <> 1 and system_users.id <> 2 and system_users.id <> 3) --1=_system 2=guest 3=サーバ管理者　は除外
   order by system_users.id