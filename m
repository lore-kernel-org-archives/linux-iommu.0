Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CC6259D
	for <iommu@lists.linux.dev>; Fri, 16 Sep 2022 07:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663312341; x=1694848341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0jETsX3p5DQRkBm8H/U1fajbR6ezzfZd+nH9Cn3T5GA=;
  b=S0kc5KqG7Wch5TbKn0OYJ2wN6uq4i0h22vrHAxDenvQ+BrO9gIGCIyvz
   ItG7Mw7c/IVRO1pZ8KW3/bsn35aS0vIq8QTOHr1GJRLSfoDBGr3IoMEme
   jyEnPxVG2iD+z0XYdnvnKAJVUatMy87ojjrqVOCBYLisf6jvVzT7+2/0/
   SROk9RrRhVEADhDu6oMPcAtYbHBgzqns+85vuj5xzZaK8jltL0suQ3Pgz
   40kK2puTHrf7oKxvrF2X0Wh+d2vYH3QQ6cwXezKknMkcdE+fpwIJcosaz
   sEMjaGVI7r79gGxYZCBfgHVSGmcwjvmNYsPm7sNvSAOi0QE616FxJC49I
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="362896114"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="362896114"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 00:12:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="650780432"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga001.jf.intel.com with ESMTP; 16 Sep 2022 00:12:15 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: baolu.lu@linux.intel.com
Cc: kevin.tian@intel.com,
	baolu.lu@intel.com,
	yi.l.liu@intel.com,
	raghunathan.srinivasan@intel.com,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] iommu/vt-d: Check correct capability for sagaw determination
Date: Fri, 16 Sep 2022 00:12:11 -0700
Message-Id: <20220916071212.2223869-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220916071212.2223869-1-yi.l.liu@intel.com>
References: <20220916071212.2223869-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check 5-level paging capability for 57 bits address width instead of
checking 1GB large page capability.

Fixes: 53fc7ad6edf2 ("iommu/vt-d: Correctly calculate sagaw value of IOMMU")
Cc: stable@vger.kernel.org
Reported-by: Raghunathan Srinivasan <raghunathan.srinivasan@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 1f2cd43cf9bc..664499dddf0c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -399,7 +399,7 @@ static unsigned long __iommu_calculate_sagaw(struct intel_iommu *iommu)
 {
 	unsigned long fl_sagaw, sl_sagaw;
 
-	fl_sagaw = BIT(2) | (cap_fl1gp_support(iommu->cap) ? BIT(3) : 0);
+	fl_sagaw = BIT(2) | (cap_5lp_support(iommu->cap) ? BIT(3) : 0);
 	sl_sagaw = cap_sagaw(iommu->cap);
 
 	/* Second level only. */
-- 
2.34.1

