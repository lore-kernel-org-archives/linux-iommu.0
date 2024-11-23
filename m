Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6019D23098E
	for <iommu@lists.linux.dev>; Sat, 23 Nov 2024 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732368294; cv=none; b=rZKnTvYijTQEjnY6ypETxmTlzzKCSkKRbf2hxUtF2ZjRR8kv0RU2VbaoepneeIfALdlXYFz4FPp1bwZwuAg/YJc4iIRFIIPdiinuUbcQam/QXjeMhmUFQp9ARbkDLLeiXX/05oM/58sf9qQtgCRBhWbpNOtAW7qB/Vv06Vb5spE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732368294; c=relaxed/simple;
	bh=A2OgPgjzv7UNCSyfd0UxhFr7w0sVcJ3fU9n/+nFG4wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQC1Pt64vGgMv2ae5sRvfpAVl7i8+pLN+/yIQeY+TjdoSZUmrxyps6CE/Jzlj5Hx5Uuw/8CSn3R1LukyY4mjE4x4PVJK+L02+bGbO5i4chZtkIEAl2ytyZmZJ6a7YzPfmr8LxLJDxkJBv8kTZlJPYPmysiv9fxupQxTrE/7g8b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUNseH36; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUNseH36"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cfe3686b8eso1733582a12.0
        for <iommu@lists.linux.dev>; Sat, 23 Nov 2024 05:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732368291; x=1732973091; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i2SzbZFifFB8Y8oXaqAKNyaSGS9kkQUccMqmpD6WdeI=;
        b=EUNseH36xd4r3ADEIWkAfuzBBAlZWzkm42iXdUEOUDDoX6E5SkXXekZKxfI4gvYJvG
         SmY6C2HNXzB2S6QPzMt1rIofxE2h6DUkaCSJRFD29uGTtlGdv1TO8jmkdH3P7JcOoq1B
         8N7VIdtk53fxkCopC6x829Jyrl+1VptHJiLfeHDMwQwYm44KjCOPV8KN/fF0vTy4hK52
         3leX1a0YAl7uvpkxeW4IyFMhokO/3FQpUI0T3eZUYmhNEp+7ixkw5rKruBFQ/g9CzMUG
         kSNUmLQ2WapyZgPcREZOc0FmED6o0nvSDs+ZUYCrgJJZjptv0jZlQafzGQ3wVJIqMtSW
         BDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732368291; x=1732973091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2SzbZFifFB8Y8oXaqAKNyaSGS9kkQUccMqmpD6WdeI=;
        b=mqduY++ZdqRXmx3shPZbhl79i8zJzWe9RZzQGKJbKTuouSesLB9/Fb2o6uE+KWv2f7
         6dmTBBVDsKWr4iX9VecRpVRgzZhYm3B+6/+Wbv3f2M62X7auyl03wMfysIsFSKF1OlYj
         PEyiCRV3Psn+kvSQUfqLYNDM0F5UlTcPlFdrRDj3JkV8EoQBc2/aSeCeyPZ+o0fO4hOj
         j6JK5qNsMuceiLBaDgN1U4X9NZV9PRkMJ6HNrjcA3kxFSWGAi0kaoVtc+ME490tdTmWt
         DHg1EedGntRZ8uAAqSg6rtFJjvCZ8HTGe05dY7NYg1k6ZdFPgRFdkVrhKBUktg9QP+o0
         4HJA==
X-Gm-Message-State: AOJu0Yy+mbj9PEZkwhq2g4yR74mUQG/i+8JzdliNpnibPoSKi2bBhZZn
	d+M5jqc50l3wUrMneQinW4yGqzzdaOcYhBWuPyXN9yg/JIUgFnrjfOYEfKvigvzeugIu0Oz15h+
	I4PUh3R6ECjYIZIfHDNuqZBg/BBs=
X-Gm-Gg: ASbGncsVlUckOQz8MhTKT0+puSnuq/4LK2Vtq5VF74Pyc0nOM8+SmbvUGqirlvRClqT
	k/SOx8EToPgG/Gn+rp08VDx2O9JdAki5h7mI1QMU/3NISj8221e68HUeYb1E3tx/LLA==
X-Google-Smtp-Source: AGHT+IHSy9njuMRaCHdseo/gKc7dYc9uY9T5XwLnxn+MkYkF2QNhmSNSxcooHtCmkKdVmbJ23yGx9zNdApSRSRUsW0w=
X-Received: by 2002:a05:6402:3511:b0:5cf:cfa8:d6cf with SMTP id
 4fb4d7f45d1cf-5d02066288emr7522508a12.17.1732368290557; Sat, 23 Nov 2024
 05:24:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <67403e13.050a0220.3c9d61.018d.GAE@google.com>
In-Reply-To: <67403e13.050a0220.3c9d61.018d.GAE@google.com>
From: Suraj Sonawane <surajsonawane0215@gmail.com>
Date: Sat, 23 Nov 2024 18:54:13 +0530
Message-ID: <CAHiZj8hNe6jgUgZ=FViJV33wd89cpeHeEX-Ak02nn97t2yGiHQ@mail.gmail.com>
Subject: Re: [syzbot] [iommu?] WARNING in iommufd_device_unbind
To: syzbot <syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com>
Cc: iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
	syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: multipart/mixed; boundary="000000000000949fee0627946c54"

--000000000000949fee0627946c54
Content-Type: multipart/alternative; boundary="000000000000949fec0627946c52"

--000000000000949fec0627946c52
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

--000000000000949fec0627946c52
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

--000000000000949fec0627946c52--
--000000000000949fee0627946c54
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fix2-WARNING-in-iommufd_device_unbind.patch"
Content-Disposition: attachment; 
	filename="0001-fix2-WARNING-in-iommufd_device_unbind.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m3u7bs2e0>
X-Attachment-Id: f_m3u7bs2e0

RnJvbSBhNTI1ZWVkMTRkNDJhOWViZjE2NDM5ZDgxZTg2MWZjMGJmY2JmOGE3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdXJhaiBTb25hd2FuZSA8c3VyYWpzb25hd2FuZTAyMTVAZ21h
aWwuY29tPgpEYXRlOiBTYXQsIDIzIE5vdiAyMDI0IDEyOjQ0OjU2ICswNTMwClN1YmplY3Q6IFtQ
QVRDSF0gZml4MiBXQVJOSU5HIGluIGlvbW11ZmRfZGV2aWNlX3VuYmluZAoKc3l6IHRlc3QKClNp
Z25lZC1vZmYtYnk6IFN1cmFqIFNvbmF3YW5lIDxzdXJhanNvbmF3YW5lMDIxNUBnbWFpbC5jb20+
Ci0tLQogZHJpdmVycy9pb21tdS9pb21tdWZkL21haW4uYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9t
bXUvaW9tbXVmZC9tYWluLmMgYi9kcml2ZXJzL2lvbW11L2lvbW11ZmQvbWFpbi5jCmluZGV4IGQy
NjgzYWQ4Mi4uOTU0YzAyMWU5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2lvbW11L2lvbW11ZmQvbWFp
bi5jCisrKyBiL2RyaXZlcnMvaW9tbXUvaW9tbXVmZC9tYWluLmMKQEAgLTEwNCw3ICsxMDQsNyBA
QCBzdGF0aWMgaW50IGlvbW11ZmRfb2JqZWN0X2RlY193YWl0X3Nob3J0dGVybShzdHJ1Y3QgaW9t
bXVmZF9jdHggKmljdHgsCiAJaWYgKHdhaXRfZXZlbnRfdGltZW91dChpY3R4LT5kZXN0cm95X3dh
aXQsCiAJCQkJcmVmY291bnRfcmVhZCgmdG9fZGVzdHJveS0+c2hvcnR0ZXJtX3VzZXJzKSA9PQog
CQkJCQkwLAotCQkJCW1zZWNzX3RvX2ppZmZpZXMoMTAwMDApKSkKKwkJCQltc2Vjc190b19qaWZm
aWVzKDEyMDAwKSkpCiAJCXJldHVybiAwOwogCiAJcHJfY3JpdCgiVGltZSBvdXQgd2FpdGluZyBm
b3IgaW9tbXVmZCBvYmplY3QgdG8gYmVjb21lIGZyZWVcbiIpOwotLSAKMi4zNC4xCgo=
--000000000000949fee0627946c54--
