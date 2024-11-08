Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E60A1E7676
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731067478; cv=none; b=IfDpbb3lUb9z/ICPmTsvk+yoGx8PZd//p2uNMItICYGk0I0K8GzI/Gf1B8ySREB8iu5td9JAnqtn0jg0kZi7kJm6t9yXymx9iJCzmQUky3c90dthYL0wt5UTlonHpDyoXkCYNv1eDexXzn4qxsNNI92pLjvIOLyhWrsw11CKUgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731067478; c=relaxed/simple;
	bh=Ztqkn6YB5KTFuQ7dpEC8XYRiiVU3SJZ6g0Npm58rDr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hiW1ZOBneQ/8IhIujS/sGVb2HuX1CqIuaNSIdehRFKOlXipCTiocY2m+Mt5NLFvjy/dZOPght49GfUaO584yyaWmXOKvCyoBFK+mVmWOuodEbe/ptGpwKwaIGtMISVyHx3DOemb0iX+GBeB0XDa+OmM+Cr7DEkAi38RN5SodLOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=is9+ANaK; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="is9+ANaK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731067477; x=1762603477;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ztqkn6YB5KTFuQ7dpEC8XYRiiVU3SJZ6g0Npm58rDr0=;
  b=is9+ANaKy+Qp1g0YL+/hbYYd/T07mbTcpgQokZhDmsowK4zyX3Jjrkx9
   GyAGG7wGIra7ZtFDTA+Uwzp8sHUThgVd8kp8ZU5V3+kI09FfV6INcNGVg
   St9KWczWlhOG+GnV7quRr2mz3bAAuu+rZYYOjj3114rmFsK3BXalWZlvd
   j8VoIqai0Z/qq38T26qjIPv0hirqPitZatL18g2NrExU2DFgfLwQGebYI
   zn1vzNPjhiVVs+JVtJxhOk42L+t94RAEf1zJRGzYwiCqEj97DIeWjklXR
   AZunAfcoqL+tXoyJUelhXQMrZQzr0omhC8t1yfDJqkXERauSWL7taxsxk
   A==;
X-CSE-ConnectionGUID: ql+oFs0lTC6oZqYsuoe3wA==
X-CSE-MsgGUID: TN9Duqf/QxuY0IsRgPxj9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31116425"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31116425"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 04:04:32 -0800
X-CSE-ConnectionGUID: BvjJf2gaSj6pwhLWq9KBvA==
X-CSE-MsgGUID: CKvdFd2ySC21KJndqgmptw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="85679028"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa008.fm.intel.com with ESMTP; 08 Nov 2024 04:04:30 -0800
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
	vasant.hegde@amd.com,
	willy@infradead.org
Subject: [PATCH v4 3/7] iommu: Detaching pasid by attaching to the blocked_domain
Date: Fri,  8 Nov 2024 04:04:23 -0800
Message-Id: <20241108120427.13562-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108120427.13562-1-yi.l.liu@intel.com>
References: <20241108120427.13562-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iommu drivers are on the way to detach pasid by attaching to the blocked
domain. However, this cannot be done in one shot. During the transition, iommu
core would select between the remove_dev_pasid op and the blocked domain.

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 819c6e0188d5..6fd4b904f270 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3302,8 +3302,18 @@ static void iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 				   struct iommu_domain *domain)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
+	struct iommu_domain *blocked_domain = ops->blocked_domain;
+	int ret = 1;
 
-	ops->remove_dev_pasid(dev, pasid, domain);
+	if (blocked_domain && blocked_domain->ops->set_dev_pasid) {
+		ret = blocked_domain->ops->set_dev_pasid(blocked_domain,
+							 dev, pasid, domain);
+	} else {
+		ops->remove_dev_pasid(dev, pasid, domain);
+		ret = 0;
+	}
+
+	WARN_ON(ret);
 }
 
 static int __iommu_set_group_pasid(struct iommu_domain *domain,
@@ -3361,7 +3371,9 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	int ret;
 
 	if (!domain->ops->set_dev_pasid ||
-	    !ops->remove_dev_pasid)
+	    (!ops->remove_dev_pasid &&
+	     (!ops->blocked_domain ||
+	      !ops->blocked_domain->ops->set_dev_pasid)))
 		return -EOPNOTSUPP;
 
 	if (!group)
-- 
2.34.1

