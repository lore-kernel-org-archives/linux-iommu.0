Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6FC22489B
	for <iommu@lists.linux.dev>; Thu, 19 Dec 2024 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614872; cv=none; b=En0eO0/vk5lTvpfNJrq1s5WXqwbDIhxNCGOe2pScIMmfGf+3vvKWaQz0Ocn5WZ2AolhB0JSDLDcq6unH00lWCW7QoQlcJ7PuYLaO9apl2R5Qwyv23TErTO0qjyvXFTUxzrjx1R+/ekdE39OAqthwez+Ci8XIQnz79+2ufac5hjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614872; c=relaxed/simple;
	bh=I87fbhbwg7QDDj98IoisQVi8rEWr4Qt/imsGRwtCF6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ferOiBnr8L28Un6owZf6iOo87aktnf0iKTkRXUJmlba7yrRWTgjNh/VJjxBNCxXHZyj8ob7J33Aqb5yHpqmc+9kEExDx7wIg3WOYd9tshNftJM/vqxhn6P/joC+QStQJQVdPCHAcMXtc6nl8LDcDUaqb0n89bQce7eYBBmvFuW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cpgNvleb; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cpgNvleb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734614870; x=1766150870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I87fbhbwg7QDDj98IoisQVi8rEWr4Qt/imsGRwtCF6A=;
  b=cpgNvleb6HFb+Gk66++eiQ1f/h3DFNGoopd4IM4OSABcgQgFNCFad8Fz
   0LmxRC8Yuf2ibrzPv/K95eR1KWwkSbA8bCD2Pw1fjgt3f/rWTrR9Gfn9V
   x0JEagwHvUiPdlpo1H0XadZ7jyYjN76Yw8D+0Wxpy8SPwoToqfozP6EW+
   pgqURO4Ulv1Nnu9r+6VE8kM6plEA8fHuIVuA2Ck2IL+ier7n4kHgHQDxx
   8mlaRoWHcHgtHVbBbJRKdDzEd/YN4YqJ7EiShZIJOlRLyN00vLRgi4oOj
   FWt9iFUHJSmPzV/0W4zFVOtSDfJx0tb8ww3QKy7SCsDpK3rbfYmednM4V
   w==;
X-CSE-ConnectionGUID: bA9hPHZZQqq2nNxc4rJkCQ==
X-CSE-MsgGUID: 4t+ZLpeEQDSPsxeG6H+kmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="46542249"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="46542249"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 05:27:48 -0800
X-CSE-ConnectionGUID: OMsW+3AQQlyLW8BlTe0EYg==
X-CSE-MsgGUID: EnT949AQTUiqu67TBPjU5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="103177301"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 19 Dec 2024 05:27:48 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: eric.auger@redhat.com,
	nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	vasant.hegde@amd.com,
	will@kernel.org
Subject: [PATCH v6 01/14] iommu: Introduce a replace API for device pasid
Date: Thu, 19 Dec 2024 05:27:33 -0800
Message-Id: <20241219132746.16193-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219132746.16193-1-yi.l.liu@intel.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
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
index 28ffd836592b..3ea62b9c7b2f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3323,14 +3323,15 @@ static void iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
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
@@ -3342,7 +3343,20 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
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
@@ -3404,7 +3418,7 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	if (ret)
 		goto out_unlock;
 
-	ret = __iommu_set_group_pasid(domain, group, pasid);
+	ret = __iommu_set_group_pasid(domain, group, pasid, NULL);
 	if (ret)
 		xa_erase(&group->pasid_array, pasid);
 out_unlock:
@@ -3413,6 +3427,74 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
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
+EXPORT_SYMBOL_NS_GPL(iommu_replace_device_pasid, "IOMMUFD_INTERNAL");
+
 /*
  * iommu_detach_device_pasid() - Detach the domain from pasid of device
  * @domain: the iommu domain.
-- 
2.34.1

