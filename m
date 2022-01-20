Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D25EC4332F
	for <iommu@archiver.kernel.org>; Thu, 20 Jan 2022 13:04:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A7D9415E2;
	Thu, 20 Jan 2022 13:04:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pozwT1pvH8rn; Thu, 20 Jan 2022 13:04:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D419F408C5;
	Thu, 20 Jan 2022 13:04:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D759C0039;
	Thu, 20 Jan 2022 13:04:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F0A0C002F
 for <iommu@lists.linux-foundation.org>; Thu, 20 Jan 2022 13:04:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 75D8E409DB
 for <iommu@lists.linux-foundation.org>; Thu, 20 Jan 2022 13:04:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8qwlTOgKI0Tx for <iommu@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 13:04:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B7D08409DA
 for <iommu@lists.linux-foundation.org>; Thu, 20 Jan 2022 13:04:21 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id A98F768BEB; Thu, 20 Jan 2022 14:04:15 +0100 (CET)
Date: Thu, 20 Jan 2022 14:04:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: syzbot <syzbot+d03b64357793677f0080@syzkaller.appspotmail.com>
Subject: Re: [syzbot] WARNING in dma_map_sgtable
Message-ID: <20220120130415.GA10364@lst.de>
References: <00000000000083ab5e05d6027f02@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <00000000000083ab5e05d6027f02@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: sumit.semwal@linaro.org, syzkaller-bugs@googlegroups.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, christian.koenig@amd.com, linux-media@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This means the DMA API is called on a not DMA capable device.  This
needs fixing in the caller.

On Thu, Jan 20, 2022 at 04:18:21AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e3a8b6a1e70c Merge tag 'slab-for-5.17-part2' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1507e01fb00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=73c17fd2d4a060fe
> dashboard link: https://syzkaller.appspot.com/bug?extid=d03b64357793677f0080
> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d03b64357793677f0080@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 21150 at kernel/dma/mapping.c:188 __dma_map_sg_attrs kernel/dma/mapping.c:188 [inline]
> WARNING: CPU: 1 PID: 21150 at kernel/dma/mapping.c:188 dma_map_sgtable+0x203/0x260 kernel/dma/mapping.c:264
> Modules linked in:
> CPU: 1 PID: 21150 Comm: syz-executor.5 Not tainted 5.16.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:__dma_map_sg_attrs kernel/dma/mapping.c:188 [inline]
> RIP: 0010:dma_map_sgtable+0x203/0x260 kernel/dma/mapping.c:264
> Code: 75 15 e8 50 b2 13 00 eb cb e8 49 b2 13 00 eb c4 e8 42 b2 13 00 eb bd e8 3b b2 13 00 0f 0b bd fb ff ff ff eb af e8 2d b2 13 00 <0f> 0b 31 ed 48 bb 00 00 00 00 00 fc ff df e9 7b ff ff ff 89 e9 80
> RSP: 0018:ffffc9000969fd20 EFLAGS: 00010287
> RAX: ffffffff8171ee13 RBX: dffffc0000000000 RCX: 0000000000040000
> RDX: ffffc900056f9000 RSI: 000000000000079b RDI: 000000000000079c
> RBP: ffff888147437408 R08: ffffffff8171ece3 R09: ffffed100d4e6956
> R10: ffffed100d4e6956 R11: 0000000000000000 R12: ffff888147437000
> R13: ffff88806a734aa0 R14: 0000000000000000 R15: 0000000000000002
> FS:  00007f009bbc7700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055555641b108 CR3: 000000001901b000 CR4: 00000000003506e0
> DR0: 0000000020000100 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
> Call Trace:
>  <TASK>
>  get_sg_table+0xfc/0x150 drivers/dma-buf/udmabuf.c:72
>  begin_cpu_udmabuf+0xf5/0x160 drivers/dma-buf/udmabuf.c:126
>  dma_buf_begin_cpu_access+0xd8/0x170 drivers/dma-buf/dma-buf.c:1164
>  dma_buf_ioctl+0x2a0/0x2f0 drivers/dma-buf/dma-buf.c:363
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:874 [inline]
>  __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:860
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f009d251fe9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f009bbc7168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f009d364f60 RCX: 00007f009d251fe9
> RDX: 0000000020000040 RSI: 0000000040086200 RDI: 000000000000000b
> RBP: 00007f009d2ac08d R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffc7751fd4f R14: 00007f009bbc7300 R15: 0000000000022000
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
---end quoted text---
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
