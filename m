Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A92920DCF
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 01:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dmVt8DTD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705367579; x=1736903579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=FxrmwASjgZtDY0JCc9Vd2TWC3Wg+zmVqsVBvQnk87Oc=;
  b=dmVt8DTDHAPEWcVY2Zds5jHRommGhN4d76iGUuwxIVZZIfFacYsD4adb
   4VEYBCIUwIwZO5sf1YZn7c0RTd7fJiSRynuV+7H0VHozfqffvXGMF0Ij0
   Mm34leBpnqrK+o1AKtFTrr0w9ejS9l/fQ7nZHGpmzoZLhp8Q3qkrY3qSh
   1ViCoGsX2Dx5npBkV/QbCNUlZjstqc6ggmqnvnYlDFMaIPOQNdERGGJOe
   xu5eSUkwaxGvJKKSaPWzy+tuhWDYBD8yzj2aoDk3VX/DU4b16XdgvBPCA
   lXSD44JIPqfH8bu8UJycpdXBcYP2Q3EuWiW4T0AtzKkbLJ6+rWzhqyL4K
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="464004399"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="464004399"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 17:12:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="733427280"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="733427280"
Received: from kechen-optiplex-9020.bj.intel.com ([10.238.157.62])
  by orsmga003.jf.intel.com with ESMTP; 15 Jan 2024 17:12:57 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH 04/11] iommu/vt-d: Retire struct intel_svm_dev
Date: Tue, 16 Jan 2024 09:11:39 +0800
Message-Id: <20240116011146.18645-5-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240116011146.18645-1-tina.zhang@intel.com>
References: <20240116011146.18645-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The struct dev_pasid_info is used by IOMMU domain to keep pasid info of
attached device. For sva domain, there is another structure which keeps
info of attached device, named intel_svm_dev. Instead of using two structs
for the same purpose, the struct dev_pasid_info can work for both sva
domain and IOMMU domain. As a result, struct intel_svm_dev gets retired.

The rcu/did/sid/qdep fields of struct intel_svm_dev are moved from struct
intel_svm_dev into struct dev_pasid_info. Besides, the names of functions
which are related to struct intel_svm_dev get changed to dev_pasid_info.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/iommu.h |  11 +---
 drivers/iommu/intel/svm.c   | 110 ++++++++++++++++++------------------
 2 files changed, 57 insertions(+), 64 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 696d95293a69..4a2f6b80b837 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -761,6 +761,8 @@ struct dev_pasid_info {
 #ifdef CONFIG_INTEL_IOMMU_DEBUGFS
 	struct dentry *debugfs_dentry; /* pointer to pasid directory dentry */
 #endif
+	struct rcu_head rcu;
+	u16 did, sid, qdep;
 };
 
 static inline void __iommu_flush_cache(
@@ -1085,15 +1087,6 @@ struct iommu_domain *intel_svm_domain_alloc(void);
 void intel_svm_remove_dev_pasid(struct device *dev, ioasid_t pasid);
 void intel_drain_pasid_prq(struct device *dev, u32 pasid);
 
-struct intel_svm_dev {
-	struct list_head list;
-	struct rcu_head rcu;
-	struct device *dev;
-	struct intel_iommu *iommu;
-	u16 did;
-	u16 sid, qdep;
-};
-
 struct intel_svm {
 	struct mmu_notifier notifier;
 	struct mm_struct *mm;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 5b1331b174df..0a934866539f 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -43,21 +43,21 @@ static void *pasid_private_find(ioasid_t pasid)
 	return xa_load(&pasid_private_array, pasid);
 }
 
-static struct intel_svm_dev *
-svm_lookup_device_by_dev(struct intel_svm *svm, struct device *dev)
+static struct dev_pasid_info *
+svm_lookup_dev_pasid_info_by_dev(struct intel_svm *svm, struct device *dev)
 {
-	struct intel_svm_dev *sdev = NULL, *t;
+	struct dev_pasid_info *dev_pasid = NULL, *t;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(t, &svm->devs, list) {
+	list_for_each_entry_rcu(t, &svm->devs, link_domain) {
 		if (t->dev == dev) {
-			sdev = t;
+			dev_pasid = t;
 			break;
 		}
 	}
 	rcu_read_unlock();
 
-	return sdev;
+	return dev_pasid;
 }
 
 int intel_svm_enable_prq(struct intel_iommu *iommu)
@@ -169,27 +169,27 @@ void intel_svm_check(struct intel_iommu *iommu)
 }
 
 static void __flush_svm_range_dev(struct intel_svm *svm,
-				  struct intel_svm_dev *sdev,
+				  struct dev_pasid_info *dev_pasid,
 				  unsigned long address,
 				  unsigned long pages, int ih)
 {
-	struct device_domain_info *info = dev_iommu_priv_get(sdev->dev);
+	struct device_domain_info *info = dev_iommu_priv_get(dev_pasid->dev);
 
 	if (WARN_ON(!pages))
 		return;
 
-	qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, address, pages, ih);
+	qi_flush_piotlb(info->iommu, dev_pasid->did, svm->pasid, address, pages, ih);
 	if (info->ats_enabled) {
-		qi_flush_dev_iotlb_pasid(sdev->iommu, sdev->sid, info->pfsid,
-					 svm->pasid, sdev->qdep, address,
+		qi_flush_dev_iotlb_pasid(info->iommu, dev_pasid->sid, info->pfsid,
+					 svm->pasid, dev_pasid->qdep, address,
 					 order_base_2(pages));
 		quirk_extra_dev_tlb_flush(info, address, order_base_2(pages),
-					  svm->pasid, sdev->qdep);
+					  svm->pasid, dev_pasid->qdep);
 	}
 }
 
 static void intel_flush_svm_range_dev(struct intel_svm *svm,
-				      struct intel_svm_dev *sdev,
+				      struct dev_pasid_info *dev_pasid,
 				      unsigned long address,
 				      unsigned long pages, int ih)
 {
@@ -199,7 +199,7 @@ static void intel_flush_svm_range_dev(struct intel_svm *svm,
 	unsigned long end = ALIGN(address + (pages << VTD_PAGE_SHIFT), align);
 
 	while (start < end) {
-		__flush_svm_range_dev(svm, sdev, start, align >> VTD_PAGE_SHIFT, ih);
+		__flush_svm_range_dev(svm, dev_pasid, start, align >> VTD_PAGE_SHIFT, ih);
 		start += align;
 	}
 }
@@ -207,30 +207,30 @@ static void intel_flush_svm_range_dev(struct intel_svm *svm,
 static void intel_flush_svm_range(struct intel_svm *svm, unsigned long address,
 				unsigned long pages, int ih)
 {
-	struct intel_svm_dev *sdev;
+	struct dev_pasid_info *dev_pasid;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(sdev, &svm->devs, list)
-		intel_flush_svm_range_dev(svm, sdev, address, pages, ih);
+	list_for_each_entry_rcu(dev_pasid, &svm->devs, link_domain)
+		intel_flush_svm_range_dev(svm, dev_pasid, address, pages, ih);
 	rcu_read_unlock();
 }
 
 static void intel_flush_svm_all(struct intel_svm *svm)
 {
 	struct device_domain_info *info;
-	struct intel_svm_dev *sdev;
+	struct dev_pasid_info *dev_pasid = NULL;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(sdev, &svm->devs, list) {
-		info = dev_iommu_priv_get(sdev->dev);
+	list_for_each_entry_rcu(dev_pasid, &svm->devs, link_domain) {
+		info = dev_iommu_priv_get(dev_pasid->dev);
 
-		qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, 0, -1UL, 0);
+		qi_flush_piotlb(info->iommu, dev_pasid->did, svm->pasid, 0, -1UL, 0);
 		if (info->ats_enabled) {
-			qi_flush_dev_iotlb_pasid(sdev->iommu, sdev->sid, info->pfsid,
-						 svm->pasid, sdev->qdep,
+			qi_flush_dev_iotlb_pasid(info->iommu, dev_pasid->sid, info->pfsid,
+						 svm->pasid, dev_pasid->qdep,
 						 0, 64 - VTD_PAGE_SHIFT);
 			quirk_extra_dev_tlb_flush(info, 0, 64 - VTD_PAGE_SHIFT,
-						  svm->pasid, sdev->qdep);
+						  svm->pasid, dev_pasid->qdep);
 		}
 	}
 	rcu_read_unlock();
@@ -255,7 +255,8 @@ static void intel_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
 	struct intel_svm *svm = container_of(mn, struct intel_svm, notifier);
-	struct intel_svm_dev *sdev;
+	struct device_domain_info *info;
+	struct dev_pasid_info *dev_pasid;
 
 	/* This might end up being called from exit_mmap(), *before* the page
 	 * tables are cleared. And __mmu_notifier_release() will delete us from
@@ -270,9 +271,11 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	 * *has* to handle gracefully without affecting other processes.
 	 */
 	rcu_read_lock();
-	list_for_each_entry_rcu(sdev, &svm->devs, list)
-		intel_pasid_tear_down_entry(sdev->iommu, sdev->dev,
+	list_for_each_entry_rcu(dev_pasid, &svm->devs, link_domain) {
+		info = dev_iommu_priv_get(dev_pasid->dev);
+		intel_pasid_tear_down_entry(info->iommu, dev_pasid->dev,
 					    svm->pasid, true);
+	}
 	rcu_read_unlock();
 
 }
@@ -282,11 +285,11 @@ static const struct mmu_notifier_ops intel_mmuops = {
 	.arch_invalidate_secondary_tlbs = intel_arch_invalidate_secondary_tlbs,
 };
 
-static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
+static int pasid_to_dev_pasid_info(struct device *dev, unsigned int pasid,
 			     struct intel_svm **rsvm,
-			     struct intel_svm_dev **rsdev)
+			     struct dev_pasid_info **rsdev_pasid_info)
 {
-	struct intel_svm_dev *sdev = NULL;
+	struct dev_pasid_info *dev_pasid = NULL;
 	struct intel_svm *svm;
 
 	if (pasid == IOMMU_PASID_INVALID || pasid >= PASID_MAX)
@@ -305,11 +308,11 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 	 */
 	if (WARN_ON(list_empty(&svm->devs)))
 		return -EINVAL;
-	sdev = svm_lookup_device_by_dev(svm, dev);
+	dev_pasid = svm_lookup_dev_pasid_info_by_dev(svm, dev);
 
 out:
 	*rsvm = svm;
-	*rsdev = sdev;
+	*rsdev_pasid_info = dev_pasid;
 
 	return 0;
 }
@@ -320,7 +323,7 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 	struct mm_struct *mm = domain->mm;
-	struct intel_svm_dev *sdev;
+	struct dev_pasid_info *dev_pasid;
 	struct intel_svm *svm;
 	unsigned long sflags;
 	int ret = 0;
@@ -350,35 +353,34 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 		}
 	}
 
-	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
-	if (!sdev) {
+	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
+	if (!dev_pasid) {
 		ret = -ENOMEM;
 		goto free_svm;
 	}
 
-	sdev->dev = dev;
-	sdev->iommu = iommu;
-	sdev->did = FLPT_DEFAULT_DID;
-	sdev->sid = PCI_DEVID(info->bus, info->devfn);
+	dev_pasid->dev = dev;
+	dev_pasid->did = FLPT_DEFAULT_DID;
+	dev_pasid->sid = PCI_DEVID(info->bus, info->devfn);
 	if (info->ats_enabled) {
-		sdev->qdep = info->ats_qdep;
-		if (sdev->qdep >= QI_DEV_EIOTLB_MAX_INVS)
-			sdev->qdep = 0;
+		dev_pasid->qdep = info->ats_qdep;
+		if (dev_pasid->qdep >= QI_DEV_EIOTLB_MAX_INVS)
+			dev_pasid->qdep = 0;
 	}
 
 	/* Setup the pasid table: */
 	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
 	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, pasid,
-					    FLPT_DEFAULT_DID, sflags);
+					    dev_pasid->did, sflags);
 	if (ret)
-		goto free_sdev;
+		goto free_dev_pasid;
 
-	list_add_rcu(&sdev->list, &svm->devs);
+	list_add_rcu(&dev_pasid->link_domain, &svm->devs);
 
 	return 0;
 
-free_sdev:
-	kfree(sdev);
+free_dev_pasid:
+	kfree(dev_pasid);
 free_svm:
 	if (list_empty(&svm->devs)) {
 		mmu_notifier_unregister(&svm->notifier, mm);
@@ -391,21 +393,19 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 
 void intel_svm_remove_dev_pasid(struct device *dev, u32 pasid)
 {
-	struct intel_svm_dev *sdev;
+	struct dev_pasid_info *dev_pasid;
 	struct intel_svm *svm;
-	struct mm_struct *mm;
 
-	if (pasid_to_svm_sdev(dev, pasid, &svm, &sdev))
+	if (pasid_to_dev_pasid_info(dev, pasid, &svm, &dev_pasid))
 		return;
-	mm = svm->mm;
 
-	if (sdev) {
-		list_del_rcu(&sdev->list);
-		kfree_rcu(sdev, rcu);
+	if (dev_pasid) {
+		list_del_rcu(&dev_pasid->link_domain);
+		kfree_rcu(dev_pasid, rcu);
 
 		if (list_empty(&svm->devs)) {
 			if (svm->notifier.ops)
-				mmu_notifier_unregister(&svm->notifier, mm);
+				mmu_notifier_unregister(&svm->notifier, svm->mm);
 			pasid_private_remove(svm->pasid);
 			kfree(svm);
 		}
-- 
2.39.3

