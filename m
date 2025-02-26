Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350A2215776
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570040; cv=none; b=eKhPOJ+1tbL6qha9A8MeRWY6U/Q7T1L+PxdNKTi8U9D8W1hD2G9HtNZTuO78xcHQFe32wahVizFE4fzeDZpT0M/VmIs9KzWN2aSQr/67yzlTupl60UeLzLVjY36k2Q+TqV14XXYIaV7ZfxvyNYznRFYAM5dgt8Zq3M9V2ytZis4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570040; c=relaxed/simple;
	bh=JY8Y1nGVrFCvIqi0jOgbMdVfpJwK8YKFI9BOaNN1tXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VwU6O7Pbh8zwRQPnd7TGZGbcWOmUw9u0sus+61SY/mHpfDm3jG/EtyMdPwYc7iWTCByeP19djT4xJJrsJrTFhtTxZpnUwG9gnHPP8RLYrRZYlsbdU69yH6IzMyUmamagj0E1kTT8d6Eiwv3343xvCiIEgmFo341t+EwdE8R/wxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Egmfqe3G; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Egmfqe3G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740570039; x=1772106039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JY8Y1nGVrFCvIqi0jOgbMdVfpJwK8YKFI9BOaNN1tXg=;
  b=Egmfqe3GOY0fVjTcugK6XP/i81O79dvkYuUZy61GyRSs3V0J1iP+I2ju
   4eXS8ZPxDYodbPoGgJu3DBWgY1ZdJoGr7+5uHL83xUazH2YffUlJrfp2d
   3Z2mS3krLuFtdh3yruVQtne2kKqHdXkOgs7T72Rft59SyY5fvElC1UL10
   IEnHv5E/nyCzPddn3Y9zYZTmUj2zwcvs3jsT4lSU3GV6nm1lOGZSX894s
   03qULs5YI9oUnNxSnZSMiW8zzk2pt/1fbaQKrM73VdQcbbSNwN15Q371/
   jMykogmv4iE0/IYNKXLMlB4fGJ7FTtlZORjMTNQXPLi/O+/+I82id/M8N
   A==;
X-CSE-ConnectionGUID: nvBXOs9US6y9d70WZosrQw==
X-CSE-MsgGUID: ke3b+8yzQQyJMitwgS8TyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52827091"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52827091"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 03:40:35 -0800
X-CSE-ConnectionGUID: EdWRvzjcQAu2NgiUdTlV2Q==
X-CSE-MsgGUID: yv9xy15HR4OIESnWWDhgwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117171587"
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
Subject: [PATCH v8 05/12] iommufd: Mark PASID-compatible domain
Date: Wed, 26 Feb 2025 03:40:25 -0800
Message-Id: <20250226114032.4591-6-yi.l.liu@intel.com>
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
index 5bdcf1f23305..5df837388419 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -135,6 +135,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	if (IS_ERR(hwpt_paging))
 		return ERR_CAST(hwpt_paging);
 	hwpt = &hwpt_paging->common;
+	hwpt->pasid_compat = flags & IOMMU_HWPT_ALLOC_PASID;
 
 	INIT_LIST_HEAD(&hwpt_paging->hwpt_item);
 	/* Pairs with iommufd_hw_pagetable_destroy() */
@@ -242,6 +243,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	if (IS_ERR(hwpt_nested))
 		return ERR_CAST(hwpt_nested);
 	hwpt = &hwpt_nested->common;
+	hwpt->pasid_compat = flags & IOMMU_HWPT_ALLOC_PASID;
 
 	refcount_inc(&parent->common.obj.users);
 	hwpt_nested->parent = parent;
@@ -296,6 +298,7 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
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

