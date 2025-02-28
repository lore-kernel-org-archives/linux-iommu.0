Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68E4256C81
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734790; cv=none; b=rtC9nd9y36Z9WZ7Sz6v+Bxekt7KRR2iHX0+CwjvFtGyaEIESQSDLgwO8x+e/P7md+vUeYM4kd2JjUzDICsZOWnN6TAJZeLDPWMLbVOVWTkHXxfwRpWJV8Rffz4NkGsy6ilanyee2XFpvQYeP2dFybDmfwWNrSILwOdDr/H8h+cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734790; c=relaxed/simple;
	bh=E0bnGY3mylsJfxsajBFZKaZ94BGYvt7K/NXKdn1kqXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECR541wlk3RFS3M8Sc3X+KZMsMmuX4gNF06X/H1P/6s812rZ0lpXYy2jzQDWCe4HRPJ4XBlwJPOv9ELCedK/JGjXVt+nrX+FAOK8DgM+ltWnpiY0DU2meTiirjpRXk1X/UoS3cnyp8ORt1Czt0y82o+XW7LmkDkRaV604xmh2DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iz+X9alO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iz+X9alO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740734788; x=1772270788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E0bnGY3mylsJfxsajBFZKaZ94BGYvt7K/NXKdn1kqXI=;
  b=Iz+X9alOeYP/rKyEiawpfwjW48cvQG8pA6RPmw6EB9lVQmyl/Ztvumhd
   7j2pCWBS5HnkVv4w7onsvSHsm3yfZJIAMJzCu6/e1rQjuH79lH2+aYlTC
   MkTRoAFgX71F/JQ/Dwqrw3n+Hmt7rfdm2Mlx/AY44WTB+eeouB/EJ6iJR
   L+D31BSHxQgebTrACkwsry+aXMFb9UIqFSOCyvzxalfddv++A5VpNCRWD
   jj4B3aHB5KnWCT3ASKyq4zOyvnRGRV2laIpJLHFJXfhFfGy0hS0xUoJEB
   +31QivAqTFsUpAazTd0wYhzlyuVSU31ycpXRgigmj7EW5n/rdMV8sMkO5
   A==;
X-CSE-ConnectionGUID: sj72JfMpRuWBQutZaIuOdQ==
X-CSE-MsgGUID: kCnT4Ft6S5ap0OJ4ERYTfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45438308"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="45438308"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 01:26:28 -0800
X-CSE-ConnectionGUID: Xs5QU5bLQ0SGET2rRe8oRw==
X-CSE-MsgGUID: 9jZ6kJIiQYWR2dOBMF45Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148212944"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa001.fm.intel.com with ESMTP; 28 Feb 2025 01:26:24 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 02/12] iommu/vt-d: Check if SVA is supported when attaching the SVA domain
Date: Fri, 28 Feb 2025 17:26:21 +0800
Message-ID: <20250228092631.3425464-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228092631.3425464-1-baolu.lu@linux.intel.com>
References: <20250228092631.3425464-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

Attach of a SVA domain should fail if SVA is not supported, move the check
for SVA support out of IOMMU_DEV_FEAT_SVA and into attach.

Also check when allocating a SVA domain to match other drivers.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/iommu/intel/iommu.c | 37 +------------------------------
 drivers/iommu/intel/svm.c   | 43 +++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cc46098f875b..a4048de66378 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3851,41 +3851,6 @@ static struct iommu_group *intel_iommu_device_group(struct device *dev)
 	return generic_device_group(dev);
 }
 
-static int intel_iommu_enable_sva(struct device *dev)
-{
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct intel_iommu *iommu;
-
-	if (!info || dmar_disabled)
-		return -EINVAL;
-
-	iommu = info->iommu;
-	if (!iommu)
-		return -EINVAL;
-
-	if (!(iommu->flags & VTD_FLAG_SVM_CAPABLE))
-		return -ENODEV;
-
-	if (!info->pasid_enabled || !info->ats_enabled)
-		return -EINVAL;
-
-	/*
-	 * Devices having device-specific I/O fault handling should not
-	 * support PCI/PRI. The IOMMU side has no means to check the
-	 * capability of device-specific IOPF.  Therefore, IOMMU can only
-	 * default that if the device driver enables SVA on a non-PRI
-	 * device, it will handle IOPF in its own way.
-	 */
-	if (!info->pri_supported)
-		return 0;
-
-	/* Devices supporting PRI should have it enabled. */
-	if (!info->pri_enabled)
-		return -EINVAL;
-
-	return 0;
-}
-
 static int context_flip_pri(struct device_domain_info *info, bool enable)
 {
 	struct intel_iommu *iommu = info->iommu;
@@ -4006,7 +3971,7 @@ intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
 		return intel_iommu_enable_iopf(dev);
 
 	case IOMMU_DEV_FEAT_SVA:
-		return intel_iommu_enable_sva(dev);
+		return 0;
 
 	default:
 		return -ENODEV;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index f5569347591f..ba93123cb4eb 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -110,6 +110,41 @@ static const struct mmu_notifier_ops intel_mmuops = {
 	.free_notifier = intel_mm_free_notifier,
 };
 
+static int intel_iommu_sva_supported(struct device *dev)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu;
+
+	if (!info || dmar_disabled)
+		return -EINVAL;
+
+	iommu = info->iommu;
+	if (!iommu)
+		return -EINVAL;
+
+	if (!(iommu->flags & VTD_FLAG_SVM_CAPABLE))
+		return -ENODEV;
+
+	if (!info->pasid_enabled || !info->ats_enabled)
+		return -EINVAL;
+
+	/*
+	 * Devices having device-specific I/O fault handling should not
+	 * support PCI/PRI. The IOMMU side has no means to check the
+	 * capability of device-specific IOPF.  Therefore, IOMMU can only
+	 * default that if the device driver enables SVA on a non-PRI
+	 * device, it will handle IOPF in its own way.
+	 */
+	if (!info->pri_supported)
+		return 0;
+
+	/* Devices supporting PRI should have it enabled. */
+	if (!info->pri_enabled)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 				   struct device *dev, ioasid_t pasid,
 				   struct iommu_domain *old)
@@ -121,6 +156,10 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 	unsigned long sflags;
 	int ret = 0;
 
+	ret = intel_iommu_sva_supported(dev);
+	if (ret)
+		return ret;
+
 	dev_pasid = domain_add_dev_pasid(domain, dev, pasid);
 	if (IS_ERR(dev_pasid))
 		return PTR_ERR(dev_pasid);
@@ -161,6 +200,10 @@ struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
 	struct dmar_domain *domain;
 	int ret;
 
+	ret = intel_iommu_sva_supported(dev);
+	if (ret)
+		return ERR_PTR(ret);
+
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
-- 
2.43.0

