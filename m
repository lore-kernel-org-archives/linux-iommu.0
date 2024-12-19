Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A60225A26
	for <iommu@lists.linux.dev>; Thu, 19 Dec 2024 13:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614876; cv=none; b=j6f9hJ0fKA0/4n9R6jNPLMKCXOmubJNOQi8v8DSTfEqb/2uYUJKbFpXxUhEL0ZAgB8St8KMqH4BnxPp7Zxz4tuFS8CReST5c2XvzjmNEc4ZELme2N+4W5rAIkgBGDhsBXt3q9pT4RuAFRbkFyvMhRFqSsnMmFmNkh8I8w8SgKhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614876; c=relaxed/simple;
	bh=h87Kc2l+VOUEsXtUo+qrdxz+7/yD51+2uxgGAV6Yrqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rDLm/R9t5lIUBJSxFU0/dmlLIG3qqMOrd5ct/FIzAQN4LqaRI72UEHpsa+L0UHPi1vXK/jtvN29wlrzDMq6HyMpyABKdpTdvDs5GQRvd5UzDQcw8zB/IKJI5gc8gFVTQn8KIXZ16bsSZB7/5xkeFEKB2cqhPIxSJ4e8bsdQCrSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kWNCl3sp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kWNCl3sp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734614873; x=1766150873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h87Kc2l+VOUEsXtUo+qrdxz+7/yD51+2uxgGAV6Yrqw=;
  b=kWNCl3spED1ciIye2qQzFgnFozy+mSzaFL0yF1wEA7trzKDwQn2d7Y7u
   q3Fo81HUwTfW58ivv26SQr8Qti8Zo9iWZRpv6mXr1GpswTktYelx3UCj6
   OEx+Uf68AoHut419pXh/WeDZqrNHChmU+gqkWO5UvIEes3HeUMYmQZyVR
   aJJ1VWFMaS6TQpkCUqAKsYi71JsqGIbjLnOuoVao83wFmfzvBt+nJTdi0
   pYofK9vSThrQllwXSUBYq4IlVOfFWxLE69UZq4hmodLWCiEuJFdf/Bn/B
   9+AyZ/zN2/hju6SDkwsn7bpNsICxGgEyLq+QuG3UyaoMbhqPPjMeSTIjB
   g==;
X-CSE-ConnectionGUID: QvNtPh4FSAS/iwS9ZLk74Q==
X-CSE-MsgGUID: AcNdMAoLQ4OULiiefUxQ5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="46542280"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="46542280"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 05:27:50 -0800
X-CSE-ConnectionGUID: SC/QB6RgRMSkULKIMNYENg==
X-CSE-MsgGUID: 6v2gT5bXQcOeEJ0NgJYV7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="103177320"
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
Subject: [PATCH v6 06/14] iommufd: Mark PASID-compatible domain
Date: Thu, 19 Dec 2024 05:27:38 -0800
Message-Id: <20241219132746.16193-7-yi.l.liu@intel.com>
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

AMD IOMMU requires attaching PASID-compatible domains to PASID-capable
devices. This includes the domains attached to RID and PASIDs. Related
discussions in link [1] and [2].  ARM has similar requirement but does
not need extra hint from iommufd, Intel does not have this requirement
but can live up with it. Hence, iommufd is going to enforce this
requirement as it's general requirement. Mark the PASID-capable domains
to prepare for adding this enforcement when PASID support is added.

[1] https://lore.kernel.org/linux-iommu/20240709182303.GK14050@ziepe.ca/
[2] https://lore.kernel.org/linux-iommu/20240822124433.GD3468552@ziepe.ca/

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
index 6d4e743ea8fe..21d33a784193 100644
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

