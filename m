Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51289AD52
	for <iommu@lists.linux.dev>; Mon, 13 Feb 2023 21:14:41 +0000 (UTC)
Received: by mail-io1-f77.google.com with SMTP id k4-20020a6b7e44000000b0071e11cafea7so9137755ioq.15
        for <iommu@lists.linux.dev>; Mon, 13 Feb 2023 13:14:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5MOkuFS9QIN3mf/KRy78aCAqz7A+XmCO2P1W5d9dmcE=;
        b=rhO8rjulS6rs8+HH6deruNbNprE9JaqDDYlIcaMSnR1BK0wKIJuwHRrUDZcWVfo1k1
         mfVftn6qIXui1znYhEESR0qbvOHl2IJwZCtqPvPizrvQ/iRl+AqMB/hJpmKHkRxcrFbK
         EA4HJ1V9g8xTCxDPdflqOBQxK2OX7yLwAnDCLrveKT/xFpjtYqsI4b1s2mp8NDCDp/A7
         c8m+A1qxWNS8yYFGZrNxwpCxg3SSkUP6a6fF5z/9Zwg6TJrCwh51IhZ10d3aRgNsaAMY
         HLHnCzrhuc2zmPfHIi4AVjcBunFOsqFZUrhji0UwPO0IOd/HaDeKqAI3NmsyIcCL/Psr
         ycDA==
X-Gm-Message-State: AO0yUKUK58MWgPSuH28nEKQ6TPO0U8ImmOCmnEm+DlxdCel47aErMZpa
	al1WO8eiW1yIuavo/hzRtRynpSzewq5RLG08hiC0SaMus1Tb
X-Google-Smtp-Source: AK7set/pAxwmNE14kr483ZJxL58VyTsM9vtXj+L/vRdydrx/Cjd+AOO1D/oO8Rw3FfGbzFqamqHiq88zxHchWOXVRzY/eQmle91o
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a02:ccf4:0:b0:38a:adeb:d4d1 with SMTP id
 l20-20020a02ccf4000000b0038aadebd4d1mr13143021jaq.81.1676322880445; Mon, 13
 Feb 2023 13:14:40 -0800 (PST)
Date: Mon, 13 Feb 2023 13:14:40 -0800
In-Reply-To: <0000000000000df2c105f4929eb5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1610405f49b5514@google.com>
Subject: Re: [syzbot] KMSAN: kernel-infoleak in iommufd_vfio_ioctl
From: syzbot <syzbot+cb1e0978f6bf46b83a58@syzkaller.appspotmail.com>
To: eric.auger@redhat.com, glider@google.com, iommu@lists.linux.dev, 
	jgg@nvidia.com, jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, lixiao.yang@intel.com, mjrosato@linux.ibm.com, 
	nicolinc@nvidia.com, robin.murphy@arm.com, syzkaller-bugs@googlegroups.com, 
	will@kernel.org, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    da13c00eebfb kmsan: silence -Wmissing-prototypes warnings
git tree:       https://github.com/google/kmsan.git master
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10d56c2b480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41295d7e980cccef
dashboard link: https://syzkaller.appspot.com/bug?extid=cb1e0978f6bf46b83a58
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16560c43480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109a7207480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/316f273df601/disk-da13c00e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c2802e9a4fe3/vmlinux-da13c00e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6211b8a40cab/bzImage-da13c00e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cb1e0978f6bf46b83a58@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:121 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_user+0x1c5/0x270 lib/usercopy.c:33
 instrument_copy_to_user include/linux/instrumented.h:121 [inline]
 _copy_to_user+0x1c5/0x270 lib/usercopy.c:33
 copy_to_user include/linux/uaccess.h:169 [inline]
 iommufd_vfio_iommu_get_info drivers/iommu/iommufd/vfio_compat.c:437 [inline]
 iommufd_vfio_ioctl+0x1e57/0x2330 drivers/iommu/iommufd/vfio_compat.c:462
 iommufd_fops_ioctl+0x254/0xb10 drivers/iommu/iommufd/main.c:315
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0x2dd/0x4b0 fs/ioctl.c:856
 __x64_sys_ioctl+0xdc/0x120 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Local variable info.i created at:
 iommufd_vfio_iommu_get_info drivers/iommu/iommufd/vfio_compat.c:384 [inline]
 iommufd_vfio_ioctl+0x423/0x2330 drivers/iommu/iommufd/vfio_compat.c:462
 iommufd_fops_ioctl+0x254/0xb10 drivers/iommu/iommufd/main.c:315

Bytes 20-23 of 24 are uninitialized
Memory access of size 24 starts at ffff88810ed3bcb0
Data copied to user address 0000000020000100

CPU: 0 PID: 5039 Comm: syz-executor178 Not tainted 6.2.0-rc8-syzkaller-80994-gda13c00eebfb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
=====================================================

