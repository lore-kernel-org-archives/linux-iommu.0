Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D4820FAB4
	for <iommu@lists.linux.dev>; Fri, 21 Feb 2025 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148421; cv=none; b=CmPiOwRchzQ4j2JUWoIMItdHZDkQgFVmbcOr2HCKtDmLl5lPILOZkrrR+TtYeorE+fZxZM+0tsoqLjvfL+EKys9IrbLRKJDRDb3co/TvKC3iRMtMpIhFrQU9IhUsysgttc6DlYYPhCrKWUs0nynlhP1REE4414M4vHk1xuMn3uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148421; c=relaxed/simple;
	bh=z+PzwYKKWYN6Umma009i9ElF/f444ER+mLI+m6cHZ5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pvUB0lq2H4bAfQLUnUPaKHXx88sK/dYerY7ytuM625og982sbw1ctbzgbA5xPlMQj/1Fu3H9qoblPvzjsM0OrADzoKPhAnABtdsZmndC1q6efhCH7ff2wS5JWkL9LIwtSNi1OGlZ/wzDTUlzsUCZ7Gyg8nHifBntOZMGXtNiwYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nQB/I/3q; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nQB/I/3q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740148419; x=1771684419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z+PzwYKKWYN6Umma009i9ElF/f444ER+mLI+m6cHZ5g=;
  b=nQB/I/3q98u4eCEojqooefAZ89L+t6KQRUU2HZiBe8Zz6o6ABMjYu0WA
   rJhX87yrhoIaOcA0TRnbLr8d+dBAx09ae5H+odHqckwd90GWzMuRfi9n5
   UI0+JUPkuB5m16hko9Z2VhL9N3xz2iMaqAzZduCvw4fWlcy9/Ua5Kx05y
   qADaqgWnNM8G0JqTWjvMzcXwDv7jwyTHfHI9aUrr0mUzxi+eNwwWw9baG
   L/9T7TQxmIWMGpMS4+7z8rDMDpxBM0akqovYt6UD1EhspsDOXmvtb3nMd
   btS7ysVAaATh1LUUbHsTcnv7yCJgWFe+SqqwgMj+vLKBa91pMlVdtpCHR
   g==;
X-CSE-ConnectionGUID: kuNm516zR6SoMFSrYobUyQ==
X-CSE-MsgGUID: NTkIR+lBSVaNYxxYY3vL+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="63441049"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="63441049"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 06:33:38 -0800
X-CSE-ConnectionGUID: MrVMNaddT8GpM1XFJcS1Vg==
X-CSE-MsgGUID: oSZxuec1TgiiCsmPAMgflA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115887166"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa007.jf.intel.com with ESMTP; 21 Feb 2025 06:33:39 -0800
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
Subject: [PATCH v2 2/4] iommu: Drop iommu_group_replace_domain()
Date: Fri, 21 Feb 2025 06:33:33 -0800
Message-Id: <20250221143335.49874-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221143335.49874-1-yi.l.liu@intel.com>
References: <20250221143335.49874-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommufd does not use it now, so drop it.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu-priv.h |  3 ---
 drivers/iommu/iommu.c      | 35 ++++++-----------------------------
 2 files changed, 6 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index de5b54eaa8bf..b4508423e13b 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -24,9 +24,6 @@ static inline const struct iommu_ops *iommu_fwspec_ops(struct iommu_fwspec *fwsp
 	return iommu_ops_from_fwnode(fwspec ? fwspec->iommu_fwnode : NULL);
 }
 
-int iommu_group_replace_domain(struct iommu_group *group,
-			       struct iommu_domain *new_domain);
-
 int iommu_device_register_bus(struct iommu_device *iommu,
 			      const struct iommu_ops *ops,
 			      const struct bus_type *bus,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 715bdb8af31b..bee3ebc91ae4 100644
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
@@ -3558,9 +3532,12 @@ EXPORT_SYMBOL_NS_GPL(iommu_detach_group_handle, "IOMMUFD_INTERNAL");
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

