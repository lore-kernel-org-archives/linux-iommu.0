Return-Path: <SRS0=kOFq=SY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E99C282E1
	for <iommu@archiver.kernel.org>; Mon, 22 Apr 2019 18:02:28 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6617820B1F
	for <iommu@archiver.kernel.org>; Mon, 22 Apr 2019 18:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YhJEalsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6617820B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 09608D8F;
	Mon, 22 Apr 2019 18:01:14 +0000 (UTC)
Received: from smtp2.linuxfoundation.org (smtp2.linux-foundation.org
	[172.17.192.36])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EA0F1D56
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Apr 2019 18:01:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp2.linuxfoundation.org (Postfix) with ESMTPS id B89991DD19
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Apr 2019 18:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=P4FAaIW8DgMN+q5PSJEzL/ZF/f2+w+9Z5hXu00tj3vQ=;
	b=YhJEalsfau+AJycLPlemT+Ms3d
	yFGYVS5OiHFl0ktpAHnQjjyRqNSXclI01+vwkxsq4LwqGShf9eXMVNbHf4j6QhO3fFo/+JEqpDe11
	PZhz0Jcg0cHof3SfYLFv4i3+XwGyVuyNtLSsGLRsXPBwMdaZMWMYUtkZcU6CFwX4OdVjec3hu9ZLq
	egsjDO8TdBCt8gRCBkeQDphal4ZIr9I/F0xMeMxDkmsEunJALo+3VjIASwZJewtBMOvlo/1H1qGBA
	OsZK8q98sdRbbYK4zYlyKy4otkJk23DrBeq4Er6ssyIhQxZHBz0mss0yCHqMXxfIGZ6wchQ6Y8bPi
	VKlSrRyg==;
Received: from 213-225-37-80.nat.highway.a1.net ([213.225.37.80]
	helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hIdFW-0002YB-SV; Mon, 22 Apr 2019 18:01:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 21/26] iommu/dma: Refactor iommu_dma_get_sgtable
Date: Mon, 22 Apr 2019 19:59:37 +0200
Message-Id: <20190422175942.18788-22-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190422175942.18788-1-hch@lst.de>
References: <20190422175942.18788-1-hch@lst.de>
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
Message-ID: <20190422175937.56SBqiqXEu-7cZjD5g1qL-kU5JKonxz0joHV8lDxi20@z>

Inline __iommu_dma_get_sgtable_page into the main function, and use the
fact that __iommu_dma_get_pages return NULL for remapped contigous
allocations to simplify the code flow a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 45 +++++++++++++++------------------------
 1 file changed, 17 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index acdfe866cb29..138b85e675c8 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1070,42 +1070,31 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	return __iommu_dma_mmap(pages, size, vma);
 }
 
-static int __iommu_dma_get_sgtable_page(struct sg_table *sgt, struct page *page,
-		size_t size)
-{
-	int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
-
-	if (!ret)
-		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
-	return ret;
-}
-
 static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs)
 {
-	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	struct page **pages;
+	struct page *page;
+	int ret;
 
-	if (!is_vmalloc_addr(cpu_addr)) {
-		struct page *page = virt_to_page(cpu_addr);
-		return __iommu_dma_get_sgtable_page(sgt, page, size);
-	}
+	if (is_vmalloc_addr(cpu_addr)) {
+		struct page **pages = __iommu_dma_get_pages(cpu_addr);
 
-	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		/*
-		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
-		 * hence in the vmalloc space.
-		 */
-		struct page *page = vmalloc_to_page(cpu_addr);
-		return __iommu_dma_get_sgtable_page(sgt, page, size);
+		if (pages) {
+			return sg_alloc_table_from_pages(sgt, pages,
+					PAGE_ALIGN(size) >> PAGE_SHIFT,
+					0, size, GFP_KERNEL);
+		}
+
+		page = vmalloc_to_page(cpu_addr);
+	} else {
+		page = virt_to_page(cpu_addr);
 	}
 
-	pages = __iommu_dma_get_pages(cpu_addr);
-	if (WARN_ON_ONCE(!pages))
-		return -ENXIO;
-	return sg_alloc_table_from_pages(sgt, pages, count, 0, size,
-					 GFP_KERNEL);
+	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
+	if (!ret)
+		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
+	return ret;
 }
 
 static const struct dma_map_ops iommu_dma_ops = {
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
