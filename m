Return-Path: <SRS0=A6MP=2O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF46DC2D0D6
	for <iommu@archiver.kernel.org>; Tue, 24 Dec 2019 07:46:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F71520706
	for <iommu@archiver.kernel.org>; Tue, 24 Dec 2019 07:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F71520706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5B92C8574A;
	Tue, 24 Dec 2019 07:46:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O9_ETxdXz3qX; Tue, 24 Dec 2019 07:46:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BB954856E8;
	Tue, 24 Dec 2019 07:46:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6008C1D81;
	Tue, 24 Dec 2019 07:46:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F369AC0881
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 07:46:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DE7CC8574A
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 07:46:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zKrsl-8vQYu0 for <iommu@lists.linux-foundation.org>;
 Tue, 24 Dec 2019 07:46:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 32739856E8
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 07:46:20 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Dec 2019 23:46:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,350,1571727600"; d="scan'208";a="223177081"
Received: from allen-box.sh.intel.com ([10.239.159.136])
 by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2019 23:46:17 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v5 4/9] iommu/vt-d: Setup pasid entries for iova over first
 level
Date: Tue, 24 Dec 2019 15:44:57 +0800
Message-Id: <20191224074502.5545-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191224074502.5545-1-baolu.lu@linux.intel.com>
References: <20191224074502.5545-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
 sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, yi.y.sun@intel.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Intel VT-d in scalable mode supports two types of page tables for
IOVA translation: first level and second level. The IOMMU driver
can choose one from both for IOVA translation according to the use
case. This sets up the pasid entry if a domain is selected to use
the first-level page table for iova translation.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 57 +++++++++++++++++++++++++++++++++----
 include/linux/intel-iommu.h | 16 +++++++----
 2 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 35f65628202c..071cbc172ce8 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -571,6 +571,11 @@ static inline int domain_type_is_si(struct dmar_domain *domain)
 	return domain->flags & DOMAIN_FLAG_STATIC_IDENTITY;
 }
 
+static inline bool domain_use_first_level(struct dmar_domain *domain)
+{
+	return domain->flags & DOMAIN_FLAG_USE_FIRST_LEVEL;
+}
+
 static inline int domain_pfn_supported(struct dmar_domain *domain,
 				       unsigned long pfn)
 {
@@ -932,6 +937,8 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 
 			domain_flush_cache(domain, tmp_page, VTD_PAGE_SIZE);
 			pteval = ((uint64_t)virt_to_dma_pfn(tmp_page) << VTD_PAGE_SHIFT) | DMA_PTE_READ | DMA_PTE_WRITE;
+			if (domain_use_first_level(domain))
+				pteval |= DMA_FL_PTE_XD;
 			if (cmpxchg64(&pte->val, 0ULL, pteval))
 				/* Someone else set it while we were thinking; use theirs. */
 				free_pgtable_page(tmp_page);
@@ -2281,17 +2288,20 @@ static int __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 	unsigned long sg_res = 0;
 	unsigned int largepage_lvl = 0;
 	unsigned long lvl_pages = 0;
+	u64 attr;
 
 	BUG_ON(!domain_pfn_supported(domain, iov_pfn + nr_pages - 1));
 
 	if ((prot & (DMA_PTE_READ|DMA_PTE_WRITE)) == 0)
 		return -EINVAL;
 
-	prot &= DMA_PTE_READ | DMA_PTE_WRITE | DMA_PTE_SNP;
+	attr = prot & (DMA_PTE_READ | DMA_PTE_WRITE | DMA_PTE_SNP);
+	if (domain_use_first_level(domain))
+		attr |= DMA_FL_PTE_PRESENT | DMA_FL_PTE_XD;
 
 	if (!sg) {
 		sg_res = nr_pages;
-		pteval = ((phys_addr_t)phys_pfn << VTD_PAGE_SHIFT) | prot;
+		pteval = ((phys_addr_t)phys_pfn << VTD_PAGE_SHIFT) | attr;
 	}
 
 	while (nr_pages > 0) {
@@ -2303,7 +2313,7 @@ static int __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 			sg_res = aligned_nrpages(sg->offset, sg->length);
 			sg->dma_address = ((dma_addr_t)iov_pfn << VTD_PAGE_SHIFT) + pgoff;
 			sg->dma_length = sg->length;
-			pteval = (sg_phys(sg) - pgoff) | prot;
+			pteval = (sg_phys(sg) - pgoff) | attr;
 			phys_pfn = pteval >> VTD_PAGE_SHIFT;
 		}
 
@@ -2515,6 +2525,36 @@ dmar_search_domain_by_dev_info(int segment, int bus, int devfn)
 	return NULL;
 }
 
+static int domain_setup_first_level(struct intel_iommu *iommu,
+				    struct dmar_domain *domain,
+				    struct device *dev,
+				    int pasid)
+{
+	int flags = PASID_FLAG_SUPERVISOR_MODE;
+	struct dma_pte *pgd = domain->pgd;
+	int agaw, level;
+
+	/*
+	 * Skip top levels of page tables for iommu which has
+	 * less agaw than default. Unnecessary for PT mode.
+	 */
+	for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
+		pgd = phys_to_virt(dma_pte_addr(pgd));
+		if (!dma_pte_present(pgd))
+			return -ENOMEM;
+	}
+
+	level = agaw_to_level(agaw);
+	if (level != 4 && level != 5)
+		return -EINVAL;
+
+	flags |= (level == 5) ? PASID_FLAG_FL5LP : 0;
+
+	return intel_pasid_setup_first_level(iommu, dev, (pgd_t *)pgd, pasid,
+					     domain->iommu_did[iommu->seq_id],
+					     flags);
+}
+
 static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 						    int bus, int devfn,
 						    struct device *dev,
@@ -2614,6 +2654,9 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		if (hw_pass_through && domain_type_is_si(domain))
 			ret = intel_pasid_setup_pass_through(iommu, domain,
 					dev, PASID_RID2PASID);
+		else if (domain_use_first_level(domain))
+			ret = domain_setup_first_level(iommu, domain, dev,
+					PASID_RID2PASID);
 		else
 			ret = intel_pasid_setup_second_level(iommu, domain,
 					dev, PASID_RID2PASID);
@@ -5374,8 +5417,12 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
 		goto attach_failed;
 
 	/* Setup the PASID entry for mediated devices: */
-	ret = intel_pasid_setup_second_level(iommu, domain, dev,
-					     domain->default_pasid);
+	if (domain_use_first_level(domain))
+		ret = domain_setup_first_level(iommu, domain, dev,
+					       domain->default_pasid);
+	else
+		ret = intel_pasid_setup_second_level(iommu, domain, dev,
+						     domain->default_pasid);
 	if (ret)
 		goto table_failed;
 	spin_unlock(&iommu->lock);
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index aaece25c055f..454c69712131 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -34,10 +34,13 @@
 #define VTD_STRIDE_SHIFT        (9)
 #define VTD_STRIDE_MASK         (((u64)-1) << VTD_STRIDE_SHIFT)
 
-#define DMA_PTE_READ (1)
-#define DMA_PTE_WRITE (2)
-#define DMA_PTE_LARGE_PAGE (1 << 7)
-#define DMA_PTE_SNP (1 << 11)
+#define DMA_PTE_READ		BIT_ULL(0)
+#define DMA_PTE_WRITE		BIT_ULL(1)
+#define DMA_PTE_LARGE_PAGE	BIT_ULL(7)
+#define DMA_PTE_SNP		BIT_ULL(11)
+
+#define DMA_FL_PTE_PRESENT	BIT_ULL(0)
+#define DMA_FL_PTE_XD		BIT_ULL(63)
 
 #define CONTEXT_TT_MULTI_LEVEL	0
 #define CONTEXT_TT_DEV_IOTLB	1
@@ -610,10 +613,11 @@ static inline void dma_clear_pte(struct dma_pte *pte)
 static inline u64 dma_pte_addr(struct dma_pte *pte)
 {
 #ifdef CONFIG_64BIT
-	return pte->val & VTD_PAGE_MASK;
+	return pte->val & VTD_PAGE_MASK & (~DMA_FL_PTE_XD);
 #else
 	/* Must have a full atomic 64-bit read */
-	return  __cmpxchg64(&pte->val, 0ULL, 0ULL) & VTD_PAGE_MASK;
+	return  __cmpxchg64(&pte->val, 0ULL, 0ULL) &
+			VTD_PAGE_MASK & (~DMA_FL_PTE_XD);
 #endif
 }
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
