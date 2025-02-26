Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5BF14A4DF
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 01:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532735; cv=none; b=CWN6zeI3hbW5pPyjyRoD3Ao3kpI9Vbh2DbzO1TUhg2WvdZUHX1s74l8S1yNq1V4+2v86qgtkJScF9UBXkXSqXGDxT4MBTO78iMAmopOiPfqZQfDlLDXuvuqubairhYBnCVGzJUQBYHCWgwxRPjNRmaQ0qTi/W9LDU6WHqLSnuNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532735; c=relaxed/simple;
	bh=hHSL0eB3PlwKyeyQ5szXwDWLbaX5WZREUg2BAIVwf7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZQR0wVDCXBcOjdini3dGS/Oqurd6RSruMHx2HQBkup1GAAE84aWEEwdKhpcxiev27Gze0fiVtO68p96j7JZBTh3tn7oi4J0tA+SOsz5DAwpjrscr3GjnBEdEJJMHLRsXsYv/RpsDy6TboigPB/fSrKJGWxNHNedZy9K16K3UdFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XyPhjt10; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XyPhjt10"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740532734; x=1772068734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hHSL0eB3PlwKyeyQ5szXwDWLbaX5WZREUg2BAIVwf7E=;
  b=XyPhjt10XPjAGVlZsW+NIFsqs2TbEc0k8NKMsbILCFzRJeXQAMtT8DSo
   p57J5qLfQpyDdjXY8XZW/8FI/aDrcrmaXxqZJFC7DHzhmWU/PKckrPHbY
   1bO85S0LfM5EdUTXypIIQs/nfC2Ke7+J+BQDC6lpPT/MOzaUVqBb3G4Bt
   D6L3QJG56tsiwg7hrFGwLBQJOQ7Suqljqnp7oyG7k1SqxbFgbB1J/AV7v
   5ZOJPa5k9AShenH9LxEFKU5wUs+uUXoaDzZBSuJRQqiw5USpQgRq563/f
   FGPFo7kb+233WWabKfFJd2X7vzVMYEBMo6I4RiVBmYjngPESCddIxV2iZ
   A==;
X-CSE-ConnectionGUID: S15pyTSmT/6dMyOSSerzNw==
X-CSE-MsgGUID: T6wTM1BnRD2bVQs9nb5sLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="45015873"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="45015873"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 17:18:52 -0800
X-CSE-ConnectionGUID: DcsJNnukR+2ruPfFzoXI5w==
X-CSE-MsgGUID: w8PcuYvXTd2NXRS05QEdqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="116563258"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa006.jf.intel.com with ESMTP; 25 Feb 2025 17:18:52 -0800
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
Subject: [PATCH v3 3/4] iommu: Store either domain or handle in group->pasid_array
Date: Tue, 25 Feb 2025 17:18:48 -0800
Message-Id: <20250226011849.5102-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226011849.5102-1-yi.l.liu@intel.com>
References: <20250226011849.5102-1-yi.l.liu@intel.com>
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
index bee3ebc91ae4..f9884a5cdeca 100644
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
+	if (!entry || xa_pointer_tag(entry) != IOMMU_PASID_ARRAY_HANDLE) {
 		handle = ERR_PTR(-ENOENT);
-	else if (type && handle->domain->type != type)
-		handle = ERR_PTR(-EBUSY);
+	} else {
+		handle = xa_untag_pointer(entry);
+		if (type && handle->domain->type != type)
+			handle = ERR_PTR(-EBUSY);
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

