Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAE01DE89E
	for <iommu@lists.linux.dev>; Fri, 14 Feb 2025 06:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513468; cv=none; b=pth9JC8kuMMW3H8oujhcTFI/gnGJJerHszYseKZYWGLC6Ru3iI2XWOqOk5yq9IbYfuak0AsB/rCjS2YlsV0+o2419z25CYlnWPA6OfVbtUzwresDXDXouc9LSvz367h2SUwG3/KgyBkHoYh6SfpxBp0s+bjRpeAWV5qadbvp7ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513468; c=relaxed/simple;
	bh=IUNYGyLwNXt2mshtCg4MZHI5Zet/iC0sXDLsWw3WF8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLAmiRh/hwpkg1M/+23omhx5+MPZ/MT34rIKCxhFgqnM9WLijRx4fpQezoV/+VnzztLTFNC2rvRrUr6KvfgDUD/uxT2BK+ksRkC7aRn/UshhaIkWb2gO+fi1rbgN2YokK6cPukEcnzbmmry1d/Jv3pYG+rmEyC0OSVv5yaUE+Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g+eOrLCJ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g+eOrLCJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739513467; x=1771049467;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IUNYGyLwNXt2mshtCg4MZHI5Zet/iC0sXDLsWw3WF8U=;
  b=g+eOrLCJQbDtd8XWODdUR+lqJFdwd7qYM9a2pmWSA/IZtieycTuSaqHh
   lsflIV2Odb2lWgwKfMqCjIgxxFC0QGstX2KWPc15K9cTu7xvB2syltdTS
   hq+3xbG9v77HRQ1vVZHisTaAfigGjM6AdbQY5W+1CgL0KdXQXYjdJSmH2
   M2h+P0uXY5IZSw7VRcQP/j5Pf5S2np9GnESc1QYO0AVvcAPxMu1K12+0B
   AakgD/cDbmV3fmpyD7T3s6mOK2Nm+/EPCqZ/QlWClHVm+LT9FqzfHb/gl
   Wub/Pe/JIKLf1rJsQFSzM1FzEHU8gcELm+7WSerJzbiTT+2hTn8wYWr6r
   w==;
X-CSE-ConnectionGUID: zyQvhDyoR9uWFUH47NwvEA==
X-CSE-MsgGUID: 3myzqFN1S6Wxd66fUOpq5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40124483"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="40124483"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 22:11:07 -0800
X-CSE-ConnectionGUID: 6dy07sscTG6imgpwvhdohg==
X-CSE-MsgGUID: +qCDbXopTjWjZcPnpExf4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114268076"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa008.jf.intel.com with ESMTP; 13 Feb 2025 22:11:03 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 02/12] iommu/vt-d: Check if SVA is supported when attaching the SVA domain
Date: Fri, 14 Feb 2025 14:10:54 +0800
Message-ID: <20250214061104.1959525-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
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

