Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AFC1C69D
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726718; cv=none; b=mKiz45+9TFOt/hB3ye3BSCf0VOfW8GVmaVJYQPBE69ajDBQoCLjnhKSl6mDU2S2vSpDV5lfAEm/wxcRMUtN8sX5eSifrHUTHS1I+L9+P9OpEkHnwvAgGct6v4iV2YP9W4mKkboEnhwzQ04blbdXZ1g59tja59AVL6dB331M9ceY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726718; c=relaxed/simple;
	bh=kYTaP2q+z5qq2nr1GrLrtDwFySjctA0oi+/o6fmDG7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NztkHK8/gGZrolmJng0crYtxxDziRVGBTuXj3sI7UbukS9rr0m9ZyLVpZew2rzXO9dVF88UCp9WhvGweBFR2hXl5AuH4Ev0+P93Vyd1s7PfOskgps1MGGRqXroQWwcNO7um+P1QacxMXtCHQ2Ru/1/Yp3I8Zs27UWzo/4v8Blb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZ6Fww7j; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZ6Fww7j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730726718; x=1762262718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kYTaP2q+z5qq2nr1GrLrtDwFySjctA0oi+/o6fmDG7s=;
  b=JZ6Fww7j4jKB9xWnwBafPoahM0AeS1x2cRyO/rN6a/pVbY8xDipuAN1i
   W05dkkeMnbaxPEtz81TYYIuskuE9mEvsn7VRxyigcjcvYbYMZaQZZCleQ
   4+TbzRRNyNyMvDnGLLbh2E8Fr0Zm3hQ5oRzr0t67iAUbS7Kcexx7Wfmky
   i4YBVJYiFUjjU/b8otF2ws3NLfEC7LBcLxzgQ5x8qgccNTkjBqxG3peoV
   Ogy2jFcdneTXRZL5LqIrp9JwOQ5kISyDcyROnOJrJgFrYLtcxuPQkwcPf
   pW0qOJM2LsgcKK5/kQBBLJxQmte6auxK61AweNmlN6KWvtDcu5VX+UNd4
   w==;
X-CSE-ConnectionGUID: +OAbwA7NQl2IwZatcgg+fg==
X-CSE-MsgGUID: km5fGXLdREyFl50+QiMF6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47884027"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="47884027"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 05:25:17 -0800
X-CSE-ConnectionGUID: 3raD8hBXQV+E8opBMUkk/A==
X-CSE-MsgGUID: jHy8gF6mQVaFmvSkvTx7Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="84100440"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa007.jf.intel.com with ESMTP; 04 Nov 2024 05:25:16 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	vasant.hegde@amd.com
Subject: [PATCH v5 01/12] iommu: Introduce a replace API for device pasid
Date: Mon,  4 Nov 2024 05:25:02 -0800
Message-Id: <20241104132513.15890-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104132513.15890-1-yi.l.liu@intel.com>
References: <20241104132513.15890-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide a high-level API to allow replacements of one domain with
another for specific pasid of a device. This is similar to
iommu_group_replace_domain() and it is expected to be used only by
IOMMUFD.

Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu-priv.h |  4 ++
 drivers/iommu/iommu.c      | 90 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index de5b54eaa8bf..90b367de267e 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -27,6 +27,10 @@ static inline const struct iommu_ops *iommu_fwspec_ops(struct iommu_fwspec *fwsp
 int iommu_group_replace_domain(struct iommu_group *group,
 			       struct iommu_domain *new_domain);
 
+int iommu_replace_device_pasid(struct iommu_domain *domain,
+			       struct device *dev, ioasid_t pasid,
+			       struct iommu_attach_handle *handle);
+
 int iommu_device_register_bus(struct iommu_device *iommu,
 			      const struct iommu_ops *ops,
 			      const struct bus_type *bus,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 53f8e60acf30..a441ba0a6733 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3411,14 +3411,15 @@ static void iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
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
@@ -3430,7 +3431,20 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
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
@@ -3492,7 +3506,7 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	if (ret)
 		goto out_unlock;
 
-	ret = __iommu_set_group_pasid(domain, group, pasid);
+	ret = __iommu_set_group_pasid(domain, group, pasid, NULL);
 	if (ret)
 		xa_erase(&group->pasid_array, pasid);
 out_unlock:
@@ -3501,6 +3515,74 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
 
+/**
+ * iommu_replace_device_pasid - Replace the domain that a pasid is attached to
+ * @domain: the new iommu domain
+ * @dev: the attached device.
+ * @pasid: the pasid of the device.
+ * @handle: the attach handle.
+ *
+ * This API allows the pasid to switch domains. Return 0 on success, or an
+ * error. The pasid will keep the old configuration if replacement failed.
+ * This is supposed to be used by iommufd, and iommufd can guarantee that
+ * both iommu_attach_device_pasid() and iommu_replace_device_pasid() would
+ * pass in a valid @handle.
+ */
+int iommu_replace_device_pasid(struct iommu_domain *domain,
+			       struct device *dev, ioasid_t pasid,
+			       struct iommu_attach_handle *handle)
+{
+	/* Caller must be a probed driver on dev */
+	struct iommu_group *group = dev->iommu_group;
+	struct iommu_attach_handle *curr;
+	int ret;
+
+	if (!domain->ops->set_dev_pasid)
+		return -EOPNOTSUPP;
+
+	if (!group)
+		return -ENODEV;
+
+	if (!dev_has_iommu(dev) || dev_iommu_ops(dev) != domain->owner ||
+	    pasid == IOMMU_NO_PASID || !handle)
+		return -EINVAL;
+
+	handle->domain = domain;
+
+	mutex_lock(&group->mutex);
+	/*
+	 * The iommu_attach_handle of the pasid becomes inconsistent with the
+	 * actual handle per the below operation. The concurrent PRI path will
+	 * deliver the PRQs per the new handle, this does not have a functional
+	 * impact. The PRI path would eventually become consistent when the
+	 * replacement is done.
+	 */
+	curr = (struct iommu_attach_handle *)xa_store(&group->pasid_array,
+						      pasid, handle,
+						      GFP_KERNEL);
+	if (!curr) {
+		xa_erase(&group->pasid_array, pasid);
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	ret = xa_err(curr);
+	if (ret)
+		goto out_unlock;
+
+	if (curr->domain == domain)
+		goto out_unlock;
+
+	ret = __iommu_set_group_pasid(domain, group, pasid, curr->domain);
+	if (ret)
+		WARN_ON(handle != xa_store(&group->pasid_array, pasid,
+					   curr, GFP_KERNEL));
+out_unlock:
+	mutex_unlock(&group->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(iommu_replace_device_pasid, IOMMUFD_INTERNAL);
+
 /*
  * iommu_detach_device_pasid() - Detach the domain from pasid of device
  * @domain: the iommu domain.
-- 
2.34.1

