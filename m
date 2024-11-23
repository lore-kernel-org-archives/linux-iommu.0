Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DB91386B4
	for <iommu@lists.linux.dev>; Sat, 23 Nov 2024 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732383605; cv=none; b=GWuDd7Nooh/40Ttx2orXGMsnDJcjeJwQ08hafmeV/oYaQK1rSkKmdahWGE49e2rkCuczPv93byRu5EmDiiLz0ftSjdUltXdFUFmy/Inil8eaE7cMq8NnXg5MshIkka901xR7pAoTiDlhrhvwwrFs348L+x7IFBjfP8xmHCNgRjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732383605; c=relaxed/simple;
	bh=SUWlvFhZ88y9oCZQXzu4MqsvHI1dd4kzYeM4ZgL7wNk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cikyJmJkbYZ5ljiMV72etF+d9X71dh08Qr6KaSWiS+3kJyAEVCMhNIrtGWHl+yWm3C1mk+q7l/moVG5BNHPsXNwN0LE0KCKPm6SXPMpiwKM+6TuNjDeAhS6LJA4v3kxsPHxI366ZvKo8DemPI6iDlJbE3f1saGQPaik8G8sbvE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a77085a3d7so30129905ab.1
        for <iommu@lists.linux.dev>; Sat, 23 Nov 2024 09:40:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732383603; x=1732988403;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qfFz15SpHCrVvxqnKaUyz4RN6DlSXKyVSnr96uHbHuE=;
        b=okoF3NerCov/rZrRXUUcxBsUfslU/i2oqA3rE8CCvYbihMio8rGOWMtP7+qNW1IqyY
         I2THEdcURcepKSkZRGldmGTNN6/ywxv4zsxLBYCMfEupVVnTsGK9TF68vjlVFXxvgTC0
         ydEt8WaBiwAckXpAmVPahpj6We34obkvsdohb5zBpRSCzf7cFnXsV0eL4v1jB4IBZhhC
         fJnulN5hMhHprvppErhX+CoElNd3Bv66WXKD5cID/TDxjFHS3eTSc9Etoj0DELLSp9t/
         7YMMZDa2Af3jd+FqFMPR5KOUI103J3jAJqxyenCyG2BQEAYNjvyo1JEvwx5NFMQruAaX
         rccQ==
X-Gm-Message-State: AOJu0Ywa+fbXNtfoRKp1prEnDJQs4zgUL8+VKnZKeQEpjPAJVrijln7n
	b20+1jJyllcuceW+eMWyZ+tRHiVNqN75U/TiJxvdiP+yuCHGX9PQ3OA2c+cWa8dGoooe/2uLiuh
	KmvIZekVspQ+aOxBwp9lam1c3thtV205mySy8iBHJDnY1nQzgxivhXL8=
X-Google-Smtp-Source: AGHT+IGrUdsyX24hBRvcijc+4cRnb2UfM0U26Tmg8RDJfAYSlDyRb85mNCtu83cuPptfyeZ4NTqxvkqkPrKMNZ0LdBAaD8bigAwq
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:ca6:b0:3a7:933e:ed95 with SMTP id
 e9e14a558f8ab-3a7933eee23mr84515875ab.2.1732383603213; Sat, 23 Nov 2024
 09:40:03 -0800 (PST)
Date: Sat, 23 Nov 2024 09:40:03 -0800
In-Reply-To: <CAHiZj8iCJHepbifizgOXDdq5ztyjC9WPB8vXcWkfYZks2VNYtA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67421373.050a0220.1cc393.001a.GAE@google.com>
Subject: Re: [syzbot] [iommu?] WARNING in iommufd_device_unbind
From: syzbot <syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com>
To: iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
	surajsonawane0215@gmail.com, syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in iommufd_device_unbind

iommufd: Time out waiting for iommufd object to become free
------------[ cut here ]------------
WARNING: CPU: 1 PID: 7718 at drivers/iommu/iommufd/iommufd_private.h:190 iommufd_object_destroy_user drivers/iommu/iommufd/iommufd_private.h:190 [inline]
WARNING: CPU: 1 PID: 7718 at drivers/iommu/iommufd/iommufd_private.h:190 iommufd_device_unbind+0x81/0xa0 drivers/iommu/iommufd/device.c:280
Modules linked in:
CPU: 1 UID: 0 PID: 7718 Comm: syz.2.28 Not tainted 6.12.0-syzkaller-08446-g228a1157fb9f-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:iommufd_object_destroy_user drivers/iommu/iommufd/iommufd_private.h:190 [inline]
RIP: 0010:iommufd_device_unbind+0x81/0xa0 drivers/iommu/iommufd/device.c:280
Code: 00 e8 13 a6 01 00 89 c3 31 ff 89 c6 e8 78 61 4c fc 85 db 75 0f e8 2f 5d 4c fc 5b 41 5e 41 5f c3 cc cc cc cc e8 20 5d 4c fc 90 <0f> 0b 90 eb eb 89 f9 80 e1 07 80 c1 03 38 c1 7c b8 e8 a9 f1 b3 fc
RSP: 0000:ffffc9000558fc38 EFLAGS: 00010293
RAX: ffffffff8548efc0 RBX: 00000000fffffff0 RCX: ffff88802b943c00
RDX: 0000000000000000 RSI: 00000000fffffff0 RDI: 0000000000000000
RBP: ffffc9000558fd70 R08: ffffffff8548efa8 R09: 1ffff11004af9f00
R10: dffffc0000000000 R11: ffffed1004af9f01 R12: ffff88803200d698
R13: ffff88803200d680 R14: ffff88807d293c00 R15: dffffc0000000000
FS:  00007f8c8c5a06c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020b04000 CR3: 000000006c9d0000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iommufd_selftest_destroy+0x95/0xe0 drivers/iommu/iommufd/selftest.c:1621
 iommufd_object_remove+0x3b6/0x530 drivers/iommu/iommufd/main.c:185
 iommufd_fops_ioctl+0x4d6/0x5a0 drivers/iommu/iommufd/main.c:409
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8c8b77e759
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8c8c5a0038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f8c8b936058 RCX: 00007f8c8b77e759
RDX: 0000000020000400 RSI: 0000000000003b80 RDI: 0000000000000003
RBP: 00007f8c8b7f175e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f8c8b936058 R15: 00007fffb80aeab8
 </TASK>


Tested on:

commit:         228a1157 Merge tag '6.13-rc-part1-SMB3-client-fixes' o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=178f975f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=402159daa216c89d
dashboard link: https://syzkaller.appspot.com/bug?extid=c92878e123785b1fa2db
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1585a9c0580000

