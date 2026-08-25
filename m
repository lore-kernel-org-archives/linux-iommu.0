Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FC33CFF65
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 08:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787644842; cv=none; b=N9rjsiO1qPqzcb0pHVowvW9qM7MlFzxMA5qTYqNP0RL0WeGEYQaZLIvOepznupT8HwjVgIgflnlxyUPd5KMv/+RYMdiUMbLe2k6pIqT1ZnNQ+tMoccWwbuQu4BD45OHqhqQ4Kl72rWkl89efOdq4ZEtg1Kid4YFJ8h8rpMVfA/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787644842; c=relaxed/simple;
	bh=V+Xi6AkeKBo95x+OkZ9Z0tTyPCJrEga08xdKfVcyxOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WJu/Zm/Y5KaEym4o5iaq/6HCGzbJD9b7rHBhawiQohfGa4oJRSG/RWP7rKdtsw0o9FK5Z7cG7RdPVlQYkhJaEEhP9NLM3brY/HRtZ47Fdir5wT0v+994GxuJXUcKAWa8MlZY763TOa4a1xFUmwY6e24tMPf4Bhd/OoZ++amEO0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eXos7e77; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eXos7e77"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787644840; x=1819180840;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V+Xi6AkeKBo95x+OkZ9Z0tTyPCJrEga08xdKfVcyxOE=;
  b=eXos7e77dDlR8ri2PlITaOILEZqsNINL7gwAf3gw6D2V6sFBN8iW2J8Y
   lO2+T8QKtVdtbjwlTU1M4xeoLB9A5ac6812NYftyrjEmLUkjsvay2r5Da
   B3GHMvLvuXfzszmaLRpeAiFIzzX1GMfuFZTJk/jZvenItbVU3poJiU7Ak
   3dBWukyrpmnAeqxwXlSQTsD6T2OuNn5vHUx7sSfBj5l1bzTiW/J1+mtMV
   a66HRg2E/O6ulAQaVTU0xaBNthhfJ6HPX+Nn/5g74QgPpOZXAAVZ5feqM
   1LtUC+g/DW7AHrDFDORBcnw7pMcuayype2QZL1iNPr/ftXvwoBEKDFYQN
   g==;
X-CSE-ConnectionGUID: nXdK1IFARuuANhARGWmMog==
X-CSE-MsgGUID: hL1gJpiuR+ydtqC9PJIG8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="99452934"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="99452934"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 01:00:37 -0700
X-CSE-ConnectionGUID: YTsaLPHSRb+GC5bpvi94gw==
X-CSE-MsgGUID: HB5c2gWuT+u120Fqk5+OkQ==
X-ExtLoop1: 1
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.229.148])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 01:00:33 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH] iommu/vt-d: Fix page table level calculation in compute_vasz_lg2_ss()
Date: Tue, 25 Aug 2026 16:00:02 +0800
Message-ID: <20260825080002.117412-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.52.0

