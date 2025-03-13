Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CED2266F1B
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 12:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869357; cv=none; b=iYRhtAmtEbH8ANA957A8YgMnHz6ipRcLo0SRKJV4wSDvUvyx5chpWN1ZBBvfMFHASrRVp2iVIKjUMy4hMPjGZE8vQsFu2AYY2iUZ+goHPmDItLAega2EEEE5zSS9iC6qrTlf2TnniHyXi6wB7yoUfeTynID1vYQRP8bD/UyXDL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869357; c=relaxed/simple;
	bh=NtrMpO1QtWbF9+2TkatKORlT2i0d3ZYFoaRl58+RNt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ix2SPrlx6vpkdqQn+0jVbGYlCcKGPmUYvwMNwvEVq9pf5HmQOiwMxJh/H0n7UcoFKCME1MrQNlaA+ayyABjS+MY/sfTGKRzYsBHphSu345AaFoHl4HU8oitnufT5mF56Ts4ZPrF8F4hrbLujEDuXmv8EmL+jIhuDOD/CqdqSNZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XAU87JZN; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XAU87JZN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741869356; x=1773405356;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NtrMpO1QtWbF9+2TkatKORlT2i0d3ZYFoaRl58+RNt8=;
  b=XAU87JZNrYb43glKOwquRu7RXvGjj8mzyo7qjpaDdguMnIcuEGu/Woq6
   8HjA3vbsDfjL3/QrCfUAzEVcx1/BajbOvZ6sSXeKjl3w4wNEnPkyJ+z8g
   KHU1UvQrd02DyEqxhLQIEh4ksujuqmX9mYFgGsIrK6lzaWYaJnhMCWK1p
   YSlBfHPzNdxuVSQal+j7NQNdVZSU6zH+IjdMDk34Ifg9Zuj5V2oHnsSej
   Q34K+DhjLhnUTnakqCedlR+DhODi9l0jtrwm1lcax6AQTaxM5I0rpzK2s
   fLfhVWNe5nAZ3kGHrme/8c8xTJLcUJ+yWP32IesHYKQgsVThY6ZKQzl9v
   A==;
X-CSE-ConnectionGUID: fS44XJ7pSrujURzjjvUuCA==
X-CSE-MsgGUID: XG0N0Ff+QraHlsIvQkEGeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42863981"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42863981"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:35:39 -0700
X-CSE-ConnectionGUID: ho18GmahS2qKYH+RQIXdpA==
X-CSE-MsgGUID: jf5nvwVzRBuJ2Vqp3wPPYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126005540"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 13 Mar 2025 05:35:40 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v9 15/21] iommufd: Enforce PASID-compatible domain for RID
Date: Thu, 13 Mar 2025 05:35:26 -0700
Message-Id: <20250313123532.103522-16-yi.l.liu@intel.com>
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

Per the definition of IOMMU_HWPT_ALLOC_PASID, iommufd needs to enforce
the RID to use PASID-compatible domain if PASID has been attached, and
vice versa. The PASID path has already enforced it. This adds the
enforcement in the RID path.

This enforcement requires a lock across the RID and PASID attach path,
the idev->igroup->lock is used as both the RID and the PASID path holds
it.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
v8 -> v9: iommufd_hwpt_pasid_compat() is moved to prior patch
	  I didn't include r-b from Kevin and Jason as this patch has
	  quite a few change compared with v8. It's mainly due to the
	  introduction of pasid_attach for both RID and PASID path.
---
 drivers/iommu/iommufd/device.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index bceaee7376c2..5db6dc705d44 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -503,8 +503,29 @@ static int iommufd_hwpt_pasid_compat(struct iommufd_hw_pagetable *hwpt,
 				     struct iommufd_device *idev,
 				     ioasid_t pasid)
 {
-	if (pasid != IOMMU_NO_PASID && !hwpt->pasid_compat)
-		return -EINVAL;
+	struct iommufd_group *igroup = idev->igroup;
+
+	lockdep_assert_held(&igroup->lock);
+
+	if (pasid == IOMMU_NO_PASID) {
+		unsigned long start = IOMMU_NO_PASID;
+
+		if (!hwpt->pasid_compat &&
+		    xa_find_after(&igroup->pasid_attach,
+				  &start, UINT_MAX, XA_PRESENT))
+			return -EINVAL;
+	}
+
+	if (pasid != IOMMU_NO_PASID) {
+		struct iommufd_attach_handle *handle;
+
+		handle = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
+
+		if (!hwpt->pasid_compat ||
+		    (handle && handle->hwpt && !handle->hwpt->pasid_compat))
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -515,8 +536,6 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 {
 	int rc;
 
-	lockdep_assert_held(&idev->igroup->lock);
-
 	rc = iommufd_hwpt_pasid_compat(hwpt, idev, pasid);
 	if (rc)
 		return rc;
-- 
2.34.1

