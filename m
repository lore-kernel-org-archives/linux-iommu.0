Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364536106
	for <iommu@lists.linux.dev>; Fri, 16 Jun 2023 08:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686903208; x=1718439208;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6ItNP+JKSJICj4eyo+r6suaHTPScQyJ1JFtXO/FOP/0=;
  b=VtCL6xZleOifLxoQTJxp+a0pzC1ZQV1M23gmOnLOpZazPJ+NJwC5cdaM
   P6mdQSOdd8995myd4Cxz2ip7ZldJK1jeXIHTluVAG2MfhXEWOZEU2XfTJ
   bQ5cTVQ0fsz2LEZeRtMSPMqgFEY06xHsY3fluVNTBGEEYSRJ2yrnoqjiK
   xfIQC+qyXRtza1fYSjBwcpxxwmRxhs4QPmyQMoub2zIDbGomLCNAnfWeR
   EI4zrjenlpZjYhANQI6aWkW2i9r/M3/q9pdsbyE7lLPw8tWOzLUOQ/ZI/
   ZWj80mb+K04iGb4DAJm+508GP8zDZo8ciBwinz1v2Lz0CaJrSUjayr5WA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="343898454"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="343898454"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 01:13:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="959538546"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="959538546"
Received: from tower.bj.intel.com ([10.238.157.62])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 01:13:21 -0700
From: Yanfei Xu <yanfei.xu@intel.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	tina.zhang@intel.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	yanfei.xu@intel.com
Subject: [PATCH v2] iommu/vt-d: Fix to flush cache of PASID directory table
Date: Fri, 16 Jun 2023 16:10:45 +0800
Message-Id: <20230616081045.721873-1-yanfei.xu@intel.com>
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
table is zero. Fix it by calculating the size by page order.

Found this when reading the code, no actual problem encountered
for now

Fixes: 194b3348bdbb ("iommu/vt-d: Fix PASID directory pointer coherency")
Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
---
v1->v2:
  use variable "order" to calculate the table size (Suggested by baolu)

 drivers/iommu/intel/pasid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index c5d479770e12..49fc5a038a14 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -129,7 +129,7 @@ int intel_pasid_alloc_table(struct device *dev)
 	info->pasid_table = pasid_table;
 
 	if (!ecap_coherent(info->iommu->ecap))
-		clflush_cache_range(pasid_table->table, size);
+		clflush_cache_range(pasid_table->table, (1 << order) * PAGE_SIZE);
 
 	return 0;
 }
-- 
2.34.1

