Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A528CC4727F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 08:56:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11DF720738
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 08:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ur7y8KKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DF720738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D44528721E;
	Wed, 30 Sep 2020 08:56:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qb4uxGDGMqcY; Wed, 30 Sep 2020 08:56:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4CCDA86FFB;
	Wed, 30 Sep 2020 08:56:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E881C0890;
	Wed, 30 Sep 2020 08:56:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 759D0C016F
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:56:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4346685F45
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:56:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EseAz8JqjjGI for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 08:56:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8619485F32
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=7wlocwmYpV53gq2F4Jsvj5msvlzhpCuIuqnDE5DhBvk=; b=Ur7y8KKe3cjA7e0c1Ea7QqV9r0
 vY6VIBz2QcoRLJe9lf7uVRs2DNjFyCceMqUuaJygZTMw/RtSXGJbPOPzNAzKNsJ1k73ddTiasezFZ
 d0hr/6pxdWLxOh5G5wi2tXE5PItFpNtOtmzrOATkrGIFj+CSQRKxjTQP+80GSwnqfxLRzI5GIQM7t
 K+UXTWNBUwSNRxuZWs4qixxTrx0/+tQCjZOLhctLfzeUlYLst+FOknUyqNZ8n7HjsVmTEyGAD7Iid
 mBbuQ58px4mSIIt4V5A5liJNpP0MRtl24PqVZybE6L48rdfFCi+v4WRhR7c4l8YwN7EX093oOyrEQ
 MiD31FuA==;
Received: from [2001:4bb8:180:7b62:c70:4a89:bc61:4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNXu2-0003sf-CF; Wed, 30 Sep 2020 08:55:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 4/9] dma-contiguous: remove dma_contiguous_set_default
Date: Wed, 30 Sep 2020 10:55:43 +0200
Message-Id: <20200930085548.920261-5-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930085548.920261-1-hch@lst.de>
References: <20200930085548.920261-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-arch@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

dma_contiguous_set_default contains a trivial assignment, and has a
single caller that is compiled if CONFIG_CMA_DMA is enabled.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-contiguous.h | 7 -------
 kernel/dma/contiguous.c        | 2 +-
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
index 41ec08d81bc317..f9ce1ee58d4180 100644
--- a/include/linux/dma-contiguous.h
+++ b/include/linux/dma-contiguous.h
@@ -66,11 +66,6 @@ static inline struct cma *dev_get_cma_area(struct device *dev)
 	return dma_contiguous_default_area;
 }
 
-static inline void dma_contiguous_set_default(struct cma *cma)
-{
-	dma_contiguous_default_area = cma;
-}
-
 void dma_contiguous_reserve(phys_addr_t addr_limit);
 
 int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
@@ -91,8 +86,6 @@ static inline struct cma *dev_get_cma_area(struct device *dev)
 	return NULL;
 }
 
-static inline void dma_contiguous_set_default(struct cma *cma) { }
-
 static inline void dma_contiguous_reserve(phys_addr_t limit) { }
 
 static inline int dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 95adcee972e85c..bf05ec2256e149 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -407,7 +407,7 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 	dma_contiguous_early_fixup(rmem->base, rmem->size);
 
 	if (default_cma)
-		dma_contiguous_set_default(cma);
+		dma_contiguous_default_area = cma;
 
 	rmem->ops = &rmem_cma_ops;
 	rmem->priv = cma;
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
