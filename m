Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F4D8820
	for <iommu@lists.linux.dev>; Wed, 22 Nov 2023 03:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mCXu6BCE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700623832; x=1732159832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HFcvyEodi+fPlzWO9+8MOcJlJiNIw4yl1ellDdedZDU=;
  b=mCXu6BCEPVWJxYwSEWT+hpiZM/HrZyLORxOCpdBdCRV4uDSMekERy+uB
   5jdqAh0Pg0zLaC1j5O3M+dQE2lwcfkPcjsJDKnPMEi8FnTNQ+4hWocnL1
   3sG5/YFg4KYUULknC9fri8SjJ/Se5yAACuYAsTETRQtNDRsdm6kFJEXBO
   LtVBW2t3FOrL0V8nS80xeWcLkKOVatqnzMcSFJ+owG/FZaT1wVhnVdOzD
   6+ITNw3ntUAl5pub1Y713cVVeAADwIbwmgCqIClJCSJXrkkacbCiOgfF8
   5WfXnc+A3hPR0y54g6xL30nH/9hpABBGnxRn/TIdEdiaEXbK9qjcXP7X8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="391742776"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="391742776"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 19:30:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="8090164"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa002.jf.intel.com with ESMTP; 21 Nov 2023 19:30:31 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: mohd.syazwan.abdul.halim@intel.com,
	Kunwu Chan <chentao@kylinos.cn>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] iommu/vt-d: Omit devTLB invalidation requests when TES=0
Date: Wed, 22 Nov 2023 11:26:03 +0800
Message-Id: <20231122032608.165144-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122032608.165144-1-baolu.lu@linux.intel.com>
References: <20231122032608.165144-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The latest VT-d spec indicates that when remapping hardware is disabled
(TES=0 in Global Status Register), upstream ATS Invalidation Completion
requests are treated as UR (Unsupported Request).

Consequently, the spec recommends in section 4.3 Handling of Device-TLB
Invalidations that software refrain from submitting any Device-TLB
invalidation requests when address remapping hardware is disabled.

Verify address remapping hardware is enabled prior to submitting Device-
TLB invalidation requests.

Fixes: 792fb43ce2c9 ("iommu/vt-d: Enable Intel IOMMU scalable mode by default")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20231114011036.70142-2-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/dmar.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index a3414afe11b0..23cb80d62a9a 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1522,6 +1522,15 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 {
 	struct qi_desc desc;
 
+	/*
+	 * VT-d spec, section 4.3:
+	 *
+	 * Software is recommended to not submit any Device-TLB invalidation
+	 * requests while address remapping hardware is disabled.
+	 */
+	if (!(iommu->gcmd & DMA_GCMD_TE))
+		return;
+
 	if (mask) {
 		addr |= (1ULL << (VTD_PAGE_SHIFT + mask - 1)) - 1;
 		desc.qw1 = QI_DEV_IOTLB_ADDR(addr) | QI_DEV_IOTLB_SIZE;
@@ -1587,6 +1596,15 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 	unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order - 1);
 	struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
 
+	/*
+	 * VT-d spec, section 4.3:
+	 *
+	 * Software is recommended to not submit any Device-TLB invalidation
+	 * requests while address remapping hardware is disabled.
+	 */
+	if (!(iommu->gcmd & DMA_GCMD_TE))
+		return;
+
 	desc.qw0 = QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
 		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
 		QI_DEV_IOTLB_PFSID(pfsid);
-- 
2.34.1

