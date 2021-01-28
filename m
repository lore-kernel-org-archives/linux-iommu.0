Return-Path: <SRS0=9w/B=G7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38A7C433DB
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 15:03:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A514B64DE0
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 15:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A514B64DE0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5A54185DF2;
	Thu, 28 Jan 2021 15:03:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s3bsDoh-tKdE; Thu, 28 Jan 2021 15:03:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B98BC86879;
	Thu, 28 Jan 2021 15:03:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B714C1825;
	Thu, 28 Jan 2021 15:03:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A506C0FA8
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 15:03:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7538F2E0F7
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 15:03:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7+6IQZnvwocS for <iommu@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 15:03:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by silver.osuosl.org (Postfix) with ESMTPS id 6423A2E0F6
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 15:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=V9Mg8tXW0rNlZuOFD1i/bt5R8THD0IcaaC9lFgbmReU=; b=SUDWHoqs/u+HfYA9otWMGiEnmB
 XnxFdgujo+RxjKGbRnKsCXQ3r6kJh0lKp0nb1nFs6yhwpQ2iBbxeZhQuCy4CA+GMfx81WcdJniwI/
 Bz6ozDlsv1lj91VWNuKHd2Wol66E0DBC46C08+kEhS72E640bb5fqwvkLV4iurgENbpi4pgfwfruc
 irRyGUPUXwaQp5RgAwZYu44Wdyt5G4Zbimr+UoX9l9l7/wQcFBszCYe8Klt7M+jYgY7rroYb4dAO+
 RzAGgrTCjnw30P57qAS15oPNe6BLrufJxnB0wcNxQ0AlCl49qaTynGc6Ix+4YzbW73RVhPB8zFcjz
 evjU9SkQ==;
Received: from [2001:4bb8:18c:25a3:5b32:95f:aa1f:ea4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l58p8-008bKo-Ny; Thu, 28 Jan 2021 15:03:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Tomasz Figa <tfiga@chromium.org>, Ricardo Ribalda <ribalda@chromium.org>,
 Sergey Senozhatsky <senozhatsky@google.com>,
 iommu@lists.linux-foundation.org
Subject: [PATCH 2/6] dma-mapping: add a dma_mmap_pages helper
Date: Thu, 28 Jan 2021 15:58:33 +0100
Message-Id: <20210128145837.2250561-3-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128145837.2250561-1-hch@lst.de>
References: <20210128145837.2250561-1-hch@lst.de>
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
index fbfa3f5abd9498..4977a748cb9483 100644
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
index 68992e35c8c3a7..c1e515496c067b 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -515,6 +515,19 @@ void dma_free_pages(struct device *dev, size_t size, struct page *page,
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
