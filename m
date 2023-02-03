Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC35A1863
	for <iommu@lists.linux.dev>; Fri,  3 Feb 2023 08:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675414411; x=1706950411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kB18aiVy7J86X3vvgBkRFgvMDABP1q/NhATKJ+pNSBQ=;
  b=heduQZAjnxSSVRtsj2Ub6eat/kaMzfdcrSpL9GTR1raDO8nIN5FbFbyo
   TDcgEEnud5nrlOuQzTIVuzBpP5OJHqKR837O8/nZegyiDULItOfD57RCS
   yR7dz+FalwhXMbSTMEy6EPfr9Jt2zVo3Gzkie0wMsQ4pSCOwvvzZiV08o
   E+vUlAL3uZ1vLojgcyLFGfzDjFCfI+Qi57JxSAWSXKOqEh4ufEEM9XJnE
   EyiHl56ny4rjWyM/g1z5mwcPeRJS8bfDw2/lTdYMyTtgVUxf2owHKCOj/
   Ds6VREYqcfUUSSNTbWKbCn7t+nbu3kc9NFYre+CmboQHXA6/rH5dJ6uwS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="327337329"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="327337329"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 00:53:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="994447955"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="994447955"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga005.fm.intel.com with ESMTP; 03 Feb 2023 00:53:15 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev,
	dmaengine@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/2] iommu/vt-d: Move iopf code from SVA to IOPF enabling path
Date: Fri,  3 Feb 2023 16:44:56 +0800
Message-Id: <20230203084456.469641-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203084456.469641-1-baolu.lu@linux.intel.com>
References: <20230203084456.469641-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Generally enabling IOMMU_DEV_FEAT_SVA requires IOMMU_DEV_FEAT_IOPF, but
some devices manage I/O Page Faults themselves instead of relying on the
IOMMU. Move IOPF related code from SVA to IOPF enabling path to make the
driver work for devices that manage IOPF themselves.

For the device drivers that relies on the IOMMU for IOPF through PCI/PRI,
IOMMU_DEV_FEAT_IOPF must be enabled before and disabled after
IOMMU_DEV_FEAT_SVA.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a1a66798e1f0..149cb20d8dd5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4632,7 +4632,6 @@ static int intel_iommu_enable_sva(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu;
-	int ret;
 
 	if (!info || dmar_disabled)
 		return -EINVAL;
@@ -4644,17 +4643,13 @@ static int intel_iommu_enable_sva(struct device *dev)
 	if (!(iommu->flags & VTD_FLAG_SVM_CAPABLE))
 		return -ENODEV;
 
-	if (!info->pasid_enabled || !info->pri_enabled || !info->ats_enabled)
+	if (!info->pasid_enabled)
 		return -EINVAL;
 
-	ret = iopf_queue_add_device(iommu->iopf_queue, dev);
-	if (!ret)
-		ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
-
-	return ret;
+	return 0;
 }
 
-static int intel_iommu_disable_sva(struct device *dev)
+static int intel_iommu_disable_iopf(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
@@ -4670,11 +4665,20 @@ static int intel_iommu_disable_sva(struct device *dev)
 static int intel_iommu_enable_iopf(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	int ret;
 
-	if (info && info->pri_supported)
-		return 0;
+	if (!info || !info->ats_enabled || !info->pri_enabled)
+		return -ENODEV;
 
-	return -ENODEV;
+	ret = iopf_queue_add_device(info->iommu->iopf_queue, dev);
+	if (ret)
+		return ret;
+
+	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
+	if (ret)
+		iopf_queue_remove_device(info->iommu->iopf_queue, dev);
+
+	return ret;
 }
 
 static int
@@ -4697,10 +4701,10 @@ intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
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

