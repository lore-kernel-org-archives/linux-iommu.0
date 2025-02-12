Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346E21FBC86
	for <iommu@lists.linux.dev>; Wed, 12 Feb 2025 06:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739340346; cv=none; b=GxcWhpiB1XZeFNzDNyfqT34nJzn6x01PZex+xR62OQgoQ0kA3hKeH7OXsfKbUFma06vKDr99vy6Kd8ZOXLqrD+ZG0QQPIzaHyb0oURCcjXym3kB5gcfB9yTlI6ZvDqGpQLSAN4jyG6MiMzFcegEsfamKj1V28YPKZBOu6W0i90U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739340346; c=relaxed/simple;
	bh=qtnTL5RVy6tbTXXU8EAxdl3xRIJBWG7pn7C0i9z52ak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cDe760Ug4BeGoDKUUSDoASiMl8QdUWiqNehS5y5fa41fjGpY0pDRmhRmrUbmrqPfhVHC3vBiuHt1xhO/gsuV0EiHmf5YVAtpNA2vb31AZE4T7yiFarcIvVGFpGfgqxw6dxw3b05aI+LWti0ZpOkFTCzd2pw7DK85Ef0ij/K8jRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C1DBdLpY; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C1DBdLpY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739340345; x=1770876345;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qtnTL5RVy6tbTXXU8EAxdl3xRIJBWG7pn7C0i9z52ak=;
  b=C1DBdLpYr53GAQV8GQkKmzPOcjEnW3qmgSjPtvODOtbHwbFW+DGs8Oul
   XWJu16g8RItqO05iXkFw3pa6WlqeTLNnKoOqJcI6jcAm6mKNAhnSWDAUv
   ndOVwAJdZetQY2mJY9g5N5+bLI4TDssKgYFcxjnjeCHmbUFbSdifWFPH9
   P5IaoEA+Sno5QLgNSznJGXmhUcHLyXUWsXHAzwW1YmgnlwhAlgRn8wGgM
   ZROkPV2ISDpRUO1+HcMjVvg2kkiYaJ4ytGcjpPwJKvmo3+TqEFJ6GE+Mu
   GnfQS4PVXzYA1HvrK4IsJj7mFhD/Nc/kfouR8G9kKJolFz0OUdS8jZCtZ
   w==;
X-CSE-ConnectionGUID: 2rhSkkOLSNOrtLiyaeMvJA==
X-CSE-MsgGUID: 3IDt02q5SSGuAmLyskwRgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="57391237"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="57391237"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 22:05:44 -0800
X-CSE-ConnectionGUID: QiuYno6zQqKJizpbUXMyAQ==
X-CSE-MsgGUID: ktc2MGo2SY+SmV8bpwtLcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117900003"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa005.jf.intel.com with ESMTP; 11 Feb 2025 22:05:44 -0800
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
Subject: [PATCH 3/5] iommu: Store either domain or handle in group->pasid_array
Date: Tue, 11 Feb 2025 22:05:38 -0800
Message-Id: <20250212060540.261436-4-yi.l.liu@intel.com>
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

iommu_attach_device_pasid() only stores handle to group->pasid_array
when there is a valid handle input. However, it makes the
iommu_attach_device_pasid() unable to detect if the pasid has been
attached or not previously.

To be complete, let the iommu_attach_device_pasid() store the domain
to group->pasid_array if no valid handle. The other users of the
group->pasid_array should be updated to be consistent. e.g. the
iommu_attach_group_handle() and iommu_replace_group_handle().

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c | 47 +++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4ccb36b5aa30..a7ebcbaafb10 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -45,6 +45,9 @@ static unsigned int iommu_def_domain_type __read_mostly;
 static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
 static u32 iommu_cmd_line __read_mostly;
 
+/* Tags used with xa_tag_pointer() in group->pasid_array */
+enum { IOMMU_PASID_ARRAY_DOMAIN = 0, IOMMU_PASID_ARRAY_HANDLE = 1 };
+
 struct iommu_group {
 	struct kobject kobj;
 	struct kobject *devices_kobj;
@@ -3331,6 +3334,17 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
 		iommu_remove_dev_pasid(device->dev, pasid, domain);
 }
 
+static void *iommu_make_pasid_entry(struct iommu_domain *domain,
+				    struct iommu_attach_handle *handle)
+{
+	if (handle) {
+		handle->domain = domain;
+		return xa_tag_pointer(handle, IOMMU_PASID_ARRAY_HANDLE);
+	}
+
+	return xa_tag_pointer(domain, IOMMU_PASID_ARRAY_DOMAIN);
+}
+
 /*
  * iommu_attach_device_pasid() - Attach a domain to pasid of device
  * @domain: the iommu domain.
@@ -3348,6 +3362,7 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	struct iommu_group *group = dev->iommu_group;
 	struct group_device *device;
 	const struct iommu_ops *ops;
+	void *pasid_entry;
 	int ret;
 
 	if (!group)
@@ -3363,6 +3378,8 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	if (ops != domain->owner || pasid == IOMMU_NO_PASID)
 		return -EINVAL;
 
+	pasid_entry = iommu_make_pasid_entry(domain, handle);
+
 	mutex_lock(&group->mutex);
 	for_each_group_device(group, device) {
 		if (pasid >= device->dev->iommu->max_pasids) {
@@ -3371,10 +3388,7 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 		}
 	}
 
-	if (handle)
-		handle->domain = domain;
-
-	ret = xa_insert(&group->pasid_array, pasid, handle, GFP_KERNEL);
+	ret = xa_insert(&group->pasid_array, pasid, pasid_entry, GFP_KERNEL);
 	if (ret)
 		goto out_unlock;
 
@@ -3454,13 +3468,17 @@ struct iommu_attach_handle *
 iommu_attach_handle_get(struct iommu_group *group, ioasid_t pasid, unsigned int type)
 {
 	struct iommu_attach_handle *handle;
+	void *pasid_entry;
 
 	xa_lock(&group->pasid_array);
-	handle = xa_load(&group->pasid_array, pasid);
-	if (!handle)
+	pasid_entry = xa_load(&group->pasid_array, pasid);
+	if (xa_pointer_tag(pasid_entry) == IOMMU_PASID_ARRAY_HANDLE) {
+		handle = xa_untag_pointer(pasid_entry);
+		if (type && handle->domain->type != type)
+			handle = ERR_PTR(-EBUSY);
+	} else {
 		handle = ERR_PTR(-ENOENT);
-	else if (type && handle->domain->type != type)
-		handle = ERR_PTR(-EBUSY);
+	}
 	xa_unlock(&group->pasid_array);
 
 	return handle;
@@ -3483,15 +3501,17 @@ int iommu_attach_group_handle(struct iommu_domain *domain,
 			      struct iommu_group *group,
 			      struct iommu_attach_handle *handle)
 {
+	void *pasid_entry;
 	int ret;
 
 	if (!handle)
 		return -EINVAL;
 
-	handle->domain = domain;
+	pasid_entry = iommu_make_pasid_entry(domain, handle);
 
 	mutex_lock(&group->mutex);
-	ret = xa_insert(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
+	ret = xa_insert(&group->pasid_array,
+			IOMMU_NO_PASID, pasid_entry, GFP_KERNEL);
 	if (ret)
 		goto err_unlock;
 
@@ -3544,13 +3564,13 @@ int iommu_replace_group_handle(struct iommu_group *group,
 			       struct iommu_domain *new_domain,
 			       struct iommu_attach_handle *handle)
 {
-	void *curr;
+	void *curr, *pasid_entry;
 	int ret;
 
 	if (!new_domain || !handle)
 		return -EINVAL;
 
-	handle->domain = new_domain;
+	pasid_entry = iommu_make_pasid_entry(new_domain, handle);
 
 	mutex_lock(&group->mutex);
 	ret = xa_reserve(&group->pasid_array, IOMMU_NO_PASID, GFP_KERNEL);
@@ -3561,7 +3581,8 @@ int iommu_replace_group_handle(struct iommu_group *group,
 	if (ret)
 		goto err_release;
 
-	curr = xa_store(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
+	curr = xa_store(&group->pasid_array,
+			IOMMU_NO_PASID, pasid_entry, GFP_KERNEL);
 	WARN_ON(xa_is_err(curr));
 
 	mutex_unlock(&group->mutex);
-- 
2.34.1

