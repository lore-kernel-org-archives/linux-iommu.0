Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5F31EDA03
	for <iommu@lists.linux.dev>; Mon,  8 Dec 2025 09:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765185551; cv=none; b=MvnXZvqLaOfI8q+oaGvWzmv5qogp9ewIi8mPDtFJsPMc/RTpI53dBha/jZVKmGvVLijJHhlaPQqZxwLD0Sgaiuruy595bkkO1yVeyH77uPEUBwMGJ3JzMIjTScMIwgSF/NOPyKNGNpheV+uZL2CfhQVdBdMGewKoIjiR3CnaPqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765185551; c=relaxed/simple;
	bh=GeZc+JbeoBfQkr1X46S+38EEUrtPPrHmuVsh+DemyCc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iKj+Wjo0acmYSVrKSu1/VRICrvVghMztUgNeVKlk57BsUXhHB4uH88plM02HYHeCzHPtNSKzjODjNTbrh66brGDq5+lE8pf0KwIg2vDVuR872L+pNNYc2fTf515t+zL35yNVT8mScZ2PwEjZ8q/ZyHJEQtTben3FC8qB6/1hqb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EbZ42QRB; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EbZ42QRB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765185550; x=1796721550;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GeZc+JbeoBfQkr1X46S+38EEUrtPPrHmuVsh+DemyCc=;
  b=EbZ42QRBCK2cPXSil77Ar8OPNRWgp5Ecg4Q4k1VOwoRkbJ+nQp8lzXbv
   VYmWxwuYNmcfvAZUEvKawmdRU/v68OnNlPTpVcEecykqtyBuiPcvhkEs0
   QVg4DpHGqAuQE+mXwmGTesUzhqSu++K1NFpQANyOKqud1waEeLzBmVLxB
   uvkTRkehJN8IiQ8q5pkT+iPoSYs569tNF9esqPXoUYgN9VyAOOBmCdtxE
   YYMO1q7zbK9BTyqlpNocjDUWTg1sSuYyI7ZplLmHxT8C1lt9GqII5m0ZM
   Z+X30Ch8ywzHsyVl6j0kL91tPwGIB3xvrxsvGS6Al4C9jvr0N9cvU3rPK
   w==;
X-CSE-ConnectionGUID: JYJfHZhrTiyPbethtKimgg==
X-CSE-MsgGUID: 2ePQ8KD8T36B9BrrO/JEHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="84531037"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="84531037"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 01:19:09 -0800
X-CSE-ConnectionGUID: bVF+sbCOTbiTvkwsYfXnAA==
X-CSE-MsgGUID: CQad03VbTTiGV9wq0ZwfwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="226547347"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa002.jf.intel.com with ESMTP; 08 Dec 2025 01:19:09 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: joro@8bytes.org,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	jgg@nvidia.com
Subject: [PATCH] iommu/vt-d: Flush piotlb for SVM and Nested domain
Date: Mon,  8 Dec 2025 01:19:07 -0800
Message-Id: <20251208091907.74719-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For SVM and Nested domain, needs to use piotlb invalidation descriptor.

Fixes: b33125296b50 ("iommu/vt-d: Create unique domain ops for each stage")
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/cache.c  |  3 ++-
 drivers/iommu/intel/iommu.h  | 10 +++++++++-
 drivers/iommu/intel/nested.c |  2 +-
 drivers/iommu/intel/svm.c    |  2 +-
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 265e7290256b..bf6ebf7c4ca5 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -370,7 +370,8 @@ static void cache_tag_flush_iotlb(struct dmar_domain *domain, struct cache_tag *
 	struct intel_iommu *iommu = tag->iommu;
 	u64 type = DMA_TLB_PSI_FLUSH;
 
-	if (intel_domain_is_fs_paging(domain)) {
+	if (intel_domain_is_fs_paging(domain) ||
+	    intel_domain_is_nested_paging(domain)) {
 		qi_batch_add_piotlb(iommu, tag->domain_id, tag->pasid, addr,
 				    pages, ih, domain->qi_batch);
 		return;
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 3056583d7f56..3b655af211a9 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1379,10 +1379,18 @@ struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
 extern const struct iommu_ops intel_iommu_ops;
 extern const struct iommu_domain_ops intel_fs_paging_domain_ops;
 extern const struct iommu_domain_ops intel_ss_paging_domain_ops;
+extern const struct iommu_domain_ops intel_svm_domain_ops;
+extern const struct iommu_domain_ops intel_nested_domain_ops;
 
 static inline bool intel_domain_is_fs_paging(struct dmar_domain *domain)
 {
-	return domain->domain.ops == &intel_fs_paging_domain_ops;
+	return (domain->domain.ops == &intel_fs_paging_domain_ops) ||
+	       (domain->domain.ops == &intel_svm_domain_ops);
+}
+
+static inline bool intel_domain_is_nested_paging(struct dmar_domain *domain)
+{
+	return (domain->domain.ops == &intel_nested_domain_ops);
 }
 
 static inline bool intel_domain_is_ss_paging(struct dmar_domain *domain)
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 1b6ad9c900a5..cc755af1bd6b 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -191,7 +191,7 @@ static int intel_nested_set_dev_pasid(struct iommu_domain *domain,
 	return ret;
 }
 
-static const struct iommu_domain_ops intel_nested_domain_ops = {
+const struct iommu_domain_ops intel_nested_domain_ops = {
 	.attach_dev		= intel_nested_attach_dev,
 	.set_dev_pasid		= intel_nested_set_dev_pasid,
 	.free			= intel_nested_domain_free,
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index e147f71f91b7..75b9475c33dd 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -194,7 +194,7 @@ static void intel_svm_domain_free(struct iommu_domain *domain)
 	mmu_notifier_put(&dmar_domain->notifier);
 }
 
-static const struct iommu_domain_ops intel_svm_domain_ops = {
+const struct iommu_domain_ops intel_svm_domain_ops = {
 	.set_dev_pasid		= intel_svm_set_dev_pasid,
 	.free			= intel_svm_domain_free
 };
-- 
2.34.1

