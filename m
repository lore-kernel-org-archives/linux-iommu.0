Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21E43264E7
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 03:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790566760; cv=none; b=fgfM02VgQeIY0xqUjHsg5hJvWC6pTqu4d/Hfu2AQYVMFKL01E8U2QYJJRH/M0btu4cvLbky5YlzFSsJAfQjtslnjPTs7RMnKuHhxNL92SnTwtg83/feq4WaEL45D7/yaMY0i/lJxcddXDlNq48bBVOkMHvFQK3DWauDSTXsd3RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790566760; c=relaxed/simple;
	bh=cTJXqsrQTTFyaIqjEQYtHyxfC2GsVrQ4qJC/0W3Ue6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1ACxr5ZHhCznwlv5QZ7kJSRUfbWDwDgpgCF6hqzhuh4/P21p8Vb+G5+qcPj2Yl//ySbEwWTqRy10PFPGSZZbudJGXbm42amQdxZx8iAs9jVWMMPG3jYuN31u0POj3cMHgiscu2FKcn2YwlValzKCs8otdb+4lXzZTepuO1KNdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iuq3X01I; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iuq3X01I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790566758; x=1822102758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cTJXqsrQTTFyaIqjEQYtHyxfC2GsVrQ4qJC/0W3Ue6Q=;
  b=Iuq3X01If3d06Nc5uPijussg3RWRHe9XiknXy47qrfH25U/mKhwA80Nh
   Q/KCVIrltyB131qtZbEycoTj+CwHsZ/4Och79wE0n50S0x7zDAEBY6Ica
   UccLYBYkA/jHRLuwQuL51n7jq+VDHYfCIT2iq+JSDeniZ1l/C7m+m5Yk+
   i/SzsryM8Aa8RYR02K4kWZM+ZAebPdJW8m5ZAEs9DsfgO3svrRfgiNLfE
   JBwkBhhskn6exXLv1YFGawec4ypzanlfNLCi1qhD1o199joKsr7xKiMWh
   pTvmDsz5z9wbB7t7cbO5PJYSvkvkGbFxT6fVkfYJmaslUjq12LmrBDirw
   w==;
X-CSE-ConnectionGUID: jYXanbC0Q4Sc8+ubBNGUwA==
X-CSE-MsgGUID: md0sF1OMTX2exDzLHapgzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="101917183"
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="101917183"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 20:39:17 -0700
X-CSE-ConnectionGUID: PTvzEMmHRMSPDZOO+5wLgw==
X-CSE-MsgGUID: WBZdBOquQ+y/dqa8x4ob2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="283004078"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa005.fm.intel.com with ESMTP; 27 Sep 2026 20:39:16 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] iommu/vt-d: Fix page table level calculation in compute_vasz_lg2_ss()
Date: Mon, 28 Sep 2026 11:27:14 +0800
Message-ID: <20260928032722.2868623-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928032722.2868623-1-baolu.lu@linux.intel.com>
References: <20260928032722.2868623-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

compute_vasz_lg2_ss() finds the optimal Second-Stage page table level by
intersecting the maximum guest address width (mgaw) with the hardware's
SAGAW capability register.

The VT-d spec maps the SAGAW bit field positions as:
  - Bit 1: 39-bit AGAW (3-level page table, top_level = 2)
  - Bit 2: 48-bit AGAW (4-level page table, top_level = 3)
  - Bit 3: 57-bit AGAW (5-level page table, top_level = 4)

The fallback paths use bit shifts that are one position too large,
causing ffs() to select a deeper page table level than the mgaw window
requires:

  - mgaw > 39: "3 + ffs(sagaw >> 3)" evaluates to top_level = 4 (5-level)
    instead of top_level = 3 (4-level) when hardware supports both
    48-bit (Bit 2) and 57-bit (Bit 3) AGAW.
  - mgaw > 30: "2 + ffs(sagaw >> 2)" evaluates to top_level = 3 (4-level)
    instead of top_level = 2 (3-level) when hardware supports both
    39-bit (Bit 1) and 48-bit (Bit 2) AGAW.

In both cases the selected level is still one that the hardware advertises
in its SAGAW capability, so IOVA translation remains functionally correct.
However, an unnecessarily deep page table may be selected, adding an extra
level of page walk overhead and reducing TLB and cache efficiency without
providing any increase in addressable IOVA space beyond what the mgaw
window already caps.

Fix by decreasing the shift offset by one in each fallback case, ensuring
ffs() targets the correct SAGAW bit position and selects the smallest
page table level that fully covers the mgaw range:

  - mgaw > 39: "2 + ffs(sagaw >> 2)" correctly yields top_level = 3
  - mgaw > 30: "1 + ffs(sagaw >> 1)" correctly yields top_level = 2

Fixes: d856f9d27885 ("iommupt/vtd: Allow VT-d to have a larger table top than the vasz requires")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2e3b3ab216f8..05f351833d0b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2911,10 +2911,10 @@ static unsigned int compute_vasz_lg2_ss(struct intel_iommu *iommu,
 		*top_level = 4;
 		return min(57, mgaw);
 	} else if (mgaw > 39 && sagaw >= BIT(2)) {
-		*top_level = 3 + ffs(sagaw >> 3);
+		*top_level = 2 + ffs(sagaw >> 2);
 		return min(48, mgaw);
 	} else if (mgaw > 30 && sagaw >= BIT(1)) {
-		*top_level = 2 + ffs(sagaw >> 2);
+		*top_level = 1 + ffs(sagaw >> 1);
 		return min(39, mgaw);
 	}
 	return 0;
-- 
2.43.0

