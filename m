Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4F221104
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 01:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gevuMGVZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705367593; x=1736903593;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=U4TGnokapzoQvt4L0mjj0WWyei+9pOCPlMvnypqm7R4=;
  b=gevuMGVZfxQsPCVbeOzXzYbWVxuanHbziOGfIjpQSTl01cOJ1XJ0/Yxq
   BJcH/VaRUp63F9+pjgekw8AOQ1N4wZXLT4Nx1hR8EKPCgOcHAppz2ODGW
   yYQguwMK0Za5zsj9R1zdyU3/J8savkPHAqotYZOnudjPXkMaGSPv1ObnC
   AJsdgWLrKcGEskLAHQJw00toAJszLKXWRCyAw7LEjxYMwI1phGIXn9IOV
   hqYCX5+zo14GGGrfUSbfQYMa2BkHUb5TcoNbRDHVBQdKAo/71NihY4Gol
   Ki7pSdWjDvS702C1Hgz76CQNzJoCTN0Ss6XSNQiuv8pNQJA6lVD6KAtkp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="464004463"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="464004463"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 17:13:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="733427406"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="733427406"
Received: from kechen-optiplex-9020.bj.intel.com ([10.238.157.62])
  by orsmga003.jf.intel.com with ESMTP; 15 Jan 2024 17:13:08 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH 09/11] iommu/vt-d: Reuse intel_iommu_set_dev_pasid function
Date: Tue, 16 Jan 2024 09:11:44 +0800
Message-Id: <20240116011146.18645-10-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240116011146.18645-1-tina.zhang@intel.com>
References: <20240116011146.18645-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Refactor intel_iommu_set_dev_pasid() and make it be reused by sva domain
as the set_dev_pasid operation.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/iommu.c | 43 ++++++++++++++++++++++++++-----------
 drivers/iommu/intel/iommu.h |  2 ++
 drivers/iommu/intel/svm.c   | 42 +-----------------------------------
 3 files changed, 33 insertions(+), 54 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index af466ba301b7..8d1b9de78a43 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4574,7 +4574,7 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	intel_drain_pasid_prq(dev, pasid);
 }
 
-static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
+int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 				     struct device *dev, ioasid_t pasid)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
@@ -4593,31 +4593,48 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	if (context_copied(iommu, info->bus, info->devfn))
 		return -EBUSY;
 
-	ret = prepare_domain_attach_device(domain, dev);
-	if (ret)
-		return ret;
-
 	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
 	if (!dev_pasid)
 		return -ENOMEM;
 
-	ret = domain_attach_iommu(dmar_domain, iommu);
-	if (ret)
-		goto out_free;
+	dev_pasid->dev = dev;
+	dev_pasid->pasid = pasid;
+	if (domain_type_is_sva(dmar_domain)) {
+		dev_pasid->did = FLPT_DEFAULT_DID;
+		dev_pasid->sid = PCI_DEVID(info->bus, info->devfn);
+		if (info->ats_enabled) {
+			dev_pasid->qdep = info->ats_qdep;
+			if (dev_pasid->qdep >= QI_DEV_EIOTLB_MAX_INVS)
+				dev_pasid->qdep = 0;
+		}
+	} else {
+		ret = prepare_domain_attach_device(domain, dev);
+		if (ret)
+			goto out_free;
+
+		ret = domain_attach_iommu(dmar_domain, iommu);
+		if (ret)
+			goto out_free;
+	}
 
 	if (domain_type_is_si(dmar_domain))
 		ret = intel_pasid_setup_pass_through(iommu, dev, pasid);
 	else if (dmar_domain->use_first_level)
 		ret = domain_setup_first_level(iommu, dmar_domain,
 					       dev, pasid);
+	else if (domain_type_is_sva(dmar_domain))
+		ret = intel_pasid_setup_first_level(iommu, dev,
+			domain->mm->pgd, pasid, dev_pasid->did,
+			cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0);
 	else
 		ret = intel_pasid_setup_second_level(iommu, dmar_domain,
 						     dev, pasid);
-	if (ret)
-		goto out_detach_iommu;
-
-	dev_pasid->dev = dev;
-	dev_pasid->pasid = pasid;
+	if (ret) {
+		if (domain_type_is_sva(dmar_domain))
+			goto out_free;
+		else
+			goto out_detach_iommu;
+	}
 
 	/*
 	 * Spin lock protects dev_pasids list from being updated concurrently with
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index f0d4a685a105..ebc8edc7ea8a 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1077,6 +1077,8 @@ void free_pgtable_page(void *vaddr);
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
 struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *parent,
 					       const struct iommu_user_data *user_data);
+int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
+			      struct device *dev, ioasid_t pasid);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 void intel_svm_check(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 8ba2872bd92f..1648c31d6259 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -270,46 +270,6 @@ static const struct mmu_notifier_ops intel_mmuops = {
 	.arch_invalidate_secondary_tlbs = intel_arch_invalidate_secondary_tlbs,
 };
 
-static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
-				   struct device *dev, ioasid_t pasid)
-{
-	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct intel_iommu *iommu = info->iommu;
-	struct mm_struct *mm = domain->mm;
-	struct dev_pasid_info *dev_pasid;
-	unsigned long sflags;
-	int ret = 0;
-
-	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
-	if (!dev_pasid) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	dev_pasid->dev = dev;
-	dev_pasid->did = FLPT_DEFAULT_DID;
-	dev_pasid->sid = PCI_DEVID(info->bus, info->devfn);
-	if (info->ats_enabled) {
-		dev_pasid->qdep = info->ats_qdep;
-		if (dev_pasid->qdep >= QI_DEV_EIOTLB_MAX_INVS)
-			dev_pasid->qdep = 0;
-	}
-
-	/* Setup the pasid table: */
-	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
-	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, pasid,
-					    dev_pasid->did, sflags);
-	if (ret) {
-		kfree(dev_pasid);
-		goto out;
-	}
-
-	list_add_rcu(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
-out:
-	return ret;
-}
-
 void intel_svm_remove_dev_pasid(struct device *dev, u32 pasid)
 {
 	struct iommu_domain *domain;
@@ -721,7 +681,7 @@ static void intel_svm_domain_free(struct iommu_domain *domain)
 }
 
 static const struct iommu_domain_ops intel_svm_domain_ops = {
-	.set_dev_pasid		= intel_svm_set_dev_pasid,
+	.set_dev_pasid		= intel_iommu_set_dev_pasid,
 	.free			= intel_svm_domain_free
 };
 
-- 
2.39.3

