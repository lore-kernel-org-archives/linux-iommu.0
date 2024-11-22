Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0082013B58C
	for <iommu@lists.linux.dev>; Fri, 22 Nov 2024 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292782; cv=none; b=rPu0+GwmV04poyQtunw7zGrv1lBZDz5HQ1vOx/ogxT3vcKgenbTcv//F9rcqxtT0WwwTTtq4konHkGL8t6nkP5ilsr+8HEFOW0XEbmB4wOEP6tuRYAkNrG92yvV/jns+Mx3WYPgc/IAF9x62s8TtyRKFdnMPQVRxqlqTgFzjdWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292782; c=relaxed/simple;
	bh=bDxMvH9oVB2bjgayg85wa2IGS0MlZFO6a2brK3ahQ94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iR+mdPdctEjQtTndqydw4uJ6sr+TAGKJOtFnC/dfQpE/TlMOH9yJ0/NR70FF4Z4UtaxglWg8PxD0ap8cS1GvHLXwcv9Qgrjvh0ft6aWMrC7R9T75/AWNw/09Q6XIFnTAsEQwOzvcjWHf/j/9MYXyua8sufPo+njZ8HyURysuhMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crZpy2i3; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crZpy2i3"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cfc035649bso3084190a12.2
        for <iommu@lists.linux.dev>; Fri, 22 Nov 2024 08:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732292777; x=1732897577; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ut8S5y3x/QyXX/cAyTPWe2N3hLCbDRV3eSN2ZYEOv4o=;
        b=crZpy2i3goOONLJfRFDN/6hZjG2O0f5u5kCGzJPoyvhOSMgs+EqnEqRjMfPrgloNzy
         rn4sMCGG7YgJrTF1qCSyU/VzcjVN11i3cv/XhrqS8YEPoE+qK/R+GV9pBxoz0UIovTcZ
         LRYrlYONiABH120R/WOTJHSGnwiPDNB0ZVhFMRY9MVL+JgND8mGrGkB+/JO0MOKzcXoQ
         +a6/LaVJrktz0vSqHglvppGjcjR50L5kpJIZzR3oK82SLLmbdwEbNwbKrJ3jn//uxTbb
         43RlExXzk3tDhFEeMqNEghQQGTZHeTCk64+fNKtwQxjNU38P8IACSMX4FWQQat0IVKjQ
         QF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732292777; x=1732897577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ut8S5y3x/QyXX/cAyTPWe2N3hLCbDRV3eSN2ZYEOv4o=;
        b=Gc+lga9ClxOgBMDTBtzJjvBuMYzDJWqRV8YHrncWmsfz30ToZgw7teJvaART5xKSJp
         d7KVNq4fkVzlPavfe++XCBAJfT8DTd/7zhymoH2nLAseB3kTTI/utz/UOCo9yFE/g5iS
         VvauuG7QpU7Cvu4ZyFR8Sd+NwuNf3Z8Y4d99Ku2M0OFDiISVA8JGfiePx4WaXuE0Tshl
         4IcrtY4WyR2mvKxsz4Qe9Juvx6Oliu8lfNF46tRkv6AY2UetMjzT8cYQUc9RXLP82SGS
         CmvpVH5TInntRBGIo63kOVQ0Pocq5UUzWzpxNS9tcC5YbqiZrRq6hdedUodQWptHD0zH
         YBng==
X-Gm-Message-State: AOJu0YwfiqUPept3oEOGPfCGSbbsiPrS03hevorTxwUjzIuqWr+OefjH
	i01SD5DiZ/Qq7SOBWwngvUmU0CgjRC8WNzsWVy3i+ChUWwQA5SQFhL8nfR+awl0JXxWhQDZUUek
	EDHhup0pUnjylly72X9uYRjBOs4w=
X-Gm-Gg: ASbGncszHMvgZ9Sn8KPnYYPhPx9qMeHwUGsNDwRApAexDFUcaXchhGeYscJe0gs+caS
	udqwhMNHqa0Rj5uvS67JublcvJRh61LkKqhWffvwxOuZFJIaxrt6oGCHLJnK8FsU=
X-Google-Smtp-Source: AGHT+IEZH0CcViQYBzedbSWCkplyW3/tygHOJXorUCRrQqcg7PR/7zTm8wpWJU/9478ReyCS+tEbRQXD4HdaYVoH3mA=
X-Received: by 2002:a05:6402:4492:b0:5cf:c97c:8206 with SMTP id
 4fb4d7f45d1cf-5d020695181mr2846756a12.25.1732292777031; Fri, 22 Nov 2024
 08:26:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <67403e13.050a0220.3c9d61.018d.GAE@google.com>
In-Reply-To: <67403e13.050a0220.3c9d61.018d.GAE@google.com>
From: Suraj Sonawane <surajsonawane0215@gmail.com>
Date: Fri, 22 Nov 2024 21:55:40 +0530
Message-ID: <CAHiZj8g8dFUZj+wL5Z-Y_aL4wM-ZtC0uymGytx-oFNAWUEBz1A@mail.gmail.com>
Subject: Re: [syzbot] [iommu?] WARNING in iommufd_device_unbind
To: syzbot <syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com>
Cc: iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
	syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: multipart/mixed; boundary="0000000000009f6867062782d773"

--0000000000009f6867062782d773
Content-Type: multipart/alternative; boundary="0000000000009f6865062782d771"

--0000000000009f6865062782d771
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Fri, Nov 22, 2024 at 1:47=E2=80=AFPM syzbot <
syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com> wrote:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c6d64479d609 Merge tag 'pull-statx' of
> git://git.kernel.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D129a0ae858000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db3b3b2f3eaae5=
1f9
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=3Dc92878e123785b1fa2db
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for
> Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D17da1bf7980=
000
>
> Downloadable assets:
> disk image:
> https://storage.googleapis.com/syzbot-assets/9d212f6bb1af/disk-c6d64479.r=
aw.xz
> vmlinux:
> https://storage.googleapis.com/syzbot-assets/21a14342211b/vmlinux-c6d6447=
9.xz
> kernel image:
> https://storage.googleapis.com/syzbot-assets/f96c41f3e4a6/bzImage-c6d6447=
9.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the
> commit:
> Reported-by: syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com
>
> iommufd: Time out waiting for iommufd object to become free
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 6050 at drivers/iommu/iommufd/iommufd_private.h:208
> iommufd_object_destroy_user drivers/iommu/iommufd/iommufd_private.h:208
> [inline]
> WARNING: CPU: 1 PID: 6050 at drivers/iommu/iommufd/iommufd_private.h:208
> iommufd_device_unbind+0x81/0xa0 drivers/iommu/iommufd/device.c:280
> Modules linked in:
> CPU: 1 UID: 0 PID: 6050 Comm: syz.3.18 Not tainted
> 6.12.0-syzkaller-00239-gc6d64479d609 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 10/30/2024
> RIP: 0010:iommufd_object_destroy_user
> drivers/iommu/iommufd/iommufd_private.h:208 [inline]
> RIP: 0010:iommufd_device_unbind+0x81/0xa0
> drivers/iommu/iommufd/device.c:280
> Code: 00 e8 83 76 01 00 89 c3 31 ff 89 c6 e8 b8 85 43 fc 85 db 75 0f e8 6=
f
> 81 43 fc 5b 41 5e 41 5f c3 cc cc cc cc e8 60 81 43 fc 90 <0f> 0b 90 eb eb
> 89 f9 80 e1 07 80 c1 03 38 c1 7c b8 e8 d9 44 aa fc
> RSP: 0018:ffffc90003017c38 EFLAGS: 00010293
> RAX: ffffffff85516f50 RBX: 00000000fffffff0 RCX: ffff88802c693c00
> RDX: 0000000000000000 RSI: 00000000fffffff0 RDI: 0000000000000000
> RBP: ffffc90003017d70 R08: ffffffff85516f38 R09: 1ffff11005b9b140
> R10: dffffc0000000000 R11: ffffed1005b9b141 R12: ffff888034149718
> R13: ffff888034149700 R14: ffff888028d2c400 R15: dffffc0000000000
> FS:  00007f2573c136c0(0000) GS:ffff8880b8700000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000c001633e80 CR3: 0000000032fda000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  iommufd_selftest_destroy+0x95/0xe0 drivers/iommu/iommufd/selftest.c:1439
>  iommufd_object_remove+0x3b6/0x530 drivers/iommu/iommufd/main.c:211
>  iommufd_fops_ioctl+0x4d6/0x5a0 drivers/iommu/iommufd/main.c:424
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:906 [inline]
>  __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f2572d7e759
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f2573c13038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f2572f36058 RCX: 00007f2572d7e759
> RDX: 0000000020000400 RSI: 0000000000003b80 RDI: 0000000000000003
> RBP: 00007f2572df175e R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000001 R14: 00007f2572f36058 R15: 00007ffefd725ea8
>  </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit
> https://groups.google.com/d/msgid/syzkaller-bugs/67403e13.050a0220.3c9d61=
.018d.GAE%40google.com
> .
>

--0000000000009f6865062782d771
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">#syz test<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, Nov 22, 2024 at 1:47=E2=80=AFPM syzbo=
t &lt;<a href=3D"mailto:syzbot%2Bc92878e123785b1fa2db@syzkaller.appspotmail=
.com">syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hello,<br>
<br>
syzbot found the following issue on:<br>
<br>
HEAD commit:=C2=A0 =C2=A0 c6d64479d609 Merge tag &#39;pull-statx&#39; of gi=
t://git.kernel.or..<br>
git tree:=C2=A0 =C2=A0 =C2=A0 =C2=A0upstream<br>
console output: <a href=3D"https://syzkaller.appspot.com/x/log.txt?x=3D129a=
0ae8580000" rel=3D"noreferrer" target=3D"_blank">https://syzkaller.appspot.=
com/x/log.txt?x=3D129a0ae8580000</a><br>
kernel config:=C2=A0 <a href=3D"https://syzkaller.appspot.com/x/.config?x=
=3Db3b3b2f3eaae51f9" rel=3D"noreferrer" target=3D"_blank">https://syzkaller=
.appspot.com/x/.config?x=3Db3b3b2f3eaae51f9</a><br>
dashboard link: <a href=3D"https://syzkaller.appspot.com/bug?extid=3Dc92878=
e123785b1fa2db" rel=3D"noreferrer" target=3D"_blank">https://syzkaller.apps=
pot.com/bug?extid=3Dc92878e123785b1fa2db</a><br>
compiler:=C2=A0 =C2=A0 =C2=A0 =C2=A0Debian clang version 15.0.6, GNU ld (GN=
U Binutils for Debian) 2.40<br>
syz repro:=C2=A0 =C2=A0 =C2=A0 <a href=3D"https://syzkaller.appspot.com/x/r=
epro.syz?x=3D17da1bf7980000" rel=3D"noreferrer" target=3D"_blank">https://s=
yzkaller.appspot.com/x/repro.syz?x=3D17da1bf7980000</a><br>
<br>
Downloadable assets:<br>
disk image: <a href=3D"https://storage.googleapis.com/syzbot-assets/9d212f6=
bb1af/disk-c6d64479.raw.xz" rel=3D"noreferrer" target=3D"_blank">https://st=
orage.googleapis.com/syzbot-assets/9d212f6bb1af/disk-c6d64479.raw.xz</a><br=
>
vmlinux: <a href=3D"https://storage.googleapis.com/syzbot-assets/21a1434221=
1b/vmlinux-c6d64479.xz" rel=3D"noreferrer" target=3D"_blank">https://storag=
e.googleapis.com/syzbot-assets/21a14342211b/vmlinux-c6d64479.xz</a><br>
kernel image: <a href=3D"https://storage.googleapis.com/syzbot-assets/f96c4=
1f3e4a6/bzImage-c6d64479.xz" rel=3D"noreferrer" target=3D"_blank">https://s=
torage.googleapis.com/syzbot-assets/f96c41f3e4a6/bzImage-c6d64479.xz</a><br=
>
<br>
IMPORTANT: if you fix the issue, please add the following tag to the commit=
:<br>
Reported-by: <a href=3D"mailto:syzbot%2Bc92878e123785b1fa2db@syzkaller.apps=
potmail.com" target=3D"_blank">syzbot+c92878e123785b1fa2db@syzkaller.appspo=
tmail.com</a><br>
<br>
iommufd: Time out waiting for iommufd object to become free<br>
------------[ cut here ]------------<br>
WARNING: CPU: 1 PID: 6050 at drivers/iommu/iommufd/iommufd_private.h:208 io=
mmufd_object_destroy_user drivers/iommu/iommufd/iommufd_private.h:208 [inli=
ne]<br>
WARNING: CPU: 1 PID: 6050 at drivers/iommu/iommufd/iommufd_private.h:208 io=
mmufd_device_unbind+0x81/0xa0 drivers/iommu/iommufd/device.c:280<br>
Modules linked in:<br>
CPU: 1 UID: 0 PID: 6050 Comm: syz.3.18 Not tainted 6.12.0-syzkaller-00239-g=
c6d64479d609 #0<br>
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 10/30/2024<br>
RIP: 0010:iommufd_object_destroy_user drivers/iommu/iommufd/iommufd_private=
.h:208 [inline]<br>
RIP: 0010:iommufd_device_unbind+0x81/0xa0 drivers/iommu/iommufd/device.c:28=
0<br>
Code: 00 e8 83 76 01 00 89 c3 31 ff 89 c6 e8 b8 85 43 fc 85 db 75 0f e8 6f =
81 43 fc 5b 41 5e 41 5f c3 cc cc cc cc e8 60 81 43 fc 90 &lt;0f&gt; 0b 90 e=
b eb 89 f9 80 e1 07 80 c1 03 38 c1 7c b8 e8 d9 44 aa fc<br>
RSP: 0018:ffffc90003017c38 EFLAGS: 00010293<br>
RAX: ffffffff85516f50 RBX: 00000000fffffff0 RCX: ffff88802c693c00<br>
RDX: 0000000000000000 RSI: 00000000fffffff0 RDI: 0000000000000000<br>
RBP: ffffc90003017d70 R08: ffffffff85516f38 R09: 1ffff11005b9b140<br>
R10: dffffc0000000000 R11: ffffed1005b9b141 R12: ffff888034149718<br>
R13: ffff888034149700 R14: ffff888028d2c400 R15: dffffc0000000000<br>
FS:=C2=A0 00007f2573c136c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000=
000000<br>
CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>
CR2: 000000c001633e80 CR3: 0000000032fda000 CR4: 00000000003526f0<br>
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000<br>
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400<br>
Call Trace:<br>
=C2=A0&lt;TASK&gt;<br>
=C2=A0iommufd_selftest_destroy+0x95/0xe0 drivers/iommu/iommufd/selftest.c:1=
439<br>
=C2=A0iommufd_object_remove+0x3b6/0x530 drivers/iommu/iommufd/main.c:211<br=
>
=C2=A0iommufd_fops_ioctl+0x4d6/0x5a0 drivers/iommu/iommufd/main.c:424<br>
=C2=A0vfs_ioctl fs/ioctl.c:51 [inline]<br>
=C2=A0__do_sys_ioctl fs/ioctl.c:906 [inline]<br>
=C2=A0__se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892<br>
=C2=A0do_syscall_x64 arch/x86/entry/common.c:52 [inline]<br>
=C2=A0do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83<br>
=C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f<br>
RIP: 0033:0x7f2572d7e759<br>
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 &lt;48&gt; 3d 01 f=
0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48<br>
RSP: 002b:00007f2573c13038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010<br>
RAX: ffffffffffffffda RBX: 00007f2572f36058 RCX: 00007f2572d7e759<br>
RDX: 0000000020000400 RSI: 0000000000003b80 RDI: 0000000000000003<br>
RBP: 00007f2572df175e R08: 0000000000000000 R09: 0000000000000000<br>
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000<br>
R13: 0000000000000001 R14: 00007f2572f36058 R15: 00007ffefd725ea8<br>
=C2=A0&lt;/TASK&gt;<br>
<br>
<br>
---<br>
This report is generated by a bot. It may contain errors.<br>
See <a href=3D"https://goo.gl/tpsmEJ" rel=3D"noreferrer" target=3D"_blank">=
https://goo.gl/tpsmEJ</a> for more information about syzbot.<br>
syzbot engineers can be reached at <a href=3D"mailto:syzkaller@googlegroups=
.com" target=3D"_blank">syzkaller@googlegroups.com</a>.<br>
<br>
syzbot will keep track of this issue. See:<br>
<a href=3D"https://goo.gl/tpsmEJ#status" rel=3D"noreferrer" target=3D"_blan=
k">https://goo.gl/tpsmEJ#status</a> for how to communicate with syzbot.<br>
<br>
If the report is already addressed, let syzbot know by replying with:<br>
#syz fix: exact-commit-title<br>
<br>
If you want syzbot to run the reproducer, reply with:<br>
#syz test: git://repo/address.git branch-or-commit-hash<br>
If you attach or paste a git patch, syzbot will apply it before testing.<br=
>
<br>
If you want to overwrite report&#39;s subsystems, reply with:<br>
#syz set subsystems: new-subsystem<br>
(See the list of subsystem names on the web dashboard)<br>
<br>
If the report is a duplicate of another one, reply with:<br>
#syz dup: exact-subject-of-another-report<br>
<br>
If you want to undo deduplication, reply with:<br>
#syz undup<br>
<br>
-- <br>
You received this message because you are subscribed to the Google Groups &=
quot;syzkaller-bugs&quot; group.<br>
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:syzkaller-bugs%2Bunsubscribe@googlegroups.com" ta=
rget=3D"_blank">syzkaller-bugs+unsubscribe@googlegroups.com</a>.<br>
To view this discussion visit <a href=3D"https://groups.google.com/d/msgid/=
syzkaller-bugs/67403e13.050a0220.3c9d61.018d.GAE%40google.com" rel=3D"noref=
errer" target=3D"_blank">https://groups.google.com/d/msgid/syzkaller-bugs/6=
7403e13.050a0220.3c9d61.018d.GAE%40google.com</a>.<br>
</blockquote></div>

--0000000000009f6865062782d771--
--0000000000009f6867062782d773
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fix-WARNING-in-iommufd_device_unbind.patch"
Content-Disposition: attachment; 
	filename="0001-fix-WARNING-in-iommufd_device_unbind.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m3syd9xd0>
X-Attachment-Id: f_m3syd9xd0

RnJvbSA2MmI4NzNiYzcwYWI4ZjI1OWIyMjljY2FiMWFjZTNmNmJhNDM1Y2U1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdXJhaiBTb25hd2FuZSA8c3VyYWpzb25hd2FuZTAyMTVAZ21h
aWwuY29tPgpEYXRlOiBGcmksIDIyIE5vdiAyMDI0IDIxOjUwOjA3ICswNTMwClN1YmplY3Q6IFtQ
QVRDSF0gZml4IFdBUk5JTkcgaW4gaW9tbXVmZF9kZXZpY2VfdW5iaW5kCgpzeXogdGVzdAoKU2ln
bmVkLW9mZi1ieTogU3VyYWogU29uYXdhbmUgPHN1cmFqc29uYXdhbmUwMjE1QGdtYWlsLmNvbT4K
LS0tCiBkcml2ZXJzL2lvbW11L2lvbW11ZmQvbWFpbi5jIHwgMTEgKysrKysrKysrKy0KIDEgZmls
ZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pb21tdS9pb21tdWZkL21haW4uYyBiL2RyaXZlcnMvaW9tbXUvaW9tbXVmZC9tYWlu
LmMKaW5kZXggMGE5NmNjOGYyLi5kMjY4M2FkODIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW9tbXUv
aW9tbXVmZC9tYWluLmMKKysrIGIvZHJpdmVycy9pb21tdS9pb21tdWZkL21haW4uYwpAQCAtMTIy
LDYgKzEyMiw3IEBAIGludCBpb21tdWZkX29iamVjdF9yZW1vdmUoc3RydWN0IGlvbW11ZmRfY3R4
ICppY3R4LAogewogCXN0cnVjdCBpb21tdWZkX29iamVjdCAqb2JqOwogCVhBX1NUQVRFKHhhcywg
JmljdHgtPm9iamVjdHMsIGlkKTsKKwlERUZJTkVfTVVURVgocmVtb3ZlX211dGV4KTsgLy8gTXV0
ZXggZm9yIHRocmVhZCBzYWZldHkKIAlib29sIHplcm9kX3Nob3J0dGVybSA9IGZhbHNlOwogCWlu
dCByZXQ7CiAKQEAgLTEzOSwxMSArMTQwLDE0IEBAIGludCBpb21tdWZkX29iamVjdF9yZW1vdmUo
c3RydWN0IGlvbW11ZmRfY3R4ICppY3R4LAogCQkJICogZGVmZXIgY2xlYW5pbmcgdGhpcyBvYmpl
Y3QgdW50aWwgY2xvc2UuCiAJCQkgKi8KIAkJCXJlZmNvdW50X2RlYygmdG9fZGVzdHJveS0+dXNl
cnMpOworCQkJbXV0ZXhfdW5sb2NrKCZyZW1vdmVfbXV0ZXgpOwogCQkJcmV0dXJuIHJldDsKIAkJ
fQogCQl6ZXJvZF9zaG9ydHRlcm0gPSB0cnVlOwogCX0KIAorCW11dGV4X2xvY2soJnJlbW92ZV9t
dXRleCk7CisKIAl4YV9sb2NrKCZpY3R4LT5vYmplY3RzKTsKIAlvYmogPSB4YXNfbG9hZCgmeGFz
KTsKIAlpZiAodG9fZGVzdHJveSkgewpAQCAtMTc2LDYgKzE4MCw5IEBAIGludCBpb21tdWZkX29i
amVjdF9yZW1vdmUoc3RydWN0IGlvbW11ZmRfY3R4ICppY3R4LAogCSAqIFNpbmNlIHVzZXJzIGlz
IHplcm8gYW55IHBvc2l0aXZlIHVzZXJzX3Nob3J0dGVybSBtdXN0IGJlIHJhY2luZwogCSAqIGlv
bW11ZmRfcHV0X29iamVjdCgpLCBvciB3ZSBoYXZlIGEgYnVnLgogCSAqLworCisJbXV0ZXhfdW5s
b2NrKCZyZW1vdmVfbXV0ZXgpOworCiAJaWYgKCF6ZXJvZF9zaG9ydHRlcm0pIHsKIAkJcmV0ID0g
aW9tbXVmZF9vYmplY3RfZGVjX3dhaXRfc2hvcnR0ZXJtKGljdHgsIG9iaik7CiAJCWlmIChXQVJO
X09OKHJldCkpCkBAIC0xODcsMTEgKzE5NCwxMyBAQCBpbnQgaW9tbXVmZF9vYmplY3RfcmVtb3Zl
KHN0cnVjdCBpb21tdWZkX2N0eCAqaWN0eCwKIAlyZXR1cm4gMDsKIAogZXJyX3hhOgorCXhhX3Vu
bG9jaygmaWN0eC0+b2JqZWN0cyk7CisJbXV0ZXhfdW5sb2NrKCZyZW1vdmVfbXV0ZXgpOworCiAJ
aWYgKHplcm9kX3Nob3J0dGVybSkgewogCQkvKiBSZXN0b3JlIHRoZSB4YXJyYXkgb3duZWQgcmVm
ZXJlbmNlICovCiAJCXJlZmNvdW50X3NldCgmb2JqLT5zaG9ydHRlcm1fdXNlcnMsIDEpOwogCX0K
LQl4YV91bmxvY2soJmljdHgtPm9iamVjdHMpOwogCiAJLyogVGhlIHJldHVybmVkIG9iamVjdCBy
ZWZlcmVuY2UgY291bnQgaXMgemVybyAqLwogCXJldHVybiByZXQ7Ci0tIAoyLjM0LjEKCg==
--0000000000009f6867062782d773--
