Return-Path: <SRS0=QuKU=D7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D468C2D0A3
	for <iommu@archiver.kernel.org>; Sat, 24 Oct 2020 19:25:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8628F22276
	for <iommu@archiver.kernel.org>; Sat, 24 Oct 2020 19:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UH5i3t4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8628F22276
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 34AB98688A;
	Sat, 24 Oct 2020 19:25:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2vFCLBAaAnH7; Sat, 24 Oct 2020 19:25:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 78BDF854E7;
	Sat, 24 Oct 2020 19:25:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6042EC0052;
	Sat, 24 Oct 2020 19:25:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EBE4C0051
 for <iommu@lists.linux-foundation.org>; Sat, 24 Oct 2020 18:15:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 35180868E1
 for <iommu@lists.linux-foundation.org>; Sat, 24 Oct 2020 18:15:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mEiuEfRcZJg5 for <iommu@lists.linux-foundation.org>;
 Sat, 24 Oct 2020 18:15:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 60EF8868DE
 for <iommu@lists.linux-foundation.org>; Sat, 24 Oct 2020 18:15:18 +0000 (UTC)
Received: from kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net
 (c-67-180-217-166.hsd1.ca.comcast.net [67.180.217.166])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7B58F24650;
 Sat, 24 Oct 2020 18:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603563317;
 bh=hTHylvJInlhIshidRIoPG6FnbQIEujKIvKVJhi95JTM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=UH5i3t4LoHB4nVC+RsKRlTvYbef1xoseWjnN9vkblzyIf0rFfWSLVUwgHDwDiKrmq
 gNKd4NlJX4eFnBbMWeQGkVWhz4dAFvOSltEA706hvy1PpOlpp2t7/R6T5hgjilXqFL
 VRV15DjWafg/19Ib6CrJnRC0n8lgugJYyQdnGeP8=
Date: Sat, 24 Oct 2020 11:15:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: syzbot <syzbot+34dc2fea3478e659af01@syzkaller.appspotmail.com>
Subject: Re: WARNING in dma_map_page_attrs
Message-ID: <20201024111516.59abc9ec@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <000000000000a0f8a305b261fe4a@google.com>
References: <000000000000335adc05b23300f6@google.com>
 <000000000000a0f8a305b261fe4a@google.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Sat, 24 Oct 2020 19:25:27 +0000
Cc: sumit.semwal@linaro.org, linaro-mm-sig-owner@lists.linaro.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, hch@lst.de, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 christian.koenig@amd.com, linux-media@vger.kernel.org
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

CC: rdma, looks like rdma from the stack trace

On Fri, 23 Oct 2020 20:07:17 -0700 syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    3cb12d27 Merge tag 'net-5.10-rc1' of git://git.kernel.org/..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=13125390500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=46c6fea3eb827ae1
> dashboard link: https://syzkaller.appspot.com/bug?extid=34dc2fea3478e659af01
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16858664500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f402ef900000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+34dc2fea3478e659af01@syzkaller.appspotmail.com
> 
> netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 family 0 port 6081 - 0
> netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
> netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
> infiniband syz2: set active
> infiniband syz2: added macvlan0
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 8488 at kernel/dma/mapping.c:149 dma_map_page_attrs+0x493/0x700 kernel/dma/mapping.c:149
> Modules linked in:
> CPU: 1 PID: 8488 Comm: syz-executor144 Not tainted 5.9.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:dma_map_page_attrs+0x493/0x700 kernel/dma/mapping.c:149
> Code: 80 3c 10 00 0f 85 ed 01 00 00 48 8b 1d 86 38 e9 0c e9 2d fc ff ff 48 89 c3 e9 d1 fd ff ff e8 04 11 12 00 0f 0b e8 fd 10 12 00 <0f> 0b 49 c7 c4 ff ff ff ff e9 d5 fd ff ff e8 ea 10 12 00 48 8d 7b
> RSP: 0018:ffffc90000fdec68 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffffffff894d1060 RCX: ffffffff815df1e3
> RDX: ffff8880208c1a40 RSI: ffffffff815df5b3 RDI: ffff8880196f8b00
> RBP: ffff88801412d800 R08: 0000000000000002 R09: 0000000000000000
> R10: 0000000000000002 R11: 0000000000000000 R12: ffffea0000504b40
> R13: ffff8880196f86e8 R14: 00000000000008b8 R15: 0000000000000002
> FS:  0000000001b26880(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000200002c0 CR3: 0000000022446000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  dma_map_single_attrs include/linux/dma-mapping.h:279 [inline]
>  ib_dma_map_single include/rdma/ib_verbs.h:3967 [inline]
>  ib_mad_post_receive_mads+0x23f/0xd60 drivers/infiniband/core/mad.c:2715
>  ib_mad_port_start drivers/infiniband/core/mad.c:2862 [inline]
>  ib_mad_port_open drivers/infiniband/core/mad.c:3016 [inline]
>  ib_mad_init_device+0x72b/0x1400 drivers/infiniband/core/mad.c:3092
>  add_client_context+0x405/0x5e0 drivers/infiniband/core/device.c:680
>  enable_device_and_get+0x1d5/0x3c0 drivers/infiniband/core/device.c:1301
>  ib_register_device drivers/infiniband/core/device.c:1376 [inline]
>  ib_register_device+0x7a7/0xa40 drivers/infiniband/core/device.c:1335
>  rxe_register_device+0x46d/0x570 drivers/infiniband/sw/rxe/rxe_verbs.c:1182
>  rxe_add+0x12fe/0x16d0 drivers/infiniband/sw/rxe/rxe.c:247
>  rxe_net_add+0x8c/0xe0 drivers/infiniband/sw/rxe/rxe_net.c:507
>  rxe_newlink drivers/infiniband/sw/rxe/rxe.c:269 [inline]
>  rxe_newlink+0xb7/0xe0 drivers/infiniband/sw/rxe/rxe.c:250
>  nldev_newlink+0x30e/0x540 drivers/infiniband/core/nldev.c:1555
>  rdma_nl_rcv_msg+0x367/0x690 drivers/infiniband/core/netlink.c:195
>  rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
>  rdma_nl_rcv+0x2f2/0x440 drivers/infiniband/core/netlink.c:259
>  netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
>  netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
>  netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
>  sock_sendmsg_nosec net/socket.c:651 [inline]
>  sock_sendmsg+0xcf/0x120 net/socket.c:671
>  ____sys_sendmsg+0x6e8/0x810 net/socket.c:2353
>  ___sys_sendmsg+0xf3/0x170 net/socket.c:2407
>  __sys_sendmsg+0xe5/0x1b0 net/socket.c:2440
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x443699
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db 0d fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffc067db418 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000443699
> RDX: 0000000000000000 RSI: 00000000200002c0 RDI: 0000000000000003
> RBP: 00007ffc067db420 R08: 0000000001bbbbbb R09: 0000000001bbbbbb
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc067db430
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
