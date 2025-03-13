Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99846265CC3
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 12:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869349; cv=none; b=QCPZL9Xx5vIY+WWQ8g8F1Tymjmf0cBFkANMX/Q80OAgqkfMLGKoN3/jaj9ZZd3fXs89I22bOmxeiw+M+8puKMPEku8wxzqBJFOeiHxviywiMJPUMnujU+/dwPlFWoTypeGicG2SFyXUx1VfQ8ewQRrULuy2p2b/fdpJCD9h6qBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869349; c=relaxed/simple;
	bh=e4/ZBeR/WK8wJt+tXNx+VnkihjL4DXJKuuldiFi96tM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nPfZgim+jfbXUKJDodFUKiRpZ82H2elp9gOXUysk+SU0nVM4T5KDTE3sexAPczXuuhUkwcK5aHLBkofvOPpVNTrlodGSLVbEP6DlAqt6xHec6AFvU4F292ER1AEqsT3pfvgKFIROQAPReCoCWT8vx7OVm3lvE6oEoChiloRa5mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VFwXfevE; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VFwXfevE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741869348; x=1773405348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e4/ZBeR/WK8wJt+tXNx+VnkihjL4DXJKuuldiFi96tM=;
  b=VFwXfevE42v8W3zGZiog4JXAZyRdsl6Swi6ItGsf9gQH/KPI09koRG5L
   w0VcnPzOv1jttBJy088lxzSeGZsYRkV+YDDCHsuUMyxtCaVPss9BCYDnk
   p+M9MynKqrqwh0I+BYtczhE2t/PfwZOd/oXlH+fjvsWy6Wl/IcbevI/9+
   ivbKI47xQQ/6WySFXuXnWqB3DF7Ot8M8YLY8SUASIIZPoq7VC3wYogjut
   NKbCHVWG0TUKOZtDrWzIcF9gqyA70Sl5wKmfxsu/w4SgvCgbGVTNWf+Zf
   8AB1f4nkOBHyvO0esZr6dq0CSZLFGtltqITuR8HrAB9lsUBJRpsB0m1om
   w==;
X-CSE-ConnectionGUID: Dr6LOfVFQxiZyprVUC87Ag==
X-CSE-MsgGUID: G2YyXAR/QOe5QBAOr5RLJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42863932"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42863932"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:35:34 -0700
X-CSE-ConnectionGUID: VWHp3VoDRYi/yMphZ/WEPQ==
X-CSE-MsgGUID: kSOc3IEcSjCm95Tr+rxP3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126005483"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 13 Mar 2025 05:35:34 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v9 01/21] iommu: Clear handle->domain in detach
Date: Thu, 13 Mar 2025 05:35:12 -0700
Message-Id: <20250313123532.103522-2-yi.l.liu@intel.com>
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

The iommu core sets the handle->domain in attach/replace. To be completed,
it should clear handle->domain in detach as well to avoid potential side
effect if caller reuses a handle.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0ee17893810f..332ecb20c385 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2161,6 +2161,13 @@ static void *iommu_make_pasid_array_entry(struct iommu_domain *domain,
 	return xa_tag_pointer(domain, IOMMU_PASID_ARRAY_DOMAIN);
 }
 
+static void iommu_pasid_array_entry_clear_handle(void *entry)
+{
+	if (xa_pointer_tag(entry) == IOMMU_PASID_ARRAY_HANDLE)
+		((struct iommu_attach_handle *)
+		 xa_untag_pointer(entry))->domain = NULL;
+}
+
 static int __iommu_attach_group(struct iommu_domain *domain,
 				struct iommu_group *group)
 {
@@ -3431,10 +3438,13 @@ void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
 {
 	/* Caller must be a probed driver on dev */
 	struct iommu_group *group = dev->iommu_group;
+	void *entry;
 
 	mutex_lock(&group->mutex);
 	__iommu_remove_group_pasid(group, pasid, domain);
-	xa_erase(&group->pasid_array, pasid);
+	entry = xa_erase(&group->pasid_array, pasid);
+	WARN_ON(!entry);
+	iommu_pasid_array_entry_clear_handle(entry);
 	mutex_unlock(&group->mutex);
 }
 EXPORT_SYMBOL_GPL(iommu_detach_device_pasid);
@@ -3562,9 +3572,13 @@ EXPORT_SYMBOL_NS_GPL(iommu_attach_group_handle, "IOMMUFD_INTERNAL");
 void iommu_detach_group_handle(struct iommu_domain *domain,
 			       struct iommu_group *group)
 {
+	void *entry;
+
 	mutex_lock(&group->mutex);
 	__iommu_group_set_core_domain(group);
-	xa_erase(&group->pasid_array, IOMMU_NO_PASID);
+	entry = xa_erase(&group->pasid_array, IOMMU_NO_PASID);
+	WARN_ON(!entry);
+	iommu_pasid_array_entry_clear_handle(entry);
 	mutex_unlock(&group->mutex);
 }
 EXPORT_SYMBOL_NS_GPL(iommu_detach_group_handle, "IOMMUFD_INTERNAL");
-- 
2.34.1

