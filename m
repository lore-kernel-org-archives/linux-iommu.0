Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAF7222568
	for <iommu@lists.linux.dev>; Thu, 19 Dec 2024 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614873; cv=none; b=lndg8wAR96qHZFDjGdyi/guzKBJFb6Iu1W/suXMdYdda9ImbZwNMvnqPom8viImSCIL2vqVJBlNEnSWMU9/EhWMJFhh32+5aeBaiPWjPzqAUnacrJkTQQ+kzgBLQbP2gwXpqVQ9+kWarmTc6pKRuWTqOtvDnA4cjyFdMlVb4B+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614873; c=relaxed/simple;
	bh=wt83Igp7GWVYKyI4TfHVeXQhHFn0Qfgr8rm4PTmRC6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UDWc/WRFjr2NdBErBaDluhxjplP+8HzJj0ztKlCq8jikk8KtqYQRICxXkmP4HczXNap8aDjwNKx3O+A2InyE0iLILJEq1kDhoMzULG4IydelG5KcvIANh1aQNSvCGQlNm90ssFLQvcc5paTLy6qZ9IJml3suFYUW3tOicP04nCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ayL5DKk/; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ayL5DKk/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734614872; x=1766150872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wt83Igp7GWVYKyI4TfHVeXQhHFn0Qfgr8rm4PTmRC6s=;
  b=ayL5DKk/VWLW+Jg0m81ZZh4hlkh4cvufpoLEq5eOPQ3kMr09Tt/ih+ZA
   qpu2N1qyAEZobysHUUbCpl05uCg860j99onyNjv/d6i78skB/jbEBp07C
   P+LxlXIJ1QmYOmd/s/UM/qnh2GnyU6S7FGMVBVhSYbzSnC8uNomo7ACQD
   KuqFcJVoF+X8cgNKx8UY9YmvswUJ5aYvAB9qVVF+ne9fZ9uL5ZjlpN5nP
   21ZaE76rxUvLquselFLBFqrWwrkuJjh9g6QCb84Z6ei+Erk/P/2Md9Juw
   pgINDG+Qaes1mYlVa5E1DvTTUgmRU0ANQm/kE6JpIdJmUtc/k+FQbfWke
   w==;
X-CSE-ConnectionGUID: GsONNsvgQTWgEpdrCjdPxA==
X-CSE-MsgGUID: qKaMzsKIT1yds1wmnS9bgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="46542268"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="46542268"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 05:27:50 -0800
X-CSE-ConnectionGUID: q1Xj7wq8T+KjKydaQBpnTA==
X-CSE-MsgGUID: RiLc7E+XS2yCjyFu9H4+Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="103177313"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 19 Dec 2024 05:27:50 -0800
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
Subject: [PATCH v6 04/14] iommufd: Always pass iommu_attach_handle to iommu core
Date: Thu, 19 Dec 2024 05:27:36 -0800
Message-Id: <20241219132746.16193-5-yi.l.liu@intel.com>
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
index d06893226070..19f6e2b84274 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -137,21 +137,17 @@ int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
 
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
index d5c83f10d83e..6cf9c1f10e85 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -493,28 +493,42 @@ static inline int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
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
 
 static inline struct iommufd_viommu *
-- 
2.34.1

