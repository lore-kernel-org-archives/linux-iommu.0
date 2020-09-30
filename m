Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E2EC4741F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 08:56:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CED62076B
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 08:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PZTmJCKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CED62076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3E062203D0;
	Wed, 30 Sep 2020 08:56:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YIg+ekwYImPT; Wed, 30 Sep 2020 08:56:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1254F21FA9;
	Wed, 30 Sep 2020 08:56:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F32D1C0890;
	Wed, 30 Sep 2020 08:56:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5936EC1AD6
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:56:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 29B08203D0
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:56:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p2m2dsWnJ41I for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 08:55:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by silver.osuosl.org (Postfix) with ESMTPS id 1D72A20445
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=FfdHYeDTXhoYO7qCBmRlpvBIzEFqBt+3svzGl87S3x8=; b=PZTmJCKijrz58G/RG2MqzXGL/l
 olVALkl3XpDvDm+bNdqRHm/MtEDq2iMIwNKD6VJBzlMeGghnezkcE+6TEZ1VYVsca8mN2KeCerq28
 aBu6FBeZWZ72xCtrD8CpFDvjTWOv8Ydr/SMMhdFYQ7Ff1PJQUhXopL/AWUGOB+ezasg+qz+dm6vG1
 dUdK6SOxuscB000wVcJejnpRS6fJ7e99+fhXANHIgnSihBPpdi0V/qFRM/sqT/CI+VGPpEl74GR5q
 JrHqaasZKrbNuE98xnDDZbmapQPSjYEMb7ThNShXS96WvIw5i9aS7fPtTAw4w1olvLFnwyVhw4HuQ
 ux7qCDxA==;
Received: from [2001:4bb8:180:7b62:c70:4a89:bc61:4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNXu0-0003sL-NR; Wed, 30 Sep 2020 08:55:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 3/9] dma-contiguous: remove dev_set_cma_area
Date: Wed, 30 Sep 2020 10:55:42 +0200
Message-Id: <20200930085548.920261-4-hch@lst.de>
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

dev_set_cma_area contains a trivial assignment.  It has just three
callers that all have a non-NULL device and depend on CONFIG_DMA_CMA,
so remove the wrapper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mach-davinci/devices-da8xx.c | 2 +-
 include/linux/dma-contiguous.h        | 8 --------
 kernel/dma/contiguous.c               | 4 ++--
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 2e2853582b459e..1207eabe8d1cc4 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -905,7 +905,7 @@ void __init da8xx_rproc_reserve_cma(void)
 			__func__, ret);
 		return;
 	}
-	dev_set_cma_area(&da8xx_dsp.dev, cma);
+	da8xx_dsp.dev.cma_area = cma;
 	rproc_mem_inited = true;
 }
 #else
diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
index 62fd55d0723546..41ec08d81bc317 100644
--- a/include/linux/dma-contiguous.h
+++ b/include/linux/dma-contiguous.h
@@ -66,12 +66,6 @@ static inline struct cma *dev_get_cma_area(struct device *dev)
 	return dma_contiguous_default_area;
 }
 
-static inline void dev_set_cma_area(struct device *dev, struct cma *cma)
-{
-	if (dev)
-		dev->cma_area = cma;
-}
-
 static inline void dma_contiguous_set_default(struct cma *cma)
 {
 	dma_contiguous_default_area = cma;
@@ -97,8 +91,6 @@ static inline struct cma *dev_get_cma_area(struct device *dev)
 	return NULL;
 }
 
-static inline void dev_set_cma_area(struct device *dev, struct cma *cma) { }
-
 static inline void dma_contiguous_set_default(struct cma *cma) { }
 
 static inline void dma_contiguous_reserve(phys_addr_t limit) { }
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index f4c150810fd25c..95adcee972e85c 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -359,14 +359,14 @@ void dma_free_contiguous(struct device *dev, struct page *page, size_t size)
 
 static int rmem_cma_device_init(struct reserved_mem *rmem, struct device *dev)
 {
-	dev_set_cma_area(dev, rmem->priv);
+	dev->cma_area = rmem->priv;
 	return 0;
 }
 
 static void rmem_cma_device_release(struct reserved_mem *rmem,
 				    struct device *dev)
 {
-	dev_set_cma_area(dev, NULL);
+	dev->cma_area = NULL;
 }
 
 static const struct reserved_mem_ops rmem_cma_ops = {
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
