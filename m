Return-Path: <SRS0=NWqd=2B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD77C2D0C5
	for <iommu@archiver.kernel.org>; Wed, 11 Dec 2019 02:13:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9159206EC
	for <iommu@archiver.kernel.org>; Wed, 11 Dec 2019 02:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9159206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8988D86C3B;
	Wed, 11 Dec 2019 02:13:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pk5nvgrKWL8V; Wed, 11 Dec 2019 02:13:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 06EAF85F0F;
	Wed, 11 Dec 2019 02:13:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E936DC1796;
	Wed, 11 Dec 2019 02:13:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCD4AC0881
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 02:13:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D993385E99
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 02:13:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MXBxWrOmi897 for <iommu@lists.linux-foundation.org>;
 Wed, 11 Dec 2019 02:13:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3562285F0F
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 02:13:28 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Dec 2019 18:13:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; d="scan'208";a="225353018"
Received: from allen-box.sh.intel.com ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 10 Dec 2019 18:13:25 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v3 4/6] iommu/vt-d: Setup pasid entries for iova over first
 level
Date: Wed, 11 Dec 2019 10:12:17 +0800
Message-Id: <20191211021219.8997-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211021219.8997-1-baolu.lu@linux.intel.com>
References: <20191211021219.8997-1-baolu.lu@linux.intel.com>
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
 drivers/iommu/intel-iommu.c | 48 +++++++++++++++++++++++++++++++++++--
 include/linux/intel-iommu.h | 10 ++++----
 2 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 2b5a47584baf..83a7abf0c4f0 100644
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
@@ -2288,6 +2293,8 @@ static int __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 		return -EINVAL;
 
 	prot &= DMA_PTE_READ | DMA_PTE_WRITE | DMA_PTE_SNP;
+	if (domain_use_first_level(domain))
+		prot |= DMA_FL_PTE_PRESENT;
 
 	if (!sg) {
 		sg_res = nr_pages;
@@ -2515,6 +2522,36 @@ dmar_search_domain_by_dev_info(int segment, int bus, int devfn)
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
@@ -2614,6 +2651,9 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		if (hw_pass_through && domain_type_is_si(domain))
 			ret = intel_pasid_setup_pass_through(iommu, domain,
 					dev, PASID_RID2PASID);
+		else if (domain_use_first_level(domain))
+			ret = domain_setup_first_level(iommu, domain, dev,
+					PASID_RID2PASID);
 		else
 			ret = intel_pasid_setup_second_level(iommu, domain,
 					dev, PASID_RID2PASID);
@@ -5369,8 +5409,12 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
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
index aaece25c055f..66b525bad434 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -34,10 +34,12 @@
 #define VTD_STRIDE_SHIFT        (9)
 #define VTD_STRIDE_MASK         (((u64)-1) << VTD_STRIDE_SHIFT)
 
-#define DMA_PTE_READ (1)
-#define DMA_PTE_WRITE (2)
-#define DMA_PTE_LARGE_PAGE (1 << 7)
-#define DMA_PTE_SNP (1 << 11)
+#define DMA_PTE_READ		(1)
+#define DMA_PTE_WRITE		(2)
+#define DMA_PTE_LARGE_PAGE	(1 << 7)
+#define DMA_PTE_SNP		(1 << 11)
+
+#define DMA_FL_PTE_PRESENT	(1)
 
 #define CONTEXT_TT_MULTI_LEVEL	0
 #define CONTEXT_TT_DEV_IOTLB	1
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
