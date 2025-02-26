Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248C9238170
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740566415; cv=none; b=W/Dwp0xbBSyJNQpqHYaQw7bq4kJJbpK1KMsSbtaoZ0y7tEfxYf7sUcotiEMGQYEhvG960SrmwyUwpmexxJ5FYSv0nsd0WJzekalAG+j5luFnSB5F9TrFnWXgjeQ7QtYNPvMoGnh/i8706HmwE/w/jil++zQxxamXhvQ7c33/F0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740566415; c=relaxed/simple;
	bh=z0T94MCtuZ9Ka74GRYcZWqcJ4grGB701ipHV5/PghRs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B3lCDCy6+Ht1WRi8q0+KidGmLWPFyh/ZB/0Dn48rKjnE5JNgjatvpEkS5rxzQSY0+vRS6mLWwgAzhRyFuY0ko3usUMoB4OjmRrPR9r1I4M2flLPlOob/H7fL675X+/UCLF2sI5WnfYqkQtb5/YZew95bUDSMmtbGItMRVzQqkZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h/sZQdLC; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h/sZQdLC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740566414; x=1772102414;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z0T94MCtuZ9Ka74GRYcZWqcJ4grGB701ipHV5/PghRs=;
  b=h/sZQdLCjPaB353Psf+QlP0GYtU9XNGlVUVQcIJ5MV8/3dOjiVJa9N0l
   eZb06TngzAIWkfKINupL7b1pge5eBb07swl4EdBdUY14ukuN7T3oa+VV7
   /hbEoqcaxe5xckTcGPpsisBDaMrhNm+1UmB9CAea1iZA7q4FebSNmX5oo
   sQxglwOg6wcnQF03mhiS+R69znG4nHzRqXvO3e0h5CsOslPs9gOIaOXEI
   6ba1ho7EJrqNlnvNGNnttqguW6M17YSRa5LA7YC76cklev6unfkPhe6c7
   V19BDMgfxE93ZufAz8obKseJai7XmB3yWyWla8s7fJGbodtWEZeEEP3Bf
   A==;
X-CSE-ConnectionGUID: YL0xJYEAROiVQBeuy13a9A==
X-CSE-MsgGUID: kRpeNT4RQ5mlhnoEkJwwYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="52798215"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="52798215"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 02:40:14 -0800
X-CSE-ConnectionGUID: oPNpqiZBT5u/+heCmFV7dw==
X-CSE-MsgGUID: 5iFfsfl6QX+IDOAk0dbDlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="116680257"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa006.jf.intel.com with ESMTP; 26 Feb 2025 02:40:13 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	robin.murphy@arm.com,
	nicolinc@nvidia.com,
	will@kernel.org,
	joro@8bytes.org,
	vasant.hegde@amd.com
Subject: [PATCH] iommufd: Disallow allocating nested parent domain with fault ID
Date: Wed, 26 Feb 2025 02:40:12 -0800
Message-Id: <20250226104012.82079-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allocating a domain with a fault ID indicates that the domain is faultable.
However, there is a gap for the nested parent domain to support PRI. Some
hardware lacks the capability to distinguish whether PRI occurs at stage 1
or stage 2. This limitation may require software-based page table walking
to resolve. Since no in-tree IOMMU driver currently supports this
functionality, it is disallowed. For more details, refer to the related
discussion at [1].

[1] https://lore.kernel.org/linux-iommu/bd1655c6-8b2f-4cfa-adb1-badc00d01811@intel.com/

Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c    | 3 +++
 tools/testing/selftests/iommu/iommufd.c | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 598be26a14e2..9b5b0b852229 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -126,6 +126,9 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	if ((flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING) &&
 	    !device_iommu_capable(idev->dev, IOMMU_CAP_DIRTY_TRACKING))
 		return ERR_PTR(-EOPNOTSUPP);
+	if ((flags & IOMMU_HWPT_FAULT_ID_VALID) &&
+	    (flags & IOMMU_HWPT_ALLOC_NEST_PARENT))
+		return ERR_PTR(-EOPNOTSUPP);
 
 	hwpt_paging = __iommufd_object_alloc(
 		ictx, hwpt_paging, IOMMUFD_OBJ_HWPT_PAGING, common.obj);
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 8d8ce97b53ee..35c5f1ad482a 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -439,6 +439,10 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 				    &test_hwpt_id);
 		test_err_hwpt_alloc(EINVAL, self->device_id, self->device_id, 0,
 				    &test_hwpt_id);
+		test_err_hwpt_alloc(EOPNOTSUPP, self->device_id, self->ioas_id,
+				    IOMMU_HWPT_ALLOC_NEST_PARENT |
+						IOMMU_HWPT_FAULT_ID_VALID,
+				    &test_hwpt_id);
 
 		test_cmd_hwpt_alloc(self->device_id, self->ioas_id,
 				    IOMMU_HWPT_ALLOC_NEST_PARENT,
-- 
2.34.1

