Return-Path: <SRS0=Fdbd=H7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEFFC433E0
	for <iommu@archiver.kernel.org>; Mon,  1 Mar 2021 08:55:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E34564DF2
	for <iommu@archiver.kernel.org>; Mon,  1 Mar 2021 08:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E34564DF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 015CB4F2AC;
	Mon,  1 Mar 2021 08:55:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ifK8AA9nk3KT; Mon,  1 Mar 2021 08:55:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0EF84F2AB;
	Mon,  1 Mar 2021 08:55:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CB6EC000A;
	Mon,  1 Mar 2021 08:55:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A57DC0001
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 08:55:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5C2F04304D
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 08:55:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zJ9e6kPj3jJ0 for <iommu@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 08:55:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B5C7D43021
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 08:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=FpiyQH/WZsneXAYudL4P437T+laVaJ1w/DKPG1+Xs5M=; b=knEBVjSJ6l72ReR9UB3FsNA6Qa
 WEIhkOFFDmsvaRLMNiUoiQCu11eTBvxaWZRnD3KGRsnqQDR82Ts1jcNN7dpkPuXE0twmcRr20npyU
 ut3zAR45gcey0R7fAHp5aMIIA2rD+zdT8uyZuhcP8Ni8Zcb/gvBOfomMJdJjA9HD8bfW2uL6l0x6V
 GlYvqeYXyHav7NIaElgDSh/Eg9Pjs6lRBO4600cTM9oePUHgwub232EwQNH7xeRFr7w5Cx+gcVIj6
 8SbPTHMXXkFR3UJqaC4zxL/UFeus3e9F0IPAZ1di4q9L9lILrP4FJWIEcrQivZSEex76JQHc524Cm
 N85UdDUw==;
Received: from [2001:4bb8:19b:e4b7:cdf9:733f:4874:8eb4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lGeKM-00FVT4-3x; Mon, 01 Mar 2021 08:54:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Tomasz Figa <tfiga@chromium.org>, Ricardo Ribalda <ribalda@chromium.org>,
 Sergey Senozhatsky <senozhatsky@google.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 iommu@lists.linux-foundation.org
Subject: [PATCH 5/6] dma-iommu: implement ->alloc_noncontiguous
Date: Mon,  1 Mar 2021 09:52:35 +0100
Message-Id: <20210301085236.947011-6-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210301085236.947011-1-hch@lst.de>
References: <20210301085236.947011-1-hch@lst.de>
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
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Tested-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/iommu/dma-iommu.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index b4d7bfffb3a0d2..714fa930d7b576 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -707,6 +707,7 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
 		goto out_free_sg;
 
 	sgt->sgl->dma_address = iova;
+	sgt->sgl->dma_length = size;
 	return pages;
 
 out_free_sg:
@@ -744,6 +745,37 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
 	return NULL;
 }
 
+#ifdef CONFIG_DMA_REMAP
+static struct sg_table *iommu_dma_alloc_noncontiguous(struct device *dev,
+		size_t size, enum dma_data_direction dir, gfp_t gfp,
+		unsigned long attrs)
+{
+	struct dma_sgt_handle *sh;
+
+	sh = kmalloc(sizeof(*sh), gfp);
+	if (!sh)
+		return NULL;
+
+	sh->pages = __iommu_dma_alloc_noncontiguous(dev, size, &sh->sgt, gfp,
+						    PAGE_KERNEL, attrs);
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
@@ -1260,6 +1292,10 @@ static const struct dma_map_ops iommu_dma_ops = {
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
