Return-Path: <SRS0=s4mY=HE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3E0C433DB
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 09:51:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6283264DDB
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 09:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6283264DDB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 334C185868;
	Tue,  2 Feb 2021 09:51:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P408DZ70fxce; Tue,  2 Feb 2021 09:51:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B07F88593F;
	Tue,  2 Feb 2021 09:51:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABA1CC0174;
	Tue,  2 Feb 2021 09:51:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80886C0FA8
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 09:51:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6F198866C3
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 09:51:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TnhIsdOevJtu for <iommu@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 09:51:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7553F865FC
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 09:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=1V/H+mhD3tcZ52EzqPv1oWFhuvy8mDMctNaFk3Uutdw=; b=gGLVzoVsVpQF946JOL/QCPFHJJ
 P6cyFN8qSNoSjsA6F5aRwdB+GLJ2vH/wtkakDEp24xS4Uwf2koPsHiathaxKdiW3D5CJadk4FwdZS
 T4Se8WfT0ZFWzmuIjESOxVtyJNWVtLNtmkleqSQamPvc0a7/1JC44VbG1maSq0WjR0sktj2kEnAfU
 1MYpLKVAENwq4Irw50ZuwtPtZc3vtez7C5E9xocfeTcbdFYrf9VsuhQA0MSE4W21bVsP31ODFAJ2M
 awVKW/C8GmxlcWQsX1A7yhB3C5kq7yxcuqi5up8kOgt0nbpFdnwQVZax2+j74iZ7Uv8G8iprQ89pS
 EQXwku4w==;
Received: from [2001:4bb8:198:6bf4:7f38:755e:a6e0:73e9] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l6sLL-00F0xY-4H; Tue, 02 Feb 2021 09:51:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Tomasz Figa <tfiga@chromium.org>, Ricardo Ribalda <ribalda@chromium.org>,
 Sergey Senozhatsky <senozhatsky@google.com>,
 iommu@lists.linux-foundation.org
Subject: [PATCH 6/7] dma-iommu: implement ->alloc_noncontiguous
Date: Tue,  2 Feb 2021 10:51:09 +0100
Message-Id: <20210202095110.1215346-7-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210202095110.1215346-1-hch@lst.de>
References: <20210202095110.1215346-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-media@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
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

Implement support for allocating a non-contiguous DMA region.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 85cb004d7a44c6..4e0b170d38d57a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -718,6 +718,7 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
 		goto out_free_sg;
 
 	sgt->sgl->dma_address = iova;
+	sgt->sgl->dma_length = size;
 	return pages;
 
 out_free_sg:
@@ -755,6 +756,36 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
 	return NULL;
 }
 
+#ifdef CONFIG_DMA_REMAP
+static struct sg_table *iommu_dma_alloc_noncontiguous(struct device *dev,
+		size_t size, enum dma_data_direction dir, gfp_t gfp)
+{
+	struct dma_sgt_handle *sh;
+
+	sh = kmalloc(sizeof(*sh), gfp);
+	if (!sh)
+		return NULL;
+
+	sh->pages = __iommu_dma_alloc_noncontiguous(dev, size, &sh->sgt, gfp,
+						    PAGE_KERNEL, 0);
+	if (!sh->pages) {
+		kfree(sh);
+		return NULL;
+	}
+	return &sh->sgt;
+}
+
+static void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
+		struct sg_table *sgt, enum dma_data_direction dir)
+{
+	struct dma_sgt_handle *sh = sgt_handle(sgt);
+
+	__iommu_dma_unmap(dev, sgt->sgl->dma_address, size);
+	__iommu_dma_free_pages(sh->pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
+	sg_free_table(&sh->sgt);
+}
+#endif /* CONFIG_DMA_REMAP */
+
 static void iommu_dma_sync_single_for_cpu(struct device *dev,
 		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
 {
@@ -1270,6 +1301,10 @@ static const struct dma_map_ops iommu_dma_ops = {
 	.free			= iommu_dma_free,
 	.alloc_pages		= dma_common_alloc_pages,
 	.free_pages		= dma_common_free_pages,
+#ifdef CONFIG_DMA_REMAP
+	.alloc_noncontiguous	= iommu_dma_alloc_noncontiguous,
+	.free_noncontiguous	= iommu_dma_free_noncontiguous,
+#endif
 	.mmap			= iommu_dma_mmap,
 	.get_sgtable		= iommu_dma_get_sgtable,
 	.map_page		= iommu_dma_map_page,
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
