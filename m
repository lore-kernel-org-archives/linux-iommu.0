Return-Path: <SRS0=kdGy=CM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004D8C433E2
	for <iommu@archiver.kernel.org>; Thu,  3 Sep 2020 20:25:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB5D6206C0
	for <iommu@archiver.kernel.org>; Thu,  3 Sep 2020 20:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="pjKTUAGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5D6206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tcd.ie
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 749E086CA6;
	Thu,  3 Sep 2020 20:25:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EuWvTo+aBK-M; Thu,  3 Sep 2020 20:25:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id F2C7B86C7F;
	Thu,  3 Sep 2020 20:25:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E66B0C07FF;
	Thu,  3 Sep 2020 20:25:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 777DFC0051
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 20:25:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 47A402E137
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 20:25:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 52l7IDKDXCNP for <iommu@lists.linux-foundation.org>;
 Thu,  3 Sep 2020 20:25:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
 [209.85.215.196])
 by silver.osuosl.org (Postfix) with ESMTPS id 329F72E132
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 20:25:19 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id v15so3021745pgh.6
 for <iommu@lists.linux-foundation.org>; Thu, 03 Sep 2020 13:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tcd-ie.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PX6joUw5WN/wR+AVIANPEzCWT93Q3UvjqpxbOSmJP78=;
 b=pjKTUAGMEOW9k3y+u0jzOeBKouIQ4cbAnrLlrxH6OJG2qn9Tqr1zj0WlB7zPm2n8CJ
 pipY4b3BqR3/jjcMmPaWwyD9d/TY7Y8nYhUCKVudQqH5MGeMHC+nR8ciYn/CAZOT9CyW
 yRfGlobYBHPjJMmbEDs1v4W2g5+ZvsG3qFN7OIyYPM95+6Yz8Xg7IUuX9nhYoe34aFNE
 58H/7IAYjL3D18D7gdNOmesFRc58VlPYrskrwhFoM2i0eqDIaTYVUKvdV64Hmhb2hXkv
 x5+xNCfmdg+fCfTSHfaA2aPgcPO6MtjTid6CJcHZoxAwu5XHmvVFt5XLyLJHdJJxUINE
 YL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PX6joUw5WN/wR+AVIANPEzCWT93Q3UvjqpxbOSmJP78=;
 b=l/kOhubsnqYCMgtCArlZQN3rS+vBWFMAqKuX25l3s76fU68aCUzNl/mdpuRJOlOTUM
 MsExlm/4MhdTyAyEPovRXZBDPtvDzkcFkOiAiLki6r3shekE+UjsVFUBcAQQR4wKv+Se
 vMwHM1nVSftFXWpq7XMzE2PpN8Z/nLJufpzcmAC+Se6L8MoOtiOPlUCpYDLbA+5IbhjL
 avYVBCBTRI48U9Yoko8/DU5n68eKbmZsnsso2xhRF+Ig0hruhj9fUT+aDdj56WcSZA8v
 bDOt0g+TynEbQ7xuUN26kpTJAm8Tyrj9QDTxveSa2QSgYa5gfWBqpqtDN6OYoL/Ki+Id
 BKMA==
X-Gm-Message-State: AOAM533QB4Wh2X2L+hS5IIdRDz9K9lrr+wf9+nX/eWwPQp/zujZIP3al
 nIm/4Q6GEc/zNriHXolsdHJKlnsHVtr+1Q==
X-Google-Smtp-Source: ABdhPJyISdY1PMFqi1zp1XFHNEpfab2tQkm3sW4MTvEWKJSCCcOwK6BlJ4NmDIwwEInWX/BY6GsHfw==
X-Received: by 2002:a0c:ca87:: with SMTP id a7mr4577935qvk.17.1599164377193;
 Thu, 03 Sep 2020 13:19:37 -0700 (PDT)
Received: from tom-ThinkPad-X1-Carbon-5th.hitronhub.home
 (CPEa84e3fce9b83-CMa84e3fce9b80.cpe.net.cable.rogers.com. [99.230.61.29])
 by smtp.googlemail.com with ESMTPSA id g37sm2863257qtk.76.2020.09.03.13.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 13:19:36 -0700 (PDT)
From: Tom Murphy <murphyt7@tcd.ie>
To: iommu@lists.linux-foundation.org
Subject: [PATCH V2 1/5] iommu: Handle freelists when using deferred flushing
 in iommu drivers
Date: Thu,  3 Sep 2020 21:18:33 +0100
Message-Id: <20200903201839.7327-2-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200903201839.7327-1-murphyt7@tcd.ie>
References: <20200903201839.7327-1-murphyt7@tcd.ie>
MIME-Version: 1.0
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
 Tom Murphy <murphyt7@tcd.ie>
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

Allow the iommu_unmap_fast to return newly freed page table pages and
pass the freelist to queue_iova in the dma-iommu ops path.

This is useful for iommu drivers (in this case the intel iommu driver)
which need to wait for the ioTLB to be flushed before newly
free/unmapped page table pages can be freed. This way we can still batch
ioTLB free operations and handle the freelists.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
---
 drivers/iommu/dma-iommu.c   | 30 ++++++++++++++------
 drivers/iommu/intel/iommu.c | 55 ++++++++++++++++++++++++-------------
 include/linux/iommu.h       |  1 +
 3 files changed, 59 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 4959f5df21bd..f69dc9467d71 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -50,6 +50,18 @@ struct iommu_dma_cookie {
 	struct iommu_domain		*fq_domain;
 };
 
+static void iommu_dma_entry_dtor(unsigned long data)
+{
+	struct page *freelist = (struct page *)data;
+
+	while (freelist != NULL) {
+		unsigned long p = (unsigned long)page_address(freelist);
+
+		freelist = freelist->freelist;
+		free_page(p);
+	}
+}
+
 static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
 {
 	if (cookie->type == IOMMU_DMA_IOVA_COOKIE)
@@ -344,7 +356,8 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	if (!cookie->fq_domain && !iommu_domain_get_attr(domain,
 			DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE, &attr) && attr) {
 		cookie->fq_domain = domain;
-		init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all, NULL);
+		init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
+				iommu_dma_entry_dtor);
 	}
 
 	if (!dev)
@@ -438,7 +451,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 }
 
 static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
-		dma_addr_t iova, size_t size)
+		dma_addr_t iova, size_t size, struct page *freelist)
 {
 	struct iova_domain *iovad = &cookie->iovad;
 
@@ -447,7 +460,8 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
 		cookie->msi_iova -= size;
 	else if (cookie->fq_domain)	/* non-strict mode */
 		queue_iova(iovad, iova_pfn(iovad, iova),
-				size >> iova_shift(iovad), 0);
+				size >> iova_shift(iovad),
+				(unsigned long) freelist);
 	else
 		free_iova_fast(iovad, iova_pfn(iovad, iova),
 				size >> iova_shift(iovad));
@@ -472,7 +486,7 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 
 	if (!cookie->fq_domain)
 		iommu_tlb_sync(domain, &iotlb_gather);
-	iommu_dma_free_iova(cookie, dma_addr, size);
+	iommu_dma_free_iova(cookie, dma_addr, size, iotlb_gather.freelist);
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
@@ -494,7 +508,7 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 		return DMA_MAPPING_ERROR;
 
 	if (iommu_map_atomic(domain, iova, phys - iova_off, size, prot)) {
-		iommu_dma_free_iova(cookie, iova, size);
+		iommu_dma_free_iova(cookie, iova, size, NULL);
 		return DMA_MAPPING_ERROR;
 	}
 	return iova + iova_off;
@@ -649,7 +663,7 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
 out_free_sg:
 	sg_free_table(&sgt);
 out_free_iova:
-	iommu_dma_free_iova(cookie, iova, size);
+	iommu_dma_free_iova(cookie, iova, size, NULL);
 out_free_pages:
 	__iommu_dma_free_pages(pages, count);
 	return NULL;
@@ -900,7 +914,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	return __finalise_sg(dev, sg, nents, iova);
 
 out_free_iova:
-	iommu_dma_free_iova(cookie, iova, iova_len);
+	iommu_dma_free_iova(cookie, iova, iova_len, NULL);
 out_restore_sg:
 	__invalidate_sg(sg, nents);
 	return 0;
@@ -1194,7 +1208,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	return msi_page;
 
 out_free_iova:
-	iommu_dma_free_iova(cookie, iova, size);
+	iommu_dma_free_iova(cookie, iova, size, NULL);
 out_free_page:
 	kfree(msi_page);
 	return NULL;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 237a470e1e9c..03699860880b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1160,17 +1160,17 @@ static struct page *dma_pte_clear_level(struct dmar_domain *domain, int level,
    pages can only be freed after the IOTLB flush has been done. */
 static struct page *domain_unmap(struct dmar_domain *domain,
 				 unsigned long start_pfn,
-				 unsigned long last_pfn)
+				 unsigned long last_pfn,
+				 struct page *freelist)
 {
-	struct page *freelist;
-
 	BUG_ON(!domain_pfn_supported(domain, start_pfn));
 	BUG_ON(!domain_pfn_supported(domain, last_pfn));
 	BUG_ON(start_pfn > last_pfn);
 
 	/* we don't need lock here; nobody else touches the iova range */
 	freelist = dma_pte_clear_level(domain, agaw_to_level(domain->agaw),
-				       domain->pgd, 0, start_pfn, last_pfn, NULL);
+				       domain->pgd, 0, start_pfn, last_pfn,
+				       freelist);
 
 	/* free pgd */
 	if (start_pfn == 0 && last_pfn == DOMAIN_MAX_PFN(domain->gaw)) {
@@ -1924,7 +1924,8 @@ static void domain_exit(struct dmar_domain *domain)
 	if (domain->pgd) {
 		struct page *freelist;
 
-		freelist = domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw));
+		freelist = domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw),
+				NULL);
 		dma_free_pagelist(freelist);
 	}
 
@@ -3480,7 +3481,7 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
 	if (dev_is_pci(dev))
 		pdev = to_pci_dev(dev);
 
-	freelist = domain_unmap(domain, start_pfn, last_pfn);
+	freelist = domain_unmap(domain, start_pfn, last_pfn, NULL);
 	if (intel_iommu_strict || (pdev && pdev->untrusted) ||
 			!has_iova_flush_queue(&domain->iovad)) {
 		iommu_flush_iotlb_psi(iommu, domain, start_pfn,
@@ -4575,7 +4576,8 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
 			struct page *freelist;
 
 			freelist = domain_unmap(si_domain,
-						start_vpfn, last_vpfn);
+						start_vpfn, last_vpfn,
+						NULL);
 
 			rcu_read_lock();
 			for_each_active_iommu(iommu, drhd)
@@ -5543,10 +5545,8 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 				struct iommu_iotlb_gather *gather)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	struct page *freelist = NULL;
 	unsigned long start_pfn, last_pfn;
-	unsigned int npages;
-	int iommu_id, level = 0;
+	int level = 0;
 
 	/* Cope with horrid API which requires us to unmap more than the
 	   size argument if it happens to be a large-page mapping. */
@@ -5558,22 +5558,38 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 	start_pfn = iova >> VTD_PAGE_SHIFT;
 	last_pfn = (iova + size - 1) >> VTD_PAGE_SHIFT;
 
-	freelist = domain_unmap(dmar_domain, start_pfn, last_pfn);
-
-	npages = last_pfn - start_pfn + 1;
-
-	for_each_domain_iommu(iommu_id, dmar_domain)
-		iommu_flush_iotlb_psi(g_iommus[iommu_id], dmar_domain,
-				      start_pfn, npages, !freelist, 0);
-
-	dma_free_pagelist(freelist);
+	gather->freelist = domain_unmap(dmar_domain, start_pfn, last_pfn,
+			gather->freelist);
 
 	if (dmar_domain->max_addr == iova + size)
 		dmar_domain->max_addr = iova;
 
+	iommu_iotlb_gather_add_page(domain, gather, iova, size);
+
 	return size;
 }
 
+static void intel_iommu_tlb_sync(struct iommu_domain *domain,
+		struct iommu_iotlb_gather *gather)
+{
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	unsigned long iova_pfn = IOVA_PFN(gather->start);
+	size_t size = gather->end - gather->start;
+	unsigned long start_pfn, last_pfn;
+	unsigned long nrpages;
+	int iommu_id;
+
+	nrpages = aligned_nrpages(gather->start, size);
+	start_pfn = mm_to_dma_pfn(iova_pfn);
+	last_pfn = start_pfn + nrpages - 1;
+
+	for_each_domain_iommu(iommu_id, dmar_domain)
+		iommu_flush_iotlb_psi(g_iommus[iommu_id], dmar_domain,
+			start_pfn, nrpages, !gather->freelist, 0);
+
+	dma_free_pagelist(gather->freelist);
+}
+
 static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 					    dma_addr_t iova)
 {
@@ -6058,6 +6074,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.aux_get_pasid		= intel_iommu_aux_get_pasid,
 	.map			= intel_iommu_map,
 	.unmap			= intel_iommu_unmap,
+	.iotlb_sync		= intel_iommu_tlb_sync,
 	.iova_to_phys		= intel_iommu_iova_to_phys,
 	.probe_device		= intel_iommu_probe_device,
 	.probe_finalize		= intel_iommu_probe_finalize,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5f0b7859d2eb..e3eafb3cf4ba 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -186,6 +186,7 @@ struct iommu_iotlb_gather {
 	unsigned long		start;
 	unsigned long		end;
 	size_t			pgsize;
+	struct page		*freelist;
 };
 
 /**
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
