Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA9921103
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 01:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Op60HGq9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705367594; x=1736903594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=VBHoV32D25qCVRW7uUxm3sc2Jdg5GmOYRu2CJOib4HU=;
  b=Op60HGq9l66EYRifUiqCdAJdySIa9yNRDJYekxCyoxlxuSNBEwUf50hi
   MxXZJADdCeogBXYglxI7ye6CjuoEpwK63Qu5lJG0EQRQypMaRCciGXz1u
   +ZXmRkj/+sceIcqWSlR3FvJvG3/HdiRQS8fFjs0V/rynLL50E+xMgFG7R
   BvoI7qz1tDID8w86c8VfH2ECT4YQ1IGUWnCA+I9osNRnEhgG0tNdXF6cB
   wSww19oa02hLKYS+X2OSZYbcnl/pqBkGIPFKt4OFxoxNcqd87+sGQRz20
   bHRGt4uBusZz9x3S32te2GZq/6gzj4OUJfkwF6GICA2kGv0beQR9ad6ww
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="464004464"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="464004464"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 17:13:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="733427420"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="733427420"
Received: from kechen-optiplex-9020.bj.intel.com ([10.238.157.62])
  by orsmga003.jf.intel.com with ESMTP; 15 Jan 2024 17:13:10 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH 10/11] iommu/vt-d: Retire intel_svm_remove_dev_pasid function
Date: Tue, 16 Jan 2024 09:11:45 +0800
Message-Id: <20240116011146.18645-11-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240116011146.18645-1-tina.zhang@intel.com>
References: <20240116011146.18645-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

IOMMU core has added a dedicated callback for allocating sva domain.
So intel driver doesn't need intel_svm_remove_dev_pasid function to handle
mm notification any more.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/iommu.c | 15 ++++-----------
 drivers/iommu/intel/iommu.h |  4 ----
 drivers/iommu/intel/svm.c   | 34 ----------------------------------
 3 files changed, 4 insertions(+), 49 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 8d1b9de78a43..92af368c37a7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4541,19 +4541,9 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	unsigned long flags;
 
 	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
-	if (WARN_ON_ONCE(!domain))
+	if (WARN_ON_ONCE(IS_ERR_OR_NULL(domain)))
 		goto out_tear_down;
 
-	/*
-	 * The SVA implementation needs to handle its own stuffs like the mm
-	 * notification. Before consolidating that code into iommu core, let
-	 * the intel sva code handle it.
-	 */
-	if (domain_type_is_sva(dmar_domain)) {
-		intel_svm_remove_dev_pasid(dev, pasid);
-		goto out_tear_down;
-	}
-
 	dmar_domain = to_dmar_domain(domain);
 	spin_lock_irqsave(&dmar_domain->lock, flags);
 	list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain) {
@@ -4566,6 +4556,9 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	WARN_ON_ONCE(!dev_pasid);
 	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
+	if (domain_type_is_sva(dmar_domain))
+		goto out_tear_down;
+
 	domain_detach_iommu(dmar_domain, iommu);
 	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
 	kfree_rcu(dev_pasid, rcu);
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index ebc8edc7ea8a..243474dfaf1d 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1088,7 +1088,6 @@ int intel_svm_page_response(struct device *dev, struct iopf_fault *evt,
 			    struct iommu_page_response *msg);
 struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
 					    struct mm_struct *mm);
-void intel_svm_remove_dev_pasid(struct device *dev, ioasid_t pasid);
 void intel_drain_pasid_prq(struct device *dev, u32 pasid);
 #else
 static inline void intel_svm_check(struct intel_iommu *iommu) {}
@@ -1099,9 +1098,6 @@ static inline struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
 	return NULL;
 }
 
-static inline void intel_svm_remove_dev_pasid(struct device *dev, ioasid_t pasid)
-{
-}
 #endif
 
 #ifdef CONFIG_INTEL_IOMMU_DEBUGFS
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 1648c31d6259..79d1f3107847 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -26,23 +26,6 @@
 
 static irqreturn_t prq_event_thread(int irq, void *d);
 
-static struct dev_pasid_info *
-domain_lookup_dev_pasid_info_by_dev(struct dmar_domain *domain, struct device *dev)
-{
-	struct dev_pasid_info *dev_pasid = NULL, *t;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(t, &domain->dev_pasids, link_domain) {
-		if (t->dev == dev) {
-			dev_pasid = t;
-			break;
-		}
-	}
-	rcu_read_unlock();
-
-	return dev_pasid;
-}
-
 int intel_svm_enable_prq(struct intel_iommu *iommu)
 {
 	struct iopf_queue *iopfq;
@@ -270,23 +253,6 @@ static const struct mmu_notifier_ops intel_mmuops = {
 	.arch_invalidate_secondary_tlbs = intel_arch_invalidate_secondary_tlbs,
 };
 
-void intel_svm_remove_dev_pasid(struct device *dev, u32 pasid)
-{
-	struct iommu_domain *domain;
-	struct dev_pasid_info *dev_pasid;
-
-	domain = iommu_get_domain_for_dev_pasid(dev, pasid,
-						IOMMU_DOMAIN_SVA);
-	if (WARN_ON_ONCE(IS_ERR_OR_NULL(domain)))
-		return;
-
-	dev_pasid = domain_lookup_dev_pasid_info_by_dev(to_dmar_domain(domain), dev);
-	if (dev_pasid) {
-		list_del_rcu(&dev_pasid->link_domain);
-		kfree_rcu(dev_pasid, rcu);
-	}
-}
-
 /* Page request queue descriptor */
 struct page_req_dsc {
 	union {
-- 
2.39.3

