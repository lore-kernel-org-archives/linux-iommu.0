Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B211C3F2C
	for <iommu@lists.linux.dev>; Wed,  4 Dec 2024 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733315379; cv=none; b=P76QmLGCkpFG08CxKJRRW63nBeD39/tNKSLfuQPKFoyLyhuc/28pgtY898W/bhm9gGMLtD/IPeaTrPUfKjdv6+cm3VkAXIP51+Thu1REjP0gM/hWHsPNypZep6ZuxcfePOA65CagHvE/luQ981QG75Ky44NwMAS0lheyRw3h7bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733315379; c=relaxed/simple;
	bh=qaXBrpGyFt9i3LniGPVfnD7c/ISqj1AsLkUlsnwfNM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YQEER3wAqBRK1mXbLbVW1JwWSF4TmatkoDFPB06nZ2wutlseXu6LMC1noHr5h7lpKt6xIofxM/j3W8LDrmNHYwuhlveRMd3PxGeHuSlt0jsslpefbrJwzr/FF79E9cLU7P2fp2sCD+DYLaTgqDF9er1W083LhuTlV0NVvMNp+Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KGWkWilF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KGWkWilF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733315378; x=1764851378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qaXBrpGyFt9i3LniGPVfnD7c/ISqj1AsLkUlsnwfNM0=;
  b=KGWkWilF2xRifXbHEtkYTCrQojnw2EOxoav7YXCIrQDxQcF+0YeWFReS
   klWcox2DTLbGnYP3e6QTe4JUwCNJBSKMpGmIiBjQLOID3uDQdeF1EoqTt
   z01HN1XYEagmznnGaSDZvTyDt6w+xX1RmP9zDC98m0Odk2JwQaNTQpsI/
   HEECVH1D1mEvqIsLtIQY8Yl9NpaRGw5mNcpyn/p4cNtgHw2jRXSDjWOB6
   XwGC3rWoUYG+meLYvVeDcB+ZSnPDr6glmvnIa8vamucRdqoTKNO4UKGEl
   w54iBx8ti8WuEwu+laWTKsW8EqfZl5LIpPTMRw6gexIittCpEWDN/JlVS
   w==;
X-CSE-ConnectionGUID: FnVja9JcQE6UFe7EwOOkFg==
X-CSE-MsgGUID: X1YRdHUmRFe1mOsfPzo3HQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="32937925"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="32937925"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 04:29:34 -0800
X-CSE-ConnectionGUID: rgp/M8gGTnS7x4VhjIBY0g==
X-CSE-MsgGUID: 114BOdpTTM2lMbRF5mEGCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="93599091"
Received: from unknown (HELO 984fee00a4c6.jf.intel.com) ([10.165.58.231])
  by orviesa010.jf.intel.com with ESMTP; 04 Dec 2024 04:29:34 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	vasant.hegde@amd.com,
	will@kernel.org
Subject: [PATCH v6 7/7] iommu: Remove the remove_dev_pasid op
Date: Wed,  4 Dec 2024 04:29:28 -0800
Message-Id: <20241204122928.11987-8-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204122928.11987-1-yi.l.liu@intel.com>
References: <20241204122928.11987-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iommu drivers that supports PASID have supported attaching pasid to the
blocked_domain, hence remove the remove_dev_pasid op from the iommu_ops.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c | 17 ++++-------------
 include/linux/iommu.h |  5 -----
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 149ae5300cc4..d328d4753eef 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3317,17 +3317,9 @@ static void iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	struct iommu_domain *blocked_domain = ops->blocked_domain;
-	int ret = 1;
 
-	if (blocked_domain && blocked_domain->ops->set_dev_pasid) {
-		ret = blocked_domain->ops->set_dev_pasid(blocked_domain,
-							 dev, pasid, domain);
-	} else {
-		ops->remove_dev_pasid(dev, pasid, domain);
-		ret = 0;
-	}
-
-	WARN_ON(ret);
+	WARN_ON(blocked_domain->ops->set_dev_pasid(blocked_domain,
+						   dev, pasid, domain));
 }
 
 static int __iommu_set_group_pasid(struct iommu_domain *domain,
@@ -3390,9 +3382,8 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	ops = dev_iommu_ops(dev);
 
 	if (!domain->ops->set_dev_pasid ||
-	    (!ops->remove_dev_pasid &&
-	     (!ops->blocked_domain ||
-	      !ops->blocked_domain->ops->set_dev_pasid)))
+	    !ops->blocked_domain ||
+	    !ops->blocked_domain->ops->set_dev_pasid)
 		return -EOPNOTSUPP;
 
 	if (ops != domain->owner || pasid == IOMMU_NO_PASID)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 318d27841130..38c65e92ecd0 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -587,9 +587,6 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
  *		- IOMMU_DOMAIN_DMA: must use a dma domain
  *		- 0: use the default setting
  * @default_domain_ops: the default ops for domains
- * @remove_dev_pasid: Remove any translation configurations of a specific
- *                    pasid, so that any DMA transactions with this pasid
- *                    will be blocked by the hardware.
  * @viommu_alloc: Allocate an iommufd_viommu on a physical IOMMU instance behind
  *                the @dev, as the set of virtualization resources shared/passed
  *                to user space IOMMU instance. And associate it with a nesting
@@ -647,8 +644,6 @@ struct iommu_ops {
 			      struct iommu_page_response *msg);
 
 	int (*def_domain_type)(struct device *dev);
-	void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid,
-				 struct iommu_domain *domain);
 
 	struct iommufd_viommu *(*viommu_alloc)(
 		struct device *dev, struct iommu_domain *parent_domain,
-- 
2.34.1

