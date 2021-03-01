Return-Path: <SRS0=Fdbd=H7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EFFC433DB
	for <iommu@archiver.kernel.org>; Mon,  1 Mar 2021 08:53:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E4CE64DF5
	for <iommu@archiver.kernel.org>; Mon,  1 Mar 2021 08:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4CE64DF5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 379124F2AB;
	Mon,  1 Mar 2021 08:53:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SlHTluT4JxRP; Mon,  1 Mar 2021 08:53:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id B17F74F2AA;
	Mon,  1 Mar 2021 08:53:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D5A5C000A;
	Mon,  1 Mar 2021 08:53:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F5A0C0001
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 08:53:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8C0EE43047
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 08:53:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KssXu1_M7cMR for <iommu@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 08:53:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CDD3243021
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 08:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=J1KHVQd7KIKA4eutBclaxDE2iy2Glo4eu+2ejZioyaQ=; b=vzWa2E0TktPPujc2OKk4KpSe7L
 f5AGhX4tGFsXwRelNHe541ktMZg0gUWgjM8CeUmJvj9s+UTWLHgxgHTcB2OLCCxUC6isRrXEXEJ+U
 WQMAqccxtJfH4SQznEiSmemCnFgV9E0+ezk3No2VovvhdDcypCIXXoyX4BZXzJ+VhAsB7EID283pp
 g1R6UPp+u5g6oPKRxLC0Rh1fio7D79UF5jNdpB/Cb7VX+x3ueOk+8NFXUF2rGX1hfWKeIuRbn5fAi
 dKPXDXwuk+oOVTdQMWzCeKmG73Z4NgjjVUJbz3Eq37oNqm4XLpp8HUxvzrH2r4X9W67B940aJ2P8u
 rgbjfMug==;
Received: from [2001:4bb8:19b:e4b7:cdf9:733f:4874:8eb4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lGeIN-00FVG1-Ro; Mon, 01 Mar 2021 08:52:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Tomasz Figa <tfiga@chromium.org>, Ricardo Ribalda <ribalda@chromium.org>,
 Sergey Senozhatsky <senozhatsky@google.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 iommu@lists.linux-foundation.org
Subject: [PATCH 1/6] dma-mapping: add a dma_mmap_pages helper
Date: Mon,  1 Mar 2021 09:52:31 +0100
Message-Id: <20210301085236.947011-2-hch@lst.de>
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

Add a helper to map memory allocated using dma_alloc_pages into
a user address space, similar to the dma_alloc_attrs function for
coherent allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Tested-by: Ricardo Ribalda <ribalda@chromium.org>
---
 Documentation/core-api/dma-api.rst | 10 ++++++++++
 include/linux/dma-mapping.h        |  2 ++
 kernel/dma/mapping.c               | 13 +++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
index e6d23f117308df..157a474ae54416 100644
--- a/Documentation/core-api/dma-api.rst
+++ b/Documentation/core-api/dma-api.rst
@@ -563,6 +563,16 @@ Free a region of memory previously allocated using dma_alloc_pages().
 dev, size, dma_handle and dir must all be the same as those passed into
 dma_alloc_pages().  page must be the pointer returned by dma_alloc_pages().
 
+::
+
+	int
+	dma_mmap_pages(struct device *dev, struct vm_area_struct *vma,
+		       size_t size, struct page *page)
+
+Map an allocation returned from dma_alloc_pages() into a user address space.
+dev and size must be the same as those passed into dma_alloc_pages().
+page must be the pointer returned by dma_alloc_pages().
+
 ::
 
 	void *
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 2a984cb4d1e037..2b8dce756e1fa1 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -263,6 +263,8 @@ struct page *dma_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp);
 void dma_free_pages(struct device *dev, size_t size, struct page *page,
 		dma_addr_t dma_handle, enum dma_data_direction dir);
+int dma_mmap_pages(struct device *dev, struct vm_area_struct *vma,
+		size_t size, struct page *page);
 
 static inline void *dma_alloc_noncoherent(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index b6a63367993328..9ce86c77651c6f 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -517,6 +517,19 @@ void dma_free_pages(struct device *dev, size_t size, struct page *page,
 }
 EXPORT_SYMBOL_GPL(dma_free_pages);
 
+int dma_mmap_pages(struct device *dev, struct vm_area_struct *vma,
+		size_t size, struct page *page)
+{
+	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+
+	if (vma->vm_pgoff >= count || vma_pages(vma) > count - vma->vm_pgoff)
+		return -ENXIO;
+	return remap_pfn_range(vma, vma->vm_start,
+			       page_to_pfn(page) + vma->vm_pgoff,
+			       vma_pages(vma) << PAGE_SHIFT, vma->vm_page_prot);
+}
+EXPORT_SYMBOL_GPL(dma_mmap_pages);
+
 int dma_supported(struct device *dev, u64 mask)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
