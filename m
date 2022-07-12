Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EA51FB8
	for <iommu@lists.linux.dev>; Tue, 12 Jul 2022 00:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657584841; x=1689120841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GzlhirecLvIVUu2iZ2UlHBIY5boXyb2x1HwRo/KzfaU=;
  b=jarvSwXaZSpp0+dQhdTDpPgy6W3QgoFPI2IVSjc3kIX/ps1zNMintArC
   4cFrOeGPmKUv/8jXCYDvVfnImbQ//NAJxUVCDpIUG/iGyxjK0atCAuCB8
   2okjmjcDqZeNH3xplGYPbvL90N5oymxrrrZ/T8tyaCpenKpVTYzW0uAMN
   26ns1+ipXW4ViWF9loCMeEmzQQI92YM1931RsS2ld6P5uT0W8XGextMqO
   7dQ9xpghZd9FV7Lg86pP5ZLC0gGty5MFGWxpvGVv2AbXQsNAPfEp73IXc
   qam4Pi+wBTyuEizaj/Q2iGdknmsbHZ9v5lI5eZHIqKwtPrOyxPOY+gHNt
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="264589970"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="264589970"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:14:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="592445785"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2022 17:13:57 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/25] iommu/vt-d: Unnecessary spinlock for root table alloc and free
Date: Tue, 12 Jul 2022 08:08:55 +0800
Message-Id: <20220712000908.3431936-13-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
References: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IOMMU root table is allocated and freed in the IOMMU initialization
code in static boot or hot-remove paths. There's no need for a spinlock.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20220706025524.2904370-5-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 77915d61f7ec..ff49c9460ede 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -809,14 +809,12 @@ static int device_context_mapped(struct intel_iommu *iommu, u8 bus, u8 devfn)
 
 static void free_context_table(struct intel_iommu *iommu)
 {
-	int i;
-	unsigned long flags;
 	struct context_entry *context;
+	int i;
+
+	if (!iommu->root_entry)
+		return;
 
-	spin_lock_irqsave(&iommu->lock, flags);
-	if (!iommu->root_entry) {
-		goto out;
-	}
 	for (i = 0; i < ROOT_ENTRY_NR; i++) {
 		context = iommu_context_addr(iommu, i, 0, 0);
 		if (context)
@@ -828,12 +826,10 @@ static void free_context_table(struct intel_iommu *iommu)
 		context = iommu_context_addr(iommu, i, 0x80, 0);
 		if (context)
 			free_pgtable_page(context);
-
 	}
+
 	free_pgtable_page(iommu->root_entry);
 	iommu->root_entry = NULL;
-out:
-	spin_unlock_irqrestore(&iommu->lock, flags);
 }
 
 #ifdef CONFIG_DMAR_DEBUG
@@ -1232,7 +1228,6 @@ static void domain_unmap(struct dmar_domain *domain, unsigned long start_pfn,
 static int iommu_alloc_root_entry(struct intel_iommu *iommu)
 {
 	struct root_entry *root;
-	unsigned long flags;
 
 	root = (struct root_entry *)alloc_pgtable_page(iommu->node);
 	if (!root) {
@@ -1242,10 +1237,7 @@ static int iommu_alloc_root_entry(struct intel_iommu *iommu)
 	}
 
 	__iommu_flush_cache(iommu, root, ROOT_SIZE);
-
-	spin_lock_irqsave(&iommu->lock, flags);
 	iommu->root_entry = root;
-	spin_unlock_irqrestore(&iommu->lock, flags);
 
 	return 0;
 }
-- 
2.25.1

