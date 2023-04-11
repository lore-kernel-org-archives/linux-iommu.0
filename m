Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2022F23C8
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 06:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681195700; x=1712731700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AH2O7XJ83CyJq/BvNVtHKqMDArNO32apjduqQxjWqso=;
  b=PbZQPXcfViUMukJf7fZEbJzwsaffHvbsWNaXWRnySgYpQFPZUIE1Q27W
   Bw+lxznUX0+hoKOkOWHiNl3zs+Ct4I5K60f5ugVuhjmVKilirThN0c6wL
   8rVJvzzO9onmBaIXyTHXYLkZ8Cn/jXN+yKT6NEd0EzSfupAvJ+1Z3Ox69
   G1IuOfAMs3C4YsSNndusV5M3lL2wou7vKvnRWXBTtb2ed8qBGnUcVexaw
   m2eORP+Kn3OALIxzVJPttAn7HQ/FXvO44OBcgV3KjCCjZOfEdVUF/UC+p
   Qxi718ZOo+CyJ4pCejqqyAFgt0mwu7S/UkYYuyJh8sBfOxQ3aPXDuMYJg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341028515"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341028515"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 23:48:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="1018256547"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018256547"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 10 Apr 2023 23:48:15 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/17] iommu/vt-d: Move iopf code from SVA to IOPF enabling path
Date: Tue, 11 Apr 2023 14:48:01 +0800
Message-Id: <20230411064815.31456-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411064815.31456-1-baolu.lu@linux.intel.com>
References: <20230411064815.31456-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Generally enabling IOMMU_DEV_FEAT_SVA requires IOMMU_DEV_FEAT_IOPF, but
some devices manage I/O Page Faults themselves instead of relying on the
IOMMU. Move IOPF related code from SVA to IOPF enabling path.

For the device drivers that relies on the IOMMU for IOPF through PCI/PRI,
IOMMU_DEV_FEAT_IOPF must be enabled before and disabled after
IOMMU_DEV_FEAT_SVA.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20230324120234.313643-4-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index caf664448ee9..a6f07c74da2d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4638,7 +4638,6 @@ static int intel_iommu_enable_sva(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu;
-	int ret;
 
 	if (!info || dmar_disabled)
 		return -EINVAL;
@@ -4667,6 +4666,21 @@ static int intel_iommu_enable_sva(struct device *dev)
 	if (!info->pri_enabled)
 		return -EINVAL;
 
+	return 0;
+}
+
+static int intel_iommu_enable_iopf(struct device *dev)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu;
+	int ret;
+
+	if (!info || !info->ats_enabled || !info->pri_enabled)
+		return -ENODEV;
+	iommu = info->iommu;
+	if (!iommu)
+		return -EINVAL;
+
 	ret = iopf_queue_add_device(iommu->iopf_queue, dev);
 	if (ret)
 		return ret;
@@ -4678,7 +4692,7 @@ static int intel_iommu_enable_sva(struct device *dev)
 	return ret;
 }
 
-static int intel_iommu_disable_sva(struct device *dev)
+static int intel_iommu_disable_iopf(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
@@ -4695,16 +4709,6 @@ static int intel_iommu_disable_sva(struct device *dev)
 	return ret;
 }
 
-static int intel_iommu_enable_iopf(struct device *dev)
-{
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-
-	if (info && info->pri_supported)
-		return 0;
-
-	return -ENODEV;
-}
-
 static int
 intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
 {
@@ -4725,10 +4729,10 @@ intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
 {
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
-		return 0;
+		return intel_iommu_disable_iopf(dev);
 
 	case IOMMU_DEV_FEAT_SVA:
-		return intel_iommu_disable_sva(dev);
+		return 0;
 
 	default:
 		return -ENODEV;
-- 
2.34.1

