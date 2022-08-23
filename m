Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B129EA3D
	for <iommu@lists.linux.dev>; Tue, 23 Aug 2022 06:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661235684; x=1692771684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HZr6zm9MRiZvT4X/n+Dcm6DPcUCmmNLdW2r1N7oYAw0=;
  b=Pds/fu8tu3r+5ApRBiwHMKqvBkX6hh8BJfdz2AaYhI4lGsrRH5xnmhBV
   gC3+gNWofLIG3yUXG11BhcS2RrlvMyqO3zOR5W8VApIyNhYjXRfhv1WI6
   gnBM/Ths6R4lflTjtBO9l9zyxSP54ylFFlzlbe6QozWIx7WXnOuzj/Dn9
   VrvVXjNbnrOpLUaH2JoG2MNwJguGi9ZptRL8iMMswjG8m8/2M5ekE7YjF
   fUx8TP9SesV12yseoLySum/wDdyiPeePCaAx/BF5bQLNon/ZtdD3EFCof
   TqDg2QBFnjLDFv7XRuV3zxZ9/9AGuEinArEVejABpDRAK6rr7YkZ5zsDu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="273356209"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="273356209"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 23:21:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="605553187"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 22 Aug 2022 23:21:22 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Lennert Buytenhek <buytenh@wantstofly.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Wen Jin <wen.jin@intel.com>,
	iommu@lists.linux.dev,
	iommu@lists.linux-foundation.org
Subject: [PATCH 2/4] iommu/vt-d: Correctly calculate sagaw value of IOMMU
Date: Tue, 23 Aug 2022 14:15:55 +0800
Message-Id: <20220823061557.1631056-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220823061557.1631056-1-baolu.lu@linux.intel.com>
References: <20220823061557.1631056-1-baolu.lu@linux.intel.com>
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
Link: https://lore.kernel.org/r/20220817023558.3253263-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b9d058c27568..b155c7af7d15 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -390,14 +390,36 @@ static inline int domain_pfn_supported(struct dmar_domain *domain,
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
+	fl_sagaw = BIT(2) | (cap_fl1gp_support(iommu->cap) ? BIT(3) : 0);
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

