Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C62B1E7C11
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577587; cv=none; b=uyyIJmK5qRvFYd10ztwICOR/X9BJVPsws7Ew4pfUW1PenySyDX8txZUvSEW6FoL2ap1R2pak4Q1pRSN3uXoMr9fi+7DhKr3My+9KEeaV9zr5cru4Hs8vW+BzppSxNgiEmHJnzMD+BzUEWZYPn6YzvOyuwoO3eLU+/qXyRz8PGo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577587; c=relaxed/simple;
	bh=gVbbRrnGwNnGzrg0PcMWseIlbZd+2rOtKOWlutXmUcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t1+D9e2EDZC+EVVuXyt6De6TdfqohLqdUL6HNNSu35hkf1Fpa880TIHOSSC1dVLBJTtGe541trmO2cbp2/nQHUqsaMb+UzIhqktj8s28dca0tF0iwskMKis+D3+EGIpP5habmzdy0LaVnxmdrjctbYgGx2T8Gh8UU7vmdVigAA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AadYiU0g; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AadYiU0g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742577586; x=1774113586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gVbbRrnGwNnGzrg0PcMWseIlbZd+2rOtKOWlutXmUcs=;
  b=AadYiU0gxaUxlVoSMtESr/KSyl09elNgNrsdXCubeovDy9xMfWjIxx8A
   QCA5yXKwvMrzP1Phrngil+7GO7Vu+YgeNtfPlO9IAFKjfVtxDn9AWjVvo
   IXtCbU4xtIq8Pi+B49hB52j6aER27JUnWl0ozySPss6Zbcp1XyRKF6FIW
   /eyM8f5lY8IE/ErxDxkMTzL9NWbNajQxyq5ZHr38faJhxl6awEbiNn6xz
   gufcb7sjcTfMvGKRzY/+U5yzR6zx96aaCrkspR7J8zuNt+Fo26D53z3yU
   Iluu5AGymhKNu/237Tdrwto4Wn86VmLQOyyovxKrP7ZFZBh1Gwn3ByDDh
   g==;
X-CSE-ConnectionGUID: Ndt9+d6kSZyA6OCanledwA==
X-CSE-MsgGUID: Y+RCJtOkTxSlmfRs2Zyoaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43976783"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="43976783"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 10:19:43 -0700
X-CSE-ConnectionGUID: 7qCY3bGhTPC47xwJL20nuw==
X-CSE-MsgGUID: G1+twzdjSSi1efJ4OTiarQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="123914421"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa010.fm.intel.com with ESMTP; 21 Mar 2025 10:19:42 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v11 02/18] iommu: Introduce a replace API for device pasid
Date: Fri, 21 Mar 2025 10:19:24 -0700
Message-Id: <20250321171940.7213-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250321171940.7213-1-yi.l.liu@intel.com>
References: <20250321171940.7213-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide a high-level API to allow replacements of one domain with another
for specific pasid of a device. This is similar to
iommu_replace_group_handle() and it is expected to be used only by IOMMUFD.

Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
v10 -> v11: Drop redundant handle check as handle is always valid in
            iommu_replace_device_pasid(). No inline helper
---
 drivers/iommu/iommu-priv.h |   3 +
 drivers/iommu/iommu.c      | 115 +++++++++++++++++++++++++++++++++++--
 2 files changed, 114 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index c74fff25be78..b8528d5dd1e7 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -56,4 +56,7 @@ static inline int iommufd_sw_msi(struct iommu_domain *domain,
 }
 #endif /* CONFIG_IOMMUFD_DRIVER_CORE && CONFIG_IRQ_MSI_IOMMU */
 
+int iommu_replace_device_pasid(struct iommu_domain *domain,
+			       struct device *dev, ioasid_t pasid,
+			       struct iommu_attach_handle *handle);
 #endif /* __LINUX_IOMMU_PRIV_H */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9f1db10645ee..c8c891f27e45 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -514,6 +514,13 @@ static void iommu_deinit_device(struct device *dev)
 	dev_iommu_free(dev);
 }
 
+static struct iommu_domain *pasid_array_entry_to_domain(void *entry)
+{
+	if (xa_pointer_tag(entry) == IOMMU_PASID_ARRAY_DOMAIN)
+		return xa_untag_pointer(entry);
+	return ((struct iommu_attach_handle *)xa_untag_pointer(entry))->domain;
+}
+
 DEFINE_MUTEX(iommu_probe_device_lock);
 
 static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
@@ -3324,14 +3331,15 @@ static void iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
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
@@ -3343,7 +3351,15 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
 	for_each_group_device(group, device) {
 		if (device == last_gdev)
 			break;
-		iommu_remove_dev_pasid(device->dev, pasid, domain);
+		/*
+		 * If no old domain, undo the succeeded devices/pasid.
+		 * Otherwise, rollback the succeeded devices/pasid to the old
+		 * domain. And it is a driver bug to fail attaching with a
+		 * previously good domain.
+		 */
+		if (!old || WARN_ON(old->ops->set_dev_pasid(old, device->dev,
+							    pasid, domain)))
+			iommu_remove_dev_pasid(device->dev, pasid, domain);
 	}
 	return ret;
 }
@@ -3412,7 +3428,7 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	if (ret)
 		goto out_unlock;
 
-	ret = __iommu_set_group_pasid(domain, group, pasid);
+	ret = __iommu_set_group_pasid(domain, group, pasid, NULL);
 	if (ret) {
 		xa_release(&group->pasid_array, pasid);
 		goto out_unlock;
@@ -3433,6 +3449,97 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
 
+/**
+ * iommu_replace_device_pasid - Replace the domain that a specific pasid
+ *                              of the device is attached to
+ * @domain: the new iommu domain
+ * @dev: the attached device.
+ * @pasid: the pasid of the device.
+ * @handle: the attach handle.
+ *
+ * This API allows the pasid to switch domains. The @pasid should have been
+ * attached. Otherwise, this fails. The pasid will keep the old configuration
+ * if replacement failed.
+ *
+ * Caller should always provide a new handle to avoid race with the paths
+ * that have lockless reference to handle if it intends to pass a valid handle.
+ *
+ * Return 0 on success, or an error.
+ */
+int iommu_replace_device_pasid(struct iommu_domain *domain,
+			       struct device *dev, ioasid_t pasid,
+			       struct iommu_attach_handle *handle)
+{
+	/* Caller must be a probed driver on dev */
+	struct iommu_group *group = dev->iommu_group;
+	struct iommu_attach_handle *entry;
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
+	mutex_lock(&group->mutex);
+	entry = iommu_make_pasid_array_entry(domain, handle);
+	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL,
+			  XA_ZERO_ENTRY, GFP_KERNEL);
+	if (xa_is_err(curr)) {
+		ret = xa_err(curr);
+		goto out_unlock;
+	}
+
+	/*
+	 * No domain (with or without handle) attached, hence not
+	 * a replace case.
+	 */
+	if (!curr) {
+		xa_release(&group->pasid_array, pasid);
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	/*
+	 * Reusing handle is problematic as there are paths that refers
+	 * the handle without lock. To avoid race, reject the callers that
+	 * attempt it.
+	 */
+	if (curr == entry) {
+		WARN_ON(1);
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	curr_domain = pasid_array_entry_to_domain(curr);
+	ret = 0;
+
+	if (curr_domain != domain) {
+		ret = __iommu_set_group_pasid(domain, group,
+					      pasid, curr_domain);
+		if (ret)
+			goto out_unlock;
+	}
+
+	/*
+	 * The above xa_cmpxchg() reserved the memory, and the
+	 * group->mutex is held, this cannot fail.
+	 */
+	WARN_ON(xa_is_err(xa_store(&group->pasid_array,
+				   pasid, entry, GFP_KERNEL)));
+
+out_unlock:
+	mutex_unlock(&group->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(iommu_replace_device_pasid, "IOMMUFD_INTERNAL");
+
 /*
  * iommu_detach_device_pasid() - Detach the domain from pasid of device
  * @domain: the iommu domain.
-- 
2.34.1

