Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033FB21A443
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478470; cv=none; b=qwycN0X9766loXbz+bxnrpWZyeJghUeKHdEY00uXmfGYom8BY2k+C7rIHqTkj4+3G9LRRnZ+HhS7YQdhLNjlM9GZxrjgTsMvCmkkKpxM/LPDhjKUImqeMfvr8mntIVFi19Oy8fNsez5wqiJ7x/rN9xO2IAPKML7WejLc0mUcVKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478470; c=relaxed/simple;
	bh=6SWGq8JkYnAG+JTiI55v9fb/OvKI5H+oJMVBC5Lthys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T/Cmlr4Z8XC2W5IKjnRQyIxkaRS/rzxDBluWe5BPO8duWq0CHhSyNfTugmLtsfbHXD8NRbCtDmilcGBTbyttoTWivsjEndWazpGECURHV0X4c3bf5Ke3SpZIYGWTpmgY9IVFH7amZoB1qf9C6mOKxZaQPhDqpi4WMIqWQcFVew8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c8w8iF32; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c8w8iF32"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742478469; x=1774014469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6SWGq8JkYnAG+JTiI55v9fb/OvKI5H+oJMVBC5Lthys=;
  b=c8w8iF321VoTKG9h1WPAyQMjaSvK7gKHqKUwsumJ8U76b+4XJmOUkTlh
   LPtb2FKZs1SPqFssr30Hxfl6Mv9Qg7KPxbo/8dQdMcbQCZfqsCJaxn8eT
   kRUVOgisDsANkVTl+VPf2aaGX1rDHOxVcidOolZQOy8raIoml/fC+sNLY
   K2gSNJS0HOWZ3NEdOGvPpW9fRWRJTCFeBPAdrj0m05OhsR1KfHFkhnjDI
   aQbmPIdLu3h6wHqaz2vlPgBGNhAqr1Zd0rTwztsSwMHyPPIlUShSJ4w6T
   /SSbfjf5u2zkPuBFRVTgfVfEST04+y81XHbKx3S05RogmqVHnx2/KX9ub
   A==;
X-CSE-ConnectionGUID: q3C1hUf7THiDccUqrB2YQg==
X-CSE-MsgGUID: 1gzMuHC2TdWDTkzGV23d/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="69063040"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="69063040"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 06:47:46 -0700
X-CSE-ConnectionGUID: N6I6JJPLSNG+UkYva3bNNQ==
X-CSE-MsgGUID: 4uShKnHkStWGchPrBb7Lzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="160319137"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa001.jf.intel.com with ESMTP; 20 Mar 2025 06:47:46 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v10 02/18] iommu: Introduce a replace API for device pasid
Date: Thu, 20 Mar 2025 06:47:28 -0700
Message-Id: <20250320134744.5777-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250320134744.5777-1-yi.l.liu@intel.com>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
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
---
v9 - > v10: Convert to the v8 version, added a check to fail the case
            in which the passed handle is equal to the existing one.
---
 drivers/iommu/iommu-priv.h |   4 ++
 drivers/iommu/iommu.c      | 117 +++++++++++++++++++++++++++++++++++--
 2 files changed, 117 insertions(+), 4 deletions(-)

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
index cffd96e3efd2..07134bb85c00 100644
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
@@ -3311,14 +3318,15 @@ static void iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
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
@@ -3330,7 +3338,15 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
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
@@ -3399,7 +3415,7 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	if (ret)
 		goto out_unlock;
 
-	ret = __iommu_set_group_pasid(domain, group, pasid);
+	ret = __iommu_set_group_pasid(domain, group, pasid, NULL);
 	if (ret) {
 		xa_release(&group->pasid_array, pasid);
 		goto out_unlock;
@@ -3420,6 +3436,99 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
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
+	if (handle && curr == entry) {
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
+	if (curr != entry) {
+		/*
+		 * The above xa_cmpxchg() reserved the memory, and the
+		 * group->mutex is held, this cannot fail.
+		 */
+		WARN_ON(xa_is_err(xa_store(&group->pasid_array,
+					   pasid, entry, GFP_KERNEL)));
+	}
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

