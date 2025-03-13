Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EE1266B71
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869350; cv=none; b=Xp5MOFT57afbixOSymt15S7AVz30o1maQGWsb95llIbesBFv3hgjiXzr1NlLbz6JNp4QQYYjhF78/JsvsU1sy9Z4RomCWNXfrcWDDV+eWHBbkpDrvZw85MZ7n8q4W3mzTn+0yRDsLeFh9u/iapXAlA8/jPC7z+2q1+/4K3m7DZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869350; c=relaxed/simple;
	bh=7B/VqXhvmPIjVnSGliCdA8yXM3HhosGkoFL4PtC3GQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H5RuqiGPApyRmygRhK3jf3Y2gLoTn+7a7v8FiSFLIUu7sBQTOXyVoTLIH9c5BHIlql9SbD70wgNStd35LkIdA99QTwkExcHDYNdch1WGfa9oW4ZS+5el9tYzcgMUnMXBRx/eky7fDE8WkVJqV7I7TV6HGrxILX4FHuZMu3lANPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RmAeZfOX; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RmAeZfOX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741869348; x=1773405348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7B/VqXhvmPIjVnSGliCdA8yXM3HhosGkoFL4PtC3GQQ=;
  b=RmAeZfOX9dDbo54I3qPAgxQ+CAVXOZANEbESVgClrl18XH2rADTNmiej
   k/RWc8Io3uLJwPcPdyoV2HNMKSWKe4jNWHbkts/zLISauXwLl6aP026+w
   2OnjMdnmhx69BEETBPTq4urVQxnzAu+R8J73FAn4L5oF+sC5agicjqToy
   Onj2apQQT1nPLc9iGBtIn8lPrVJ7bXVWbMZHCBgVow0ZRwwOxXrsEnIN3
   CNTfY+I3BlN5JKBV4PQgMMq5EGesY10MxRSXE2BFimfwdF7viMGox/+O6
   vGzidquCy4unq/1R6pWRLE6G8is2RjX4l3GkMjBKvBeJt6BGkGH0d2Q4T
   w==;
X-CSE-ConnectionGUID: LyHCSEyHQXuasAxqp+nWQQ==
X-CSE-MsgGUID: OhAGGDelQtScwSCsmXtjYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42863939"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42863939"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:35:35 -0700
X-CSE-ConnectionGUID: YayeqfNdQwiM65hu4npILA==
X-CSE-MsgGUID: b7yag+1QQSSP19o415JCCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126005489"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 13 Mar 2025 05:35:35 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v9 03/21] iommu: Introduce a replace API for device pasid
Date: Thu, 13 Mar 2025 05:35:14 -0700
Message-Id: <20250313123532.103522-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250313123532.103522-1-yi.l.liu@intel.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
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
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
--
v8 -> v9: Adapted this patch to use iommu_group_pasid_store() which checks
	  the current pasid array entry and change the handle->domain under
	  xa_lock().
--
 drivers/iommu/iommu-priv.h |   4 ++
 drivers/iommu/iommu.c      | 111 ++++++++++++++++++++++++++++++++++---
 2 files changed, 107 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index b4508423e13b..2985f05d699f 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -43,4 +43,8 @@ void iommu_detach_group_handle(struct iommu_domain *domain,
 int iommu_replace_group_handle(struct iommu_group *group,
 			       struct iommu_domain *new_domain,
 			       struct iommu_attach_handle *handle);
+
+int iommu_replace_device_pasid(struct iommu_domain *domain,
+			       struct device *dev, ioasid_t pasid,
+			       struct iommu_attach_handle *handle);
 #endif /* __LINUX_IOMMU_PRIV_H */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6a314122a9da..a828c96ad6c5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -513,6 +513,13 @@ static void iommu_deinit_device(struct device *dev)
 	dev_iommu_free(dev);
 }
 
+static inline struct iommu_domain *pasid_array_entry_to_domain(void *entry)
+{
+	if (xa_pointer_tag(entry) == IOMMU_PASID_ARRAY_DOMAIN)
+		return xa_untag_pointer(entry);
+	return ((struct iommu_attach_handle *)xa_untag_pointer(entry))->domain;
+}
+
 DEFINE_MUTEX(iommu_probe_device_lock);
 
 static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
@@ -2170,7 +2177,7 @@ static void iommu_pasid_array_entry_clear_handle(void *entry)
 
 /* Caller should have reserved memory for __xa_store() */
 static void iommu_group_pasid_store(struct iommu_group *group, ioasid_t pasid,
-				    struct iommu_domain *domain,
+				    void *curr, struct iommu_domain *domain,
 				    struct iommu_attach_handle *handle)
 {
 	void *entry;
@@ -2179,8 +2186,13 @@ static void iommu_group_pasid_store(struct iommu_group *group, ioasid_t pasid,
 
 	xa_lock(&group->pasid_array);
 	entry = iommu_make_pasid_array_entry(domain, handle);
+	if (curr == entry)
+		goto out_unlock;
+
 	WARN_ON(xa_is_err(__xa_store(&group->pasid_array, pasid, entry,
 				     GFP_KERNEL)));
+
+out_unlock:
 	xa_unlock(&group->pasid_array);
 }
 
@@ -3334,14 +3346,15 @@ static void iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
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
@@ -3353,7 +3366,15 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
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
@@ -3416,7 +3437,7 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	if (ret)
 		goto out_unlock;
 
-	ret = __iommu_set_group_pasid(domain, group, pasid);
+	ret = __iommu_set_group_pasid(domain, group, pasid, NULL);
 	if (ret) {
 		xa_release(&group->pasid_array, pasid);
 		goto out_unlock;
@@ -3428,7 +3449,7 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	 * operation succeeds as we cannot tolerate PRIs becoming concurrently
 	 * queued and then failing attach.
 	 */
-	iommu_group_pasid_store(group, pasid, domain, handle);
+	iommu_group_pasid_store(group, pasid, NULL, domain, handle);
 
 out_unlock:
 	mutex_unlock(&group->mutex);
@@ -3436,6 +3457,79 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
 
+/**
+ * iommu_replace_device_pasid - Replace the domain that a pasid
+ *                              is attached to
+ * @domain: the new iommu domain
+ * @dev: the attached device.
+ * @pasid: the pasid of the device.
+ * @handle: the attach handle.
+ *
+ * This API allows the pasid to switch domains. The @pasid should have been
+ * attached. Otherwise, this fails.
+ * The pasid will keep the old configuration if replacement failed.
+ * Return 0 on success, or an error.
+ */
+int iommu_replace_device_pasid(struct iommu_domain *domain,
+			       struct device *dev, ioasid_t pasid,
+			       struct iommu_attach_handle *handle)
+{
+	/* Caller must be a probed driver on dev */
+	struct iommu_group *group = dev->iommu_group;
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
+	iommu_group_pasid_store(group, pasid, curr, domain, handle);
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
@@ -3562,7 +3656,7 @@ int iommu_attach_group_handle(struct iommu_domain *domain,
 	 * operation succeeds as we cannot tolerate PRIs becoming concurrently
 	 * queued and then failing attach.
 	 */
-	iommu_group_pasid_store(group, IOMMU_NO_PASID, domain, handle);
+	iommu_group_pasid_store(group, IOMMU_NO_PASID, NULL, domain, handle);
 
 out_unlock:
 	mutex_unlock(&group->mutex);
@@ -3623,7 +3717,8 @@ int iommu_replace_group_handle(struct iommu_group *group,
 	if (ret)
 		goto err_release;
 
-	iommu_group_pasid_store(group, IOMMU_NO_PASID, new_domain, handle);
+	iommu_group_pasid_store(group, IOMMU_NO_PASID, NULL,
+				new_domain, handle);
 
 	mutex_unlock(&group->mutex);
 
-- 
2.34.1

