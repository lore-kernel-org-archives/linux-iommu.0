Return-Path: <SRS0=Kg+4=TA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACD7C04AA8
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 10:54:48 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5969221670
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 10:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lFkIBA1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5969221670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0B9F4FA4;
	Tue, 30 Apr 2019 10:53:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 20F3CF09
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 10:53:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id ACF1F5F4
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 10:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=M6fFr4ykwzfclekn4F4y+EAuHbNiGlpDK1CBEkIwimk=;
	b=lFkIBA1UAMus+qnF5KxWh61iAO
	DemPJ3df1/uFYr1Oj57bYXJYjYV6d8l39knuzoIq1wn8wSqZZo5XPJH6Zo2i/od0xgkfvD5FYVn2Z
	AOFFY5LmZX2RiVXvXwrFTVmyW66IaBWvH+w7tZAcOTzQnwgki9KI8urvZ5dUNXcvevQU8HYMD6upb
	EUehEHB88XoNMzDIwgzhoPKCMsu5OhfEacAokZNi7RbCdeBScq03JGjn3XMXNQQC89uBqoc+bTyQ+
	GJXfnFnAjnTRON/eIJqQI6HOKQasUYwsoo2CNaFokQUzG+HJLRim516xu5z8x7gwLlHu9P6LxUrwe
	wgNoqKBA==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hLQNm-0007ie-Rj; Tue, 30 Apr 2019 10:53:07 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 10/25] iommu/dma: Factor out remapped pages lookup
Date: Tue, 30 Apr 2019 06:51:59 -0400
Message-Id: <20190430105214.24628-11-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430105214.24628-1-hch@lst.de>
References: <20190430105214.24628-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190430105159.M5jZddFZ-2JmXtZmJJPJ2qlOxHDWB7dwJil-JNfvVwM@z>

From: Robin Murphy <robin.murphy@arm.com>

Since we duplicate the find_vm_area() logic a few times in places where
we only care aboute the pages, factor out a helper to abstract it.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
[hch: don't warn when not finding a region, as we'll rely on that later]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 82fb208017fb..84fe9a9eb0bb 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -525,6 +525,15 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 	return pages;
 }
 
+static struct page **__iommu_dma_get_pages(void *cpu_addr)
+{
+	struct vm_struct *area = find_vm_area(cpu_addr);
+
+	if (!area || !area->pages)
+		return NULL;
+	return area->pages;
+}
+
 /**
  * iommu_dma_free - Free a buffer allocated by __iommu_dma_alloc()
  * @dev: Device which owns this buffer
@@ -1023,11 +1032,11 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 		dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
 		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
 	} else if (is_vmalloc_addr(cpu_addr)){
-		struct vm_struct *area = find_vm_area(cpu_addr);
+		struct page **pages = __iommu_dma_get_pages(cpu_addr);
 
-		if (WARN_ON(!area || !area->pages))
+		if (!pages)
 			return;
-		__iommu_dma_free(dev, area->pages, iosize, &handle);
+		__iommu_dma_free(dev, pages, iosize, &handle);
 		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
 	} else {
 		__iommu_dma_unmap(dev, handle, iosize);
@@ -1059,7 +1068,7 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 {
 	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long off = vma->vm_pgoff;
-	struct vm_struct *area;
+	struct page **pages;
 	int ret;
 
 	vma->vm_page_prot = arch_dma_mmap_pgprot(dev, vma->vm_page_prot, attrs);
@@ -1084,11 +1093,10 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		return __iommu_dma_mmap_pfn(vma, pfn, size);
 	}
 
-	area = find_vm_area(cpu_addr);
-	if (WARN_ON(!area || !area->pages))
+	pages = __iommu_dma_get_pages(cpu_addr);
+	if (!pages)
 		return -ENXIO;
-
-	return __iommu_dma_mmap(area->pages, size, vma);
+	return __iommu_dma_mmap(pages, size, vma);
 }
 
 static int __iommu_dma_get_sgtable_page(struct sg_table *sgt, struct page *page,
@@ -1106,7 +1114,7 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 		unsigned long attrs)
 {
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	struct vm_struct *area = find_vm_area(cpu_addr);
+	struct page **pages;
 
 	if (!is_vmalloc_addr(cpu_addr)) {
 		struct page *page = virt_to_page(cpu_addr);
@@ -1122,10 +1130,10 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 		return __iommu_dma_get_sgtable_page(sgt, page, size);
 	}
 
-	if (WARN_ON(!area || !area->pages))
+	pages = __iommu_dma_get_pages(cpu_addr);
+	if (!pages)
 		return -ENXIO;
-
-	return sg_alloc_table_from_pages(sgt, area->pages, count, 0, size,
+	return sg_alloc_table_from_pages(sgt, pages, count, 0, size,
 					 GFP_KERNEL);
 }
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
