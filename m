Return-Path: <SRS0=Kg+4=TA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C01C43219
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 10:55:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9071121670
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 10:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ze2rYAAE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9071121670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E6234FCB;
	Tue, 30 Apr 2019 10:53:55 +0000 (UTC)
Received: from smtp2.linuxfoundation.org (smtp2.linux-foundation.org
	[172.17.192.36])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3AB34F22
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 10:53:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp2.linuxfoundation.org (Postfix) with ESMTPS id B95761DD62
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 10:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1vC6OhmYwyBBteAL2BIbuUfCVi9+xpE1H5x70o+8scQ=;
	b=Ze2rYAAEs9zDtI/bODz9LcN5xi
	cLkr/a5DIHuluOjZUvvRtjkWZPkGffPhL7LbUWtZ89bc6RC5J7xWgAQaWBjazoJdo1ghHqzM5JCU8
	BOV1VY54pniQ3uUWNL6pJmKodxMqGhVyPP9PJKq5n5UuRR/fuy2lo24h0p6cDnMZ+jXfA9slR84gw
	c2tHBwiYE6MhYRYbpk08k1SIv6FJJSw7gIV5Wwr+xCTiP4kIIbaOsimgT4StECKI4yAxgCWVmOAdq
	ZjrV0tLTCCqPGUZhQI8oVmZGUi4MPGZgcNZSXwqdz0IW11CPIUh9k0KbRsFuCQuAZwwh0CBAgyKHQ
	BSw9F6xA==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hLQNr-0007mA-13; Tue, 30 Apr 2019 10:53:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 13/25] iommu/dma: Refactor iommu_dma_free
Date: Tue, 30 Apr 2019 06:52:02 -0400
Message-Id: <20190430105214.24628-14-hch@lst.de>
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
Message-ID: <20190430105202.zEtmQ0r1-JIdHJ36XxwiX1jbuoH5q9zi_wrJfR8mWKQ@z>

From: Robin Murphy <robin.murphy@arm.com>

The freeing logic was made particularly horrible by part of it being
opaque to the arch wrapper, which led to a lot of convoluted repetition
to ensure each path did everything in the right order. Now that it's
all private, we can pick apart and consolidate the logically-distinct
steps of freeing the IOMMU mapping, the underlying pages, and the CPU
remap (if necessary) into something much more manageable.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
[various cosmetic changes to the code flow]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 73 ++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 25def31ade4d..f5c0e8cd3387 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -916,6 +916,39 @@ static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 	__iommu_dma_unmap(dev, handle, size);
 }
 
+static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
+		dma_addr_t handle, unsigned long attrs)
+{
+	size_t alloc_size = PAGE_ALIGN(size);
+	int count = alloc_size >> PAGE_SHIFT;
+	struct page *page = NULL, **pages = NULL;
+
+	__iommu_dma_unmap(dev, handle, size);
+
+	/* Non-coherent atomic allocation? Easy */
+	if (dma_free_from_pool(cpu_addr, alloc_size))
+		return;
+
+	if (is_vmalloc_addr(cpu_addr)) {
+		/*
+		 * If it the address is remapped, then it's either non-coherent
+		 * or highmem CMA, or an iommu_dma_alloc_remap() construction.
+		 */
+		pages = __iommu_dma_get_pages(cpu_addr);
+		if (!pages)
+			page = vmalloc_to_page(cpu_addr);
+		dma_common_free_remap(cpu_addr, alloc_size, VM_USERMAP);
+	} else {
+		/* Lowmem means a coherent atomic or CMA allocation */
+		page = virt_to_page(cpu_addr);
+	}
+
+	if (pages)
+		__iommu_dma_free_pages(pages, count);
+	if (page && !dma_release_from_contiguous(dev, page, count))
+		__free_pages(page, get_order(alloc_size));
+}
+
 static void *iommu_dma_alloc(struct device *dev, size_t size,
 		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
 {
@@ -985,46 +1018,6 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	return addr;
 }
 
-static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
-		dma_addr_t handle, unsigned long attrs)
-{
-	size_t iosize = size;
-
-	size = PAGE_ALIGN(size);
-	/*
-	 * @cpu_addr will be one of 4 things depending on how it was allocated:
-	 * - A remapped array of pages for contiguous allocations.
-	 * - A remapped array of pages from iommu_dma_alloc_remap(), for all
-	 *   non-atomic allocations.
-	 * - A non-cacheable alias from the atomic pool, for atomic
-	 *   allocations by non-coherent devices.
-	 * - A normal lowmem address, for atomic allocations by
-	 *   coherent devices.
-	 * Hence how dodgy the below logic looks...
-	 */
-	if (dma_in_atomic_pool(cpu_addr, size)) {
-		__iommu_dma_unmap(dev, handle, iosize);
-		dma_free_from_pool(cpu_addr, size);
-	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		struct page *page = vmalloc_to_page(cpu_addr);
-
-		__iommu_dma_unmap(dev, handle, iosize);
-		dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
-		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
-	} else if (is_vmalloc_addr(cpu_addr)){
-		struct page **pages = __iommu_dma_get_pages(cpu_addr);
-
-		if (!pages)
-			return;
-		__iommu_dma_unmap(dev, handle, iosize);
-		__iommu_dma_free_pages(pages, size >> PAGE_SHIFT);
-		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
-	} else {
-		__iommu_dma_unmap(dev, handle, iosize);
-		__free_pages(virt_to_page(cpu_addr), get_order(size));
-	}
-}
-
 static int __iommu_dma_mmap_pfn(struct vm_area_struct *vma,
 			      unsigned long pfn, size_t size)
 {
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
