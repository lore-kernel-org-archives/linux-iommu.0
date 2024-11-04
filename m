Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BEC487BF
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 13:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726720; cv=none; b=G9jMUiFepa7ZY09vR8xJW+4VKevJA5HnpjStZetVvxgMG/IZ4Sqv0+L6cGx4NJI1N+sleGPzIH4tAyAPUYcSe9tng+X/Y+EoC1isIL8+CzERFaMBxIciZxWY3hgwFgIYnUvwOfqsfiA/uhAz/tPiPe9W7Yf+h+GzuDQLIBao2Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726720; c=relaxed/simple;
	bh=r8YL3gV78Md7fw+Bij0xPv0QfVGEOagDK9opEaw2kPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PS1x732wvA23GB51n0YpSHSejOXb96RUVgRo1oUeLoT9LGCeniuz5fbw+u/hKVhelTazTZu5GlBK+PF+c8hldjXnzphhD+ZSPmRTHu7MH5lLmNxfS8bvE3GE/AK9n/3CvDb05iL4E5OW2DADyod/m4zoYG86cFM7ST3RS2H6AMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NlPmJBCg; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NlPmJBCg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730726720; x=1762262720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r8YL3gV78Md7fw+Bij0xPv0QfVGEOagDK9opEaw2kPo=;
  b=NlPmJBCgnuD7SaIkqZELyD6L3kLbbKTa4fuW1F0hhjx3oRd967vrkWwG
   GPL1CAetpaVzV2wzaK+rQu4A4aesiSDIuzRLK7T0pv+Cblo6f6WQW5Tso
   3TwHSh/17q4o5KuyM5uXgsz3SgHRwEdCtilguxiSg43EWJOguSNITANde
   E6eMpRjt2wlfP3fTl590sf47+y1+rRnvJpVE06LSU53FIcrTwHFz4w+Vz
   GpUTEg3GhAprUsS8ELKGoVeKA8Q2yFRB0XJiUsBU3mNBhL/bHzQQFpBq6
   CrzQYjzk4quy5OWZR5XuC+tS7L+m3mmc5rMJ8dUrXedzLhU3GvoLbi10w
   Q==;
X-CSE-ConnectionGUID: UTUq1ZG0SQ6qnr8gfWsmlg==
X-CSE-MsgGUID: DvrbmhI1S3aZY7SOQEoY0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47884046"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="47884046"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 05:25:18 -0800
X-CSE-ConnectionGUID: FTXcK9spRymtrMHOfjt63Q==
X-CSE-MsgGUID: hjyvFFItTQG3uNNENkbn+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="84100451"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa007.jf.intel.com with ESMTP; 04 Nov 2024 05:25:18 -0800
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
Subject: [PATCH v5 04/12] iommufd: Always pass iommu_attach_handle to iommu core
Date: Mon,  4 Nov 2024 05:25:05 -0800
Message-Id: <20241104132513.15890-5-yi.l.liu@intel.com>
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

The iommu_attach_handle is optional in the RID attach/replace API and the
PASID attach APIs. But it is a mandatory argument for the PASID replace API.
Without it, the PASID replace path cannot get the old domain. Hence, the
PASID path (attach/replace) requires the attach handle. As iommufd is the
major user of the RID attach/replace with iommu_attach_handle, this also
makes the iommufd always pass the attach handle for the RID path as well.
This keeps the RID and PASID path much aligned.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/fault.c           | 12 ++++--------
 drivers/iommu/iommufd/iommufd_private.h | 20 +++++++++++++++++---
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index add94b044dc6..55418a067869 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -132,21 +132,17 @@ int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
 
 	curr = iommufd_device_get_attach_handle(idev);
 
-	if (hwpt->fault)
-		ret = iommufd_dev_replace_handle(idev, hwpt, old);
-	else
-		ret = iommu_replace_group_handle(idev->igroup->group,
-						 hwpt->domain, NULL);
+	ret = iommufd_dev_replace_handle(idev, hwpt, old);
 	if (ret) {
 		if (iopf_on)
 			iommufd_fault_iopf_disable(idev);
 		return ret;
 	}
 
-	if (curr) {
+	if (old->fault)
 		iommufd_auto_response_faults(old, curr);
-		kfree(curr);
-	}
+
+	kfree(curr);
 
 	if (iopf_off)
 		iommufd_fault_iopf_disable(idev);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 66eb95063068..19870b08056e 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -512,28 +512,42 @@ static inline int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 	if (hwpt->fault)
 		return iommufd_fault_domain_attach_dev(hwpt, idev);
 
-	return iommu_attach_group(hwpt->domain, idev->igroup->group);
+	return iommufd_dev_attach_handle(hwpt, idev);
 }
 
 static inline void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
 					      struct iommufd_device *idev)
 {
+	struct iommufd_attach_handle *handle;
+
 	if (hwpt->fault) {
 		iommufd_fault_domain_detach_dev(hwpt, idev);
 		return;
 	}
 
-	iommu_detach_group(hwpt->domain, idev->igroup->group);
+	handle = iommufd_device_get_attach_handle(idev);
+	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
+	kfree(handle);
 }
 
 static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 					      struct iommufd_hw_pagetable *hwpt,
 					      struct iommufd_hw_pagetable *old)
 {
+	struct iommufd_attach_handle *curr;
+	int ret;
+
 	if (old->fault || hwpt->fault)
 		return iommufd_fault_domain_replace_dev(idev, hwpt, old);
 
-	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
+	curr = iommufd_device_get_attach_handle(idev);
+
+	ret = iommufd_dev_replace_handle(idev, hwpt, old);
+	if (ret)
+		return ret;
+
+	kfree(curr);
+	return 0;
 }
 
 #ifdef CONFIG_IOMMUFD_TEST
-- 
2.34.1

