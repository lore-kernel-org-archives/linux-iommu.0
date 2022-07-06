Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51138C43334
	for <iommu@archiver.kernel.org>; Wed,  6 Jul 2022 03:00:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01B1F60F6C;
	Wed,  6 Jul 2022 03:00:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 01B1F60F6C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UnK7QUmC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3AET9F90ZaJQ; Wed,  6 Jul 2022 03:00:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9067660F6F;
	Wed,  6 Jul 2022 03:00:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9067660F6F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D656C0071;
	Wed,  6 Jul 2022 03:00:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01738C0070
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 03:00:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF9CE40AC7
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 03:00:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CF9CE40AC7
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=UnK7QUmC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V0XVn7dzHLGm for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 03:00:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 00C69409EE
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 00C69409EE
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 03:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657076410; x=1688612410;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=C3JcqkNtyIa/3XeEvp8QehQA1FW7d0yOZTzbsfqpcAY=;
 b=UnK7QUmCwvFS8lcbNNZnTpWwrQYF8XZzLjshDVuUcCbOddnrMXEP3ctx
 3KHq4RBsnVdZH/LT4VGmneyUoOVdW72+qvdX/Y5htv4HXICfV9ktSw9+h
 zbvx6qHnU89iNB+d3rx7qyht5RqANETyzQlkjQ8o4h9YL1Rw4Huqe/fgh
 XuK+nCvUb+jt0Mpuoa5jHjyDhDdrEoczRsOXS8HKOpp934re1HQxsm69x
 LB1LEa7tTlWopEE+5SnDbRfnCqodMYUrom3ml+NGJJ7bVM5FsdIQD2lse
 rC8eJLkDtlMNoVnR1wV3FKgJV3bFw9vDawmPyXni/GgxFAywy5cuYz+N1 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="272409578"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; d="scan'208";a="272409578"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2022 20:00:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; d="scan'208";a="567875151"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga006.jf.intel.com with ESMTP; 05 Jul 2022 20:00:07 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev
Subject: [PATCH v4 07/11] iommu/vt-d: Acquiring lock in pasid manipulation
 helpers
Date: Wed,  6 Jul 2022 10:55:20 +0800
Message-Id: <20220706025524.2904370-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706025524.2904370-1-baolu.lu@linux.intel.com>
References: <20220706025524.2904370-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, Jacob jun Pan <jacob.jun.pan@intel.com>
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
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c |   2 -
 drivers/iommu/intel/pasid.c | 103 +++++++++++++++++++-----------------
 drivers/iommu/intel/svm.c   |   3 --
 3 files changed, 55 insertions(+), 53 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7f03576e72d7..3d53de8c7634 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2489,7 +2489,6 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 		}
 
 		/* Setup the PASID entry for requests without PASID: */
-		spin_lock(&iommu->lock);
 		if (hw_pass_through && domain_type_is_si(domain))
 			ret = intel_pasid_setup_pass_through(iommu, domain,
 					dev, PASID_RID2PASID);
@@ -2499,7 +2498,6 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 		else
 			ret = intel_pasid_setup_second_level(iommu, domain,
 					dev, PASID_RID2PASID);
-		spin_unlock(&iommu->lock);
 		if (ret) {
 			dev_err(dev, "Setup RID2PASID failed\n");
 			dmar_remove_one_dev_info(dev);
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 43f090381ec7..7792a1b2ebc4 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -450,17 +450,17 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
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
@@ -496,22 +496,6 @@ static void pasid_flush_caches(struct intel_iommu *iommu,
 	}
 }
 
-static inline int pasid_enable_wpe(struct pasid_entry *pte)
-{
-#ifdef CONFIG_X86
-	unsigned long cr0 = read_cr0();
-
-	/* CR0.WP is normally set but just to be sure */
-	if (unlikely(!(cr0 & X86_CR0_WP))) {
-		pr_err_ratelimited("No CPU write protect!\n");
-		return -EINVAL;
-	}
-#endif
-	pasid_set_wpe(pte);
-
-	return 0;
-};
-
 /*
  * Set up the scalable mode pasid table entry for first only
  * translation type.
@@ -528,39 +512,52 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 		return -EINVAL;
 	}
 
-	pte = intel_pasid_get_entry(dev, pasid);
-	if (WARN_ON(!pte))
+	if (flags & PASID_FLAG_SUPERVISOR_MODE) {
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
+	pte = intel_pasid_get_entry(dev, pasid);
+	if (!pte) {
+		spin_unlock(&iommu->lock);
+		return -ENODEV;
+	}
+
+	if (pasid_pte_is_present(pte)) {
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
@@ -572,6 +569,8 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 	/* Setup Present and PASID Granular Transfer Type: */
 	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_FL_ONLY);
 	pasid_set_present(pte);
+	spin_unlock(&iommu->lock);
+
 	pasid_flush_caches(iommu, pte, pasid, did);
 
 	return 0;
@@ -629,15 +628,17 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	pgd_val = virt_to_phys(pgd);
 	did = domain->iommu_did[iommu->seq_id];
 
+	spin_lock(&iommu->lock);
 	pte = intel_pasid_get_entry(dev, pasid);
 	if (!pte) {
-		dev_err(dev, "Failed to get pasid entry of PASID %d\n", pasid);
+		spin_unlock(&iommu->lock);
 		return -ENODEV;
 	}
 
-	/* Caller must ensure PASID entry is not in use. */
-	if (pasid_pte_is_present(pte))
+	if (pasid_pte_is_present(pte)) {
+		spin_unlock(&iommu->lock);
 		return -EBUSY;
+	}
 
 	pasid_clear_entry(pte);
 	pasid_set_domain_id(pte, did);
@@ -654,6 +655,8 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	if (pasid != PASID_RID2PASID)
 		pasid_set_sre(pte);
 	pasid_set_present(pte);
+	spin_unlock(&iommu->lock);
+
 	pasid_flush_caches(iommu, pte, pasid, did);
 
 	return 0;
@@ -669,15 +672,17 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 	u16 did = FLPT_DEFAULT_DID;
 	struct pasid_entry *pte;
 
+	spin_lock(&iommu->lock);
 	pte = intel_pasid_get_entry(dev, pasid);
 	if (!pte) {
-		dev_err(dev, "Failed to get pasid entry of PASID %d\n", pasid);
+		spin_unlock(&iommu->lock);
 		return -ENODEV;
 	}
 
-	/* Caller must ensure PASID entry is not in use. */
-	if (pasid_pte_is_present(pte))
+	if (pasid_pte_is_present(pte)) {
+		spin_unlock(&iommu->lock);
 		return -EBUSY;
+	}
 
 	pasid_clear_entry(pte);
 	pasid_set_domain_id(pte, did);
@@ -692,6 +697,8 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 	 */
 	pasid_set_sre(pte);
 	pasid_set_present(pte);
+	spin_unlock(&iommu->lock);
+
 	pasid_flush_caches(iommu, pte, pasid, did);
 
 	return 0;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 82288a50660d..64072e628bbd 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -394,11 +394,8 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	sflags = (flags & SVM_FLAG_SUPERVISOR_MODE) ?
 			PASID_FLAG_SUPERVISOR_MODE : 0;
 	sflags |= cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
-	spin_lock(&iommu->lock);
 	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm->pasid,
 					    FLPT_DEFAULT_DID, sflags);
-	spin_unlock(&iommu->lock);
-
 	if (ret)
 		goto free_sdev;
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
