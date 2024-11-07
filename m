Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405AE212169
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730982166; cv=none; b=KeNV0qNAAxx3vW00pcLG/SGg5mtdcozy80G71djDJiAPVeQbUYt3InWWddvrgxwZN4qupBPbgHnAn0C/3/YRsVAcrJNsP5qQt5ULMT+EBBFgRX4rMDkgKzq1CXwuMW1AUN/jjKda9oWRuJ/1H1Rl4wVMDyj9pZMv4U10X2Sj3ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730982166; c=relaxed/simple;
	bh=RXe1e0lpDmoY4yOdlKQD+FyrfZS6AMGHeVy4+CirLKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VjiiSqHKA+1tocw+7jvPKHT8887I9+FjOrL5kmlaQ6fxqpQheUYSVMiCYvbVYZHb1MV5el4PRfxdxB6t91ym/fc0topoXJP7FBUO8ERoe5GyBLIjlKxj9tmNcN6tQtwG+4ut1m8gTETuTiwC7XqPhvt9ivocBhSSODbqnELrZ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BAgfSuQ4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BAgfSuQ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730982165; x=1762518165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RXe1e0lpDmoY4yOdlKQD+FyrfZS6AMGHeVy4+CirLKU=;
  b=BAgfSuQ416/F/zdL7QTuCYKYCMtBUF0JjmaqpwbjYMGg5WHfWll0n3b2
   ep03qKCNF9CZqOglodr9OTFfw1VJBYHF4QSkVA/8NqbUEdo9+1FPZJ3aa
   IHW7vRWOg7vwey2Jt8brPIF21P+ujVpBhEDSJZ9LzJuyylWuX262YwUdJ
   0hZ6CC6FLgOPriu/16FO/L5k+t919AXmoJtvhprQZVz5PSJ5QMJC5RrKj
   lyA6o8kXCTQh5mGFQHq7ytVoBSsDS6D5Q+JX0RTeNfejQXP+7gFgW2pzx
   O1MtU9rATne4IzGy3j+b3pIFuKqMZiCGH9Nd8k/U81QeBOw2k6WM02Sql
   g==;
X-CSE-ConnectionGUID: kORYcDnPQ3K58Ku7rj6r7Q==
X-CSE-MsgGUID: kMYzNmcaQuOk/bnABpsoIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="34744669"
X-IronPort-AV: E=Sophos;i="6.12,265,1728975600"; 
   d="scan'208";a="34744669"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 04:22:42 -0800
X-CSE-ConnectionGUID: fZegnVb4Tz6RExKCRozIZQ==
X-CSE-MsgGUID: yPwV+2mwQOKgqV9NJ4xIUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,265,1728975600"; 
   d="scan'208";a="90180615"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 07 Nov 2024 04:22:43 -0800
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
Subject: [PATCH v6 12/13] iommu/arm-smmu-v3: Make set_dev_pasid() op support replace
Date: Thu,  7 Nov 2024 04:22:33 -0800
Message-Id: <20241107122234.7424-13-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107122234.7424-1-yi.l.liu@intel.com>
References: <20241107122234.7424-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

set_dev_pasid() op is going to be enhanced to support domain replacement
of a pasid. This prepares for this op definition.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 9 +++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 2 +-
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 645da7b69bed..1d3e71569775 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -349,7 +349,7 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 	 * get reassigned
 	 */
 	arm_smmu_make_sva_cd(&target, master, domain->mm, smmu_domain->cd.asid);
-	ret = arm_smmu_set_pasid(master, smmu_domain, id, &target);
+	ret = arm_smmu_set_pasid(master, smmu_domain, id, &target, old);
 
 	mmput(domain->mm);
 	return ret;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a66d9a044e52..7ee3cbbe3744 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2901,7 +2901,7 @@ static int arm_smmu_s1_set_dev_pasid(struct iommu_domain *domain,
 	 */
 	arm_smmu_make_s1_cd(&target_cd, master, smmu_domain);
 	return arm_smmu_set_pasid(master, to_smmu_domain(domain), id,
-				  &target_cd);
+				  &target_cd, old);
 }
 
 static void arm_smmu_update_ste(struct arm_smmu_master *master,
@@ -2931,16 +2931,13 @@ static void arm_smmu_update_ste(struct arm_smmu_master *master,
 
 int arm_smmu_set_pasid(struct arm_smmu_master *master,
 		       struct arm_smmu_domain *smmu_domain, ioasid_t pasid,
-		       struct arm_smmu_cd *cd)
+		       struct arm_smmu_cd *cd, struct iommu_domain *old)
 {
 	struct iommu_domain *sid_domain = iommu_get_domain_for_dev(master->dev);
 	struct arm_smmu_attach_state state = {
 		.master = master,
-		/*
-		 * For now the core code prevents calling this when a domain is
-		 * already attached, no need to set old_domain.
-		 */
 		.ssid = pasid,
+		.old_domain = old,
 	};
 	struct arm_smmu_cd *cdptr;
 	int ret;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index c9e5290e995a..1e96d4af03f8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -879,7 +879,7 @@ void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
 
 int arm_smmu_set_pasid(struct arm_smmu_master *master,
 		       struct arm_smmu_domain *smmu_domain, ioasid_t pasid,
-		       struct arm_smmu_cd *cd);
+		       struct arm_smmu_cd *cd, struct iommu_domain *old);
 
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
 void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
-- 
2.34.1

