Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD0CC433F5
	for <iommu@archiver.kernel.org>; Fri, 27 May 2022 06:34:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C99A9412DB;
	Fri, 27 May 2022 06:34:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W15NQDcNzg2p; Fri, 27 May 2022 06:34:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 914AB404FD;
	Fri, 27 May 2022 06:34:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CBEBC0032;
	Fri, 27 May 2022 06:34:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 975F8C002D
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 06:34:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8614A412EB
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 06:34:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B0Sf_sspwecP for <iommu@lists.linux-foundation.org>;
 Fri, 27 May 2022 06:34:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A7ED8412E8
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 06:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653633258; x=1685169258;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nk2qypEy/nmgBzwnnFI/3khrxYw2DdL52Z36RT1s4ss=;
 b=E3iwthOJQglIgOJHnP4mEUJl37GOuXV3/8GkFXUTtjUajgLIR010PSzU
 s06tymRwrk9Uhi+ZYoLt5mVj52HARqvCpEdtcfP0LvKLnfdIwnWd0DR/w
 SQV+t3SD86AKSOUynpGq8XE3ZSLkD4Od5afSwM62Sb3y8OehTwZhuy1YG
 gl11tZ42IcwR6flL77vAuJdE4LS8sa9wr6Iqxhr6AOJfuAXaLMJZh3WXi
 Y7iEdbKlI1sftANomXMluf37kcgDd+pEqFrO/ZCqH+12gJBEq9lmTMtU9
 I7XY6lQVEzX9vEWhAl2kC0+fwh66awXrA0wmqHERdg0eeldEef3m0AtwK g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="274123339"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; d="scan'208";a="274123339"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2022 23:34:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; d="scan'208";a="718688641"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 26 May 2022 23:34:15 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 07/12] iommu/vt-d: Acquiring lock in pasid manipulation helpers
Date: Fri, 27 May 2022 14:30:14 +0800
Message-Id: <20220527063019.3112905-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
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
to make the code self-contained.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c |   2 -
 drivers/iommu/intel/pasid.c | 106 +++++++++++++++++++-----------------
 drivers/iommu/intel/svm.c   |   5 +-
 3 files changed, 56 insertions(+), 57 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 0da937ce0534..ccf3c7fa26f1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2488,7 +2488,6 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 		}
 
 		/* Setup the PASID entry for requests without PASID: */
-		spin_lock_irqsave(&iommu->lock, flags);
 		if (hw_pass_through && domain_type_is_si(domain))
 			ret = intel_pasid_setup_pass_through(iommu, domain,
 					dev, PASID_RID2PASID);
@@ -2498,7 +2497,6 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 		else
 			ret = intel_pasid_setup_second_level(iommu, domain,
 					dev, PASID_RID2PASID);
-		spin_unlock_irqrestore(&iommu->lock, flags);
 		if (ret) {
 			dev_err(dev, "Setup RID2PASID failed\n");
 			dmar_remove_one_dev_info(dev);
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 0627d6465f25..bab5c385fa1e 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -498,17 +498,17 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
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
@@ -544,21 +544,17 @@ static void pasid_flush_caches(struct intel_iommu *iommu,
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
@@ -576,39 +572,47 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
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
-		return -EBUSY;
+	spin_lock(&iommu->lock);
+	pte = get_non_present_pasid_entry(dev, pasid);
+	if (!pte) {
+		spin_unlock(&iommu->lock);
+		return -ENODEV;
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
@@ -620,6 +624,8 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 	/* Setup Present and PASID Granular Transfer Type: */
 	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_FL_ONLY);
 	pasid_set_present(pte);
+	spin_unlock(&iommu->lock);
+
 	pasid_flush_caches(iommu, pte, pasid, did);
 
 	return 0;
@@ -677,16 +683,13 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	pgd_val = virt_to_phys(pgd);
 	did = domain->iommu_did[iommu->seq_id];
 
-	pte = intel_pasid_get_entry(dev, pasid);
+	spin_lock(&iommu->lock);
+	pte = get_non_present_pasid_entry(dev, pasid);
 	if (!pte) {
-		dev_err(dev, "Failed to get pasid entry of PASID %d\n", pasid);
+		spin_unlock(&iommu->lock);
 		return -ENODEV;
 	}
 
-	/* Caller must ensure PASID entry is not in use. */
-	if (pasid_pte_is_present(pte))
-		return -EBUSY;
-
 	pasid_clear_entry(pte);
 	pasid_set_domain_id(pte, did);
 	pasid_set_slptr(pte, pgd_val);
@@ -702,6 +705,8 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	if (pasid != PASID_RID2PASID)
 		pasid_set_sre(pte);
 	pasid_set_present(pte);
+	spin_unlock(&iommu->lock);
+
 	pasid_flush_caches(iommu, pte, pasid, did);
 
 	return 0;
@@ -717,16 +722,13 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 	u16 did = FLPT_DEFAULT_DID;
 	struct pasid_entry *pte;
 
-	pte = intel_pasid_get_entry(dev, pasid);
+	spin_lock(&iommu->lock);
+	pte = get_non_present_pasid_entry(dev, pasid);
 	if (!pte) {
-		dev_err(dev, "Failed to get pasid entry of PASID %d\n", pasid);
+		spin_unlock(&iommu->lock);
 		return -ENODEV;
 	}
 
-	/* Caller must ensure PASID entry is not in use. */
-	if (pasid_pte_is_present(pte))
-		return -EBUSY;
-
 	pasid_clear_entry(pte);
 	pasid_set_domain_id(pte, did);
 	pasid_set_address_width(pte, iommu->agaw);
@@ -740,6 +742,8 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
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
