Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9E6188CC4
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 05:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729231111; cv=none; b=XZyoKKGl3Dc9WI2QkOoB34QsBnm1cuZBpDYe44clvCHE9dxDsNX7gZ+46Fxd+dHADw5RMJPR/vSULuyiFnE8j4Fim65ulIP5Ca4IhaqwC+ccjlcdVeVK1G8Wjzz6/SLe1rWDP4V4NuWXy3uccNoOf19wJJ4E4T2H9X/ThOtSEu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729231111; c=relaxed/simple;
	bh=T7fBMWi071z7M1pLhief7DGpLGWGlmFH1yYzkvK762c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P2d8PftseP6Lu1y64xkr0e+dT8466+CdPcJWOcbohSt+p2mcWX1PKsO/D3jlRCND5j3OCz4quXHxvwJ1HlPOl685AIn/YZsTdafjgxuLFj3qLmU/I1YRo1ct+GVQ4mICOK/NCe0dNblJRoJsF2b7Kt+i8dKVQOvT4ojupwwqidc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iEApPsCn; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iEApPsCn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729231109; x=1760767109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T7fBMWi071z7M1pLhief7DGpLGWGlmFH1yYzkvK762c=;
  b=iEApPsCnsZfygL2An17cLxw2h3X+SB8HhrKmEN7v9sY5yXsuLs5ng1v3
   7FQ+1UilLAhtY+S42fsda9V6Y+NueOyijTf70WDQezDk4Ka1v6y3hjoNa
   7Y1aIkrmGqGSJjNt839kUZosLAo5NirCAE0nm+6GeuhKt5vOSXDN5Tmwd
   mpSzpQlwG3MQDUJ1R37AF9k5A95N2tdcu/k+Z8pDYIrK7qawmT/CLb51W
   c8CHAlDpDfqBs4d3qT2rDQc7F1OYLAV0mHJpgc1drgf7PQveQ16CxoWQy
   XtHZVfgsP+YPokOzCc5Hn+2XApkuHcp0rGnpmeXJZWChQ0I3C5Uf3oOzw
   w==;
X-CSE-ConnectionGUID: ksRizzYFQMSrF2rwnmLgKQ==
X-CSE-MsgGUID: uPncvBRMSASalGdKdK2DnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39879132"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39879132"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 22:58:27 -0700
X-CSE-ConnectionGUID: mCUYuPyqSDeqfzKB/nPR3g==
X-CSE-MsgGUID: Xh6VZBgbRHyri+f8sBdP2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78675730"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa009.jf.intel.com with ESMTP; 17 Oct 2024 22:58:27 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	will@kernel.org
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	vasant.hegde@amd.com
Subject: [PATCH v2 2/3] iommu/arm-smmu-v3: Make the blocked domain support PASID
Date: Thu, 17 Oct 2024 22:58:23 -0700
Message-Id: <20241018055824.24880-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018055824.24880-1-yi.l.liu@intel.com>
References: <20241018055824.24880-1-yi.l.liu@intel.com>
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
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f70165f544df..ae68c7b7fcd5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2961,13 +2961,12 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
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
@@ -2988,6 +2987,7 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 		    sid_domain->type == IOMMU_DOMAIN_BLOCKED)
 			sid_domain->ops->attach_dev(sid_domain, dev);
 	}
+	return 0;
 }
 
 static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
@@ -3069,6 +3069,7 @@ static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
 
 static const struct iommu_domain_ops arm_smmu_blocked_ops = {
 	.attach_dev = arm_smmu_attach_dev_blocked,
+	.set_dev_pasid = arm_smmu_blocking_set_dev_pasid,
 };
 
 static struct iommu_domain arm_smmu_blocked_domain = {
@@ -3497,7 +3498,6 @@ static struct iommu_ops arm_smmu_ops = {
 	.device_group		= arm_smmu_device_group,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
-	.remove_dev_pasid	= arm_smmu_remove_dev_pasid,
 	.dev_enable_feat	= arm_smmu_dev_enable_feature,
 	.dev_disable_feat	= arm_smmu_dev_disable_feature,
 	.page_response		= arm_smmu_page_response,
-- 
2.34.1

