Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2591851
	for <iommu@lists.linux.dev>; Wed, 17 Aug 2022 02:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660704078; x=1692240078;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4n6G6Y+EHrQouzMLtdagC2MwEGhSMCP/0lx2rTV0IDs=;
  b=XOCKOnp1cSDgPw4LJGuXoYgso40IrHQ7qwMXsnuY4ttFtLRhMlCExDLV
   wCIGaA2UiRDan9TPayA0DmcRQ87jV4jUfYUU75RE1LG0r1zdE38c8uj8s
   ShjrSgSOn9UzCltkrF6Hivy3Lh2qr+AQUcUebzX0ZkyfCGqs5njItWNuA
   wMlqcqepE5Y0G3hTIivxXCtnHeqYRYa/+vVpHeyvclDlzuV60aRWZHJMM
   k3HypYs/zXFulbGwG5Hy54bhTlxs+HQ4gxnLTmVV8O3FwzJZEihIzHAkZ
   uxnatzfVvpJvAkKraX8JObmWOsa/hHo1512EEwUeuak/GjtwCbk2fw+rd
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="272152352"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="272152352"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 19:41:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="603738830"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 16 Aug 2022 19:41:14 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	raghunathan.srinivasan@intel.com,
	yi.l.liu@intel.com,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] iommu/vt-d: Correctly calculate sagaw value of IOMMU
Date: Wed, 17 Aug 2022 10:35:58 +0800
Message-Id: <20220817023558.3253263-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Intel IOMMU driver possibly selects between the first-level and the
second-level translation tables for DMA address translation. However,
the levels of page-table walks for the 4KB base page size are calculated
from the SAGAW field of the capability register, which is only valid for
the second-level page table. This causes the IOMMU driver to stop working
if the hardware (or the emulated IOMMU) advertises only first-level
translation capability and reports the SAGAW field as 0.

This solves the above problem by considering both the first level and the
second level when calculating the supported page table levels.

Fixes: b802d070a52a1 ("iommu/vt-d: Use iova over first level")
Cc: stable@vger.kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 889ad2c9a7b9..2d0d2ef820d2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -370,14 +370,36 @@ static inline int domain_pfn_supported(struct dmar_domain *domain,
 	return !(addr_width < BITS_PER_LONG && pfn >> addr_width);
 }
 
+/*
+ * Calculate the Supported Adjusted Guest Address Widths of an IOMMU.
+ * Refer to 11.4.2 of the VT-d spec for the encoding of each bit of
+ * the returned SAGAW.
+ */
+static unsigned long __iommu_calculate_sagaw(struct intel_iommu *iommu)
+{
+	unsigned long fl_sagaw, sl_sagaw;
+
+	fl_sagaw = 0x6 | (cap_fl1gp_support(iommu->cap) ? BIT(3) : 0);
+	sl_sagaw = cap_sagaw(iommu->cap);
+
+	/* Second level only. */
+	if (!sm_supported(iommu) || !ecap_flts(iommu->ecap))
+		return sl_sagaw;
+
+	/* First level only. */
+	if (!ecap_slts(iommu->ecap))
+		return fl_sagaw;
+
+	return fl_sagaw & sl_sagaw;
+}
+
 static int __iommu_calculate_agaw(struct intel_iommu *iommu, int max_gaw)
 {
 	unsigned long sagaw;
 	int agaw;
 
-	sagaw = cap_sagaw(iommu->cap);
-	for (agaw = width_to_agaw(max_gaw);
-	     agaw >= 0; agaw--) {
+	sagaw = __iommu_calculate_sagaw(iommu);
+	for (agaw = width_to_agaw(max_gaw); agaw >= 0; agaw--) {
 		if (test_bit(agaw, &sagaw))
 			break;
 	}
-- 
2.25.1

