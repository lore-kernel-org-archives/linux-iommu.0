Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A782A1A76C7
	for <iommu@lists.linux.dev>; Thu, 12 Sep 2024 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146780; cv=none; b=pOzodMLF7Ds1rNqa18dgIK0Bnr1XXSFePzTDOJFBBAnfSgM05K1xnBxrCfadJaDAwCqkjPq7CLiYX6Eu6wOVZP0pRDRSpd0ws3ImEh9lRsNxxJmiKqIFW9bommhj6dw1/v+YoThb0An/3AHIrlyDg58zMyGvwMbHM4cHd45bKdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146780; c=relaxed/simple;
	bh=0XxKBaycudG+spAOHgQrx0ct4g0+tJZYEtf66Xv1DFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qwe+/0+s/H2aSwwAn4WpW/QSQmzzkFwS6RakuvbdHBtboE9aspycOS+0qduaj+obof8hyK4pBtrIZdp8FxvvClinUVXzG2ejpRyt6K51XZIUdMwATWz0Ej33zYrnAVvIPZBgJNrDiNv+hKVIljbMhYj9r7fjBH4v+/K4qWwHaRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ntVvClJL; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ntVvClJL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726146778; x=1757682778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0XxKBaycudG+spAOHgQrx0ct4g0+tJZYEtf66Xv1DFc=;
  b=ntVvClJLziuHr9vpm9gqfZAqyL5AJTjcYqMDFn87eTcaNQSiW2RozzUy
   ebY8n23fvSzGTIBpBzKN06LaTA+9Jetw/LnB0Ywx1WpfIQUD4m2NtNx91
   3tfP0POH9lFWDRTrn8nkcWWJaZJRLDsooDMPlSogNU1s3aWZuigtJv2fK
   JCio1Y6tUpVQ0HyqvTUqfFxLG0MqeRdgIX/92W2aZvV63ioF/1yKToCjQ
   fXDYiKvXeABZPEcQhEqejS53JPUx7eykt0EUrjXDxDv4YZKKtMZf9HGzH
   M9/zTSUq9odYd8uwTLuAB/q/cYuejvkRUm6Fu4VgaOvw8BvlqzDOl9bRQ
   w==;
X-CSE-ConnectionGUID: BLi9RQlKTLm91aMurfAHfA==
X-CSE-MsgGUID: xkmrQZNjSBqN6cbnLsspaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="27911197"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="27911197"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 06:12:57 -0700
X-CSE-ConnectionGUID: 8LM3Ao2LT3CR5aFJdHc1aw==
X-CSE-MsgGUID: yH/YYeBNRfyVFuK1Ro4NeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67996540"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa006.jf.intel.com with ESMTP; 12 Sep 2024 06:12:57 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	linux-kselftest@vger.kernel.org,
	vasant.hegde@amd.com
Subject: [PATCH v4 01/10] iommu: Introduce a replace API for device pasid
Date: Thu, 12 Sep 2024 06:12:46 -0700
Message-Id: <20240912131255.13305-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912131255.13305-1-yi.l.liu@intel.com>
References: <20240912131255.13305-1-yi.l.liu@intel.com>
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
index b6b44b184004..066f659018a5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3347,14 +3347,15 @@ static void iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
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
@@ -3366,7 +3367,20 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
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
@@ -3425,7 +3439,7 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	if (ret)
 		goto out_unlock;
 
-	ret = __iommu_set_group_pasid(domain, group, pasid);
+	ret = __iommu_set_group_pasid(domain, group, pasid, NULL);
 	if (ret)
 		xa_erase(&group->pasid_array, pasid);
 out_unlock:
@@ -3434,6 +3448,74 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
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
+	 * deliver the PRQs per the new handle, this does not have a function
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

