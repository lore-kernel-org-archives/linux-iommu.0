Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2730C433E6
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 19:31:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EE6564F64
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 19:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE6564F64
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 58C7D868F5;
	Thu,  4 Feb 2021 19:31:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ct5X6jlpT2jW; Thu,  4 Feb 2021 19:31:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F3713868D5;
	Thu,  4 Feb 2021 19:31:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDE8FC07FD;
	Thu,  4 Feb 2021 19:31:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F75BC013A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 19:31:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 54EAB8725F
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 19:31:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sv3MCg3dz5aV for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 19:31:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E2EA587269
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 19:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=DxaRDKf7HluJFpLbNHgF0rL3eIOI92nWEAIlQODnQYU=; b=SDRHtqwATWNLDinMfquTc/cYVG
 83BJkhFN+82vUcjXxw3huP58Nn/tgk4XqLWCOmnKwXwjX3znQvHVl/ozxAlE9QFcfvcravtEZO5Ey
 quElTSy8JfgbTmVKcG6gXtlgaN/K7aAORyEbHRi+SM8otwS+4a14RhNvf5+6QB63TOvNUUPXbddTm
 Wdb62Tjut7/29dyvVs7FEDm1DDLOLJQiDvKG0g5jwq4iQjZA2QE/DRx/Xs9ToXL4/4QiMQ3OM2ZEm
 bWpHegKujvO+xw5xD1Venvs4NYVDlGl/HUQQWHdwwccxuPLweM9VO+F95EJCN7puvsmwXlaB7EcgW
 g0yFTWJQ==;
Received: from [2001:4bb8:184:7d04:e998:f47:b9fb:7611] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l7kL5-001Jim-Lh; Thu, 04 Feb 2021 19:30:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: jxgao@google.com,
	gregkh@linuxfoundation.org
Subject: [PATCH 6/8] swiotlb: don't modify orig_addr in swiotlb_tbl_sync_single
Date: Thu,  4 Feb 2021 20:30:33 +0100
Message-Id: <20210204193035.2606838-7-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210204193035.2606838-1-hch@lst.de>
References: <20210204193035.2606838-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: saravanak@google.com, konrad.wilk@oracle.com, marcorr@google.com,
 linux-nvme@lists.infradead.org, kbusch@kernel.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com
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

swiotlb_tbl_map_single currently nevers sets a tlb_addr that is not
aligned to the tlb bucket size.  But we're going to add such a case
soon, for which this adjustment would be bogus.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/swiotlb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index e78615e3be2906..6a2439826a1ba4 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -658,7 +658,6 @@ void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
 
 	if (orig_addr == INVALID_PHYS_ADDR)
 		return;
-	orig_addr += (unsigned long)tlb_addr & ((1 << IO_TLB_SHIFT) - 1);
 
 	switch (target) {
 	case SYNC_FOR_CPU:
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
