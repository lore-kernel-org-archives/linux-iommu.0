Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A04328EF
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 06:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681195720; x=1712731720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KoxeI8nGmhipdmhbf/hPatJykHf7P/Wr8q6XOawTXGM=;
  b=ljwW+8QutgF5C1lmtxr7KB3VxtMR62IPDYPFqAtaZYCSp9plrTGWqEMI
   yc140+Nka2FIshuvu+lyZnASPjZtndgUc88eDxknhX0uA3ZBtTqzn6Eyg
   Bx4Bdd/ThOziL+U+OD+tXIO9kfTlg4+APBIUy8f+AYYGI9tlL3oZJyFQ/
   nRXPItOGBVsxvPeWikpPT2lKC7tBjn4TpelhcOxcCWcIM94phfp7mDTgY
   3qvCXkO6Nu2OjlmaXyTl7miHGcayuRKiqfIggTYTMTWpZOkWzYxEuUZ37
   lG5UJujacuA81N/TrX5Lh4EM+SZQGijOUYpB7rSebSag+GXk2IT93oRqi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341028617"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341028617"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 23:48:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="1018256633"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018256633"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 10 Apr 2023 23:48:37 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/17] iommu/vt-d: Remove BUG_ON in handling iotlb cache invalidation
Date: Tue, 11 Apr 2023 14:48:11 +0800
Message-Id: <20230411064815.31456-14-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411064815.31456-1-baolu.lu@linux.intel.com>
References: <20230411064815.31456-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tina Zhang <tina.zhang@intel.com>

VT-d iotlb cache invalidation request with unexpected type is considered
as a bug to developers, which can be fixed. So, when such kind of issue
comes out, it needs to be reported through the kernel log, instead of
halting the system. Replacing BUG_ON with warning reporting.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Link: https://lore.kernel.org/r/20230406065944.2773296-4-tina.zhang@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c4847a5aaf52..dd61bb554aa7 100644
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
@@ -1483,7 +1487,8 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 	uint64_t addr = (uint64_t)pfn << VTD_PAGE_SHIFT;
 	u16 did = domain_id_iommu(domain, iommu);
 
-	BUG_ON(pages == 0);
+	if (WARN_ON(!pages))
+		return;
 
 	if (ih)
 		ih = 1 << 6;
-- 
2.34.1

