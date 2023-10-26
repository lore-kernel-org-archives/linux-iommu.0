Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B221CAB2
	for <iommu@lists.linux.dev>; Thu, 26 Oct 2023 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.68.228])
	by sina.com (172.16.235.25) with ESMTP
	id 653A47E900002175; Thu, 26 Oct 2023 19:05:17 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 78810734210231
X-SMAIL-UIID: AA9490FE7EAA4F0182A2D406B1C991EF-20231026-190517
From: Hillf Danton <hdanton@sina.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: syzbot <syzbot+45f6cae2ca8c1f71e529@syzkaller.appspotmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	robin.murphy@arm.com,
	syzkaller-bugs@googlegroups.com,
	will@kernel.org
Subject: Re: [syzbot] [iommu?] KASAN: slab-use-after-free Read in iommufd_ioas_iova_ranges
Date: Thu, 26 Oct 2023 19:05:02 +0800
Message-Id: <20231026110502.2046-1-hdanton@sina.com>
In-Reply-To: <20231025183220.GQ691768@ziepe.ca>
References: <000000000000d621b406088a2f55@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 25 Oct 2023 15:32:20 -0300 Jason Gunthorpe <jgg@ziepe.ca>
> On Wed, Oct 25, 2023 at 06:11:01AM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    c3200081020d Merge tag 'block-6.6-2023-10-20' of git://git..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15013471680000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=849fe52ba7c6d78a
> > dashboard link: https://syzkaller.appspot.com/bug?extid=45f6cae2ca8c1f71e529
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/caa5c1eed3ec/disk-c3200081.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/7990a3a9f71e/vmlinux-c3200081.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/015551ac9acc/bzImage-c3200081.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+45f6cae2ca8c1f71e529@syzkaller.appspotmail.com
> > 
> > ==================================================================
> > BUG: KASAN: slab-use-after-free in __up_read+0xb3/0x690 kernel/locking/rwsem.c:1342
> > Read of size 8 at addr ffff8880283c9068 by task syz-executor.2/30372
> 
> Oh *ugh* I knew about this limitation once and forgot about it
> apparently.
> 
>   CPU 0         CPU1
>  down_read()
>  up_read()
>                 down_write()
>                 up_write()
> 		kfree()
>  [..]
>   tail portion of up_read()
> 
> I suppose the rwsem should be turned into a refcount and completion

The line [1] syzbot caught is before preempt is disabled, so no lock is
released yet, and the report is a simple uaf with nothing to do with
down_write().
With this report put aside, after the atomic operation in __up_read(),
sem is longer touched without waiter detected, so the refcount and
completion could not be proposed without a hoofed skull.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/locking/rwsem.c?id=c3200081020d#n1342
