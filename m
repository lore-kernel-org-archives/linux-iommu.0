Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7070034F261
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 06:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773036596; cv=none; b=mn75RWn66eHO0zRJksIgSszJPaGoIub9/CaTLo1ZEYXTvX97obCotX16lzA//gw3BVcNBHkJVJcM5+pkACYU6++ZXeYyYVz6hZKAuztymMxBwFP3S+k3gEYhwYymPIBEcNQVjJIDKnTt7n7aN/vpnaGAlSIN2/NKwG1ZOY79svU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773036596; c=relaxed/simple;
	bh=y8qXgGjcx+msGq9DbKTPaip+V0IsY6bVsi2//JJIGbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4KUL1X6cK1Ut24zohYyC17Z2zclFFMMuAukLsfyZBPNVIE0Bmh7x7zxclVLBClgA6iCYLCO8XkXdSB5p+tvbR7xcN85Gx5MzoIp+1rnVEDcGp3nru0tQAJr2YryO++GooTSo2thZl19YyNR7X1FHJs6BJMdUsaZy6Ct2mOAazs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A/UJGmv0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A/UJGmv0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773036596; x=1804572596;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y8qXgGjcx+msGq9DbKTPaip+V0IsY6bVsi2//JJIGbU=;
  b=A/UJGmv0Fhfz03eQ/VG4pwxjecJkgkGhyCFHZld217+Qsj9+OAqXYH99
   M0e+KPMPhEKJqK9H7VFLqbZPOXWdAaTG21hKcV4MAwCDL3LWIUvfWOZWS
   gmKAHgKULTCXAJOR2HSfGcaLoh+fYDuZCcwaDBcyi7Cb1j7lmZYwwaNoD
   fzHGZk+uti6/+hmt09mf/5MbSPMnjWC6I/+xC7DIlYeIrlec+QilZ7kyd
   IQUfk1p69JEcm0/gcepU5wdAH7VEuF89W7yGbFF3ECEqt9r2a+J5kXMHM
   d+Z8RNNIWJUMA4lM1QzSIA1IzYqg2ScyTwobn6ZwH5YHGooBx+OJVNokP
   A==;
X-CSE-ConnectionGUID: Q67UwsJlQHeMKZa4OyPm9w==
X-CSE-MsgGUID: Ynp0XuXNRb+4NF2HAiYrkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="73248288"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="73248288"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 23:09:55 -0700
X-CSE-ConnectionGUID: F+hdJFR3TVy7IuNTidKv+A==
X-CSE-MsgGUID: cLVSFpj2Q4iu+n1FV3mhow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="245669171"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa001.fm.intel.com with ESMTP; 08 Mar 2026 23:09:52 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: Dmytro Maluka <dmaluka@chromium.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 5/8] iommu/vt-d: Use intel_pasid_write() for first-stage setup
Date: Mon,  9 Mar 2026 14:06:45 +0800
Message-ID: <20260309060648.276762-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309060648.276762-1-baolu.lu@linux.intel.com>
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor intel_pasid_setup_first_level() to utilize the intel_pasid_write()
helper. By moving to the entry_sync library, the driver now constructs the
target entry in a local buffer and hands it off to intel_pasid_write().

This refactoring removes the need for __domain_setup_first_level(),
simplifies locking by using the group mutex, and ensures a consistent
update path for all first-stage setups.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |  5 -----
 drivers/iommu/intel/iommu.c | 16 +++-------------
 drivers/iommu/intel/pasid.c | 36 +++++++++---------------------------
 drivers/iommu/intel/svm.c   |  5 ++---
 4 files changed, 14 insertions(+), 48 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 54b58d01d0cb..fd6ca3b7f594 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1202,11 +1202,6 @@ domain_add_dev_pasid(struct iommu_domain *domain,
 		     struct device *dev, ioasid_t pasid);
 void domain_remove_dev_pasid(struct iommu_domain *domain,
 			     struct device *dev, ioasid_t pasid);
-
-int __domain_setup_first_level(struct intel_iommu *iommu, struct device *dev,
-			       ioasid_t pasid, u16 did, phys_addr_t fsptptr,
-			       int flags, struct iommu_domain *old);
-
 int dmar_ir_support(void);
 
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5369526e89d0..db5e8dad50dc 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1248,16 +1248,6 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 	__iommu_flush_cache(iommu, context, sizeof(*context));
 }
 
-int __domain_setup_first_level(struct intel_iommu *iommu, struct device *dev,
-			       ioasid_t pasid, u16 did, phys_addr_t fsptptr,
-			       int flags, struct iommu_domain *old)
-{
-	if (old)
-		intel_pasid_tear_down_entry(iommu, dev, pasid, false);
-
-	return intel_pasid_setup_first_level(iommu, dev, fsptptr, pasid, did, flags);
-}
-
 static int domain_setup_second_level(struct intel_iommu *iommu,
 				     struct dmar_domain *domain,
 				     struct device *dev, ioasid_t pasid,
@@ -1301,9 +1291,9 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 	      BIT(PT_FEAT_DMA_INCOHERENT)))
 		flags |= PASID_FLAG_PWSNP;
 
-	return __domain_setup_first_level(iommu, dev, pasid,
-					  domain_id_iommu(domain, iommu),
-					  pt_info.gcr3_pt, flags, old);
+	return intel_pasid_setup_first_level(iommu, dev, pt_info.gcr3_pt, pasid,
+					     domain_id_iommu(domain, iommu),
+					     flags);
 }
 
 static int dmar_domain_attach_device(struct dmar_domain *domain,
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index b7c8888afaef..8ea1ac8cbf5e 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -172,9 +172,8 @@ static const struct entry_sync_writer_ops128 writer_ops128 = {
 
 #define INTEL_PASID_SYNC_MEM_COUNT	12
 
-static int __maybe_unused intel_pasid_write(struct intel_iommu *iommu,
-					    struct device *dev, u32 pasid,
-					    u128 *target)
+static int intel_pasid_write(struct intel_iommu *iommu, struct device *dev,
+			     u32 pasid, u128 *target)
 {
 	struct pasid_entry *pte = intel_pasid_get_entry(dev, pasid);
 	struct intel_pasid_writer p_writer = {
@@ -531,17 +530,14 @@ static void intel_pasid_flush_present(struct intel_iommu *iommu,
 
 /*
  * Set up the scalable mode pasid table entry for first only
- * translation type.
+ * translation type. Caller should zero out the entry before
+ * calling.
  */
 static void pasid_pte_config_first_level(struct intel_iommu *iommu,
 					 struct pasid_entry *pte,
 					 phys_addr_t fsptptr, u16 did,
 					 int flags)
 {
-	lockdep_assert_held(&iommu->lock);
-
-	pasid_clear_entry(pte);
-
 	/* Setup the first level page table pointer: */
 	pasid_set_flptr(pte, fsptptr);
 
@@ -564,7 +560,9 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu, struct device *dev,
 				  phys_addr_t fsptptr, u32 pasid, u16 did,
 				  int flags)
 {
-	struct pasid_entry *pte;
+	struct pasid_entry new_pte = {0};
+
+	iommu_group_mutex_assert(dev);
 
 	if (!ecap_flts(iommu->ecap)) {
 		pr_err("No first level translation support on %s\n",
@@ -578,25 +576,9 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu, struct device *dev,
 		return -EINVAL;
 	}
 
-	spin_lock(&iommu->lock);
-	pte = intel_pasid_get_entry(dev, pasid);
-	if (!pte) {
-		spin_unlock(&iommu->lock);
-		return -ENODEV;
-	}
+	pasid_pte_config_first_level(iommu, &new_pte, fsptptr, did, flags);
 
-	if (pasid_pte_is_present(pte)) {
-		spin_unlock(&iommu->lock);
-		return -EBUSY;
-	}
-
-	pasid_pte_config_first_level(iommu, pte, fsptptr, did, flags);
-
-	spin_unlock(&iommu->lock);
-
-	pasid_flush_caches(iommu, pte, pasid, did);
-
-	return 0;
+	return intel_pasid_write(iommu, dev, pasid, (u128 *)&new_pte);
 }
 
 /*
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index fea10acd4f02..978d63073e3b 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -171,9 +171,8 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 	/* Setup the pasid table: */
 	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
 	sflags |= PASID_FLAG_PWSNP;
-	ret = __domain_setup_first_level(iommu, dev, pasid,
-					 FLPT_DEFAULT_DID, __pa(mm->pgd),
-					 sflags, old);
+	ret = intel_pasid_setup_first_level(iommu, dev, __pa(mm->pgd),
+					    pasid, FLPT_DEFAULT_DID, sflags);
 	if (ret)
 		goto out_unwind_iopf;
 
-- 
2.43.0

