Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E8B14D422
	for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719564944; cv=none; b=CR++yQARU9cWLpqbxL1o9bEC5X75/Zp7KcHTDF45hW5ulku49+L49oNll5x2+sFyP1xCGtGsA10V5rEeRzPy6cm5ngQfakfBE8jMSm6O4XBzCbnIvWLSZUjatrruKfD24UOAvHCB5cXqrETaiSRS4eoOMA2qGwHMydUBU1VHYmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719564944; c=relaxed/simple;
	bh=6SS7Fb39DoNB5c9cj+YJNOms5HfGgM/fpHR5MkoWBYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uw3FfVdRLPy/7ivooS1p5BTxtPeoBOkGKGrHXcX7NKSW1TpN+vGPS0hyG1eDnG47n5oNU81ouwHgDkQKsIxFC/RNzIKcgkQwS8nG5y2/dGUbQ1UZFABP0MPwj/H8wdSzHApMrWdwXkeEqT5guG9e+qJz70ux0Gf2trM0WCx4kZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bM8dSKnm; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bM8dSKnm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719564942; x=1751100942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6SS7Fb39DoNB5c9cj+YJNOms5HfGgM/fpHR5MkoWBYA=;
  b=bM8dSKnmHzMO1HpQ5N72y0tsBUO9d7Mxale6txItSMtus9xbuTNsfH6e
   YKuKM5lVKFBHN74MCYtv8FBv7JBrfG0nKk5YO+4wYFnfatNlDUnmN5pAG
   5NRxBNTLprwNHfsA1rHjvDWKgtiyV854GYPiZLkNcxJPYxCeVvKlFPRIp
   2k5VnBrg5Y4yhZ25QjAOXTjCyFVgKzR2NiQycaTQziPOC1p2zPBWW3+c1
   QR+vopku9vBbaXvgcUWHiQBoIckHi7ee88j8GCBisp3jSPb6HZINnDiUK
   nO5TNcSW0HXIXdH4X7cA5RKuNApK2c9ndpGlzsmhTtIZTLMnd8dsRHRCK
   g==;
X-CSE-ConnectionGUID: IJH3m0p0RK2apWQ20zm/kg==
X-CSE-MsgGUID: TkL9/AaASiGMqWN1Prohuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="34277478"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="34277478"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 01:55:40 -0700
X-CSE-ConnectionGUID: P+Wo46d6QluCwUdnJRSucA==
X-CSE-MsgGUID: 6QQsMQ1xRdKz7ltd1PGmsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="44584524"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa010.jf.intel.com with ESMTP; 28 Jun 2024 01:55:41 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	robin.murphy@arm.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev
Subject: [PATCH 1/6] iommu: Pass old domain to set_dev_pasid op
Date: Fri, 28 Jun 2024 01:55:33 -0700
Message-Id: <20240628085538.47049-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628085538.47049-1-yi.l.liu@intel.com>
References: <20240628085538.47049-1-yi.l.liu@intel.com>
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
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/amd/amd_iommu.h                   | 3 ++-
 drivers/iommu/amd/pasid.c                       | 3 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 3 ++-
 drivers/iommu/intel/iommu.c                     | 6 ++++--
 drivers/iommu/intel/svm.c                       | 3 ++-
 drivers/iommu/iommu.c                           | 3 ++-
 include/linux/iommu.h                           | 2 +-
 7 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 2fde1302a584..31141c6bdf54 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -51,7 +51,8 @@ struct iommu_domain *amd_iommu_domain_alloc_sva(struct device *dev,
 						struct mm_struct *mm);
 void amd_iommu_domain_free(struct iommu_domain *dom);
 int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
-			    struct device *dev, ioasid_t pasid);
+			    struct device *dev, ioasid_t pasid,
+			    struct iommu_domain *old);
 void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 				struct iommu_domain *domain);
 
diff --git a/drivers/iommu/amd/pasid.c b/drivers/iommu/amd/pasid.c
index a68215f2b3e1..77bf5f5f947a 100644
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
index e490ffb38015..c058949749cb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -631,7 +631,8 @@ void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
 }
 
 static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
-				      struct device *dev, ioasid_t id)
+				      struct device *dev, ioasid_t id,
+				      struct iommu_domain *old)
 {
 	int ret = 0;
 	struct mm_struct *mm = domain->mm;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 129e5b685762..288c929b3d15 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4065,7 +4065,8 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 }
 
 static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
-				     struct device *dev, ioasid_t pasid)
+				     struct device *dev, ioasid_t pasid,
+				     struct iommu_domain *old)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
@@ -4352,7 +4353,8 @@ static int identity_domain_attach_dev(struct iommu_domain *domain,
 }
 
 static int identity_domain_set_dev_pasid(struct iommu_domain *domain,
-					 struct device *dev, ioasid_t pasid)
+					 struct device *dev, ioasid_t pasid,
+					 struct iommu_domain *old)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index ef12e95e400a..a5845ca94867 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -194,7 +194,8 @@ static const struct mmu_notifier_ops intel_mmuops = {
 };
 
 static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
-				   struct device *dev, ioasid_t pasid)
+				   struct device *dev, ioasid_t pasid,
+				   struct iommu_domain *old)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8212fed27e18..b3a1dabed2dd 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3274,7 +3274,8 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
 	int ret;
 
 	for_each_group_device(group, device) {
-		ret = domain->ops->set_dev_pasid(domain, device->dev, pasid);
+		ret = domain->ops->set_dev_pasid(domain, device->dev,
+						 pasid, NULL);
 		if (ret)
 			goto err_revert;
 	}
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index bff6e7e81fa3..a33f53aab61b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -633,7 +633,7 @@ struct iommu_ops {
 struct iommu_domain_ops {
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
 	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
-			     ioasid_t pasid);
+			     ioasid_t pasid, struct iommu_domain *old);
 
 	int (*map_pages)(struct iommu_domain *domain, unsigned long iova,
 			 phys_addr_t paddr, size_t pgsize, size_t pgcount,
-- 
2.34.1

