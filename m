Return-Path: <SRS0=bDbm=VH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD28CC74A35
	for <iommu@archiver.kernel.org>; Wed, 10 Jul 2019 21:44:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA2D20838
	for <iommu@archiver.kernel.org>; Wed, 10 Jul 2019 21:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="SVtPgNJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA2D20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2FFF049DC;
	Wed, 10 Jul 2019 21:44:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2A41249D1
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Jul 2019 21:37:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
	[209.85.222.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 794D5883
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Jul 2019 21:37:32 +0000 (UTC)
Received: by mail-qk1-f196.google.com with SMTP id s145so3153551qke.7
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Jul 2019 14:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=St1qYh9tlVeaUB7eh4n72DWxZ8GSBB5lPnCn4WHYVHw=;
	b=SVtPgNJ4ZIv0M43ejuyHAoXp14LcG2YNYCLbuptnvVYUFBvaYofNKYUM+z0OB/1aoC
	o9XLnsSpDDfFesjJAkj5VQTU4+coitlcwGHfTMh7+UOgiU2r2vWzPtkKne+tISqHX6kR
	oH/4ISlffM3fENAdWCMtvJS/ZC8B+KbTYjj4vVe40e4i2L+7NcAGkuAmgTVUfAJYQNNU
	J8WRG5hlE5y2LGHYuvz7y0v+VjGIhk7AIlhVa4EcYr1ICxvXe5Lhh2TNSPvmVCglMtd9
	sjJoDmyPSgDJCFghTRWf/6Nw2aTfxUV3w6ojnp4eNkDtmw1+t+CeMIYs+HMQCfNeHmEi
	cjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=St1qYh9tlVeaUB7eh4n72DWxZ8GSBB5lPnCn4WHYVHw=;
	b=LLG+CryELJvKm/YSclUO8FpPjWQiy8o2B6YFCHfyrrP1MSqukec9gYgFqLARzUvcGy
	Ms/wMWr4GOki06zWdTMa5apr+Pyo4ELfpqpb0XRn5UJumNk4bCIAdeyYwyNKGG5Ebqax
	8/Ckx1r2+dFSH1N5KmH2pT0IANPWB29AkYcieNhVlUm0Yf3KaZEEHg1yFknCh7nG2f5J
	ZsetvFrSGVcC4lR9TDQZKpenrJP7mIlrmqbukkOSs8yIJg7yU62DukEAwmECH2YkXbLn
	zwmy/Q5dll7XlFCF5SS/GsKgAOkqARgPMdSgh1DugcdqJQ8KBXkgwjf1qCMZgCoc0zap
	hLGg==
X-Gm-Message-State: APjAAAU56VRvhq4BTcaRVxYIaoXBaNNm+HANrYdn6psgxIrwT4KU9L9F
	bxCITu8Nn7K9AvWDRNJEzfKaQg==
X-Google-Smtp-Source: APXvYqxtsgCH3Yb5EvQyvFkbLrmMWRJmYeFGMIyDCPFqJarGrAZ+ibbxy/7KEh30njTYCZ7k1vQUmA==
X-Received: by 2002:a05:620a:685:: with SMTP id
	f5mr293718qkh.238.1562794651499; 
	Wed, 10 Jul 2019 14:37:31 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
	by smtp.gmail.com with ESMTPSA id y3sm1729926qtj.46.2019.07.10.14.37.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Jul 2019 14:37:30 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
To: jroedel@suse.de
Subject: [PATCH] iommu/amd: fix a crash in iova_magazine_free_pfns
Date: Wed, 10 Jul 2019 17:37:15 -0400
Message-Id: <1562794635-8988-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

When a system is under heavy memory pressure, the allocation in
alloc_iova_fast() could still fail even flush_rcache=true, and then
causes dma_ops_alloc_iova() return 0.

pqi_scsi_queue_command
  pqi_raid_submit_scsi_cmd_with_io_request
    scsi_dma_map
      map_sg
        dma_ops_alloc_iova
         alloc_iova_fast

Later, map_sg()->iommu_map_page() would probably fail due to the invalid
PFN 0, and call free_iova_fast()->iova_rcache_insert() to insert it to
the rcache. Finally, it will trigger the BUG_ON(!iova) here.

    kernel BUG at drivers/iommu/iova.c:801!
    Workqueue: kblockd blk_mq_run_work_fn
    RIP: 0010:iova_magazine_free_pfns+0x7d/0xc0
    Call Trace:
     free_cpu_cached_iovas+0xbd/0x150
     alloc_iova_fast+0x8c/0xba
     dma_ops_alloc_iova.isra.6+0x65/0xa0
     map_sg+0x8c/0x2a0
     scsi_dma_map+0xc6/0x160
     pqi_aio_submit_io+0x1f6/0x440 [smartpqi]
     pqi_scsi_queue_command+0x90c/0xdd0 [smartpqi]
     scsi_queue_rq+0x79c/0x1200
     blk_mq_dispatch_rq_list+0x4dc/0xb70
     blk_mq_sched_dispatch_requests+0x249/0x310
     __blk_mq_run_hw_queue+0x128/0x200
     blk_mq_run_work_fn+0x27/0x30
     process_one_work+0x522/0xa10
     worker_thread+0x63/0x5b0
     kthread+0x1d2/0x1f0
     ret_from_fork+0x22/0x40

Fix it by validating the return from the 2nd alloc_iova_fast() in
dma_ops_alloc_iova(), so map_sg() could handle the error condition
immediately.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/amd_iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 73740b969e62..f24c689b4e01 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1697,6 +1697,8 @@ static unsigned long dma_ops_alloc_iova(struct device *dev,
 	if (!pfn)
 		pfn = alloc_iova_fast(&dma_dom->iovad, pages,
 				      IOVA_PFN(dma_mask), true);
+	if (!pfn)
+		return DMA_MAPPING_ERROR;
 
 	return (pfn << PAGE_SHIFT);
 }
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
