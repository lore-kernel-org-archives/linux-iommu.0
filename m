Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E36204C1A
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 04:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752468774; cv=none; b=CJ3Zfnpoi15Lrm0BXC+H5JLbuEE3OaCzJowvF7A0SEZLvmN8E27dPAYmFCF+ji02+1pa+jzaPM+XZEIL3LlTc4Om3HjJ934LyPb7+g1G5yimXgJ07qT28ewAyt2f74ZT3jZuoeRI/9ncISZh/xo3SrBIooU+UboTP3XBIBryAsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752468774; c=relaxed/simple;
	bh=Zo3e/7tiLVLCxcZDd4c9LLFf6IGNHzpwzRkWpHf/R6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RAWzJ+J+01AmioDd4Hbe10UC99BNEy9LdvJ/YzEguSv/lYPJSbmkRA5lgOu598W7AENv6o8fDslAGtQuXzpP3y0QAVuZRzUlbyGW1PwAsNMbtUdlgYa0Wf5chUmiFIsP6epGyInYhq/h8Kr7NQZtDDbVHoJmMTYBrDfKm6p2QyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QWQnN5sM; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QWQnN5sM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752468773; x=1784004773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zo3e/7tiLVLCxcZDd4c9LLFf6IGNHzpwzRkWpHf/R6s=;
  b=QWQnN5sMQfzQaGhVkN3uhwjeOcCbGGPDhMtYWf8m1T7FDHgZHqO5XCP3
   tgYcUCyVg8BIIzO3kV0AmSbT9S3/lQfdQWibiajlbQtCIARgRsR2/zaCF
   WsU21xF5Kw33KnCANSqn3J0y3BXQQ850dCSqA9Y7vc4lYwstT+kpybF5G
   TFoQnvzTZ98Od37twIfg2/21Z/qrw0wVzeXxvOYU1shlDa3URzdFa7dfp
   N2HUPshzLnD1riWrMMRdyNhMeG4N0Sto4C8MLS1c7nUQzE9PFrP1mVxZ8
   NLQJFsXCfsWjtTFxsmUZ4fgDWlN6wduH8toVluca3YTH1NTeydS3Ux1DX
   g==;
X-CSE-ConnectionGUID: a7MA51paQgmRuN+lCr3IFQ==
X-CSE-MsgGUID: oTsqruARTNW9+Asug8DHcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53765043"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="53765043"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 21:52:51 -0700
X-CSE-ConnectionGUID: 1tOy7zTCQzOQYwDEGy9L3g==
X-CSE-MsgGUID: 8pQDLCltRVKy+BbFSFq/Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="161166150"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa003.jf.intel.com with ESMTP; 13 Jul 2025 21:52:50 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] iommu/vt-d: Lift the __pa to domain_setup_first_level/intel_svm_set_dev_pasid()
Date: Mon, 14 Jul 2025 12:50:20 +0800
Message-ID: <20250714045028.958850-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714045028.958850-1-baolu.lu@linux.intel.com>
References: <20250714045028.958850-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

Pass the phys_addr_t down through the call chain from the top instead of
passing a pgd_t * KVA. This moves the __pa() into
domain_setup_first_level() which is the first function to obtain the pgd
from the IOMMU page table in this call chain.

The SVA flow is also adjusted to get the pa of the mm->pgd.

iommput will move the __pa() into iommupt code, it never shares the KVA of
the page table with the driver.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/1-v3-dbbe6f7e7ae3+124ffe-vtd_prep_jgg@nvidia.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 15 +++++++--------
 drivers/iommu/intel/iommu.h |  7 +++----
 drivers/iommu/intel/pasid.c | 17 +++++++++--------
 drivers/iommu/intel/pasid.h | 11 +++++------
 drivers/iommu/intel/svm.c   |  2 +-
 5 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b23efb70b52c..7c2e5e682a41 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1736,15 +1736,14 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 	intel_context_flush_no_pasid(info, context, did);
 }
 
-int __domain_setup_first_level(struct intel_iommu *iommu,
-			       struct device *dev, ioasid_t pasid,
-			       u16 did, pgd_t *pgd, int flags,
-			       struct iommu_domain *old)
+int __domain_setup_first_level(struct intel_iommu *iommu, struct device *dev,
+			       ioasid_t pasid, u16 did, phys_addr_t fsptptr,
+			       int flags, struct iommu_domain *old)
 {
 	if (!old)
-		return intel_pasid_setup_first_level(iommu, dev, pgd,
-						     pasid, did, flags);
-	return intel_pasid_replace_first_level(iommu, dev, pgd, pasid, did,
+		return intel_pasid_setup_first_level(iommu, dev, fsptptr, pasid,
+						     did, flags);
+	return intel_pasid_replace_first_level(iommu, dev, fsptptr, pasid, did,
 					       iommu_domain_did(old, iommu),
 					       flags);
 }
@@ -1793,7 +1792,7 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 
 	return __domain_setup_first_level(iommu, dev, pasid,
 					  domain_id_iommu(domain, iommu),
-					  (pgd_t *)pgd, flags, old);
+					  __pa(pgd), flags, old);
 }
 
 static bool domain_need_iotlb_sync_map(struct dmar_domain *domain,
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 61f42802fe9e..50d69cc88a1f 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1255,10 +1255,9 @@ domain_add_dev_pasid(struct iommu_domain *domain,
 void domain_remove_dev_pasid(struct iommu_domain *domain,
 			     struct device *dev, ioasid_t pasid);
 
-int __domain_setup_first_level(struct intel_iommu *iommu,
-			       struct device *dev, ioasid_t pasid,
-			       u16 did, pgd_t *pgd, int flags,
-			       struct iommu_domain *old);
+int __domain_setup_first_level(struct intel_iommu *iommu, struct device *dev,
+			       ioasid_t pasid, u16 did, phys_addr_t fsptptr,
+			       int flags, struct iommu_domain *old);
 
 int dmar_ir_support(void);
 
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index ac67a056b6c8..52f678975da7 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -348,14 +348,15 @@ static void intel_pasid_flush_present(struct intel_iommu *iommu,
  */
 static void pasid_pte_config_first_level(struct intel_iommu *iommu,
 					 struct pasid_entry *pte,
-					 pgd_t *pgd, u16 did, int flags)
+					 phys_addr_t fsptptr, u16 did,
+					 int flags)
 {
 	lockdep_assert_held(&iommu->lock);
 
 	pasid_clear_entry(pte);
 
 	/* Setup the first level page table pointer: */
-	pasid_set_flptr(pte, (u64)__pa(pgd));
+	pasid_set_flptr(pte, fsptptr);
 
 	if (flags & PASID_FLAG_FL5LP)
 		pasid_set_flpm(pte, 1);
@@ -372,9 +373,9 @@ static void pasid_pte_config_first_level(struct intel_iommu *iommu,
 	pasid_set_present(pte);
 }
 
-int intel_pasid_setup_first_level(struct intel_iommu *iommu,
-				  struct device *dev, pgd_t *pgd,
-				  u32 pasid, u16 did, int flags)
+int intel_pasid_setup_first_level(struct intel_iommu *iommu, struct device *dev,
+				  phys_addr_t fsptptr, u32 pasid, u16 did,
+				  int flags)
 {
 	struct pasid_entry *pte;
 
@@ -402,7 +403,7 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 		return -EBUSY;
 	}
 
-	pasid_pte_config_first_level(iommu, pte, pgd, did, flags);
+	pasid_pte_config_first_level(iommu, pte, fsptptr, did, flags);
 
 	spin_unlock(&iommu->lock);
 
@@ -412,7 +413,7 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 }
 
 int intel_pasid_replace_first_level(struct intel_iommu *iommu,
-				    struct device *dev, pgd_t *pgd,
+				    struct device *dev, phys_addr_t fsptptr,
 				    u32 pasid, u16 did, u16 old_did,
 				    int flags)
 {
@@ -430,7 +431,7 @@ int intel_pasid_replace_first_level(struct intel_iommu *iommu,
 		return -EINVAL;
 	}
 
-	pasid_pte_config_first_level(iommu, &new_pte, pgd, did, flags);
+	pasid_pte_config_first_level(iommu, &new_pte, fsptptr, did, flags);
 
 	spin_lock(&iommu->lock);
 	pte = intel_pasid_get_entry(dev, pasid);
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index fd0fd1a0df84..a771a77d4239 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -288,9 +288,9 @@ extern unsigned int intel_pasid_max_id;
 int intel_pasid_alloc_table(struct device *dev);
 void intel_pasid_free_table(struct device *dev);
 struct pasid_table *intel_pasid_get_table(struct device *dev);
-int intel_pasid_setup_first_level(struct intel_iommu *iommu,
-				  struct device *dev, pgd_t *pgd,
-				  u32 pasid, u16 did, int flags);
+int intel_pasid_setup_first_level(struct intel_iommu *iommu, struct device *dev,
+				  phys_addr_t fsptptr, u32 pasid, u16 did,
+				  int flags);
 int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 				   struct dmar_domain *domain,
 				   struct device *dev, u32 pasid);
@@ -302,9 +302,8 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
 			     u32 pasid, struct dmar_domain *domain);
 int intel_pasid_replace_first_level(struct intel_iommu *iommu,
-				    struct device *dev, pgd_t *pgd,
-				    u32 pasid, u16 did, u16 old_did,
-				    int flags);
+				    struct device *dev, phys_addr_t fsptptr,
+				    u32 pasid, u16 did, u16 old_did, int flags);
 int intel_pasid_replace_second_level(struct intel_iommu *iommu,
 				     struct dmar_domain *domain,
 				     struct device *dev, u16 old_did,
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index f3da596410b5..8c0bed36c587 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -171,7 +171,7 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 	/* Setup the pasid table: */
 	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
 	ret = __domain_setup_first_level(iommu, dev, pasid,
-					 FLPT_DEFAULT_DID, mm->pgd,
+					 FLPT_DEFAULT_DID, __pa(mm->pgd),
 					 sflags, old);
 	if (ret)
 		goto out_unwind_iopf;
-- 
2.43.0

