Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AF51E2834
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731067482; cv=none; b=BB7o4sxB2zwDZ2NfKgxYpCF59GzgUf7UHgD2pb5wLdCOK4I+lUikk1V6RLs+WBql7WKhdm8HR2WurrAs8/raezVtFlY+j+ugT2pqE9oDWSwQhs2bESwotZmG4uZ/b1yatiOUMCBHCC+vdMG2+V8OHzii/c659rvG8U3MxQNeM24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731067482; c=relaxed/simple;
	bh=CQNBEu2JwavCGSEpJSQqW92hh61UdmjmKwLxFCOoolw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GR9c7u/T0YX7t0ozBV0g58TFTF7fk9WJ4C5PxL20UlKKLVc/fakcndc265Cacrv/7pErKMC7/kAVrIuO7GqyPC4zk5V68+vIGRfiGswGJ4c8PFZyEWwjOY0wa9c9aOvPU5neQmW7HhOQUklDrb6wOINrqYLPlwy5H84tVOvRYak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahbpli8J; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahbpli8J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731067481; x=1762603481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CQNBEu2JwavCGSEpJSQqW92hh61UdmjmKwLxFCOoolw=;
  b=ahbpli8JlV/+fO065eQOEXQZuShHdnRAWHoGkZOJyhQg8MlLuxtyh5la
   VIiYg35o/U/ovC2AK0HIQDXA/aMjGm7CwA86+tC8zk2chtzAxLb20t3A3
   uy6qACHlOd3o8GG7dgSRLqETfARlleNlxGH4NVsAKg+8NIwNORDLBlYSg
   ZbQZmULHgaFebEAtbRmvcPR+waYyQRis1rXwqLksD8jOS6UMuBWqKSNns
   J6DqiUARTi7zqEGpIVPK8+XT6W6gWxNsCNvmUKsqGrglEjsNIXGgpknQ4
   6QruL74cnQ9NCXeKigrBZ22OK4r9sgHjkLz8uKpdGRIRLuWg1U8q/wR1j
   w==;
X-CSE-ConnectionGUID: WAWvaILeSF6sJMNG3scWkQ==
X-CSE-MsgGUID: QDCFUOyPQf648E4mwQG50w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31116432"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31116432"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 04:04:32 -0800
X-CSE-ConnectionGUID: 8jPCKd2FSTyOYptJ5NZeMw==
X-CSE-MsgGUID: 9aVtwdCUSbaefL4fgoEG3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="85679033"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa008.fm.intel.com with ESMTP; 08 Nov 2024 04:04:31 -0800
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
Subject: [PATCH v4 4/7] iommu/arm-smmu-v3: Make the blocked domain support PASID
Date: Fri,  8 Nov 2024 04:04:24 -0800
Message-Id: <20241108120427.13562-5-yi.l.liu@intel.com>
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

From: Jason Gunthorpe <jgg@nvidia.com>

The blocked domain is used to park RID to be blocking DMA state. This
can be extended to PASID as well. By this, the remove_dev_pasid() op
of ARM SMMUv3 can be dropped.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7ee3cbbe3744..276738d047e7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2979,13 +2979,12 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 	return ret;
 }
 
-static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
-				      struct iommu_domain *domain)
+static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
+					   struct device *dev, ioasid_t pasid,
+					   struct iommu_domain *old_domain)
 {
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(old_domain);
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
-	struct arm_smmu_domain *smmu_domain;
-
-	smmu_domain = to_smmu_domain(domain);
 
 	mutex_lock(&arm_smmu_asid_lock);
 	arm_smmu_clear_cd(master, pasid);
@@ -3006,6 +3005,7 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 		    sid_domain->type == IOMMU_DOMAIN_BLOCKED)
 			sid_domain->ops->attach_dev(sid_domain, dev);
 	}
+	return 0;
 }
 
 static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
@@ -3087,6 +3087,7 @@ static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
 
 static const struct iommu_domain_ops arm_smmu_blocked_ops = {
 	.attach_dev = arm_smmu_attach_dev_blocked,
+	.set_dev_pasid = arm_smmu_blocking_set_dev_pasid,
 };
 
 static struct iommu_domain arm_smmu_blocked_domain = {
@@ -3514,7 +3515,6 @@ static struct iommu_ops arm_smmu_ops = {
 	.device_group		= arm_smmu_device_group,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
-	.remove_dev_pasid	= arm_smmu_remove_dev_pasid,
 	.dev_enable_feat	= arm_smmu_dev_enable_feature,
 	.dev_disable_feat	= arm_smmu_dev_disable_feature,
 	.page_response		= arm_smmu_page_response,
-- 
2.34.1

