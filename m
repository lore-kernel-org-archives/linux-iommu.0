Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D1AC43334
	for <iommu@archiver.kernel.org>; Tue, 14 Jun 2022 02:56:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 077C18145D;
	Tue, 14 Jun 2022 02:56:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xDTYLNn_c4YW; Tue, 14 Jun 2022 02:55:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C142881452;
	Tue, 14 Jun 2022 02:55:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F3A8C0032;
	Tue, 14 Jun 2022 02:55:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CAA9C002D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 02:55:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 090DD40985
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 02:55:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HnQXNKnHRnya for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 02:55:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A9693409ED
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 02:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655175356; x=1686711356;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EAjIQYdFglf9BwBkf15G6oBYNR6+NPtkQlQ3XFT8w7Q=;
 b=bf87ZWUAuKo+Ql+ZpT84BTWj8MQnz49WPu8rYvoJrp78yFdt3oaDE4lt
 /LqlBo1V+menDcfeaSUCUHhY5SEFEt+2U/r88pCxRzRIvn1sifT0czu+r
 w1EZwlU8AnEEiTKBNeUwKbog6/a74Ru4/QmBLfjXU6YM+/gdzDOIKjl4f
 NmEKqMAKYLsPB4z7I0VwLtvv+8JWEuHH9Z4UcKQNGT9DDFzbXoUqSBLCT
 uCCRD3MV6A5Hk4pJtK46AMzwuNPUu22GEjOSZ9jsBX4Rv/e04lTs88ILs
 sVCtv6Baru3SFMSxCG3MI8c0x0nKuYW/ecRtRlNjWN9e64MgX/7gTMR82 w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="303887131"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; d="scan'208";a="303887131"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2022 19:55:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; d="scan'208";a="588166570"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga007.fm.intel.com with ESMTP; 13 Jun 2022 19:55:53 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 07/12] iommu/vt-d: Acquiring lock in pasid manipulation
 helpers
Date: Tue, 14 Jun 2022 10:51:32 +0800
Message-Id: <20220614025137.1632762-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
References: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Robin Murphy <robin.murphy@arm.com>
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

The iommu->lock is used to protect the per-IOMMU pasid directory table
and pasid table. Move the spinlock acquisition/release into the helpers
to make the code self-contained. Again, the iommu->lock is never used
in interrupt contexts, hence there's no need to disable the interrupts
when holding the lock.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c |   2 -
 drivers/iommu/intel/pasid.c | 108 +++++++++++++++++++-----------------
 drivers/iommu/intel/svm.c   |   5 +-
 3 files changed, 57 insertions(+), 58 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 8fdaa01ef10d..12cd12fc86a4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2496,7 +2496,6 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 		}
 
 		/* Setup the PASID entry for requests without PASID: */
-		spin_lock_irqsave(&iommu->lock, flags);
 		if (hw_pass_through && domain_type_is_si(domain))
 			ret = intel_pasid_setup_pass_through(iommu, domain,
 					dev, PASID_RID2PASID);
@@ -2506,7 +2505,6 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 		else
 			ret = intel_pasid_setup_second_level(iommu, domain,
 					dev, PASID_RID2PASID);
-		spin_unlock_irqrestore(&iommu->lock, flags);
 		if (ret) {
 			dev_err(dev, "Setup RID2PASID failed\n");
 			dmar_remove_one_dev_info(dev);
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 641a4a6eb61e..3276895d7ba7 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -496,17 +496,17 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 	struct pasid_entry *pte;
 	u16 did, pgtt;
 
+	spin_lock(&iommu->lock);
 	pte = intel_pasid_get_entry(dev, pasid);
-	if (WARN_ON(!pte))
-		return;
-
-	if (!pasid_pte_is_present(pte))
+	if (WARN_ON(!pte) || !pasid_pte_is_present(pte)) {
+		spin_unlock(&iommu->lock);
 		return;
+	}
 
 	did = pasid_get_domain_id(pte);
 	pgtt = pasid_pte_get_pgtt(pte);
-
 	intel_pasid_clear_entry(dev, pasid, fault_ignore);
+	spin_unlock(&iommu->lock);
 
 	if (!ecap_coherent(iommu->ecap))
 		clflush_cache_range(pte, sizeof(*pte));
@@ -542,21 +542,17 @@ static void pasid_flush_caches(struct intel_iommu *iommu,
 	}
 }
 
-static inline int pasid_enable_wpe(struct pasid_entry *pte)
+static struct pasid_entry *get_non_present_pasid_entry(struct device *dev,
+						       u32 pasid)
 {
-#ifdef CONFIG_X86
-	unsigned long cr0 = read_cr0();
+	struct pasid_entry *pte;
 
-	/* CR0.WP is normally set but just to be sure */
-	if (unlikely(!(cr0 & X86_CR0_WP))) {
-		pr_err_ratelimited("No CPU write protect!\n");
-		return -EINVAL;
-	}
-#endif
-	pasid_set_wpe(pte);
+	pte = intel_pasid_get_entry(dev, pasid);
+	if (!pte || pasid_pte_is_present(pte))
+		return NULL;
 
-	return 0;
-};
+	return pte;
+}
 
 /*
  * Set up the scalable mode pasid table entry for first only
@@ -574,39 +570,47 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 		return -EINVAL;
 	}
 
-	pte = intel_pasid_get_entry(dev, pasid);
-	if (WARN_ON(!pte))
+	if ((flags & PASID_FLAG_SUPERVISOR_MODE)) {
+#ifdef CONFIG_X86
+		unsigned long cr0 = read_cr0();
+
+		/* CR0.WP is normally set but just to be sure */
+		if (unlikely(!(cr0 & X86_CR0_WP))) {
+			pr_err("No CPU write protect!\n");
+			return -EINVAL;
+		}
+#endif
+		if (!ecap_srs(iommu->ecap)) {
+			pr_err("No supervisor request support on %s\n",
+			       iommu->name);
+			return -EINVAL;
+		}
+	}
+
+	if ((flags & PASID_FLAG_FL5LP) && !cap_5lp_support(iommu->cap)) {
+		pr_err("No 5-level paging support for first-level on %s\n",
+		       iommu->name);
 		return -EINVAL;
+	}
 
-	/* Caller must ensure PASID entry is not in use. */
-	if (pasid_pte_is_present(pte))
+	spin_lock(&iommu->lock);
+	pte = get_non_present_pasid_entry(dev, pasid);
+	if (!pte) {
+		spin_unlock(&iommu->lock);
 		return -EBUSY;
+	}
 
 	pasid_clear_entry(pte);
 
 	/* Setup the first level page table pointer: */
 	pasid_set_flptr(pte, (u64)__pa(pgd));
 	if (flags & PASID_FLAG_SUPERVISOR_MODE) {
-		if (!ecap_srs(iommu->ecap)) {
-			pr_err("No supervisor request support on %s\n",
-			       iommu->name);
-			return -EINVAL;
-		}
 		pasid_set_sre(pte);
-		if (pasid_enable_wpe(pte))
-			return -EINVAL;
-
+		pasid_set_wpe(pte);
 	}
 
-	if (flags & PASID_FLAG_FL5LP) {
-		if (cap_5lp_support(iommu->cap)) {
-			pasid_set_flpm(pte, 1);
-		} else {
-			pr_err("No 5-level paging support for first-level\n");
-			pasid_clear_entry(pte);
-			return -EINVAL;
-		}
-	}
+	if (flags & PASID_FLAG_FL5LP)
+		pasid_set_flpm(pte, 1);
 
 	if (flags & PASID_FLAG_PAGE_SNOOP)
 		pasid_set_pgsnp(pte);
@@ -618,6 +622,8 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 	/* Setup Present and PASID Granular Transfer Type: */
 	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_FL_ONLY);
 	pasid_set_present(pte);
+	spin_unlock(&iommu->lock);
+
 	pasid_flush_caches(iommu, pte, pasid, did);
 
 	return 0;
@@ -675,15 +681,12 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	pgd_val = virt_to_phys(pgd);
 	did = domain->iommu_did[iommu->seq_id];
 
-	pte = intel_pasid_get_entry(dev, pasid);
+	spin_lock(&iommu->lock);
+	pte = get_non_present_pasid_entry(dev, pasid);
 	if (!pte) {
-		dev_err(dev, "Failed to get pasid entry of PASID %d\n", pasid);
-		return -ENODEV;
-	}
-
-	/* Caller must ensure PASID entry is not in use. */
-	if (pasid_pte_is_present(pte))
+		spin_unlock(&iommu->lock);
 		return -EBUSY;
+	}
 
 	pasid_clear_entry(pte);
 	pasid_set_domain_id(pte, did);
@@ -700,6 +703,8 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	if (pasid != PASID_RID2PASID)
 		pasid_set_sre(pte);
 	pasid_set_present(pte);
+	spin_unlock(&iommu->lock);
+
 	pasid_flush_caches(iommu, pte, pasid, did);
 
 	return 0;
@@ -715,15 +720,12 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 	u16 did = FLPT_DEFAULT_DID;
 	struct pasid_entry *pte;
 
-	pte = intel_pasid_get_entry(dev, pasid);
+	spin_lock(&iommu->lock);
+	pte = get_non_present_pasid_entry(dev, pasid);
 	if (!pte) {
-		dev_err(dev, "Failed to get pasid entry of PASID %d\n", pasid);
-		return -ENODEV;
-	}
-
-	/* Caller must ensure PASID entry is not in use. */
-	if (pasid_pte_is_present(pte))
+		spin_unlock(&iommu->lock);
 		return -EBUSY;
+	}
 
 	pasid_clear_entry(pte);
 	pasid_set_domain_id(pte, did);
@@ -738,6 +740,8 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 	 */
 	pasid_set_sre(pte);
 	pasid_set_present(pte);
+	spin_unlock(&iommu->lock);
+
 	pasid_flush_caches(iommu, pte, pasid, did);
 
 	return 0;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 580713aa9e07..64072e628bbd 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -328,9 +328,9 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 					   unsigned int flags)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	unsigned long iflags, sflags;
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm;
+	unsigned long sflags;
 	int ret = 0;
 
 	svm = pasid_private_find(mm->pasid);
@@ -394,11 +394,8 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	sflags = (flags & SVM_FLAG_SUPERVISOR_MODE) ?
 			PASID_FLAG_SUPERVISOR_MODE : 0;
 	sflags |= cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
-	spin_lock_irqsave(&iommu->lock, iflags);
 	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm->pasid,
 					    FLPT_DEFAULT_DID, sflags);
-	spin_unlock_irqrestore(&iommu->lock, iflags);
-
 	if (ret)
 		goto free_sdev;
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
