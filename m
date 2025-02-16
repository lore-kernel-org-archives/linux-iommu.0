Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D14C83A14
	for <iommu@lists.linux.dev>; Sun, 16 Feb 2025 03:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739677956; cv=none; b=B9yoccfEGILyN0NxwrU7bhwy0GIAWIxcnxbDZseFFfn5+6aEN/H54TijcIryqLSCt6hnYSYjaiv+Me9NatnQu54tatwBbt1Dj1WH1qa4hd2hQaHZWYoAhIpTetlGz81j92mNqo09UTo5dEvaXythwseLbHVxProEDMdRyUMuVT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739677956; c=relaxed/simple;
	bh=9F5E3U7EHFeRdqFBhc3aN+elhVPxDFxZEWK7nfLCJrk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IN+6l75qzIZkvI0s5qPXjMFjRUR3gwygg171BhMVVApjsq6yQ08OUdRk5D1BtsNPxHl8/z7aqV8JJBRzXHmEZJFHM3ioi/8FG3nF0MEuYDXCxE0sY9gNjiaibvfKAidwmwYbo/A2B5q/bOigMA92idp594hcttmFQMOemvmkhtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VXFz+j4h; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VXFz+j4h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739677955; x=1771213955;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9F5E3U7EHFeRdqFBhc3aN+elhVPxDFxZEWK7nfLCJrk=;
  b=VXFz+j4htAGvjMgUwqrqztW5XH3jI2fRTI5U6JnbFNIupjhtoJTYaw3S
   L/YW6vR8Fj4po0Wakj8GKWcJX5BLXWVuLBTAMUtMRkebHVfAlR4fbQWmf
   JOYakz3++JuEsfnNTDMqYk0VroG6ex60fDYIoTrw0Jbn/fK/V0kvdCh7O
   cvSKn+9CmVXwlb+qLUbhnILd8R7acCXnL7RKczXYyA9gvqWrtLRujCif1
   GaF91HtP8QwQzY40r/2NoN9sqIUbDw20T14ZUqfnHyIPSftnGCvtHowyI
   jMVNJ0njKK2BYM5rQq9oLIchxj92S8h/vUW8nvxBWKK1IDJDnKM/aMN25
   Q==;
X-CSE-ConnectionGUID: NJ9kOWRwT6GQT+TRr8S/Jg==
X-CSE-MsgGUID: eVXmuZWxTj6jPFPvgRqywg==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="57919320"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="57919320"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 19:52:33 -0800
X-CSE-ConnectionGUID: 22lqdUqTTZabwZIb83m/SQ==
X-CSE-MsgGUID: qBICkUctQLq1iTcWm/dslw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="113544706"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa009.jf.intel.com with ESMTP; 15 Feb 2025 19:52:34 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	jgg@nvidia.com
Cc: yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	robin.murphy@arm.com,
	nicolinc@nvidia.com,
	will@kernel.org,
	vasant.hegde@amd.com
Subject: [PATCH v7 05/13] iommufd: Mark PASID-compatible domain
Date: Sat, 15 Feb 2025 19:52:20 -0800
Message-Id: <20250216035228.23831-6-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250216035228.23831-1-yi.l.liu@intel.com>
References: <20250216035228.23831-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AMD IOMMU requires attaching PASID-compatible domains to PASID-capable
devices. This includes the domains attached to RID and PASIDs. Related
discussions in link [1] and [2]. ARM also has such a requirement, Intel
does not need it, but can live up with it. Hence, iommufd is going to
enforce this requirement as it is not harmful to vendors that do not
need it.

Mark the PASID-capable domains to prepare for adding this enforcement
when iommufd PASID support is added.

[1] https://lore.kernel.org/linux-iommu/20240709182303.GK14050@ziepe.ca/
[2] https://lore.kernel.org/linux-iommu/20240822124433.GD3468552@ziepe.ca/

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c    | 3 +++
 drivers/iommu/iommufd/iommufd_private.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index af2b72647d5a..6fc848d3ef47 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -132,6 +132,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	if (IS_ERR(hwpt_paging))
 		return ERR_CAST(hwpt_paging);
 	hwpt = &hwpt_paging->common;
+	hwpt->pasid_compat = flags & IOMMU_HWPT_ALLOC_PASID;
 
 	INIT_LIST_HEAD(&hwpt_paging->hwpt_item);
 	/* Pairs with iommufd_hw_pagetable_destroy() */
@@ -239,6 +240,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	if (IS_ERR(hwpt_nested))
 		return ERR_CAST(hwpt_nested);
 	hwpt = &hwpt_nested->common;
+	hwpt->pasid_compat = flags & IOMMU_HWPT_ALLOC_PASID;
 
 	refcount_inc(&parent->common.obj.users);
 	hwpt_nested->parent = parent;
@@ -293,6 +295,7 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
 	if (IS_ERR(hwpt_nested))
 		return ERR_CAST(hwpt_nested);
 	hwpt = &hwpt_nested->common;
+	hwpt->pasid_compat = flags & IOMMU_HWPT_ALLOC_PASID;
 
 	hwpt_nested->viommu = viommu;
 	refcount_inc(&viommu->obj.users);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 193ee8a3d5f9..cfb6a0767a30 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -276,6 +276,7 @@ struct iommufd_hw_pagetable {
 	struct iommufd_object obj;
 	struct iommu_domain *domain;
 	struct iommufd_fault *fault;
+	bool pasid_compat : 1;
 };
 
 struct iommufd_hwpt_paging {
-- 
2.34.1

