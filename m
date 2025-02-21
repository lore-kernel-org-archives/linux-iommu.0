Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07681A270
	for <iommu@lists.linux.dev>; Fri, 21 Feb 2025 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148421; cv=none; b=aLL18U3LZr09mjBM3noA+TuoQRRy+QPL8WQlKl1mkJkdnufAxH/Urdg3kotEgANP0rc11n2ORN2yAxv8WyIq7ybHUzdB9aePead8ZouArjJeo409+x5i8sKqUaUKsjttkZzKOek0b1pgpwqKMc9bhTmUcUQVnn9V65OICflIC2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148421; c=relaxed/simple;
	bh=2IRfZtBWK21bYMaAO1BVSx+se46er1QRCDQ2oRDnHSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UWrGVIyebGhsNLfAOoWKMhxc2MrjL5wFK7nuZPy2Ghi3UOryGvE/jSWYQlwtXHAIihZfEjobCiF8oRbmr+lbpP65Qf4Wq9TixcjuOZXDf4gpiRC/LwO1CFmoSLfm3Fz9pT4zESjz9Gr46l1m58X+hTu7Sikv2xbVagz4L3ygkKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d3eiRqyf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d3eiRqyf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740148419; x=1771684419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2IRfZtBWK21bYMaAO1BVSx+se46er1QRCDQ2oRDnHSc=;
  b=d3eiRqyfm8aNFaNmQaSCZ/L85CKu1/bVf917YhfT9A5qlEhqeJTwi+dl
   /tmSZ2cniWPCa1TRLVrGW/qrSG1RfQYXeXEZRYgq9Gm8nHVd+6ZrmMWXB
   0R6qJ9ZgNcSi7Zvosz6rvrFqbWSZ+tJ9KJaMv0pxKoMi3FF4mr2qszJqk
   xhjPZgnLu4BnJGlQCKsM0dSekqt0I9RZDa6qbXiBPP9/wHSc4rGk8zYf1
   mJg+uGE/31H4BfxuhDSn8MLyTXdbbw6IV8K3hvQgv6DN17ocxpE5uZGQN
   vpYcrVR7CbnpqkxF4wOUp7Ix8W/4/D+NcYq2nkfgBFkXlqrPd+oLXAs2R
   Q==;
X-CSE-ConnectionGUID: ZHzKQ5YTTcS59jm3875j5w==
X-CSE-MsgGUID: EoJFsV6wT4yaK1dqbFVxzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="63441056"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="63441056"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 06:33:38 -0800
X-CSE-ConnectionGUID: +yRA2b9SSgKs5wEtGx6v4w==
X-CSE-MsgGUID: y8LTvPN9Tc6IC+u7/eKx5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115887172"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa007.jf.intel.com with ESMTP; 21 Feb 2025 06:33:39 -0800
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
Subject: [PATCH v2 3/4] iommu: Store either domain or handle in group->pasid_array
Date: Fri, 21 Feb 2025 06:33:34 -0800
Message-Id: <20250221143335.49874-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221143335.49874-1-yi.l.liu@intel.com>
References: <20250221143335.49874-1-yi.l.liu@intel.com>
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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index bee3ebc91ae4..eff5f678883b 100644
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
@@ -2147,6 +2150,17 @@ struct iommu_domain *iommu_get_dma_domain(struct device *dev)
 	return dev->iommu_group->default_domain;
 }
 
+static void *iommu_make_pasid_array_entry(struct iommu_domain *domain,
+					  struct iommu_attach_handle *handle)
+{
+	if (handle) {
+		handle->domain = domain;
+		return xa_tag_pointer(handle, IOMMU_PASID_ARRAY_HANDLE);
+	}
+
+	return xa_tag_pointer(domain, IOMMU_PASID_ARRAY_DOMAIN);
+}
+
 static int __iommu_attach_group(struct iommu_domain *domain,
 				struct iommu_group *group)
 {
@@ -3348,6 +3362,7 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	struct iommu_group *group = dev->iommu_group;
 	struct group_device *device;
 	const struct iommu_ops *ops;
+	void *entry;
 	int ret;
 
 	if (!group)
@@ -3371,10 +3386,9 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 		}
 	}
 
-	if (handle)
-		handle->domain = domain;
+	entry = iommu_make_pasid_array_entry(domain, handle);
 
-	ret = xa_insert(&group->pasid_array, pasid, handle, GFP_KERNEL);
+	ret = xa_insert(&group->pasid_array, pasid, entry, GFP_KERNEL);
 	if (ret)
 		goto out_unlock;
 
@@ -3454,13 +3468,17 @@ struct iommu_attach_handle *
 iommu_attach_handle_get(struct iommu_group *group, ioasid_t pasid, unsigned int type)
 {
 	struct iommu_attach_handle *handle;
+	void *entry;
 
 	xa_lock(&group->pasid_array);
-	handle = xa_load(&group->pasid_array, pasid);
-	if (!handle)
+	entry = xa_load(&group->pasid_array, pasid);
+	if (xa_pointer_tag(entry) == IOMMU_PASID_ARRAY_HANDLE) {
+		handle = xa_untag_pointer(entry);
+		if (type && handle->domain->type != type)
+			handle = ERR_PTR(-EBUSY);
+	} else {
 		handle = ERR_PTR(-ENOENT);
-	else if (type && handle->domain->type != type)
-		handle = ERR_PTR(-EBUSY);
+	}
 	xa_unlock(&group->pasid_array);
 
 	return handle;
@@ -3483,14 +3501,15 @@ int iommu_attach_group_handle(struct iommu_domain *domain,
 			      struct iommu_group *group,
 			      struct iommu_attach_handle *handle)
 {
+	void *entry;
 	int ret;
 
 	if (!handle)
 		return -EINVAL;
 
 	mutex_lock(&group->mutex);
-	handle->domain = domain;
-	ret = xa_insert(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
+	entry = iommu_make_pasid_array_entry(domain, handle);
+	ret = xa_insert(&group->pasid_array, IOMMU_NO_PASID, entry, GFP_KERNEL);
 	if (ret)
 		goto err_unlock;
 
@@ -3543,14 +3562,14 @@ int iommu_replace_group_handle(struct iommu_group *group,
 			       struct iommu_domain *new_domain,
 			       struct iommu_attach_handle *handle)
 {
-	void *curr;
+	void *curr, *entry;
 	int ret;
 
 	if (!new_domain || !handle)
 		return -EINVAL;
 
 	mutex_lock(&group->mutex);
-	handle->domain = new_domain;
+	entry = iommu_make_pasid_array_entry(new_domain, handle);
 	ret = xa_reserve(&group->pasid_array, IOMMU_NO_PASID, GFP_KERNEL);
 	if (ret)
 		goto err_unlock;
@@ -3559,7 +3578,7 @@ int iommu_replace_group_handle(struct iommu_group *group,
 	if (ret)
 		goto err_release;
 
-	curr = xa_store(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
+	curr = xa_store(&group->pasid_array, IOMMU_NO_PASID, entry, GFP_KERNEL);
 	WARN_ON(xa_is_err(curr));
 
 	mutex_unlock(&group->mutex);
-- 
2.34.1

