Return-Path: <SRS0=C6HT=CX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2A8C43461
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 15:22:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C81B20829
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 15:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fTgqNs7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C81B20829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BB99C87226;
	Mon, 14 Sep 2020 15:22:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LhpyWQ+rG3Yj; Mon, 14 Sep 2020 15:22:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2DC2C87085;
	Mon, 14 Sep 2020 15:22:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F29C7C088B;
	Mon, 14 Sep 2020 15:22:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 872CAC0859
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 15:22:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7982020439
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 15:22:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kt6+ag1dsM3T for <iommu@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 15:22:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by silver.osuosl.org (Postfix) with ESMTPS id 4BA2920343
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 15:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=Y4Zt5Q6wslvCqwY7SHiicX4jOFlI8lEV5uqNCn2aPDc=; b=fTgqNs7c5EBijS2DP4edBbpLiN
 UGpXgXxgKbOHvPtwrOPu7ImJF2b75wXAG9Ku78wGkkG+v9lQ52Ag5nH3dgiq1KbDywwk/Cvz9cWlz
 BWaYfAMBLusX9aAaVmab+mQOqO79KCe+tL8S3vj3Syqps+xM10G9m/5bhIdXt+4N1H1yzP5SG5J5w
 kBKy+xzJMzB3KmsCgnheH/cpg4h9kXXBM5qYBU1BB1FdRAaw2nV8HDKSmVkgImXmpVHSCJDLlqvuO
 6qxzqCVTtZLsXZBSL0TL8FCYo/qDJBfT1w7a2NSNAytKj2HEeiiFChC1P/u5ePX5K/mR6pNNrOoyz
 vjw6Ynrg==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHqIf-0004Dp-GN; Mon, 14 Sep 2020 15:21:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Joonyoung Shim <jy0922.shim@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, Ben Skeggs <bskeggs@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Tomasz Figa <tfiga@chromium.org>,
 Matt Porter <mporter@kernel.crashing.org>, iommu@lists.linux-foundation.org
Subject: [PATCH 16/17] dma-iommu: implement ->alloc_noncoherent
Date: Mon, 14 Sep 2020 16:44:32 +0200
Message-Id: <20200914144433.1622958-17-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200914144433.1622958-1-hch@lst.de>
References: <20200914144433.1622958-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-doc@vger.kernel.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org,
 Stefan Richter <stefanr@s5r6.in-berlin.de>, netdev@vger.kernel.org,
 linux1394-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
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

Implement the alloc_noncoherent method to provide memory that is neither
coherent not contiguous.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 41 +++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 00a5b49248e334..c12c1dc43d312e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -572,6 +572,7 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
  * @size: Size of buffer in bytes
  * @dma_handle: Out argument for allocated DMA handle
  * @gfp: Allocation flags
+ * @prot: pgprot_t to use for the remapped mapping
  * @attrs: DMA attributes for this allocation
  *
  * If @size is less than PAGE_SIZE, then a full CPU page will be allocated,
@@ -580,14 +581,14 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
  * Return: Mapped virtual address, or NULL on failure.
  */
 static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+		dma_addr_t *dma_handle, gfp_t gfp, pgprot_t prot,
+		unsigned long attrs)
 {
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	bool coherent = dev_is_dma_coherent(dev);
 	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
-	pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
 	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
 	struct page **pages;
 	struct sg_table sgt;
@@ -1030,8 +1031,10 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	gfp |= __GFP_ZERO;
 
 	if (IS_ENABLED(CONFIG_DMA_REMAP) && gfpflags_allow_blocking(gfp) &&
-	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
-		return iommu_dma_alloc_remap(dev, size, handle, gfp, attrs);
+	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS)) {
+		return iommu_dma_alloc_remap(dev, size, handle, gfp,
+				dma_pgprot(dev, PAGE_KERNEL, attrs), attrs);
+	}
 
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
 	    !gfpflags_allow_blocking(gfp) && !coherent)
@@ -1052,6 +1055,34 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	return cpu_addr;
 }
 
+#ifdef CONFIG_DMA_REMAP
+static void *iommu_dma_alloc_noncoherent(struct device *dev, size_t size,
+		dma_addr_t *handle, enum dma_data_direction dir, gfp_t gfp)
+{
+	if (!gfpflags_allow_blocking(gfp)) {
+		struct page *page;
+
+		page = dma_common_alloc_pages(dev, size, handle, dir, gfp);
+		if (!page)
+			return NULL;
+		return page_address(page);
+	}
+
+	return iommu_dma_alloc_remap(dev, size, handle, gfp | __GFP_ZERO,
+				     PAGE_KERNEL, 0);
+}
+
+static void iommu_dma_free_noncoherent(struct device *dev, size_t size,
+		void *cpu_addr, dma_addr_t handle, enum dma_data_direction dir)
+{
+	__iommu_dma_unmap(dev, handle, size);
+	__iommu_dma_free(dev, size, cpu_addr);
+}
+#else
+#define iommu_dma_alloc_noncoherent		NULL
+#define iommu_dma_free_noncoherent		NULL
+#endif /* CONFIG_DMA_REMAP */
+
 static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs)
@@ -1122,6 +1153,8 @@ static const struct dma_map_ops iommu_dma_ops = {
 	.free			= iommu_dma_free,
 	.alloc_pages		= dma_common_alloc_pages,
 	.free_pages		= dma_common_free_pages,
+	.alloc_noncoherent	= iommu_dma_alloc_noncoherent,
+	.free_noncoherent	= iommu_dma_free_noncoherent,
 	.mmap			= iommu_dma_mmap,
 	.get_sgtable		= iommu_dma_get_sgtable,
 	.map_page		= iommu_dma_map_page,
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
