Return-Path: <SRS0=A2w3=TU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BACC04AAF
	for <iommu@archiver.kernel.org>; Mon, 20 May 2019 07:31:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A06420856
	for <iommu@archiver.kernel.org>; Mon, 20 May 2019 07:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TCxpu/Fd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A06420856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 56513B2F;
	Mon, 20 May 2019 07:31:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DE35AAF3
	for <iommu@lists.linux-foundation.org>;
	Mon, 20 May 2019 07:31:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4DE037ED
	for <iommu@lists.linux-foundation.org>;
	Mon, 20 May 2019 07:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4yq3kV3thLlqiEKl0TkXIPpsrbT4sL5fdW/emb+GzxE=;
	b=TCxpu/Fdw6MIxnFwk/8KV7HD/p
	1Nej32hH8cWBycuJvqWrgEE/woM+RIeLEVRi2rrE+RTGOXpT2myPCtaZXAM1qrVks8JeENalx+3Pt
	mA1pDOsWjTHZwNohQIS3T1+eraudWLHI0BUd9L5bWsZVgsTCeSLKGMdCVjxbPxbkgkrvqgR0w2o5I
	wm1hZClL2LCyCP4nOS1Vpw6y2zLjMjQM8WZjJRVk1As5NfVKZXDxAiaMMP5GjdFNTzpYUoAR0m2/h
	99kCYIuaTCE84bhjosvt3eB0ObvczHL45WkTnam75Kf5w8IKHN1n/pgCHCioLdz3o/NMuVFpwnwvb
	LTeAPjnQ==;
Received: from 089144206147.atnat0015.highway.bob.at ([89.144.206.147]
	helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hScl8-00043d-GL; Mon, 20 May 2019 07:30:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 07/24] iommu/dma: Move domain lookup into __iommu_dma_{map,
	unmap}
Date: Mon, 20 May 2019 09:29:31 +0200
Message-Id: <20190520072948.11412-8-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520072948.11412-1-hch@lst.de>
References: <20190520072948.11412-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Tom Murphy <tmurphy@arista.com>, Catalin Marinas <catalin.marinas@arm.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Robin Murphy <robin.murphy@arm.com>

Most of the callers don't care, and the couple that do already have the
domain to hand for other reasons are in slow paths where the (trivial)
overhead of a repeated lookup will be utterly immaterial.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
[hch: dropped the hunk touching iommu_dma_get_msi_page to avoid a
 conflict with another series]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index c406abe3be01..6ece8f477fc8 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -448,9 +448,10 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
 				size >> iova_shift(iovad));
 }
 
-static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr,
+static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 		size_t size)
 {
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	size_t iova_off = iova_offset(iovad, dma_addr);
@@ -465,8 +466,9 @@ static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr,
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
-		size_t size, int prot, struct iommu_domain *domain)
+		size_t size, int prot)
 {
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	size_t iova_off = 0;
 	dma_addr_t iova;
@@ -565,7 +567,7 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 static void __iommu_dma_free(struct device *dev, struct page **pages,
 		size_t size, dma_addr_t *handle)
 {
-	__iommu_dma_unmap(iommu_get_dma_domain(dev), *handle, size);
+	__iommu_dma_unmap(dev, *handle, size);
 	__iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
 	*handle = DMA_MAPPING_ERROR;
 }
@@ -718,14 +720,13 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 static dma_addr_t __iommu_dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, int prot)
 {
-	return __iommu_dma_map(dev, page_to_phys(page) + offset, size, prot,
-			iommu_get_dma_domain(dev));
+	return __iommu_dma_map(dev, page_to_phys(page) + offset, size, prot);
 }
 
 static void __iommu_dma_unmap_page(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	__iommu_dma_unmap(iommu_get_dma_domain(dev), handle, size);
+	__iommu_dma_unmap(dev, handle, size);
 }
 
 static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
@@ -734,11 +735,10 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 {
 	phys_addr_t phys = page_to_phys(page) + offset;
 	bool coherent = dev_is_dma_coherent(dev);
+	int prot = dma_info_to_prot(dir, coherent, attrs);
 	dma_addr_t dma_handle;
 
-	dma_handle =__iommu_dma_map(dev, phys, size,
-			dma_info_to_prot(dir, coherent, attrs),
-			iommu_get_dma_domain(dev));
+	dma_handle =__iommu_dma_map(dev, phys, size, prot);
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    dma_handle != DMA_MAPPING_ERROR)
 		arch_sync_dma_for_device(dev, phys, size, dir);
@@ -750,7 +750,7 @@ static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 {
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
-	__iommu_dma_unmap(iommu_get_dma_domain(dev), dma_handle, size);
+	__iommu_dma_unmap(dev, dma_handle, size);
 }
 
 /*
@@ -931,21 +931,20 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 		sg = tmp;
 	}
 	end = sg_dma_address(sg) + sg_dma_len(sg);
-	__iommu_dma_unmap(iommu_get_dma_domain(dev), start, end - start);
+	__iommu_dma_unmap(dev, start, end - start);
 }
 
 static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	return __iommu_dma_map(dev, phys, size,
-			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO,
-			iommu_get_dma_domain(dev));
+			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO);
 }
 
 static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	__iommu_dma_unmap(iommu_get_dma_domain(dev), handle, size);
+	__iommu_dma_unmap(dev, handle, size);
 }
 
 static void *iommu_dma_alloc(struct device *dev, size_t size,
@@ -1222,7 +1221,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	if (!msi_page)
 		return NULL;
 
-	iova = __iommu_dma_map(dev, msi_addr, size, prot, domain);
+	iova = __iommu_dma_map(dev, msi_addr, size, prot);
 	if (iova == DMA_MAPPING_ERROR)
 		goto out_free_page;
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
