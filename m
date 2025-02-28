Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2CE25BAA7
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 09:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734809; cv=none; b=iDvnYtgrk7QgtOM7asMYQNJiFJj9Q8U3lqwYEmUlMF3rVZlTPCSbRmnE0mrNmK50yN12irBJb8UbrgmPMh9u4iiYetuUGtqYEuDwYDt/xNtDHDPt0iMdRs+PmOOgrQemKKG074xW/KhhdpCD36xoKmZuUhmf+E6vIqAgfCCxQ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734809; c=relaxed/simple;
	bh=KF/373Uym7o0grt9RffFwxMY4xuy3p+bGjJCwnjS2Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Seis2p5354gOIkU+8p/4v8dWca79AwaxtOt3aqoGOVafYx/ks5D/lA1hAWHplmNeeNfrDwcq7XLfmNPLhqC0eQ+r/BsQwKC1N/uhNO83KIZTSxSN74EbmIiRSoi1d/ByXa7Nbe8Lp6q43xMbXXRjTGY2ivJT/eYBFmMldkoW1tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dJ1O2nfi; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dJ1O2nfi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740734808; x=1772270808;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KF/373Uym7o0grt9RffFwxMY4xuy3p+bGjJCwnjS2Cw=;
  b=dJ1O2nfiZXGoiVG4CqVHUnQIf3asWwOo6Z+slEPjWf176rKHoFVpnePr
   MjMRYPdAWV20lP6cdUswk+EHfjEFAJ9yFUvh8L3axqQthkkT5nIn6XffV
   WuI0ofysWvBnPkVcHtUC+xy93pOn5MEnYofs2WvpW31/AoHIj546LNtdG
   /AH7lvwbEh3AmgepKAR/gr1yg8v3Vi/75Tz/lAHuOBC7UyT8F4w8xJ24v
   n4u0Tllajk+XdgCO8M/ep7zNPxY3zJ+a+20AmrHC9JHuEiUlpO3SACgud
   f4+lR/f8k8lFhFTaza5vmWhU32058hSOUJ+WwgfewMLtMOMM2HGHplzJu
   g==;
X-CSE-ConnectionGUID: u0noIXIDQJ24TXILpIDufg==
X-CSE-MsgGUID: SFfKU48fRBaoEsG9+teJvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45438378"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="45438378"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 01:26:47 -0800
X-CSE-ConnectionGUID: dW3pjHFwTN2Hoh0PnFQwCw==
X-CSE-MsgGUID: R4RKkO5HSi+mYJ4rusZqpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148213009"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa001.fm.intel.com with ESMTP; 28 Feb 2025 01:26:44 -0800
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
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 08/12] iommufd/selftest: Put iopf enablement in domain attach path
Date: Fri, 28 Feb 2025 17:26:27 +0800
Message-ID: <20250228092631.3425464-9-baolu.lu@linux.intel.com>
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

Update iopf enablement in the iommufd mock device driver to use the new
method, similar to the arm-smmu-v3 driver. Enable iopf support when any
domain with an iopf_handler is attached, and disable it when the domain
is removed.

Add a refcount in the mock device state structure to keep track of the
number of domains set to the device and PASIDs that require iopf.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/iommu/iommufd/selftest.c | 64 ++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index d40deb0a4f06..471af81e2617 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -58,6 +58,9 @@ enum {
 	MOCK_PFN_HUGE_IOVA = _MOCK_PFN_START << 2,
 };
 
+static int mock_dev_enable_iopf(struct device *dev, struct iommu_domain *domain);
+static void mock_dev_disable_iopf(struct device *dev, struct iommu_domain *domain);
+
 /*
  * Syzkaller has trouble randomizing the correct iova to use since it is linked
  * to the map ioctl's output, and it has no ide about that. So, simplify things.
@@ -164,6 +167,8 @@ struct mock_dev {
 	unsigned long flags;
 	int id;
 	u32 cache[MOCK_DEV_CACHE_NUM];
+	unsigned int iopf_refcount;
+	struct iommu_domain *domain;
 };
 
 static inline struct mock_dev *to_mock_dev(struct device *dev)
@@ -193,15 +198,34 @@ static int mock_domain_nop_attach(struct iommu_domain *domain,
 				  struct device *dev)
 {
 	struct mock_dev *mdev = to_mock_dev(dev);
+	int ret;
 
 	if (domain->dirty_ops && (mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY))
 		return -EINVAL;
 
+	ret = mock_dev_enable_iopf(dev, domain);
+	if (ret)
+		return ret;
+
+	mock_dev_disable_iopf(dev, mdev->domain);
+	mdev->domain = domain;
+
+	return 0;
+}
+
+static int mock_domain_blocking_attach(struct iommu_domain *domain,
+				       struct device *dev)
+{
+	struct mock_dev *mdev = to_mock_dev(dev);
+
+	mock_dev_disable_iopf(dev, mdev->domain);
+	mdev->domain = NULL;
+
 	return 0;
 }
 
 static const struct iommu_domain_ops mock_blocking_ops = {
-	.attach_dev = mock_domain_nop_attach,
+	.attach_dev = mock_domain_blocking_attach,
 };
 
 static struct iommu_domain mock_blocking_domain = {
@@ -549,22 +573,42 @@ static void mock_domain_page_response(struct device *dev, struct iopf_fault *evt
 {
 }
 
-static int mock_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
+static int mock_dev_enable_iopf(struct device *dev, struct iommu_domain *domain)
 {
-	if (feat != IOMMU_DEV_FEAT_IOPF || !mock_iommu_iopf_queue)
+	struct mock_dev *mdev = to_mock_dev(dev);
+	int ret;
+
+	if (!domain || !domain->iopf_handler)
+		return 0;
+
+	if (!mock_iommu_iopf_queue)
 		return -ENODEV;
 
-	return iopf_queue_add_device(mock_iommu_iopf_queue, dev);
+	if (mdev->iopf_refcount) {
+		mdev->iopf_refcount++;
+		return 0;
+	}
+
+	ret = iopf_queue_add_device(mock_iommu_iopf_queue, dev);
+	if (ret)
+		return ret;
+
+	mdev->iopf_refcount = 1;
+
+	return 0;
 }
 
-static int mock_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
+static void mock_dev_disable_iopf(struct device *dev, struct iommu_domain *domain)
 {
-	if (feat != IOMMU_DEV_FEAT_IOPF || !mock_iommu_iopf_queue)
-		return -ENODEV;
+	struct mock_dev *mdev = to_mock_dev(dev);
+
+	if (!domain || !domain->iopf_handler)
+		return;
+
+	if (--mdev->iopf_refcount)
+		return;
 
 	iopf_queue_remove_device(mock_iommu_iopf_queue, dev);
-
-	return 0;
 }
 
 static void mock_viommu_destroy(struct iommufd_viommu *viommu)
@@ -709,8 +753,6 @@ static const struct iommu_ops mock_ops = {
 	.device_group = generic_device_group,
 	.probe_device = mock_probe_device,
 	.page_response = mock_domain_page_response,
-	.dev_enable_feat = mock_dev_enable_feat,
-	.dev_disable_feat = mock_dev_disable_feat,
 	.user_pasid_table = true,
 	.viommu_alloc = mock_viommu_alloc,
 	.default_domain_ops =
-- 
2.43.0

