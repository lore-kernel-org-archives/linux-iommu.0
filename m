Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E295D1B0F20
	for <iommu@lists.linux.dev>; Mon, 10 Mar 2025 02:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741574865; cv=none; b=V1nUE23uYVrxBmcyZVu6j2CQNqCf2hsMY5aG8wl2EMVe7O+I7OXeiXh6kCUSskL+ZbdU2zmyJCKIcsIZb5/1YKB0O9KGoAqDebWOA0m2cmKIRgjdI9SnxRualxDAnQq9lw+cohA9a+4oSW4tbrM30aCv+b1hkxRMYI/bTQ7QjqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741574865; c=relaxed/simple;
	bh=eRLZCAOXumm8xciIXwNBy9yoUgyMWxGZG1wMruoGihQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g23mmqVONg9nVms0JVsbkOSVx9Wpo0uSyeIXFuUrz50WrojcrEAs6E6lvVilNOG6k+WmhVqvT5b7JMdR99uV8pZRIEqfh0wfDbYzLAtDTocUWkCzvzGT6sSD8McT4xFkETX/wTDa5jCm+QNeevG7qsHoid1Hpu35EcSb90u6/CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZCGlxPxv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZCGlxPxv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741574864; x=1773110864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eRLZCAOXumm8xciIXwNBy9yoUgyMWxGZG1wMruoGihQ=;
  b=ZCGlxPxvEivXQ48GrOSRcj7vak4sqhpErWC37xMKMe5fsbl/tac9m71m
   7AxkYcZvvTtuu0yXS4Lq/EjBKdowUy2dcX5Cz4pWDinJh5+EPCrxzG1zk
   6lVwZzs5hM7ULCeFBdI+2qXXiUBOFv9smcNVb5Dc9dolH+NWryS7DXdGu
   oF2u7B79GHj4XFS981SbRJ4noFQWGkOilKU90yult03vJLgIAV3WRm8lL
   9SHbft+nvTH5ZHFcLaKSg7wmNphN6jDW9d+20dkVw4j2EXq+CCr3Wbxx7
   X7Qs+us6YlhNWP4z/7A1YoEbtcrdL6K0ka0iQodfta7zYn0RC07JkGdTV
   Q==;
X-CSE-ConnectionGUID: /U3s8g4ISxuCSj7vUI153Q==
X-CSE-MsgGUID: Lwin+wz0SauS5OF5QJ6rig==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42401603"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="42401603"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 19:47:39 -0700
X-CSE-ConnectionGUID: A/PkadB7QAW0CFl7ygzhuw==
X-CSE-MsgGUID: pnw+4NfiQiyn+0r25QAzTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="143079231"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa002.fm.intel.com with ESMTP; 09 Mar 2025 19:47:37 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] iommu/vt-d: Check if SVA is supported when attaching the SVA domain
Date: Mon, 10 Mar 2025 10:47:46 +0800
Message-ID: <20250310024749.3702681-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250310024749.3702681-1-baolu.lu@linux.intel.com>
References: <20250310024749.3702681-1-baolu.lu@linux.intel.com>
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
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Link: https://lore.kernel.org/r/20250228092631.3425464-3-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 37 +------------------------------
 drivers/iommu/intel/svm.c   | 43 +++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e7152ea77393..58bff6fe3a93 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3862,41 +3862,6 @@ static struct iommu_group *intel_iommu_device_group(struct device *dev)
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
@@ -4017,7 +3982,7 @@ intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
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

