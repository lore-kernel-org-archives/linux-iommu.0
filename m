Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28D91FBC93
	for <iommu@lists.linux.dev>; Wed, 12 Feb 2025 06:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739340346; cv=none; b=s0V+BTgkpwgP+8O1jTbQVOlR+DNVXkZ4XzVF5bbMI31la9ow/HUN42MjPWDkN6pv2BO74Tnr62yDgDaQBHuyNlsXgMPxhazmUYHXdEfbVJcscbgDRO2IyqRUyTEQUsWfmlnUoBKNlTP6Lxh/NAtVO4pn2fEgqgPzt+kzsb1iUZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739340346; c=relaxed/simple;
	bh=2RcVdMUL+PQyeQxm8eDU9BR1dOV9Z+AD0LDM1xBKE9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dN060NPnaGkxxnMFqNrJwOJcMP54wwGRvTfHAaCRFHs1s9gvc/UkanJkxbSUjZxqmdn6b0ZyQmNzf01E/D5Lg1bzjrWH1hwugfoivQ5vHHvdtBnWCDno4eiX8wsQjLjc8LqRrHQDS4FTEGPsG7oxInfFNOKtiNMoW/h57hTCtEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KDKH5aZi; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KDKH5aZi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739340345; x=1770876345;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2RcVdMUL+PQyeQxm8eDU9BR1dOV9Z+AD0LDM1xBKE9g=;
  b=KDKH5aZiiUFXZr/+jhjaumNA3rmBVpr7VSRNKNDNiaadUYz6W4C0FaE0
   07nA6biWv0N+Fe1+r+KYg0gfZqZaajq0kM0alYVNRSJEV5lanPHeXeC3A
   0Px1K4kfNK/8RKf4u7WTsChjLx0SkMw+2s1RpLCOqPzhKDvGQUzrAQRYg
   SkBQQzd8vJ1MqyRBmRUjrheOfLUtWAJsnGwVkMG/oZ/+4LXwd5OLF60XP
   DZMHqZiYTGcSmN6wBzP+tXnpswpU26elv+/HCAMkFmsFppFMMo3kyHbWr
   z7ZBJ8dmrHW3nVGqjUxje6kMCucBtOS0vKQmEj56xobJeaOfnslgYs1Ir
   Q==;
X-CSE-ConnectionGUID: Dtl78oJuRTCBTre1VQ0oxA==
X-CSE-MsgGUID: 1beGC4XeRv6mYYXygMp1yA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="57391231"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="57391231"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 22:05:44 -0800
X-CSE-ConnectionGUID: HyigzjrrShu+mX9zHIt9Aw==
X-CSE-MsgGUID: BDuMwkhEQaiPbi1FPov/mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117899997"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa005.jf.intel.com with ESMTP; 11 Feb 2025 22:05:44 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com
Cc: kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	robin.murphy@arm.com,
	nicolinc@nvidia.com,
	will@kernel.org
Subject: [PATCH 2/5] iommu: Drop iommu_group_replace_domain()
Date: Tue, 11 Feb 2025 22:05:37 -0800
Message-Id: <20250212060540.261436-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212060540.261436-1-yi.l.liu@intel.com>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommufd does not use it now, so drop it.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c | 35 ++++++-----------------------------
 1 file changed, 6 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index eef7e19c547d..4ccb36b5aa30 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2187,32 +2187,6 @@ int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
 }
 EXPORT_SYMBOL_GPL(iommu_attach_group);
 
-/**
- * iommu_group_replace_domain - replace the domain that a group is attached to
- * @group: IOMMU group that will be attached to the new domain
- * @new_domain: new IOMMU domain to replace with
- *
- * This API allows the group to switch domains without being forced to go to
- * the blocking domain in-between.
- *
- * If the currently attached domain is a core domain (e.g. a default_domain),
- * it will act just like the iommu_attach_group().
- */
-int iommu_group_replace_domain(struct iommu_group *group,
-			       struct iommu_domain *new_domain)
-{
-	int ret;
-
-	if (!new_domain)
-		return -EINVAL;
-
-	mutex_lock(&group->mutex);
-	ret = __iommu_group_set_domain(group, new_domain);
-	mutex_unlock(&group->mutex);
-	return ret;
-}
-EXPORT_SYMBOL_NS_GPL(iommu_group_replace_domain, "IOMMUFD_INTERNAL");
-
 static int __iommu_device_set_domain(struct iommu_group *group,
 				     struct device *dev,
 				     struct iommu_domain *new_domain,
@@ -3559,9 +3533,12 @@ EXPORT_SYMBOL_NS_GPL(iommu_detach_group_handle, "IOMMUFD_INTERNAL");
  * @new_domain: new IOMMU domain to replace with
  * @handle: attach handle
  *
- * This is a variant of iommu_group_replace_domain(). It allows the caller to
- * provide an attach handle for the new domain and use it when the domain is
- * attached.
+ * This API allows the group to switch domains without being forced to go to
+ * the blocking domain in-between. It allows the caller to provide an attach
+ * handle for the new domain and use it when the domain is attached.
+ *
+ * If the currently attached domain is a core domain (e.g. a default_domain),
+ * it will act just like the iommu_attach_group_handle().
  */
 int iommu_replace_group_handle(struct iommu_group *group,
 			       struct iommu_domain *new_domain,
-- 
2.34.1

