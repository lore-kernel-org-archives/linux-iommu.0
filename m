Return-Path: <SRS0=NqTC=YJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC76FA3728
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 22:04:23 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F4F20872
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 22:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ndf5ytWy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F4F20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D51A1C00;
	Wed, 16 Oct 2019 22:04:22 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4029EBA4
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 22:04:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com
	(us-smtp-delivery-1.mimecast.com [205.139.110.120])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 0E28E8A9
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 22:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1571263459;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=Ht56pow+7hHw9PkEuutZWXs4JG9Pm3nm9+CAX9wBhmU=;
	b=Ndf5ytWyhwvqCZtL1eRAHbW3m4kdZa00nmJ4BjyWsPwD38bbL9zezaMiz3XhCC5mO4grIG
	arReqPhusfiYDIR7MNYv9CCv85t54VokXXBLsRBhNGSNdUjzup+ASeSexmYxVxc0gtGe11
	dKgc44q0WoUr7/rO3P2xTiA9NO5F5Dw=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
	[209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
	us-mta-362-_aVtzNUCMlyrfOXcfl_HrQ-1; Wed, 16 Oct 2019 18:04:18 -0400
Received: by mail-io1-f72.google.com with SMTP id x13so40275540ioa.18
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 15:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
	:mail-followup-to:references:mime-version:content-disposition
	:in-reply-to:user-agent;
	bh=kj70mauJvZOpd/TGWZLioMkjLh4i7juGQ9MH3JKRYp8=;
	b=NBEv7yiWTpFwRzZAZ9Dkr6QuZgICm4f8rzAoRbJnolKMI/my3Fpf0S1Raj92bNH2r6
	3X03FyVKAjm0iGDBsvYopc0H+6X3MvhC7u2UuOTv+hQJm32Vx/NwjM+OlB81AUFBB6+g
	yqM0KwJ8zPXn5egV0r6s+kw099m85OI67DL6I+t839dwFFfBr463fsptTDed6ONnto2l
	1pF8ivwJ/MeOHmWcmsJuErYuhcu2prJzxD50O0XqTczfLqsTCC9cAbpePvLCZpcqC3kk
	ebiRaaDzZ1JUJpSo3T2MjaGoxjgVDu4uHQB8qK9r0uP0f0PSAiG+Mc2mudi3NYdoJCgw
	YGfg==
X-Gm-Message-State: APjAAAXpWxNZbp3j035PKA9vevxrVlr/he2oDLJoi47xfE/GGaBdP/XQ
	sQkF3xDIr1XRr4jwP6On85GbLAly9xytd4yXjqrg8c72RhiLhd8o4s+urdJ3kdM7wsRBKOt41vn
	Vr4kau3vdtd605QQqgGr1x6CgvU3VvQ==
X-Received: by 2002:a92:d68c:: with SMTP id p12mr105832iln.89.1571263457427;
	Wed, 16 Oct 2019 15:04:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw2n9fNqx+DgjljfcPTCFSsOSULZy7Jj1xvkVK0JMwFYEs+vGr6R1mtvp72rlXSkFkxpGvpaQ==
X-Received: by 2002:a92:d68c:: with SMTP id p12mr105802iln.89.1571263457096;
	Wed, 16 Oct 2019 15:04:17 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
	by smtp.gmail.com with ESMTPSA id r138sm7729iod.59.2019.10.16.15.04.16
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 16 Oct 2019 15:04:16 -0700 (PDT)
Date: Wed, 16 Oct 2019 15:04:15 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Qian Cai <cai@lca.pw>
Subject: Re: [PATCH -next] iommu/amd: fix a warning in increase_address_space
Message-ID: <20191016220415.cbam7qk3pxjmw4gi@cantor>
Mail-Followup-To: Qian Cai <cai@lca.pw>, jroedel@suse.de,
	don.brace@microsemi.com, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, jejb@linux.ibm.com,
	esc.storagedev@microsemi.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
References: <1571254542-13998-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
In-Reply-To: <1571254542-13998-1-git-send-email-cai@lca.pw>
User-Agent: NeoMutt/20180716
X-MC-Unique: _aVtzNUCMlyrfOXcfl_HrQ-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
Cc: don.brace@microsemi.com, jroedel@suse.de, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, jejb@linux.ibm.com,
	esc.storagedev@microsemi.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Wed Oct 16 19, Qian Cai wrote:
>After the commit 754265bcab78 ("iommu/amd: Fix race in
>increase_address_space()"), it could still possible trigger a race
>condition under some heavy memory pressure below. The race to trigger a
>warning is,
>
>CPU0:				CPU1:
>in alloc_pte():		in increase_address_space():
>while (address > PM_LEVEL_SIZE(domain->mode)) [1]
>
>				spin_lock_irqsave(&domain->lock
>				domain->mode    += 1;
>				spin_unlock_irqrestore(&domain->lock
>
>in increase_address_space():
>spin_lock_irqsave(&domain->lock
>if (WARN_ON_ONCE(domain->mode == PAGE_MODE_6_LEVEL))
>
>[1] domain->mode = 5
>
>It is unclear the triggering of the warning is the root cause of the
>smartpqi offline yet, but let's fix it first by lifting the locking.
>
>WARNING: CPU: 57 PID: 124314 at drivers/iommu/amd_iommu.c:1474
>iommu_map_page+0x718/0x7e0
>smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000
>address=0xffffffffffec0000 flags=0x0010]
>smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000
>address=0xffffffffffec1000 flags=0x0010]
>CPU: 57 PID: 124314 Comm: oom01 Tainted: G           O
>Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40
>07/10/2019
>RIP: 0010:iommu_map_page+0x718/0x7e0
>Code: 88 a5 70 ff ff ff e9 5d fa ff ff 48 8b b5 70 ff ff ff 4c 89 ef e8
>08 32 2f 00 41 80 fc 01 0f 87 b7 3d 00 00 41 83 e4 01 eb be <0f> 0b 48
>8b b5 70 ff ff ff 4c 89 ef e8 e7 31 2f 00 eb dd 0f 0b 48
>RSP: 0018:ffff888da4816cb8 EFLAGS: 00010046
>RAX: 0000000000000000 RBX: ffff8885fe689000 RCX: ffffffff96f4a6c4
>RDX: 0000000000000007 RSI: dffffc0000000000 RDI: ffff8885fe689124
>RBP: ffff888da4816da8 R08: ffffed10bfcd120e R09: ffffed10bfcd120e
>R10: ffffed10bfcd120d R11: ffff8885fe68906b R12: 0000000000000000
>smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000
>address=0xffffffffffec1a00 flags=0x0010]
>R13: ffff8885fe689068 R14: ffff8885fe689124 R15: 0000000000000000
>smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000
>address=0xffffffffffec1e00 flags=0x0010]
>FS:  00007f29722ba700(0000) GS:ffff88902f880000(0000)
>knlGS:0000000000000000
>CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>CR2: 00007f27f82d8000 CR3: 000000102ed9c000 CR4: 00000000003406e0
>Call Trace:
>smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000
>address=0xffffffffffec2000 flags=0x0010]
> map_sg+0x1ce/0x2f0
>smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000
>address=0xffffffffffec2400 flags=0x0010]
> scsi_dma_map+0xd7/0x160
> pqi_raid_submit_scsi_cmd_with_io_request+0x1b8/0x420 [smartpqi]
>smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000
>address=0xffffffffffec2800 flags=0x0010]
> pqi_scsi_queue_command+0x8ab/0xe00 [smartpqi]
>smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000
>address=0xffffffffffec2c00 flags=0x0010]
> scsi_queue_rq+0xd19/0x1360
>smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000
>address=0xffffffffffec3000 flags=0x0010]
> __blk_mq_try_issue_directly+0x295/0x3f0
>smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000
>address=0xffffffffffec3400 flags=0x0010]
>AMD-Vi: Event logged [IO_PAGE_FAULT device=23:00.0 domain=0x0000
>address=0xffffffffffec3800 flags=0x0010]
> blk_mq_request_issue_directly+0xb5/0x100
>AMD-Vi: Event logged [IO_PAGE_FAULT device=23:00.0 domain=0x0000
>address=0xffffffffffec3c00 flags=0x0010]
> blk_mq_try_issue_list_directly+0xa9/0x160
> blk_mq_sched_insert_requests+0x228/0x380
> blk_mq_flush_plug_list+0x448/0x7e0
> blk_flush_plug_list+0x1eb/0x230
> blk_finish_plug+0x43/0x5d
> shrink_node_memcg+0x9c5/0x1550
>smartpqi 0000:23:00.0: controller is offline: status code 0x14803
>smartpqi 0000:23:00.0: controller offline
>
>Fixes: 754265bcab78 ("iommu/amd: Fix race in increase_address_space()")
>Signed-off-by: Qian Cai <cai@lca.pw>
>---
>
>BTW, Joerg, this line from the commit "iommu/amd: Remove domain->updated" looks
>suspicious. Not sure what the purpose of it.
>
>*updated = increase_address_space(domain, gfp) || *updated;
>

Looking at it again I think that isn't an issue really, it would just
not lose updated being set in a previous loop iteration, but now
I'm wondering about the loop itself. In the cases where it would return
false, how does the evaluation of the condition for the while loop
change?

> drivers/iommu/amd_iommu.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>index 2369b8af81f3..a5754068aa29 100644
>--- a/drivers/iommu/amd_iommu.c
>+++ b/drivers/iommu/amd_iommu.c
>@@ -1465,12 +1465,9 @@ static void free_pagetable(struct protection_domain *domain)
> static bool increase_address_space(struct protection_domain *domain,
> 				   gfp_t gfp)
> {
>-	unsigned long flags;
> 	bool ret = false;
> 	u64 *pte;
>
>-	spin_lock_irqsave(&domain->lock, flags);
>-
> 	if (WARN_ON_ONCE(domain->mode == PAGE_MODE_6_LEVEL))
> 		/* address space already 64 bit large */
> 		goto out;
>@@ -1487,8 +1484,6 @@ static bool increase_address_space(struct protection_domain *domain,
> 	ret = true;
>
> out:
>-	spin_unlock_irqrestore(&domain->lock, flags);
>-
> 	return ret;
> }
>
>@@ -1499,14 +1494,19 @@ static u64 *alloc_pte(struct protection_domain *domain,
> 		      gfp_t gfp,
> 		      bool *updated)
> {
>+	unsigned long flags;
> 	int level, end_lvl;
> 	u64 *pte, *page;
>
> 	BUG_ON(!is_power_of_2(page_size));
>
>+	spin_lock_irqsave(&domain->lock, flags);
>+
> 	while (address > PM_LEVEL_SIZE(domain->mode))
> 		*updated = increase_address_space(domain, gfp) || *updated;
>
>+	spin_unlock_irqrestore(&domain->lock, flags);
>+
> 	level   = domain->mode - 1;
> 	pte     = &domain->pt_root[PM_LEVEL_INDEX(level, address)];
> 	address = PAGE_SIZE_ALIGN(address, page_size);
>-- 
>1.8.3.1
>
>_______________________________________________
>iommu mailing list
>iommu@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
