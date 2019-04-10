Return-Path: <SRS0=ghiB=SM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91A4C10F11
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 16:14:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94F2020830
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 16:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pYRog09Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F2020830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8677B1AAF;
	Wed, 10 Apr 2019 16:14:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B20531AA3
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 16:14:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 429AE875
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 16:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BP+Wh0lLqnHO3KrV1s/tt4geUUO2uuz94OBaXFfBhmo=;
	b=pYRog09ZCUrU8g3z9dheVnhzkF
	DuklzZTN0rFyvjAZ2VAnlz/I0VCydPXmynuxl0q58pMcJIhQ5T93NH/9qRvvLDR0SJMr1hedoQAMS
	8e5uZBswSoZoEQ4s5yzsV9w8HwiTmm4tB6Xc/usdbuRcFC/3GCLh9if5+kpId2YDJgFSS/I+1UAab
	ji5qKMZX+kzT5lsFicGErqCoDSf/1LBM1XOkMvQILqWCHm/af+Zn6VDj66yL3hklUvGqRZj7m71gc
	uztyBNpeRb3CyBu3MWBUayVV+Ryw/txSNLSWwNHL1Ka8F6XWtTCU8gbQI49NzqxuzgKjtF/BWd5J6
	JJAjf9hQ==;
Received: from 089144214194.atnat0023.highway.a1.net ([89.144.214.194]
	helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hEFru-0007OB-4E; Wed, 10 Apr 2019 16:14:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/3] intel-iommu: clean up iommu_no_mapping
Date: Wed, 10 Apr 2019 18:14:06 +0200
Message-Id: <20190410161408.7119-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410161408.7119-1-hch@lst.de>
References: <20190410161408.7119-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org
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
Message-ID: <20190410161406.uGxOWTGhf4lrP02sH6e73d1sXf9rX4h5qrsbmrivux4@z>

Invert the return value to avoid double negatives, use a bool
instead of int as the return value, and reduce some indentation
after early returns.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/intel-iommu.c | 47 +++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 28cb713d728c..121a0cb450df 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3606,45 +3606,40 @@ struct dmar_domain *get_valid_domain_for_dev(struct device *dev)
 }
 
 /* Check if the dev needs to go through non-identity map and unmap process.*/
-static int iommu_no_mapping(struct device *dev)
+static bool iommu_need_mapping(struct device *dev)
 {
 	int found;
 
 	if (iommu_dummy(dev))
-		return 1;
+		return false;
 
 	if (!iommu_identity_mapping)
-		return 0;
+		return true;
 
 	found = identity_mapping(dev);
 	if (found) {
 		if (iommu_should_identity_map(dev, 0))
-			return 1;
-		else {
-			/*
-			 * 32 bit DMA is removed from si_domain and fall back
-			 * to non-identity mapping.
-			 */
-			dmar_remove_one_dev_info(dev);
-			dev_info(dev, "32bit DMA uses non-identity mapping\n");
-			return 0;
-		}
+			return false;
+
+		/*
+		 * 32 bit DMA is removed from si_domain and fall back to
+		 * non-identity mapping.
+		 */
+		dmar_remove_one_dev_info(dev);
+		dev_info(dev, "32bit DMA uses non-identity mapping\n");
 	} else {
 		/*
 		 * In case of a detached 64 bit DMA device from vm, the device
 		 * is put into si_domain for identity mapping.
 		 */
-		if (iommu_should_identity_map(dev, 0)) {
-			int ret;
-			ret = domain_add_dev_info(si_domain, dev);
-			if (!ret) {
-				dev_info(dev, "64bit DMA uses identity mapping\n");
-				return 1;
-			}
+		if (iommu_should_identity_map(dev, 0) &&
+		    !domain_add_dev_info(si_domain, dev)) {
+			dev_info(dev, "64bit DMA uses identity mapping\n");
+			return false;
 		}
 	}
 
-	return 0;
+	return true;
 }
 
 static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
@@ -3660,7 +3655,7 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 
 	BUG_ON(dir == DMA_NONE);
 
-	if (iommu_no_mapping(dev))
+	if (!iommu_need_mapping(dev))
 		return paddr;
 
 	domain = get_valid_domain_for_dev(dev);
@@ -3731,7 +3726,7 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
 	struct intel_iommu *iommu;
 	struct page *freelist;
 
-	if (iommu_no_mapping(dev))
+	if (!iommu_need_mapping(dev))
 		return;
 
 	domain = find_domain(dev);
@@ -3782,7 +3777,7 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
 
-	if (!iommu_no_mapping(dev))
+	if (iommu_need_mapping(dev))
 		flags &= ~(GFP_DMA | GFP_DMA32);
 	else if (dev->coherent_dma_mask < dma_get_required_mask(dev)) {
 		if (dev->coherent_dma_mask < DMA_BIT_MASK(32))
@@ -3796,7 +3791,7 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 
 		page = dma_alloc_from_contiguous(dev, count, order,
 						 flags & __GFP_NOWARN);
-		if (page && iommu_no_mapping(dev) &&
+		if (page && !iommu_need_mapping(dev) &&
 		    page_to_phys(page) + size > dev->coherent_dma_mask) {
 			dma_release_from_contiguous(dev, page, count);
 			page = NULL;
@@ -3878,7 +3873,7 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 	struct intel_iommu *iommu;
 
 	BUG_ON(dir == DMA_NONE);
-	if (iommu_no_mapping(dev))
+	if (!iommu_need_mapping(dev))
 		return intel_nontranslate_map_sg(dev, sglist, nelems, dir);
 
 	domain = get_valid_domain_for_dev(dev);
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
