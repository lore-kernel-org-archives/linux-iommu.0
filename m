Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873501FBC9A
	for <iommu@lists.linux.dev>; Wed, 12 Feb 2025 06:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739340348; cv=none; b=qqTWLgrLnR7c+pDikiP5yHLglmsDfIabGgNoQQMFB11VerzexsgyweB/MgTZSPzeOip19J1qbKCLgzXGnEPFPsMuf1sCg7jroMbXQA1yfQg2PMt0DrGPN5mGEze6yuczCEVNTgmSgkifoKCCPg+TCgGWNF8RIekL5OfNI5foVP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739340348; c=relaxed/simple;
	bh=8SDNQH23x2GSjEXlL3Zke3NGPQKDwh2lxN++zwJACb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jz8IcyLHyM960PperpwoWIoMT1BeCRFNh5WLPmiyspiZK8ZXy47SjN1B3H7LpK1rVfOga8ha7326qTRkWDtfgWF1Ni5uS5rMegoisZ8SVE6347/14XWPgYuUkCG1oXnvjbY/M0xcLEXaU2uPQ3WytLMuiUpDs5+ErckCbDN3NDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LkZe1UsX; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LkZe1UsX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739340347; x=1770876347;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8SDNQH23x2GSjEXlL3Zke3NGPQKDwh2lxN++zwJACb0=;
  b=LkZe1UsXIak0s0h/KqSvAaftyvbSm+CaZRBeYlR8fjMNjxoGoCs8eedY
   G+advjpfXY1TUDP/6eSwdQBYgEelzPp5kQxMaEXRQW8F3O9PnKXdpQbx6
   cQFj9/B/cVgTKEbywZ0LQJB9OHU9NnyXkBtvw9VqLuCpMGRIYk0hSRHjH
   ei72VDUEt4DREDsOgC2tUMuCNjEhlPz/+TsaEloLKtBvjfg33fxE5LgAz
   G5yOPPPTWGyrnZwpq5fJWN3scflkfOHT2Lsxqcz059CTKeQco2vdeyHAt
   XLXHSoX63chbDTJPGK0AkfMWhxXTMaPJHR3OGsW0ve4+XMSb/clCVQn2M
   Q==;
X-CSE-ConnectionGUID: AtNGgeMERb+qRQb+A1W/5A==
X-CSE-MsgGUID: We+23YG6TZ+Rkr56EqKxdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="57391250"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="57391250"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 22:05:45 -0800
X-CSE-ConnectionGUID: oxyqhjWYRLqogNmflAb9HA==
X-CSE-MsgGUID: mIi3C8JZQjagCYv0gk4oaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117900013"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa005.jf.intel.com with ESMTP; 11 Feb 2025 22:05:45 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com
Cc: kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	robin.murphy@arm.com,
	nicolinc@nvidia.com,
	will@kernel.org
Subject: [PATCH 5/5] iommu: Retire group->domain
Date: Tue, 11 Feb 2025 22:05:40 -0800
Message-Id: <20250212060540.261436-6-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212060540.261436-1-yi.l.liu@intel.com>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

group->domain stores the current attached domain of the group. Now, it is
also stored in group->pasid_array[0], hence retire the group->domain.

Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/dma-iommu.c  |   3 +-
 drivers/iommu/iommu-priv.h |   1 +
 drivers/iommu/iommu.c      | 178 +++++++++++++++++++++----------------
 3 files changed, 106 insertions(+), 76 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 2a9fa0c8cc00..5da9aca0c021 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -34,6 +34,7 @@
 
 #include "dma-iommu.h"
 #include "iommu-pages.h"
+#include "iommu-priv.h"
 
 struct iommu_dma_msi_page {
 	struct list_head	list;
@@ -1746,7 +1747,7 @@ size_t iommu_dma_max_mapping_size(struct device *dev)
 
 void iommu_setup_dma_ops(struct device *dev)
 {
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct iommu_domain *domain = iommu_group_domain(dev->iommu_group);
 
 	if (dev_is_pci(dev))
 		dev->iommu->pci_32bit_workaround = !iommu_dma_forcedac;
diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index de5b54eaa8bf..fedc57754a48 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -46,4 +46,5 @@ void iommu_detach_group_handle(struct iommu_domain *domain,
 int iommu_replace_group_handle(struct iommu_group *group,
 			       struct iommu_domain *new_domain,
 			       struct iommu_attach_handle *handle);
+struct iommu_domain *iommu_group_domain(struct iommu_group *group);
 #endif /* __LINUX_IOMMU_PRIV_H */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d673feab82aa..c3bf8e131a8e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -60,7 +60,6 @@ struct iommu_group {
 	int id;
 	struct iommu_domain *default_domain;
 	struct iommu_domain *blocking_domain;
-	struct iommu_domain *domain;
 	struct list_head entry;
 	unsigned int owner_cnt;
 	void *owner;
@@ -101,7 +100,8 @@ static void iommu_release_device(struct device *dev);
 static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev);
 static int __iommu_attach_group(struct iommu_domain *domain,
-				struct iommu_group *group);
+				struct iommu_group *group,
+				struct iommu_attach_handle *handle);
 static struct iommu_domain *__iommu_paging_domain_alloc_flags(struct device *dev,
 						       unsigned int type,
 						       unsigned int flags);
@@ -116,19 +116,26 @@ static int __iommu_device_set_domain(struct iommu_group *group,
 				     unsigned int flags);
 static int __iommu_group_set_domain_internal(struct iommu_group *group,
 					     struct iommu_domain *new_domain,
+					     struct iommu_attach_handle *handle,
 					     unsigned int flags);
 static int __iommu_group_set_domain(struct iommu_group *group,
 				    struct iommu_domain *new_domain)
 {
-	return __iommu_group_set_domain_internal(group, new_domain, 0);
+	return __iommu_group_set_domain_internal(group, new_domain, NULL, 0);
 }
 static void __iommu_group_set_domain_nofail(struct iommu_group *group,
 					    struct iommu_domain *new_domain)
 {
 	WARN_ON(__iommu_group_set_domain_internal(
-		group, new_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED));
+		group, new_domain, NULL, IOMMU_SET_DOMAIN_MUST_SUCCEED));
 }
 
+static int __iommu_group_set_domain_handle(struct iommu_group *group,
+					   struct iommu_domain *new_domain,
+					   struct iommu_attach_handle *handle)
+{
+	return __iommu_group_set_domain_internal(group, new_domain, handle, 0);
+}
 static int iommu_setup_default_domain(struct iommu_group *group,
 				      int target_type);
 static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
@@ -504,7 +511,7 @@ static void iommu_deinit_device(struct device *dev)
 			iommu_domain_free(group->blocking_domain);
 			group->blocking_domain = NULL;
 		}
-		group->domain = NULL;
+		xa_erase(&group->pasid_array, IOMMU_NO_PASID);
 	}
 
 	/* Caller must put iommu_group */
@@ -515,8 +522,29 @@ static void iommu_deinit_device(struct device *dev)
 
 DEFINE_MUTEX(iommu_probe_device_lock);
 
+struct iommu_domain *iommu_group_domain(struct iommu_group *group)
+{
+	struct iommu_domain *domain;
+	void *pasid_entry;
+
+	lockdep_assert_held(&group->mutex);
+
+	pasid_entry = xa_load(&group->pasid_array, IOMMU_NO_PASID);
+	if (xa_pointer_tag(pasid_entry) == IOMMU_PASID_ARRAY_HANDLE) {
+		struct iommu_attach_handle *handle;
+
+		handle = xa_untag_pointer(pasid_entry);
+		domain = handle->domain;
+	} else {
+		domain = xa_untag_pointer(pasid_entry);
+	}
+
+	return domain;
+}
+
 static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
 {
+	struct iommu_domain *gdomain;
 	const struct iommu_ops *ops;
 	struct iommu_group *group;
 	struct group_device *gdev;
@@ -563,11 +591,12 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	 * iommu_setup_default_domain()
 	 */
 	list_add_tail(&gdev->list, &group->devices);
-	WARN_ON(group->default_domain && !group->domain);
+	gdomain = iommu_group_domain(group);
+	WARN_ON(group->default_domain && !gdomain);
 	if (group->default_domain)
 		iommu_create_device_direct_mappings(group->default_domain, dev);
-	if (group->domain) {
-		ret = __iommu_device_set_domain(group, dev, group->domain, 0);
+	if (gdomain) {
+		ret = __iommu_device_set_domain(group, dev, gdomain, 0);
 		if (ret)
 			goto err_remove_gdev;
 	} else if (!group->default_domain && !group_list) {
@@ -625,6 +654,8 @@ static void __iommu_group_free_device(struct iommu_group *group,
 {
 	struct device *dev = grp_dev->dev;
 
+	lockdep_assert_held(&group->mutex);
+
 	sysfs_remove_link(group->devices_kobj, grp_dev->name);
 	sysfs_remove_link(&dev->kobj, "iommu_group");
 
@@ -637,7 +668,7 @@ static void __iommu_group_free_device(struct iommu_group *group,
 	 */
 	if (list_empty(&group->devices))
 		WARN_ON(group->owner_cnt ||
-			group->domain != group->default_domain);
+			iommu_group_domain(group) != group->default_domain);
 
 	kfree(grp_dev->name);
 	kfree(grp_dev);
@@ -2094,7 +2125,7 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 	if (list_count_nodes(&group->devices) != 1)
 		goto out_unlock;
 
-	ret = __iommu_attach_group(domain, group);
+	ret = __iommu_attach_group(domain, group, NULL);
 
 out_unlock:
 	mutex_unlock(&group->mutex);
@@ -2119,7 +2150,7 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 		return;
 
 	mutex_lock(&group->mutex);
-	if (WARN_ON(domain != group->domain) ||
+	if (WARN_ON(domain != iommu_group_domain(group)) ||
 	    WARN_ON(list_count_nodes(&group->devices) != 1))
 		goto out_unlock;
 	__iommu_group_set_core_domain(group);
@@ -2133,11 +2164,16 @@ struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)
 {
 	/* Caller must be a probed driver on dev */
 	struct iommu_group *group = dev->iommu_group;
+	struct iommu_domain *gdomain;
 
 	if (!group)
 		return NULL;
 
-	return group->domain;
+	mutex_lock(&group->mutex);
+	gdomain = iommu_group_domain(group);
+	mutex_unlock(&group->mutex);
+
+	return gdomain;
 }
 EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev);
 
@@ -2151,19 +2187,25 @@ struct iommu_domain *iommu_get_dma_domain(struct device *dev)
 }
 
 static int __iommu_attach_group(struct iommu_domain *domain,
-				struct iommu_group *group)
+				struct iommu_group *group,
+				struct iommu_attach_handle *handle)
 {
+	struct iommu_domain *gdomain;
 	struct device *dev;
 
-	if (group->domain && group->domain != group->default_domain &&
-	    group->domain != group->blocking_domain)
+	lockdep_assert_held(&group->mutex);
+
+	gdomain = iommu_group_domain(group);
+
+	if (gdomain && gdomain != group->default_domain &&
+	    gdomain != group->blocking_domain)
 		return -EBUSY;
 
 	dev = iommu_group_first_dev(group);
 	if (!dev_has_iommu(dev) || dev_iommu_ops(dev) != domain->owner)
 		return -EINVAL;
 
-	return __iommu_group_set_domain(group, domain);
+	return __iommu_group_set_domain_handle(group, domain, handle);
 }
 
 /**
@@ -2183,7 +2225,7 @@ int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
 	int ret;
 
 	mutex_lock(&group->mutex);
-	ret = __iommu_attach_group(domain, group);
+	ret = __iommu_attach_group(domain, group, NULL);
 	mutex_unlock(&group->mutex);
 
 	return ret;
@@ -2234,6 +2276,9 @@ static int __iommu_device_set_domain(struct iommu_group *group,
 	return 0;
 }
 
+static void *iommu_make_pasid_entry(struct iommu_domain *domain,
+				    struct iommu_attach_handle *handle);
+
 /*
  * If 0 is returned the group's domain is new_domain. If an error is returned
  * then the group's domain will be set back to the existing domain unless
@@ -2251,26 +2296,34 @@ static int __iommu_device_set_domain(struct iommu_group *group,
  */
 static int __iommu_group_set_domain_internal(struct iommu_group *group,
 					     struct iommu_domain *new_domain,
+					     struct iommu_attach_handle *handle,
 					     unsigned int flags)
 {
 	struct group_device *last_gdev;
+	struct iommu_domain *gdomain;
 	struct group_device *gdev;
+	void *pasid_entry;
 	int result;
 	int ret;
 
 	lockdep_assert_held(&group->mutex);
 
-	if (group->domain == new_domain)
+	gdomain = iommu_group_domain(group);
+	if (gdomain == new_domain)
 		return 0;
 
 	if (WARN_ON(!new_domain))
 		return -EINVAL;
 
+	ret = xa_reserve(&group->pasid_array, IOMMU_NO_PASID, GFP_KERNEL);
+	if (ret)
+		return ret;
+
 	/*
 	 * Changing the domain is done by calling attach_dev() on the new
 	 * domain. This switch does not have to be atomic and DMA can be
 	 * discarded during the transition. DMA must only be able to access
-	 * either new_domain or group->domain, never something else.
+	 * either new_domain or the old domain, never something else.
 	 */
 	result = 0;
 	for_each_group_device(group, gdev) {
@@ -2290,7 +2343,10 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,
 			goto err_revert;
 		}
 	}
-	group->domain = new_domain;
+
+	pasid_entry = iommu_make_pasid_entry(new_domain, handle);
+	WARN_ON(xa_is_err(xa_store(&group->pasid_array,
+				   IOMMU_NO_PASID, pasid_entry, GFP_KERNEL)));
 	return result;
 
 err_revert:
@@ -2302,16 +2358,17 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,
 	for_each_group_device(group, gdev) {
 		/*
 		 * A NULL domain can happen only for first probe, in which case
-		 * we leave group->domain as NULL and let release clean
+		 * we leave domain in pasid_array as NULL and let release clean
 		 * everything up.
 		 */
-		if (group->domain)
+		if (gdomain)
 			WARN_ON(__iommu_device_set_domain(
-				group, gdev->dev, group->domain,
+				group, gdev->dev, gdomain,
 				IOMMU_SET_DOMAIN_MUST_SUCCEED));
 		if (gdev == last_gdev)
 			break;
 	}
+	xa_release(&group->pasid_array, IOMMU_NO_PASID);
 	return ret;
 }
 
@@ -2944,7 +3001,7 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 
 	/* We must set default_domain early for __iommu_device_set_domain */
 	group->default_domain = dom;
-	if (!group->domain) {
+	if (!iommu_group_domain(group)) {
 		/*
 		 * Drivers are not allowed to fail the first domain attach.
 		 * The only way to recover from this is to fail attaching the
@@ -2952,7 +3009,7 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 		 * in group->default_domain so it is freed after.
 		 */
 		ret = __iommu_group_set_domain_internal(
-			group, dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
+			group, dom, NULL, IOMMU_SET_DOMAIN_MUST_SUCCEED);
 		if (WARN_ON(ret))
 			goto out_free_old;
 	} else {
@@ -2983,7 +3040,7 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 err_restore_domain:
 	if (old_dom)
 		__iommu_group_set_domain_internal(
-			group, old_dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
+			group, old_dom, NULL, IOMMU_SET_DOMAIN_MUST_SUCCEED);
 err_restore_def_domain:
 	if (old_dom) {
 		iommu_domain_free(dom);
@@ -3056,6 +3113,14 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	return ret ?: count;
 }
 
+static bool iommu_group_pasid_used(struct iommu_group *group)
+{
+	unsigned long start = IOMMU_NO_PASID;
+
+	lockdep_assert_held(&group->mutex);
+	return xa_find_after(&group->pasid_array, &start, UINT_MAX, XA_PRESENT);
+}
+
 /**
  * iommu_device_use_default_domain() - Device driver wants to handle device
  *                                     DMA through the kernel DMA API.
@@ -3075,8 +3140,8 @@ int iommu_device_use_default_domain(struct device *dev)
 
 	mutex_lock(&group->mutex);
 	if (group->owner_cnt) {
-		if (group->domain != group->default_domain || group->owner ||
-		    !xa_empty(&group->pasid_array)) {
+		if (iommu_group_domain(group) != group->default_domain ||
+		    group->owner || iommu_group_pasid_used(group)) {
 			ret = -EBUSY;
 			goto unlock_out;
 		}
@@ -3106,7 +3171,7 @@ void iommu_device_unuse_default_domain(struct device *dev)
 		return;
 
 	mutex_lock(&group->mutex);
-	if (!WARN_ON(!group->owner_cnt || !xa_empty(&group->pasid_array)))
+	if (!WARN_ON(!group->owner_cnt || iommu_group_pasid_used(group)))
 		group->owner_cnt--;
 
 	mutex_unlock(&group->mutex);
@@ -3139,10 +3204,14 @@ static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
 
 static int __iommu_take_dma_ownership(struct iommu_group *group, void *owner)
 {
+	struct iommu_domain *gdomain;
 	int ret;
 
-	if ((group->domain && group->domain != group->default_domain) ||
-	    !xa_empty(&group->pasid_array))
+	lockdep_assert_held(&group->mutex);
+
+	gdomain = iommu_group_domain(group);
+	if ((gdomain && gdomain != group->default_domain) ||
+	    iommu_group_pasid_used(group))
 		return -EBUSY;
 
 	ret = __iommu_group_alloc_blocking_domain(group);
@@ -3228,7 +3297,7 @@ EXPORT_SYMBOL_GPL(iommu_device_claim_dma_owner);
 static void __iommu_release_dma_ownership(struct iommu_group *group)
 {
 	if (WARN_ON(!group->owner_cnt || !group->owner ||
-		    !xa_empty(&group->pasid_array)))
+		    iommu_group_pasid_used(group)))
 		return;
 
 	group->owner_cnt = 0;
@@ -3509,37 +3578,15 @@ int iommu_attach_group_handle(struct iommu_domain *domain,
 			      struct iommu_group *group,
 			      struct iommu_attach_handle *handle)
 {
-	void *pasid_entry;
 	int ret;
 
 	if (!handle)
 		return -EINVAL;
 
-	pasid_entry = iommu_make_pasid_entry(domain, handle);
-
 	mutex_lock(&group->mutex);
-	if (xa_load(&group->pasid_array, IOMMU_NO_PASID)) {
-		ret = -EBUSY;
-		goto err_unlock;
-	}
-
-	ret = __iommu_attach_group(domain, group);
-	if (ret)
-		goto err_unlock;
-
-	ret = xa_insert(&group->pasid_array,
-			IOMMU_NO_PASID, pasid_entry, GFP_KERNEL);
-	if (ret) {
-		WARN_ON(ret == -EBUSY);
-		goto err_remove;
-	}
+	ret = __iommu_attach_group(domain, group, handle);
 	mutex_unlock(&group->mutex);
 
-	return 0;
-err_remove:
-	__iommu_group_set_core_domain(group);
-err_unlock:
-	mutex_unlock(&group->mutex);
 	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(iommu_attach_group_handle, "IOMMUFD_INTERNAL");
@@ -3579,34 +3626,15 @@ int iommu_replace_group_handle(struct iommu_group *group,
 			       struct iommu_domain *new_domain,
 			       struct iommu_attach_handle *handle)
 {
-	void *curr, *pasid_entry;
 	int ret;
 
 	if (!new_domain || !handle)
 		return -EINVAL;
 
-	pasid_entry = iommu_make_pasid_entry(new_domain, handle);
-
 	mutex_lock(&group->mutex);
-	ret = xa_reserve(&group->pasid_array, IOMMU_NO_PASID, GFP_KERNEL);
-	if (ret)
-		goto err_unlock;
-
-	ret = __iommu_group_set_domain(group, new_domain);
-	if (ret)
-		goto err_release;
-
-	curr = xa_store(&group->pasid_array,
-			IOMMU_NO_PASID, pasid_entry, GFP_KERNEL);
-	WARN_ON(xa_is_err(curr));
-
+	ret = __iommu_group_set_domain_handle(group, new_domain, handle);
 	mutex_unlock(&group->mutex);
 
-	return 0;
-err_release:
-	xa_release(&group->pasid_array, IOMMU_NO_PASID);
-err_unlock:
-	mutex_unlock(&group->mutex);
 	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
-- 
2.34.1

