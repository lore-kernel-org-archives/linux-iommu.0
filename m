Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EC232C92
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 12:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347476; cv=none; b=SjcmyzA6wkJwSZ0kziXiAiMCCPmYLEABN5UUr1s/y5x6p1m7FKllrdtzKKrBKiK+GxYdwIRyVr89HQcRqIjCm90aR4Qgbprl1ZrdURZmH69y1BuMlJiARWFl7FOa/uePNzedjZX81HINYnq+bXexE2fdeyi4FpvSPZY5JRuX6aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347476; c=relaxed/simple;
	bh=tL6iFOp9uB2F3O1O6bAwwZ4IvXxDHJUiOlQt8qupAUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YfgdefuC+Wc3a/rMD+QFgNy5Oe4Eofw0jtqi6OIWBVxoEScKeRwJ8LSCsBFF1Bi2e69XpYwC0JaehdkIRYFz61EH7NPlykhF8nixjTXYQ2wDTOTFdIv/O0Cg7auiL+bdBjYMT/9bsZMrj5IVCRsNuL7FuqTC8ND0ePBY80iloH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mrLZmgjx; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mrLZmgjx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708347475; x=1739883475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tL6iFOp9uB2F3O1O6bAwwZ4IvXxDHJUiOlQt8qupAUY=;
  b=mrLZmgjx381vUFdSoRj7Ab5uSBM6NPAVdk8fg8c39uIvx3icLfY1xj5d
   afVoTfgbURvN+k+jmfd2aNRRbb+78sdfQlAt87LxEtA4j8OCUEPV55WBv
   nX1KgYbVnwW7SFD6Npd9XsKbuIvoHJgiLDZbBC2vAA2znVEt+dD06+gNb
   KLTbcPQqLeNbUkChyBzySPsjA8cj8tVb5Vmj/LhNlz8vPB6D0AXbeTrf5
   AchpUHP/pXKH+2iEDXNO6nP1nzzuxePbwAOb2vCvcAHSRrtbNpd6t9i6S
   LyKN80D4s1npykePQ8hrAjK4YpgF2pHpHqsa1BnHROZwBcgXjJZuP900s
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2296462"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2296462"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:57:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4449302"
Received: from zhaojia-mobl2.ccr.corp.intel.com (HELO tinazhan-desk1.www.tendawifi.com) ([10.255.28.137])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:57:53 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v2 09/13] iommu/vt-d: Reuse intel_iommu_set_dev_pasid function
Date: Mon, 19 Feb 2024 20:57:19 +0800
Message-Id: <20240219125723.1645703-10-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219125723.1645703-1-tina.zhang@intel.com>
References: <20240219125723.1645703-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor intel_iommu_set_dev_pasid() and make it be reused by sva domain
as the set_dev_pasid operation.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/iommu.c | 32 +++++++++++++++++++++++++++--
 drivers/iommu/intel/iommu.h |  2 ++
 drivers/iommu/intel/svm.c   | 41 +------------------------------------
 3 files changed, 33 insertions(+), 42 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 07ca7cfd86c0..c16ff5c64264 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1644,6 +1644,21 @@ int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 	unsigned long ndomains;
 	int num, ret = -ENOSPC;
 
+	/*
+	 * SVA domain can get the iommu_domain_info bits from struct dev_pasid_info:
+	 * 1) SVA domain uses FLPT_DEFAULT_DID as the did;
+	 * 2) SVA domain can dereference a pointer of struct intel_iommu using
+	 *    dev_iommu_priv_get(dev_pasid->dev)->iommu.
+	 * 3) Since SVA domain doesn't need to use struct iommu_domain_info, it
+	 *    certainly doesn't need to keep struct iommu_domain_info instance's
+	 *    refcount.
+	 *
+	 * Therefore, hold off allocating struct iommu_domain_info for SVA domain
+	 * until we see it's necessary.
+	 */
+	if (domain_type_is_sva(domain))
+		return 0;
+
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
@@ -1691,6 +1706,10 @@ void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 {
 	struct iommu_domain_info *info;
 
+	/* See the comment in domain_attach_iommu() */
+	if (domain_type_is_sva(domain))
+		return;
+
 	spin_lock(&iommu->lock);
 	info = xa_load(&domain->iommu_array, iommu->seq_id);
 	if (--info->refcnt == 0) {
@@ -4590,7 +4609,7 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	intel_drain_pasid_prq(dev, pasid);
 }
 
-static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
+int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 				     struct device *dev, ioasid_t pasid)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
@@ -4623,6 +4642,10 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 
 	if (domain_type_is_si(dmar_domain))
 		ret = intel_pasid_setup_pass_through(iommu, dev, pasid);
+	else if (domain_type_is_sva(dmar_domain))
+		ret = intel_pasid_setup_first_level(iommu, dev,
+			domain->mm->pgd, pasid, FLPT_DEFAULT_DID,
+			cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0);
 	else if (dmar_domain->use_first_level)
 		ret = domain_setup_first_level(iommu, dmar_domain,
 					       dev, pasid);
@@ -4634,7 +4657,12 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 
 	dev_pasid->dev = dev;
 	dev_pasid->pasid = pasid;
-
+	dev_pasid->sid = PCI_DEVID(info->bus, info->devfn);
+	if (info->ats_enabled) {
+		dev_pasid->qdep = info->ats_qdep;
+		if (dev_pasid->qdep >= QI_DEV_EIOTLB_MAX_INVS)
+			dev_pasid->qdep = 0;
+	}
 	/*
 	 * Spin lock protects dev_pasids list from being updated concurrently with
 	 * multiple updaters, while rcu ensures concurrency between one updater
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 452d293bb1be..ec071a6a56f0 100644
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
index 9f350a2fea00..4cf7f5445e1a 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -270,45 +270,6 @@ static const struct mmu_notifier_ops intel_mmuops = {
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
-					    FLPT_DEFAULT_DID, sflags);
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
@@ -721,7 +682,7 @@ static void intel_svm_domain_free(struct iommu_domain *domain)
 }
 
 static const struct iommu_domain_ops intel_svm_domain_ops = {
-	.set_dev_pasid		= intel_svm_set_dev_pasid,
+	.set_dev_pasid		= intel_iommu_set_dev_pasid,
 	.free			= intel_svm_domain_free
 };
 
-- 
2.34.1

