Return-Path: <SRS0=p9ZB=5X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DE5C2BA1A
	for <iommu@archiver.kernel.org>; Tue,  7 Apr 2020 02:35:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B368206B8
	for <iommu@archiver.kernel.org>; Tue,  7 Apr 2020 02:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="gewsdy0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B368206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1822787EBF;
	Tue,  7 Apr 2020 02:35:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xgNZEJmXYk0B; Tue,  7 Apr 2020 02:35:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 89AEB87EB0;
	Tue,  7 Apr 2020 02:35:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AE89C089E;
	Tue,  7 Apr 2020 02:35:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05CF2C0177
 for <iommu@lists.linux-foundation.org>; Tue,  7 Apr 2020 02:35:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E18A72202E
 for <iommu@lists.linux-foundation.org>; Tue,  7 Apr 2020 02:35:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w2UcusItlbCA for <iommu@lists.linux-foundation.org>;
 Tue,  7 Apr 2020 02:35:04 +0000 (UTC)
X-Greylist: delayed 00:21:55 by SQLgrey-1.7.6
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com
 [209.85.219.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 0489E2201C
 for <iommu@lists.linux-foundation.org>; Tue,  7 Apr 2020 02:35:03 +0000 (UTC)
Received: by mail-qv1-f67.google.com with SMTP id q73so1167567qvq.2
 for <iommu@lists.linux-foundation.org>; Mon, 06 Apr 2020 19:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BfSGNCe4oEdtp7HObDoUBxiccfhReNwsRhUVxZRTBNI=;
 b=gewsdy0lwajFLCQWWu6WiPH8/MUhlBoR9q+iW9sg17xdjiLFUdivK0Wx6EsixHvSX3
 zQwX32w/VKiJHmS0WDQevjVGo8+gfgZi7y7DCOhRzKwmY33py4q+jaMI/YD6QapRyGB7
 YbvFsoEbARPUmTaMh0OsJ4hN3wc4UMzH3wf44LZPIUg9X3RkNhnGmhPqB3e4pTBgmVAX
 Ap0KvmbhVNLE3aN/pIyYdtZUPMIWoWig1fp5mfR3gvXwYRD0zjSjOTsu8gUtTijF9KbD
 +IoL4EAP58QvN6dW5LppI3EHYc32ZWcZtjxJH3hX7utI7ZcDL02rl5Zpl7eH0XAl+U/x
 AcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BfSGNCe4oEdtp7HObDoUBxiccfhReNwsRhUVxZRTBNI=;
 b=bA1pQe5jZ+iDfytxik85Yb31dNjb49bOIS3w80MD46NN+G1pEC6b1GY2JaYT+4TVsh
 p9msIVv9DeM0JR6L+7afgFhyXwRypuobSd0yYqGiiIZipMlIEgd9S+6o4GcXPsMNOQYS
 o82idd9pLh4cYcNgBMvzMGwemxcVMaNwgYtB/dtQwyFTj7lbmRMrlvugzYhccq2SZ2q5
 +EHJsgJLfAkyXKZqZNhtKzRsDnesvLkE+VBnoyc99zxWZhhGxHUzOTvRN7uSHIlezZP+
 FUp65/J3cBrst6t+PEefX2NKTNTH0SN0FPY5MkXeNQAXYxSBxuZbk4lN3sL6WOpuxh/D
 XMnw==
X-Gm-Message-State: AGi0PuYDEGDI1wQhR2T12GrnEDtIzAni99txL6vmxg7pvFKhwv6hQsls
 cWhkstkAKzhElp2oeuGe3nHDISawYjwTNA==
X-Google-Smtp-Source: APiQypLfdxRR9tnKWUX/fwH+m3mfpC90iHPIxMu/88gfIawO6KT91exQ+B/xGelP+JNMFRVA6Ub71w==
X-Received: by 2002:a0c:b896:: with SMTP id y22mr84351qvf.182.1586225587511;
 Mon, 06 Apr 2020 19:13:07 -0700 (PDT)
Received: from ovpn-66-196.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id d5sm103120qke.14.2020.04.06.19.13.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Apr 2020 19:13:07 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
To: joro@8bytes.org
Subject: [RFC PATCH] iommu/amd: fix a race in fetch_pte()
Date: Mon,  6 Apr 2020 22:12:46 -0400
Message-Id: <20200407021246.10941-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

fetch_pte() could race with increase_address_space() because it held no
lock from iommu_unmap_page(). On the CPU that runs fetch_pte() it could
see a stale domain->pt_root and a new increased domain->mode from
increase_address_space(). As the result, it could trigger invalid
accesses later on. Fix it by using a pair of smp_[w|r]mb in those
places.

 kernel BUG at drivers/iommu/amd_iommu.c:1704!
 BUG_ON(unmapped && !is_power_of_2(unmapped));
 Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
 RIP: 0010:amd_iommu_unmap+0x1b2/0x1d0
 Call Trace:
  <IRQ>
  __iommu_unmap+0x106/0x320
  iommu_unmap_fast+0xe/0x10
  __iommu_dma_unmap+0xdc/0x1a0
  iommu_dma_unmap_sg+0xae/0xd0
  scsi_dma_unmap+0xe7/0x150
  pqi_raid_io_complete+0x37/0x60 [smartpqi]
  pqi_irq_handler+0x1fc/0x13f0 [smartpqi]
  __handle_irq_event_percpu+0x78/0x4f0
  handle_irq_event_percpu+0x70/0x100
  handle_irq_event+0x5a/0x8b
  handle_edge_irq+0x10c/0x370
  do_IRQ+0x9e/0x1e0
  common_interrupt+0xf/0xf
  </IRQ>

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/amd_iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 20cce366e951..22328a23335f 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1434,6 +1434,11 @@ static bool increase_address_space(struct protection_domain *domain,
 	*pte             = PM_LEVEL_PDE(domain->mode,
 					iommu_virt_to_phys(domain->pt_root));
 	domain->pt_root  = pte;
+	/*
+	 * Make sure fetch_pte() will see the new domain->pt_root before it
+	 * snapshots domain->mode.
+	 */
+	smp_wmb();
 	domain->mode    += 1;
 
 	ret = true;
@@ -1460,6 +1465,8 @@ static u64 *alloc_pte(struct protection_domain *domain,
 		*updated = increase_address_space(domain, address, gfp) || *updated;
 
 	level   = domain->mode - 1;
+	/* To pair with smp_wmb() in increase_address_space(). */
+	smp_rmb();
 	pte     = &domain->pt_root[PM_LEVEL_INDEX(level, address)];
 	address = PAGE_SIZE_ALIGN(address, page_size);
 	end_lvl = PAGE_SIZE_LEVEL(page_size);
@@ -1545,6 +1552,8 @@ static u64 *fetch_pte(struct protection_domain *domain,
 		return NULL;
 
 	level	   =  domain->mode - 1;
+	/* To pair with smp_wmb() in increase_address_space(). */
+	smp_rmb();
 	pte	   = &domain->pt_root[PM_LEVEL_INDEX(level, address)];
 	*page_size =  PTE_LEVEL_PAGE_SIZE(level);
 
-- 
2.21.0 (Apple Git-122.2)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
