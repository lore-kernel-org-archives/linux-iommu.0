Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A684C6C
	for <iommu@lists.linux.dev>; Tue, 13 May 2025 03:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747105621; cv=none; b=D6k9J/pY+qLIRtSw4WeI3wL0XvqxK5sqT60R/QmMnd+YgsLcAOR9+tyAfRN4Ulue+qvIQuwDlp76Xi5bxYOuSSO1aiArh98wo9gTxJDDIRVXNKmcZeXZf3eQT1srOJ+e78SbgD4Zc7ryZLunxUlYdre9xEjF4C/Fxz29r6fR7aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747105621; c=relaxed/simple;
	bh=gkabQMWS1jUb5adlyFWFdTaBwWerIYg1lXMMuQ9p+WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWj52c37t7E94Idi0nnA6bpTt3nbQmjOtvtkwfY6fMc8qDVa39txbT79K9BJ3Lbfw4MWDNqZqNinvTfPQ2QmGm3vv65bam6tpie6wXZLv0gItzblYx4IMRoxdJPZKbXz6keKQnJI6gUCAmP83EG6YBzl6AqAZAoQqTP3AY945Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VEOpEAGI; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VEOpEAGI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747105619; x=1778641619;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gkabQMWS1jUb5adlyFWFdTaBwWerIYg1lXMMuQ9p+WE=;
  b=VEOpEAGIJajdpFg4PJEp7j/NmaqjyL0QrVgNdGKuK5Cp5OOP93GiEN3T
   wRoGM2jNK4S16OHAbnppM7/OCd4KEhbuyCy1UnwwbJJLPk6VUSPYGjJik
   tb90SYZXJGL6x0r2zBusbzuChDGMB7NI5/zT7UqkqmGBw3l8oRu35Hv8K
   Q2Q1+YJdGO0fzKcBSNG4MmINAOrcswr2akC+ddBItb9BMSWN7JNDyb3wu
   xyo1FcvUGApWuteygKgKGB8BTEo8B3GjLmTKzoS47t1Xv/g/aHMi7xdm/
   oB9603/0pfegwwYXeGnFamQieqsOs6EGNbk6YzShPweaofInSkWiX96Pm
   w==;
X-CSE-ConnectionGUID: hMxrM/OrT96klYXGhviRCQ==
X-CSE-MsgGUID: kxw4YVtCRMSvwrIYYPGS+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="52735278"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="52735278"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 20:06:59 -0700
X-CSE-ConnectionGUID: cvW6KDV7RcqIEJzFaZz2+w==
X-CSE-MsgGUID: RMHKh5WKQMCSyxeo28DqZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="138522217"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa009.fm.intel.com with ESMTP; 12 May 2025 20:06:58 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] iommu/vt-d: Use ida to manage domain id
Date: Tue, 13 May 2025 11:07:36 +0800
Message-ID: <20250513030739.2718555-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250513030739.2718555-1-baolu.lu@linux.intel.com>
References: <20250513030739.2718555-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch the intel iommu driver to use the ida mechanism for managing domain
IDs, replacing the previous fixed-size bitmap.

The previous approach allocated a bitmap large enough to cover the maximum
number of domain IDs supported by the hardware, regardless of the actual
number of domains in use. This led to unnecessary memory consumption,
especially on systems supporting a large number of iommu units but only
utilizing a small number of domain IDs.

The ida allocator dynamically manages the allocation and freeing of integer
IDs, only consuming memory for the IDs that are currently in use. This
significantly optimizes memory usage compared to the fixed-size bitmap.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20250430021135.2370244-2-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/dmar.c  |  3 ++
 drivers/iommu/intel/iommu.c | 80 ++++++++-----------------------------
 drivers/iommu/intel/iommu.h | 19 +++++++--
 3 files changed, 34 insertions(+), 68 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index e540092d664d..0e35969c026b 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1099,6 +1099,8 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 	spin_lock_init(&iommu->device_rbtree_lock);
 	mutex_init(&iommu->iopf_lock);
 	iommu->node = NUMA_NO_NODE;
+	spin_lock_init(&iommu->lock);
+	ida_init(&iommu->domain_ida);
 
 	ver = readl(iommu->reg + DMAR_VER_REG);
 	pr_info("%s: reg_base_addr %llx ver %d:%d cap %llx ecap %llx\n",
@@ -1195,6 +1197,7 @@ static void free_iommu(struct intel_iommu *iommu)
 	if (iommu->reg)
 		unmap_iommu(iommu);
 
+	ida_destroy(&iommu->domain_ida);
 	ida_free(&dmar_seq_ids, iommu->seq_id);
 	kfree(iommu);
 }
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 67c6ea1d8d44..0cac6b00adb0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1289,52 +1289,13 @@ static void iommu_disable_translation(struct intel_iommu *iommu)
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 }
 
-static int iommu_init_domains(struct intel_iommu *iommu)
-{
-	u32 ndomains;
-
-	ndomains = cap_ndoms(iommu->cap);
-	pr_debug("%s: Number of Domains supported <%d>\n",
-		 iommu->name, ndomains);
-
-	spin_lock_init(&iommu->lock);
-
-	iommu->domain_ids = bitmap_zalloc(ndomains, GFP_KERNEL);
-	if (!iommu->domain_ids)
-		return -ENOMEM;
-
-	/*
-	 * If Caching mode is set, then invalid translations are tagged
-	 * with domain-id 0, hence we need to pre-allocate it. We also
-	 * use domain-id 0 as a marker for non-allocated domain-id, so
-	 * make sure it is not used for a real domain.
-	 */
-	set_bit(0, iommu->domain_ids);
-
-	/*
-	 * Vt-d spec rev3.0 (section 6.2.3.1) requires that each pasid
-	 * entry for first-level or pass-through translation modes should
-	 * be programmed with a domain id different from those used for
-	 * second-level or nested translation. We reserve a domain id for
-	 * this purpose. This domain id is also used for identity domain
-	 * in legacy mode.
-	 */
-	set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
-
-	return 0;
-}
-
 static void disable_dmar_iommu(struct intel_iommu *iommu)
 {
-	if (!iommu->domain_ids)
-		return;
-
 	/*
 	 * All iommu domains must have been detached from the devices,
 	 * hence there should be no domain IDs in use.
 	 */
-	if (WARN_ON(bitmap_weight(iommu->domain_ids, cap_ndoms(iommu->cap))
-		    > NUM_RESERVED_DID))
+	if (WARN_ON(!ida_is_empty(&iommu->domain_ida)))
 		return;
 
 	if (iommu->gcmd & DMA_GCMD_TE)
@@ -1343,11 +1304,6 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
 
 static void free_dmar_iommu(struct intel_iommu *iommu)
 {
-	if (iommu->domain_ids) {
-		bitmap_free(iommu->domain_ids);
-		iommu->domain_ids = NULL;
-	}
-
 	if (iommu->copied_tables) {
 		bitmap_free(iommu->copied_tables);
 		iommu->copied_tables = NULL;
@@ -1380,7 +1336,6 @@ static bool first_level_by_default(struct intel_iommu *iommu)
 int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 {
 	struct iommu_domain_info *info, *curr;
-	unsigned long ndomains;
 	int num, ret = -ENOSPC;
 
 	if (domain->domain.type == IOMMU_DOMAIN_SVA)
@@ -1399,14 +1354,13 @@ int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 		return 0;
 	}
 
-	ndomains = cap_ndoms(iommu->cap);
-	num = find_first_zero_bit(iommu->domain_ids, ndomains);
-	if (num >= ndomains) {
+	num = ida_alloc_range(&iommu->domain_ida, IDA_START_DID,
+			      cap_ndoms(iommu->cap) - 1, GFP_ATOMIC);
+	if (num < 0) {
 		pr_err("%s: No free domain ids\n", iommu->name);
 		goto err_unlock;
 	}
 
-	set_bit(num, iommu->domain_ids);
 	info->refcnt	= 1;
 	info->did	= num;
 	info->iommu	= iommu;
@@ -1421,7 +1375,7 @@ int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 	return 0;
 
 err_clear:
-	clear_bit(info->did, iommu->domain_ids);
+	ida_free(&iommu->domain_ida, info->did);
 err_unlock:
 	spin_unlock(&iommu->lock);
 	kfree(info);
@@ -1438,7 +1392,7 @@ void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 	spin_lock(&iommu->lock);
 	info = xa_load(&domain->iommu_array, iommu->seq_id);
 	if (--info->refcnt == 0) {
-		clear_bit(info->did, iommu->domain_ids);
+		ida_free(&iommu->domain_ida, info->did);
 		xa_erase(&domain->iommu_array, iommu->seq_id);
 		domain->nid = NUMA_NO_NODE;
 		kfree(info);
@@ -2041,7 +1995,7 @@ static int copy_context_table(struct intel_iommu *iommu,
 
 		did = context_domain_id(&ce);
 		if (did >= 0 && did < cap_ndoms(iommu->cap))
-			set_bit(did, iommu->domain_ids);
+			ida_alloc_range(&iommu->domain_ida, did, did, GFP_KERNEL);
 
 		set_context_copied(iommu, bus, devfn);
 		new_ce[idx] = ce;
@@ -2168,11 +2122,6 @@ static int __init init_dmars(void)
 		}
 
 		intel_iommu_init_qi(iommu);
-
-		ret = iommu_init_domains(iommu);
-		if (ret)
-			goto free_iommu;
-
 		init_translation_status(iommu);
 
 		if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
@@ -2650,9 +2599,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	if (iommu->gcmd & DMA_GCMD_TE)
 		iommu_disable_translation(iommu);
 
-	ret = iommu_init_domains(iommu);
-	if (ret == 0)
-		ret = iommu_alloc_root_entry(iommu);
+	ret = iommu_alloc_root_entry(iommu);
 	if (ret)
 		goto out;
 
@@ -2971,9 +2918,14 @@ static ssize_t domains_used_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
 	struct intel_iommu *iommu = dev_to_intel_iommu(dev);
-	return sysfs_emit(buf, "%d\n",
-			  bitmap_weight(iommu->domain_ids,
-					cap_ndoms(iommu->cap)));
+	unsigned int count = 0;
+	int id;
+
+	for (id = 0; id < cap_ndoms(iommu->cap); id++)
+		if (ida_exists(&iommu->domain_ida, id))
+			count++;
+
+	return sysfs_emit(buf, "%d\n", count);
 }
 static DEVICE_ATTR_RO(domains_used);
 
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index c4916886da5a..25faf3aadd24 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -722,7 +722,7 @@ struct intel_iommu {
 	unsigned char	name[16];    /* Device Name */
 
 #ifdef CONFIG_INTEL_IOMMU
-	unsigned long 	*domain_ids; /* bitmap of domains */
+	struct ida	domain_ida; /* domain id allocator */
 	unsigned long	*copied_tables; /* bitmap of copied tables */
 	spinlock_t	lock; /* protect context, domain ids */
 	struct root_entry *root_entry; /* virtual address */
@@ -809,11 +809,22 @@ static inline struct dmar_domain *to_dmar_domain(struct iommu_domain *dom)
 }
 
 /*
- * Domain ID reserved for pasid entries programmed for first-level
- * only and pass-through transfer modes.
+ * Domain ID 0 and 1 are reserved:
+ *
+ * If Caching mode is set, then invalid translations are tagged
+ * with domain-id 0, hence we need to pre-allocate it. We also
+ * use domain-id 0 as a marker for non-allocated domain-id, so
+ * make sure it is not used for a real domain.
+ *
+ * Vt-d spec rev3.0 (section 6.2.3.1) requires that each pasid
+ * entry for first-level or pass-through translation modes should
+ * be programmed with a domain id different from those used for
+ * second-level or nested translation. We reserve a domain id for
+ * this purpose. This domain id is also used for identity domain
+ * in legacy mode.
  */
 #define FLPT_DEFAULT_DID		1
-#define NUM_RESERVED_DID		2
+#define IDA_START_DID			2
 
 /* Retrieve the domain ID which has allocated to the domain */
 static inline u16
-- 
2.43.0

