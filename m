Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A91E15C0
	for <iommu@lists.linux.dev>; Fri, 31 Mar 2023 03:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680232453; x=1711768453;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fzv7DpkaeGENakCj48hvNpKqu0JpPzSEsNWECZCTUAA=;
  b=nEI6lB5VcpzHfCDtHuDeCrPPdepEWUe5IsnM4rAvHaeI7u/T9saKe5eM
   +0ER1wqm7TrzDcuIW3V+aZ98aQbHUEi6FJjtFn70jTDDSEOoTz5V0jh8E
   eZ+cuWHXIvYfg91g+YHT0HianOqGjEcsWqJ1U0iCCzNW4Jzm8uwylqgEH
   koLFBlDN1rGIVgqiYX5ASAhqNvrYOCNIRIv7Qu1BCa7SOFpdtvuhF7sbj
   kra0Z53iuqpd4Kx6Silfd2JBlnTw1yNKqaQdp+JIDNzhElZ34pNlDv5Hs
   h1eeGNBTR8LR2RunAs6rgZQp2Jt7dpCFJ7vYFxwuiU3nwyiHYYnAN0lAJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="342991729"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="342991729"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 20:14:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="635144745"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="635144745"
Received: from test.bj.intel.com ([10.238.158.71])
  by orsmga003.jf.intel.com with ESMTP; 30 Mar 2023 20:13:52 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v2 3/7] iommu/vt-d: Remove BUG_ON in handling iotlb cache invalidation
Date: Thu, 30 Mar 2023 22:42:32 -0400
Message-Id: <20230331024236.2716001-4-tina.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331024236.2716001-1-tina.zhang@intel.com>
References: <20230331024236.2716001-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VT-d iotlb cache invalidation request with unexpected type is considered
as a bug to developers, which can be fixed. So, when such kind of issue
comes out, it needs to be reported through the kernel log, instead of
halting the system. Replacing BUG_ON with warning reporting.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/iommu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 1426df19e760..de7fe7dcbc5c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1272,7 +1272,9 @@ static void __iommu_flush_context(struct intel_iommu *iommu,
 			| DMA_CCMD_SID(source_id) | DMA_CCMD_FM(function_mask);
 		break;
 	default:
-		BUG();
+		pr_warn("%s: Unexpected context-cache invalidation type 0x%llx\n",
+			iommu->name, type);
+		return;
 	}
 	val |= DMA_CCMD_ICC;
 
@@ -1308,7 +1310,9 @@ static void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did,
 		val_iva = size_order | addr;
 		break;
 	default:
-		BUG();
+		pr_warn("%s: Unexpected iotlb invalidation type 0x%llx\n",
+			iommu->name, type);
+		return;
 	}
 	/* Note: set drain read/write */
 #if 0
@@ -1508,7 +1512,8 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 	uint64_t addr = (uint64_t)pfn << VTD_PAGE_SHIFT;
 	u16 did = domain_id_iommu(domain, iommu);
 
-	BUG_ON(pages == 0);
+	if (WARN_ON(!pages))
+		return;
 
 	if (ih)
 		ih = 1 << 6;
-- 
2.34.1

