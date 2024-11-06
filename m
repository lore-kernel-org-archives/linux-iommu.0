Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0687C204F85
	for <iommu@lists.linux.dev>; Wed,  6 Nov 2024 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907972; cv=none; b=HzqaiUDD+fBA8kTjSe7fvHo7p0E0RpG6MNFcg5ugWOVKUQXjOYGfg5KK6H5tR1MeDo0umDpJ1yan78huT7GoWtQf8VvGKNUPgv+Ecq1C36tLekiu+TpXXyYJU4h+TuAjF6Ch370IkgumXMVW0tQ4/Wz3QzXmoupjajhzuyN7kiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907972; c=relaxed/simple;
	bh=PID8oWvO+CFTF9qbbcIthacYaug1t+ww1apSwKWA758=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iyHF4yzqd60VdXedwBUrAkYOq4nzM+bV3el/BiijqquvLtLyf26e+ZVfcnQTrSyf6Jsw7kZ38DHAuqa2vdxRS4zoukRWVaaqD9kSLyVud0d7iH/t1tv8lXPUdRKn631nrtFBC1f2FOe5RnTcm7mctcGbMV7ytSapdBsISM1GJrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c4+qMOdj; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c4+qMOdj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730907971; x=1762443971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PID8oWvO+CFTF9qbbcIthacYaug1t+ww1apSwKWA758=;
  b=c4+qMOdjGsX0hM9+7S18yClvtNkFajw5Pb/3Q+LxB46f0n8y0iVRHoXp
   MgfNkQKZG/TWrQ5eE8SYQWmRFcxvkSvsuMrdbETKlzxd6JqMc8uWc7bif
   HGM12TSt32KnLKRFh1OI+cwheUqCLeR9qBZtnD/xLa00U9iFB/gS2tH3d
   XtIcsv6hps8uCoKwkDCiXinw9JsWyrbxuYVGnNEUMcdXdSbsCbr4Jvkfp
   VHk2Zi+xj2UZjyWT3rTulWOyVLPD4YhmRsMS9S9SgnvJdpWs4DFWsvBMG
   BFHmv+bQUnAJS+44z4TIaYaV+c5agCBWBsIDCOvZlGJNGbq0Ucf0f+qCW
   g==;
X-CSE-ConnectionGUID: kuj8ArPcRyCGLz2T1twPWg==
X-CSE-MsgGUID: drNauMBLS4CD7mCS+EMD1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="48174212"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="48174212"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 07:46:09 -0800
X-CSE-ConnectionGUID: vJt/UDVXTB2ReAa7cRfllQ==
X-CSE-MsgGUID: Ele5HnXvRs+2B8VLU8YAOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="89468156"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa005.jf.intel.com with ESMTP; 06 Nov 2024 07:46:08 -0800
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
Subject: [PATCH v5 01/13] iommu: Pass old domain to set_dev_pasid op
Date: Wed,  6 Nov 2024 07:45:54 -0800
Message-Id: <20241106154606.9564-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241106154606.9564-1-yi.l.liu@intel.com>
References: <20241106154606.9564-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support domain replacement for pasid, the underlying iommu driver needs
to know the old domain hence be able to clean up the existing attachment.
It would be much convenient for iommu layer to pass down the old domain.
Otherwise, iommu drivers would need to track domain for pasids by themselves,
this would duplicate code among the iommu drivers. Or iommu drivers would
rely group->pasid_array to get domain, which may not always the correct
one.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/amd/amd_iommu.h                   | 3 ++-
 drivers/iommu/amd/pasid.c                       | 3 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 3 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 3 ++-
 drivers/iommu/intel/iommu.c                     | 6 ++++--
 drivers/iommu/intel/svm.c                       | 3 ++-
 drivers/iommu/iommu.c                           | 3 ++-
 include/linux/iommu.h                           | 2 +-
 8 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 38509e1019e9..1bef5d55b2f9 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -53,7 +53,8 @@ struct iommu_domain *amd_iommu_domain_alloc_sva(struct device *dev,
 						struct mm_struct *mm);
 void amd_iommu_domain_free(struct iommu_domain *dom);
 int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
-			    struct device *dev, ioasid_t pasid);
+			    struct device *dev, ioasid_t pasid,
+			    struct iommu_domain *old);
 void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 				struct iommu_domain *domain);
 
diff --git a/drivers/iommu/amd/pasid.c b/drivers/iommu/amd/pasid.c
index 0657b9373be5..d1dfc745f55e 100644
--- a/drivers/iommu/amd/pasid.c
+++ b/drivers/iommu/amd/pasid.c
@@ -100,7 +100,8 @@ static const struct mmu_notifier_ops sva_mn = {
 };
 
 int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
-			    struct device *dev, ioasid_t pasid)
+			    struct device *dev, ioasid_t pasid,
+			    struct iommu_domain *old)
 {
 	struct pdom_dev_data *pdom_dev_data;
 	struct protection_domain *sva_pdom = to_pdomain(domain);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index a7c36654dee5..645da7b69bed 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -332,7 +332,8 @@ void arm_smmu_sva_notifier_synchronize(void)
 }
 
 static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
-				      struct device *dev, ioasid_t id)
+				      struct device *dev, ioasid_t id,
+				      struct iommu_domain *old)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 54c26f9f05db..a66d9a044e52 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2874,7 +2874,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 }
 
 static int arm_smmu_s1_set_dev_pasid(struct iommu_domain *domain,
-				      struct device *dev, ioasid_t id)
+				     struct device *dev, ioasid_t id,
+				     struct iommu_domain *old)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 3878f35be09d..402ba1058794 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4072,7 +4072,8 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 }
 
 static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
-				     struct device *dev, ioasid_t pasid)
+				     struct device *dev, ioasid_t pasid,
+				     struct iommu_domain *old)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
@@ -4358,7 +4359,8 @@ static int identity_domain_attach_dev(struct iommu_domain *domain, struct device
 }
 
 static int identity_domain_set_dev_pasid(struct iommu_domain *domain,
-					 struct device *dev, ioasid_t pasid)
+					 struct device *dev, ioasid_t pasid,
+					 struct iommu_domain *old)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 3cc43a958b4d..4a2bd65614ad 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -111,7 +111,8 @@ static const struct mmu_notifier_ops intel_mmuops = {
 };
 
 static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
-				   struct device *dev, ioasid_t pasid)
+				   struct device *dev, ioasid_t pasid,
+				   struct iommu_domain *old)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d241bfdbf1f8..13fcd9d8f2df 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3305,7 +3305,8 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
 	int ret;
 
 	for_each_group_device(group, device) {
-		ret = domain->ops->set_dev_pasid(domain, device->dev, pasid);
+		ret = domain->ops->set_dev_pasid(domain, device->dev,
+						 pasid, NULL);
 		if (ret)
 			goto err_revert;
 	}
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 6bcab2c43014..56653af5edcb 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -639,7 +639,7 @@ struct iommu_ops {
 struct iommu_domain_ops {
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
 	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
-			     ioasid_t pasid);
+			     ioasid_t pasid, struct iommu_domain *old);
 
 	int (*map_pages)(struct iommu_domain *domain, unsigned long iova,
 			 phys_addr_t paddr, size_t pgsize, size_t pgcount,
-- 
2.34.1

