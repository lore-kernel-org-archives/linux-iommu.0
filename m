Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CCC21507D
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 11:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570038; cv=none; b=SsbfKkP760pP7N2urMUFQw6kVTgGSgjNUdz2mOl0VuMRlv9ndvhdBl0pl2QvZYbrr2qwnbXRXLRXnyUuK2VeiTnjOZcaq0ExLGj9EtIri+F6xcw0zNXnDgz/hSwM2tsMoJ8J7rpI6oX3f/iLulZJi8Yn7FvnJ4AeV5Srdge5sMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570038; c=relaxed/simple;
	bh=R/70cPuQnpoKGNEkOQHwL/G0OdwfK9efTStRh5qIaDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N5SftUfDdV4hTlt6uT3Tdmv1Ot5HRN3/EpDIkCjwJyOYcHwRpJV1h9i49/6ZZ7SUri6nX68nZ07JZFqIIdG/mWiWy15zOAGsfu/rWgAVYS0rzOGol+TSrCwGU7Xxt5kqfev2Wz1bTPT6uhP+JAUHglV9NVfmfh8Tj+Y69YiI3ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P8r6AicK; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P8r6AicK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740570037; x=1772106037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R/70cPuQnpoKGNEkOQHwL/G0OdwfK9efTStRh5qIaDs=;
  b=P8r6AicKClM20RJHuyAjj1g1d2UTiNJ4WYgW1UwG+ZDyE9CHie4ioxU0
   6MwuR6NkRyr5KbLMyW7yT6yhsEY+7YD4BJzGGgK5xAATkpcLpArfu6eQe
   mDK/GPLCVz4fKICE6jVSCj2s8zvhXC2DnGVl+MIYLZDSP3Q8uNbrSZJQH
   qfrYccXCD1Cuq2hUwAoJz3I/Pyhxsm2m2Xsz6mEKdUitlNOIlIXuMuCtq
   ODe6NzJQvGajUqmIS0jDQdUn1QbfRuO6DqqtRzLNuYYUvyl1ZzVDO3tVK
   CwiwUHYDjxiMdfFlnVgGyQmIuKs8nur8en0Q+F/7x6i9qhWZ2pLBZbuPR
   Q==;
X-CSE-ConnectionGUID: x4h/KOugQ82IbynTFNRsfw==
X-CSE-MsgGUID: WZTYZT+HRoaedyWolaxdjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52827083"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52827083"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 03:40:34 -0800
X-CSE-ConnectionGUID: BRwNjyfoQqyKT/hupLMiLw==
X-CSE-MsgGUID: yxZGWemcSN+shNM6Vo56dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117171578"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa007.jf.intel.com with ESMTP; 26 Feb 2025 03:40:35 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v8 02/12] iommu: Introduce a replace API for device pasid
Date: Wed, 26 Feb 2025 03:40:22 -0800
Message-Id: <20250226114032.4591-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226114032.4591-1-yi.l.liu@intel.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
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
 drivers/iommu/iommu.c      | 113 +++++++++++++++++++++++++++++++++++--
 2 files changed, 113 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index b4508423e13b..e8e34be8140d 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -43,4 +43,8 @@ void iommu_detach_group_handle(struct iommu_domain *domain,
 int iommu_replace_group_handle(struct iommu_group *group,
 			       struct iommu_domain *new_domain,
 			       struct iommu_attach_handle *handle);
+
+int iommu_replace_device_pasid_handle(struct iommu_domain *domain,
+				      struct device *dev, ioasid_t pasid,
+				      struct iommu_attach_handle *handle);
 #endif /* __LINUX_IOMMU_PRIV_H */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f6dbb60ef948..129f32303fc5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -513,6 +513,22 @@ static void iommu_deinit_device(struct device *dev)
 	dev_iommu_free(dev);
 }
 
+static struct iommu_domain *pasid_array_entry_to_domain(void *entry)
+{
+	struct iommu_domain *domain;
+
+	if (xa_pointer_tag(entry) == IOMMU_PASID_ARRAY_HANDLE) {
+		struct iommu_attach_handle *handle;
+
+		handle = xa_untag_pointer(entry);
+		domain = handle->domain;
+	} else {
+		domain = xa_untag_pointer(entry);
+	}
+
+	return domain;
+}
+
 DEFINE_MUTEX(iommu_probe_device_lock);
 
 static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
@@ -3311,14 +3327,15 @@ static void iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
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
@@ -3330,7 +3347,20 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
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
@@ -3396,7 +3426,7 @@ int __iommu_attach_device_pasid(struct iommu_domain *domain,
 	if (ret)
 		goto out_unlock;
 
-	ret = __iommu_set_group_pasid(domain, group, pasid);
+	ret = __iommu_set_group_pasid(domain, group, pasid, NULL);
 	if (ret) {
 		xa_release(&group->pasid_array, pasid);
 		goto out_unlock;
@@ -3417,6 +3447,81 @@ int __iommu_attach_device_pasid(struct iommu_domain *domain,
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
+ * attached. Otherwise, this fails.
+ * The pasid will keep the old configuration if replacement failed.
+ * Return 0 on success, or an error.
+ */
+int iommu_replace_device_pasid_handle(struct iommu_domain *domain,
+				      struct device *dev, ioasid_t pasid,
+				      struct iommu_attach_handle *handle)
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
+	/* Not a replace case */
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
+EXPORT_SYMBOL_NS_GPL(iommu_replace_device_pasid_handle, "IOMMUFD_INTERNAL");
+
 /*
  * iommu_detach_device_pasid() - Detach the domain from pasid of device
  * @domain: the iommu domain.
-- 
2.34.1

