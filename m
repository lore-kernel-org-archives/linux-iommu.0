Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CEF21100
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 01:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OcXo5bQj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705367588; x=1736903588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=LM/HJCpnyP/sEyG96KjR+mJkdL2iRPduCW0WgEAqTHw=;
  b=OcXo5bQjkjluk9t1INEfVxh6YAFA+XlYqb4vhIaZLfR63OWwFie51MOW
   Aez21a3MnJ+IQGdeVjDU9hbqLSiy4OwS0Ds1er9M1YQAKHhW1qyOpBB93
   zI3rBxUFyktFX2FRSUMRSEDPKyBGN9QuDN46DPKagxZ0yDRIBNWh5h7cu
   2Ls7OOeRkecgGyrLcQ2tklU1v5ny8vQ/g3QLNn/kGoGzuBv3Y3715rq8I
   GAAEmETq2woJzDoJxpgb4TvA8Cbd+9RPKkcKub3ksAQNyWNgvzydb+xJU
   x9ZmzlxK2AapVm9Xo24wFBHGK43Enk+yXsp0uf083eHHQTre8IXD6goT2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="464004440"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="464004440"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 17:13:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="733427390"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="733427390"
Received: from kechen-optiplex-9020.bj.intel.com ([10.238.157.62])
  by orsmga003.jf.intel.com with ESMTP; 15 Jan 2024 17:13:01 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH 06/11] iommu/vt-d: Retire struct intel_svm
Date: Tue, 16 Jan 2024 09:11:41 +0800
Message-Id: <20240116011146.18645-7-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240116011146.18645-1-tina.zhang@intel.com>
References: <20240116011146.18645-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The sva domain is a kind of iommu_domain which allows the processor and
device to use the same virtual addresses that are managed by system
memory management. As a result, use dmar_domain to stand for a sva domain
instead of using struct intel_svm to avoid duplicating code.

Besides, allocate sva domain in domain_alloc_sva() callback which allows
the memory management notifier lifetime to follow the lifetime of the
iommu_domain.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/iommu.c |   3 +-
 drivers/iommu/intel/iommu.h |  14 +--
 drivers/iommu/intel/svm.c   | 179 +++++++++++-------------------------
 3 files changed, 61 insertions(+), 135 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a81a2be9b870..847e21117e7a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3864,8 +3864,6 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 		return domain;
 	case IOMMU_DOMAIN_IDENTITY:
 		return &si_domain->domain;
-	case IOMMU_DOMAIN_SVA:
-		return intel_svm_domain_alloc();
 	default:
 		return NULL;
 	}
@@ -4730,6 +4728,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.hw_info		= intel_iommu_hw_info,
 	.domain_alloc		= intel_iommu_domain_alloc,
+	.domain_alloc_sva	= intel_svm_domain_alloc,
 	.domain_alloc_user	= intel_iommu_domain_alloc_user,
 	.probe_device		= intel_iommu_probe_device,
 	.probe_finalize		= intel_iommu_probe_finalize,
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 4a2f6b80b837..f0d4a685a105 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -642,6 +642,7 @@ struct dmar_domain {
 
 	struct iommu_domain domain;	/* generic domain data structure for
 					   iommu core */
+	struct mmu_notifier notifier;
 };
 
 /*
@@ -1083,20 +1084,15 @@ int intel_svm_enable_prq(struct intel_iommu *iommu);
 int intel_svm_finish_prq(struct intel_iommu *iommu);
 int intel_svm_page_response(struct device *dev, struct iopf_fault *evt,
 			    struct iommu_page_response *msg);
-struct iommu_domain *intel_svm_domain_alloc(void);
+struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
+					    struct mm_struct *mm);
 void intel_svm_remove_dev_pasid(struct device *dev, ioasid_t pasid);
 void intel_drain_pasid_prq(struct device *dev, u32 pasid);
-
-struct intel_svm {
-	struct mmu_notifier notifier;
-	struct mm_struct *mm;
-	u32 pasid;
-	struct list_head devs;
-};
 #else
 static inline void intel_svm_check(struct intel_iommu *iommu) {}
 static inline void intel_drain_pasid_prq(struct device *dev, u32 pasid) {}
-static inline struct iommu_domain *intel_svm_domain_alloc(void)
+static inline struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
+							  struct mm_struct *mm)
 {
 	return NULL;
 }
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 0a934866539f..8ba2872bd92f 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -26,30 +26,13 @@
 
 static irqreturn_t prq_event_thread(int irq, void *d);
 
-static DEFINE_XARRAY_ALLOC(pasid_private_array);
-static int pasid_private_add(ioasid_t pasid, void *priv)
-{
-	return xa_alloc(&pasid_private_array, &pasid, priv,
-			XA_LIMIT(pasid, pasid), GFP_ATOMIC);
-}
-
-static void pasid_private_remove(ioasid_t pasid)
-{
-	xa_erase(&pasid_private_array, pasid);
-}
-
-static void *pasid_private_find(ioasid_t pasid)
-{
-	return xa_load(&pasid_private_array, pasid);
-}
-
 static struct dev_pasid_info *
-svm_lookup_dev_pasid_info_by_dev(struct intel_svm *svm, struct device *dev)
+domain_lookup_dev_pasid_info_by_dev(struct dmar_domain *domain, struct device *dev)
 {
 	struct dev_pasid_info *dev_pasid = NULL, *t;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(t, &svm->devs, link_domain) {
+	list_for_each_entry_rcu(t, &domain->dev_pasids, link_domain) {
 		if (t->dev == dev) {
 			dev_pasid = t;
 			break;
@@ -168,27 +151,28 @@ void intel_svm_check(struct intel_iommu *iommu)
 	iommu->flags |= VTD_FLAG_SVM_CAPABLE;
 }
 
-static void __flush_svm_range_dev(struct intel_svm *svm,
+static void __flush_svm_range_dev(struct dmar_domain *domain,
 				  struct dev_pasid_info *dev_pasid,
 				  unsigned long address,
 				  unsigned long pages, int ih)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev_pasid->dev);
+	u32 pasid = mm_get_enqcmd_pasid(domain->domain.mm);
 
 	if (WARN_ON(!pages))
 		return;
 
-	qi_flush_piotlb(info->iommu, dev_pasid->did, svm->pasid, address, pages, ih);
+	qi_flush_piotlb(info->iommu, dev_pasid->did, pasid, address, pages, ih);
 	if (info->ats_enabled) {
 		qi_flush_dev_iotlb_pasid(info->iommu, dev_pasid->sid, info->pfsid,
-					 svm->pasid, dev_pasid->qdep, address,
+					 pasid, dev_pasid->qdep, address,
 					 order_base_2(pages));
 		quirk_extra_dev_tlb_flush(info, address, order_base_2(pages),
-					  svm->pasid, dev_pasid->qdep);
+					  pasid, dev_pasid->qdep);
 	}
 }
 
-static void intel_flush_svm_range_dev(struct intel_svm *svm,
+static void intel_flush_svm_range_dev(struct dmar_domain *domain,
 				      struct dev_pasid_info *dev_pasid,
 				      unsigned long address,
 				      unsigned long pages, int ih)
@@ -199,38 +183,39 @@ static void intel_flush_svm_range_dev(struct intel_svm *svm,
 	unsigned long end = ALIGN(address + (pages << VTD_PAGE_SHIFT), align);
 
 	while (start < end) {
-		__flush_svm_range_dev(svm, dev_pasid, start, align >> VTD_PAGE_SHIFT, ih);
+		__flush_svm_range_dev(domain, dev_pasid, start, align >> VTD_PAGE_SHIFT, ih);
 		start += align;
 	}
 }
 
-static void intel_flush_svm_range(struct intel_svm *svm, unsigned long address,
+static void intel_flush_svm_range(struct dmar_domain *domain, unsigned long address,
 				unsigned long pages, int ih)
 {
 	struct dev_pasid_info *dev_pasid;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(dev_pasid, &svm->devs, link_domain)
-		intel_flush_svm_range_dev(svm, dev_pasid, address, pages, ih);
+	list_for_each_entry_rcu(dev_pasid, &domain->dev_pasids, link_domain)
+		intel_flush_svm_range_dev(domain, dev_pasid, address, pages, ih);
 	rcu_read_unlock();
 }
 
-static void intel_flush_svm_all(struct intel_svm *svm)
+static void intel_flush_svm_all(struct dmar_domain *domain)
 {
 	struct device_domain_info *info;
 	struct dev_pasid_info *dev_pasid = NULL;
+	u32 pasid = mm_get_enqcmd_pasid(domain->domain.mm);
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(dev_pasid, &svm->devs, link_domain) {
+	list_for_each_entry_rcu(dev_pasid, &domain->dev_pasids, link_domain) {
 		info = dev_iommu_priv_get(dev_pasid->dev);
 
-		qi_flush_piotlb(info->iommu, dev_pasid->did, svm->pasid, 0, -1UL, 0);
+		qi_flush_piotlb(info->iommu, dev_pasid->did, pasid, 0, -1UL, 0);
 		if (info->ats_enabled) {
 			qi_flush_dev_iotlb_pasid(info->iommu, dev_pasid->sid, info->pfsid,
-						 svm->pasid, dev_pasid->qdep,
+						 pasid, dev_pasid->qdep,
 						 0, 64 - VTD_PAGE_SHIFT);
 			quirk_extra_dev_tlb_flush(info, 0, 64 - VTD_PAGE_SHIFT,
-						  svm->pasid, dev_pasid->qdep);
+						  pasid, dev_pasid->qdep);
 		}
 	}
 	rcu_read_unlock();
@@ -241,20 +226,20 @@ static void intel_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 					struct mm_struct *mm,
 					unsigned long start, unsigned long end)
 {
-	struct intel_svm *svm = container_of(mn, struct intel_svm, notifier);
+	struct dmar_domain *domain = container_of(mn, struct dmar_domain, notifier);
 
 	if (start == 0 && end == -1UL) {
-		intel_flush_svm_all(svm);
+		intel_flush_svm_all(domain);
 		return;
 	}
 
-	intel_flush_svm_range(svm, start,
+	intel_flush_svm_range(domain, start,
 			      (end - start + PAGE_SIZE - 1) >> VTD_PAGE_SHIFT, 0);
 }
 
 static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
-	struct intel_svm *svm = container_of(mn, struct intel_svm, notifier);
+	struct dmar_domain *domain = container_of(mn, struct dmar_domain, notifier);
 	struct device_domain_info *info;
 	struct dev_pasid_info *dev_pasid;
 
@@ -271,10 +256,10 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	 * *has* to handle gracefully without affecting other processes.
 	 */
 	rcu_read_lock();
-	list_for_each_entry_rcu(dev_pasid, &svm->devs, link_domain) {
+	list_for_each_entry_rcu(dev_pasid, &domain->dev_pasids, link_domain) {
 		info = dev_iommu_priv_get(dev_pasid->dev);
 		intel_pasid_tear_down_entry(info->iommu, dev_pasid->dev,
-					    svm->pasid, true);
+					    mm_get_enqcmd_pasid(mm), true);
 	}
 	rcu_read_unlock();
 
@@ -285,78 +270,21 @@ static const struct mmu_notifier_ops intel_mmuops = {
 	.arch_invalidate_secondary_tlbs = intel_arch_invalidate_secondary_tlbs,
 };
 
-static int pasid_to_dev_pasid_info(struct device *dev, unsigned int pasid,
-			     struct intel_svm **rsvm,
-			     struct dev_pasid_info **rsdev_pasid_info)
-{
-	struct dev_pasid_info *dev_pasid = NULL;
-	struct intel_svm *svm;
-
-	if (pasid == IOMMU_PASID_INVALID || pasid >= PASID_MAX)
-		return -EINVAL;
-
-	svm = pasid_private_find(pasid);
-	if (IS_ERR(svm))
-		return PTR_ERR(svm);
-
-	if (!svm)
-		goto out;
-
-	/*
-	 * If we found svm for the PASID, there must be at least one device
-	 * bond.
-	 */
-	if (WARN_ON(list_empty(&svm->devs)))
-		return -EINVAL;
-	dev_pasid = svm_lookup_dev_pasid_info_by_dev(svm, dev);
-
-out:
-	*rsvm = svm;
-	*rsdev_pasid_info = dev_pasid;
-
-	return 0;
-}
-
 static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 				   struct device *dev, ioasid_t pasid)
 {
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 	struct mm_struct *mm = domain->mm;
 	struct dev_pasid_info *dev_pasid;
-	struct intel_svm *svm;
 	unsigned long sflags;
 	int ret = 0;
 
-	svm = pasid_private_find(pasid);
-	if (!svm) {
-		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
-		if (!svm)
-			return -ENOMEM;
-
-		svm->pasid = pasid;
-		svm->mm = mm;
-		INIT_LIST_HEAD_RCU(&svm->devs);
-
-		svm->notifier.ops = &intel_mmuops;
-		ret = mmu_notifier_register(&svm->notifier, mm);
-		if (ret) {
-			kfree(svm);
-			return ret;
-		}
-
-		ret = pasid_private_add(svm->pasid, svm);
-		if (ret) {
-			mmu_notifier_unregister(&svm->notifier, mm);
-			kfree(svm);
-			return ret;
-		}
-	}
-
 	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
 	if (!dev_pasid) {
 		ret = -ENOMEM;
-		goto free_svm;
+		goto out;
 	}
 
 	dev_pasid->dev = dev;
@@ -372,43 +300,30 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
 	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, pasid,
 					    dev_pasid->did, sflags);
-	if (ret)
-		goto free_dev_pasid;
-
-	list_add_rcu(&dev_pasid->link_domain, &svm->devs);
-
-	return 0;
-
-free_dev_pasid:
-	kfree(dev_pasid);
-free_svm:
-	if (list_empty(&svm->devs)) {
-		mmu_notifier_unregister(&svm->notifier, mm);
-		pasid_private_remove(pasid);
-		kfree(svm);
+	if (ret) {
+		kfree(dev_pasid);
+		goto out;
 	}
 
+	list_add_rcu(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
+out:
 	return ret;
 }
 
 void intel_svm_remove_dev_pasid(struct device *dev, u32 pasid)
 {
+	struct iommu_domain *domain;
 	struct dev_pasid_info *dev_pasid;
-	struct intel_svm *svm;
 
-	if (pasid_to_dev_pasid_info(dev, pasid, &svm, &dev_pasid))
+	domain = iommu_get_domain_for_dev_pasid(dev, pasid,
+						IOMMU_DOMAIN_SVA);
+	if (WARN_ON_ONCE(IS_ERR_OR_NULL(domain)))
 		return;
 
+	dev_pasid = domain_lookup_dev_pasid_info_by_dev(to_dmar_domain(domain), dev);
 	if (dev_pasid) {
 		list_del_rcu(&dev_pasid->link_domain);
 		kfree_rcu(dev_pasid, rcu);
-
-		if (list_empty(&svm->devs)) {
-			if (svm->notifier.ops)
-				mmu_notifier_unregister(&svm->notifier, svm->mm);
-			pasid_private_remove(svm->pasid);
-			kfree(svm);
-		}
 	}
 }
 
@@ -797,7 +712,12 @@ int intel_svm_page_response(struct device *dev,
 
 static void intel_svm_domain_free(struct iommu_domain *domain)
 {
-	kfree(to_dmar_domain(domain));
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+
+	if (dmar_domain->notifier.ops)
+		mmu_notifier_unregister(&dmar_domain->notifier, domain->mm);
+
+	kfree(dmar_domain);
 }
 
 static const struct iommu_domain_ops intel_svm_domain_ops = {
@@ -805,14 +725,25 @@ static const struct iommu_domain_ops intel_svm_domain_ops = {
 	.free			= intel_svm_domain_free
 };
 
-struct iommu_domain *intel_svm_domain_alloc(void)
+struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
+						  struct mm_struct *mm)
 {
 	struct dmar_domain *domain;
+	int ret;
 
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
+
 	domain->domain.ops = &intel_svm_domain_ops;
+	INIT_LIST_HEAD(&domain->dev_pasids);
+
+	domain->notifier.ops = &intel_mmuops;
+	ret = mmu_notifier_register(&domain->notifier, mm);
+	if (ret) {
+		kfree(domain);
+		return ERR_PTR(ret);
+	}
 
 	return &domain->domain;
 }
-- 
2.39.3

