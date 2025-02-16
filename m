Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435C9502BE
	for <iommu@lists.linux.dev>; Sun, 16 Feb 2025 03:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739677954; cv=none; b=AfPIJ+trGAe5qVEBFaN4DK4p/SpTGM/p1tz3ioX9R/ZjbFVTZMBpfVwYcvlYPXaqrXQ2bG4ow2peWq6G0bIK1wX4WOWpiRUXaMEfY7WH7urieGL72sqIZGW0MQKu3QmUtt9vwPVvaM1YCPGsnlIZPrIzSGhw4xH3xHP2H9ftT8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739677954; c=relaxed/simple;
	bh=A359sN2npfc4WIbCaHarLUor88+HWUy378C+1QUPEio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PxKtpV+hF+8nr0L6FPsyhrZsQuuzhVr9FEPuK1ezVrxKE1MSpZj/lQknZk0bJrWjYqlKMwDQ9qpadWBuH7AgbiBnOMxFeXMh1emDdIsy0sn++aQiwRNl9eVvgaeF9uD3HIw4b+oTfVTiwK0WCJX6q49VOAjCDgpSown0Kmdttuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jfdZs9Kg; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jfdZs9Kg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739677953; x=1771213953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A359sN2npfc4WIbCaHarLUor88+HWUy378C+1QUPEio=;
  b=jfdZs9Kgcmoldf/pvflJuG7MOfNclnG9oHOhj+TiBojptjSz2Gm/y/yC
   ZPvRCjtJCIFUCx/XKIB9983IiZbFQGTZD45/3tendnz5KPCYGhxrwb+va
   IxyvSRoXXb1gxGqMufe4iHtQvrvGBg84HVt8Yj4lgd7ChJ6NhzW2lXpus
   T4sFVptSmivwspbhG8CtMzqEbiKPDuBDMgq/tc9B8Anbc6sfSFUKVwAI0
   gU5AqO6L8Vp62jcBZCsuJ0iQIM3XwkpF7xz0QfAUZwQIbv0RxKjuSR2BR
   z1evpJ1fibrGIDP5gpdkE5bLlfv00aOy8dJWAn/NdSAXyj8cbyj1OhGSO
   w==;
X-CSE-ConnectionGUID: abF51IGDRiu6afh2RNLVTg==
X-CSE-MsgGUID: e4gGydT3ThudeP36rquChQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="57919301"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="57919301"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 19:52:31 -0800
X-CSE-ConnectionGUID: ydV1gUStS1qLor4g8VXqEA==
X-CSE-MsgGUID: bngSkv3nR3ekzQc2NH5D3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="113544663"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa009.jf.intel.com with ESMTP; 15 Feb 2025 19:52:32 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	jgg@nvidia.com
Cc: yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	robin.murphy@arm.com,
	nicolinc@nvidia.com,
	will@kernel.org,
	vasant.hegde@amd.com
Subject: [PATCH v7 02/13] iommu: Introduce a replace API for device pasid
Date: Sat, 15 Feb 2025 19:52:17 -0800
Message-Id: <20250216035228.23831-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250216035228.23831-1-yi.l.liu@intel.com>
References: <20250216035228.23831-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide a high-level API to allow replacements of one domain with
another for specific pasid of a device. This is similar to
iommu_group_replace_domain_handle() and it is expected to be used
only by IOMMUFD.

Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu-priv.h |   4 ++
 drivers/iommu/iommu.c      | 105 +++++++++++++++++++++++++++++++++----
 2 files changed, 100 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index fedc57754a48..9b2072fadfdd 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -27,6 +27,10 @@ static inline const struct iommu_ops *iommu_fwspec_ops(struct iommu_fwspec *fwsp
 int iommu_group_replace_domain(struct iommu_group *group,
 			       struct iommu_domain *new_domain);
 
+int iommu_replace_device_pasid_handle(struct iommu_domain *domain,
+				      struct device *dev, ioasid_t pasid,
+				      struct iommu_attach_handle *handle);
+
 int iommu_device_register_bus(struct iommu_device *iommu,
 			      const struct iommu_ops *ops,
 			      const struct bus_type *bus,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 95830f670e18..3a68ebe3ab25 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -522,14 +522,10 @@ static void iommu_deinit_device(struct device *dev)
 
 DEFINE_MUTEX(iommu_probe_device_lock);
 
-struct iommu_domain *iommu_group_domain(struct iommu_group *group)
+static struct iommu_domain *pasid_entry_to_domain(void *pasid_entry)
 {
 	struct iommu_domain *domain;
-	void *pasid_entry;
-
-	lockdep_assert_held(&group->mutex);
 
-	pasid_entry = xa_load(&group->pasid_array, IOMMU_NO_PASID);
 	if (xa_pointer_tag(pasid_entry) == IOMMU_PASID_ARRAY_HANDLE) {
 		struct iommu_attach_handle *handle;
 
@@ -542,6 +538,13 @@ struct iommu_domain *iommu_group_domain(struct iommu_group *group)
 	return domain;
 }
 
+struct iommu_domain *iommu_group_domain(struct iommu_group *group)
+{
+	lockdep_assert_held(&group->mutex);
+
+	return pasid_entry_to_domain(xa_load(&group->pasid_array, IOMMU_NO_PASID));
+}
+
 static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
 {
 	struct iommu_domain *gdomain;
@@ -3369,14 +3372,15 @@ static void iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 }
 
 static int __iommu_set_group_pasid(struct iommu_domain *domain,
-				   struct iommu_group *group, ioasid_t pasid)
+				   struct iommu_group *group, ioasid_t pasid,
+				   struct iommu_domain *old)
 {
 	struct group_device *device, *last_gdev;
 	int ret;
 
 	for_each_group_device(group, device) {
 		ret = domain->ops->set_dev_pasid(domain, device->dev,
-						 pasid, NULL);
+						 pasid, old);
 		if (ret)
 			goto err_revert;
 	}
@@ -3388,7 +3392,20 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
 	for_each_group_device(group, device) {
 		if (device == last_gdev)
 			break;
-		iommu_remove_dev_pasid(device->dev, pasid, domain);
+		/* If no old domain, undo the succeeded devices/pasid */
+		if (!old) {
+			iommu_remove_dev_pasid(device->dev, pasid, domain);
+			continue;
+		}
+
+		/*
+		 * Rollback the succeeded devices/pasid to the old domain.
+		 * And it is a driver bug to fail attaching with a previously
+		 * good domain.
+		 */
+		if (WARN_ON(old->ops->set_dev_pasid(old, device->dev,
+						    pasid, domain)))
+			iommu_remove_dev_pasid(device->dev, pasid, domain);
 	}
 	return ret;
 }
@@ -3462,7 +3479,7 @@ int __iommu_attach_device_pasid(struct iommu_domain *domain,
 		goto out_unlock;
 	}
 
-	ret = __iommu_set_group_pasid(domain, group, pasid);
+	ret = __iommu_set_group_pasid(domain, group, pasid, NULL);
 	if (ret)
 		goto out_unlock;
 
@@ -3478,6 +3495,76 @@ int __iommu_attach_device_pasid(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(__iommu_attach_device_pasid);
 
+/**
+ * iommu_replace_device_pasid_handle - Replace the domain that a pasid
+ *                                     is attached to
+ * @domain: the new iommu domain
+ * @dev: the attached device.
+ * @pasid: the pasid of the device.
+ * @handle: the attach handle.
+ *
+ * This API allows the pasid to switch domains. The @pasid should have been
+ * attached via iommu_replace_device_pasid_handle(), otherwise, this fails.
+ * The pasid will keep the old configuration if replacement failed.
+ * Return 0 on success, or an error.
+ */
+int iommu_replace_device_pasid_handle(struct iommu_domain *domain,
+				      struct device *dev, ioasid_t pasid,
+				      struct iommu_attach_handle *handle)
+{
+	/* Caller must be a probed driver on dev */
+	struct iommu_group *group = dev->iommu_group;
+	struct iommu_attach_handle *pasid_entry;
+	struct iommu_domain *curr_domain;
+	void *curr;
+	int ret;
+
+	if (!group)
+		return -ENODEV;
+
+	if (!domain->ops->set_dev_pasid)
+		return -EOPNOTSUPP;
+
+	if (dev_iommu_ops(dev) != domain->owner ||
+	    pasid == IOMMU_NO_PASID || !handle)
+		return -EINVAL;
+
+	handle->domain = domain;
+
+	mutex_lock(&group->mutex);
+	curr = xa_load(&group->pasid_array, pasid);
+	/* Not a replace case */
+	if (!curr) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	curr_domain = pasid_entry_to_domain(curr);
+
+	if (curr_domain == domain) {
+		ret = 0;
+		goto out_unlock;
+	}
+
+	ret = __iommu_set_group_pasid(domain, group, pasid, curr_domain);
+	if (ret)
+		goto out_unlock;
+
+	pasid_entry = iommu_make_pasid_entry(domain, handle);
+
+	curr = xa_store(&group->pasid_array, pasid, pasid_entry, GFP_KERNEL);
+	if (xa_is_err(curr)) {
+		ret = xa_err(curr);
+		WARN_ON(__iommu_set_group_pasid(curr_domain, group,
+						pasid, domain));
+	}
+
+out_unlock:
+	mutex_unlock(&group->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(iommu_replace_device_pasid_handle, "IOMMUFD_INTERNAL");
+
 /*
  * iommu_detach_device_pasid() - Detach the domain from pasid of device
  * @domain: the iommu domain.
-- 
2.34.1

