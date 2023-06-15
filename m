Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BE6A45
	for <iommu@lists.linux.dev>; Thu, 15 Jun 2023 07:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686813532; x=1718349532;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tv0xInhDNZvIGN29/qg5JZUQvfOAzDkVJk+y8zR9+Z0=;
  b=ZjE8i8W5fRSYFplo7odk277vLPw/NRW+H+Cg0bltmmU6YvIoa+B2nV6z
   HodB+9+nZRCpCSFkwTo7SyybDL1vvpbxXeD7ZDSRw88S5vJPJPGP5luyN
   Rbp8jjA/5EjQPHW0vCxkPd7E7PruPItMMao9OitTst5rjrSYbkNDK/7yp
   Xu6MQaczsHrg8YmR9MTmffUKsgLsWb4v1imMtyt5+r+Bb2YmkTOucMtGs
   guDVeococ+8h7VMb2jNsN5NmJ+XYZfbHpO1HwWJItf5XlO0grmoPALOGq
   Wl1EeJGAL0LFlHim7BxDEtybz+Ml4zTIQ4VonP4x7Yf2DkX6S7QG3mdmY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="339183071"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="339183071"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 00:18:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="706544678"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="706544678"
Received: from tower.bj.intel.com ([10.238.157.62])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 00:18:49 -0700
From: Yanfei Xu <yanfei.xu@intel.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	yanfei.xu@intel.com
Subject: [PATCH] iommu/vt-d: Fix to flush cache of PASID directory table
Date: Thu, 15 Jun 2023 15:16:13 +0800
Message-Id: <20230615071613.690639-1-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even the PCI devices don't support pasid capability, PASID
table is mandatory for a PCI device in scalable mode. However
flushing cache of pasid directory table for these devices are
not taken after pasid table is allocated as the "size" of
table is zero. Fix to assign it with a page size.

Fixes: 194b3348bdbb ("iommu/vt-d: Fix PASID directory pointer coherency")
Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
---
 drivers/iommu/intel/pasid.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index c5d479770e12..bde7df055865 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -115,7 +115,9 @@ int intel_pasid_alloc_table(struct device *dev)
 				  intel_pasid_max_id);
 
 	size = max_pasid >> (PASID_PDE_SHIFT - 3);
-	order = size ? get_order(size) : 0;
+	if (!size)
+		size = PAGE_SIZE;
+	order = get_order(size);
 	pages = alloc_pages_node(info->iommu->node,
 				 GFP_KERNEL | __GFP_ZERO, order);
 	if (!pages) {
-- 
2.34.1

