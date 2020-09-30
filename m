Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D5FC47420
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 08:56:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DB4420659
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 08:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dFDx5ZNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB4420659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CD6932202C;
	Wed, 30 Sep 2020 08:56:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v-KDPz1iMfgd; Wed, 30 Sep 2020 08:56:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id AD1AE20445;
	Wed, 30 Sep 2020 08:56:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B76DC1AD7;
	Wed, 30 Sep 2020 08:56:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 254C3C016F
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:55:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 07889203D0
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:55:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oGvLOyn8UVD7 for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 08:55:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by silver.osuosl.org (Postfix) with ESMTPS id 63EDF20400
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=uoDyUocMuxzXBw/J3MbtQm99bSltpvYBdHObApmUBIs=; b=dFDx5ZNML+cWYXkIEd6M5bUEy8
 Ar5BHcfB6+dtOGD1wBQRyRAmE2iye02HQKfsdJJfgTOpYowgxuLIxmfM81z2HFg7z31W3toGzdsFw
 f/BScPfOqNIVdPt5GaLNORtSWW8k+e6xjfk7NoGOVGHyw3OqpC7jKOOf6ESTy4K0cgvWv/GPSbe8e
 ZMvexOaWThxdFvgc6sKB4h5+gyp7VLAC7+6NM6awEfX5YZ65ld9mVVIg6hqMD3+Pp3PhLZgH4A75W
 FTw9f8kDlC7dT408D7eY1r+Tw23zX0oMM9g3+slkfbQxiXQpBl5oCf7h3iXw/PQk6zieqGG4wEESw
 +heP/yKQ==;
Received: from [2001:4bb8:180:7b62:c70:4a89:bc61:4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNXtz-0003sE-2r; Wed, 30 Sep 2020 08:55:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 2/9] dma-contiguous: remove dma_declare_contiguous
Date: Wed, 30 Sep 2020 10:55:41 +0200
Message-Id: <20200930085548.920261-3-hch@lst.de>
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

dma_declare_contiguous is a trivial wrapper around
dma_contiguous_reserve_area and just has a single caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mach-davinci/devices-da8xx.c | 16 +++++++++-----
 include/linux/dma-contiguous.h        | 32 ---------------------------
 2 files changed, 10 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index feb206bdf6e172..2e2853582b459e 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -884,6 +884,7 @@ early_param("rproc_mem", early_rproc_mem);
 
 void __init da8xx_rproc_reserve_cma(void)
 {
+	struct cma *cma;
 	int ret;
 
 	if (!rproc_base || !rproc_size) {
@@ -897,13 +898,16 @@ void __init da8xx_rproc_reserve_cma(void)
 	pr_info("%s: reserving 0x%lx @ 0x%lx...\n",
 		__func__, rproc_size, (unsigned long)rproc_base);
 
-	ret = dma_declare_contiguous(&da8xx_dsp.dev, rproc_size, rproc_base, 0);
-	if (ret)
-		pr_err("%s: dma_declare_contiguous failed %d\n", __func__, ret);
-	else
-		rproc_mem_inited = true;
+	ret = dma_contiguous_reserve_area(rproc_size, rproc_base, 0, &cma,
+			true);
+	if (ret) {
+		pr_err("%s: dma_contiguous_reserve_area failed %d\n",
+			__func__, ret);
+		return;
+	}
+	dev_set_cma_area(&da8xx_dsp.dev, cma);
+	rproc_mem_inited = true;
 }
-
 #else
 
 void __init da8xx_rproc_reserve_cma(void)
diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
index fe55e004f1f433..62fd55d0723546 100644
--- a/include/linux/dma-contiguous.h
+++ b/include/linux/dma-contiguous.h
@@ -83,31 +83,6 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
 				       phys_addr_t limit, struct cma **res_cma,
 				       bool fixed);
 
-/**
- * dma_declare_contiguous() - reserve area for contiguous memory handling
- *			      for particular device
- * @dev:   Pointer to device structure.
- * @size:  Size of the reserved memory.
- * @base:  Start address of the reserved memory (optional, 0 for any).
- * @limit: End address of the reserved memory (optional, 0 for any).
- *
- * This function reserves memory for specified device. It should be
- * called by board specific code when early allocator (memblock or bootmem)
- * is still activate.
- */
-
-static inline int dma_declare_contiguous(struct device *dev, phys_addr_t size,
-					 phys_addr_t base, phys_addr_t limit)
-{
-	struct cma *cma;
-	int ret;
-	ret = dma_contiguous_reserve_area(size, base, limit, &cma, true);
-	if (ret == 0)
-		dev_set_cma_area(dev, cma);
-
-	return ret;
-}
-
 struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
 				       unsigned int order, bool no_warn);
 bool dma_release_from_contiguous(struct device *dev, struct page *pages,
@@ -135,13 +110,6 @@ static inline int dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base
 	return -ENOSYS;
 }
 
-static inline
-int dma_declare_contiguous(struct device *dev, phys_addr_t size,
-			   phys_addr_t base, phys_addr_t limit)
-{
-	return -ENOSYS;
-}
-
 static inline
 struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
 				       unsigned int order, bool no_warn)
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
