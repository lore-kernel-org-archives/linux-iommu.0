Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADE123BF
	for <iommu@lists.linux.dev>; Wed, 16 Nov 2022 05:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668576164; x=1700112164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N39zYywKGtvDLEpu4Wp5yD2tKhZZrUwiZr6H+Wm2BCU=;
  b=X0oXQSx7JDizAYLFsguIFQi5sRfofbCAxxpoZZN83dpIz8hXTgFOPfCB
   aWdmfBPcCVT3ZVyCsUOFAcxgHxJOYNjlyrbz6+rDmR7LWu0c+6r2pGNQo
   LIMGhcBwfnCfXj6tVsVE/lNJAMiebGeFqrpfuNSKTiMvmpvm09zlC9L2n
   ANJnWGUhzzxI7JK2GnSLBSLLx8wuVkhYNY2Uapa5zlCyR4LxdalBI3M+3
   gfcEuriH3jz/N+lXKdKKorH0MYDYHHPG8d/fuWUav3afc7kdWGRL9Gylx
   kHBKNaZO7ssdJX/FJzne7+f5SBb1DL6KUbe6kjiI+Kew/EUgraqLHeMLV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="295820138"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="295820138"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 21:22:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="702724781"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="702724781"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 15 Nov 2022 21:22:42 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iommu/vt-d: Set SRE bit only when hardware has SRS cap
Date: Wed, 16 Nov 2022 13:15:44 +0800
Message-Id: <20221116051544.26540-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116051544.26540-1-baolu.lu@linux.intel.com>
References: <20221116051544.26540-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tina Zhang <tina.zhang@intel.com>

SRS cap is the hardware cap telling if the hardware IOMMU can support
requests seeking supervisor privilege or not. SRE bit in scalable-mode
PASID table entry is treated as Reserved(0) for implementation not
supporting SRS cap.

Checking SRS cap before setting SRE bit can avoid the non-recoverable
fault of "Non-zero reserved field set in PASID Table Entry" caused by
setting SRE bit while there is no SRS cap support. The fault messages
look like below:

 DMAR: DRHD: handling fault status reg 2
 DMAR: [DMA Read NO_PASID] Request device [00:0d.0] fault addr 0x1154e1000
       [fault reason 0x5a]
       SM: Non-zero reserved field set in PASID Table Entry

Fixes: 6f7db75e1c46 ("iommu/vt-d: Add second level page table interface")
Cc: stable@vger.kernel.org
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Link: https://lore.kernel.org/r/20221115070346.1112273-1-tina.zhang@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index c30ddac40ee5..e13d7e5273e1 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -642,7 +642,7 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	 * Since it is a second level only translation setup, we should
 	 * set SRE bit as well (addresses are expected to be GPAs).
 	 */
-	if (pasid != PASID_RID2PASID)
+	if (pasid != PASID_RID2PASID && ecap_srs(iommu->ecap))
 		pasid_set_sre(pte);
 	pasid_set_present(pte);
 	spin_unlock(&iommu->lock);
@@ -685,7 +685,8 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 	 * We should set SRE bit as well since the addresses are expected
 	 * to be GPAs.
 	 */
-	pasid_set_sre(pte);
+	if (ecap_srs(iommu->ecap))
+		pasid_set_sre(pte);
 	pasid_set_present(pte);
 	spin_unlock(&iommu->lock);
 
-- 
2.34.1

