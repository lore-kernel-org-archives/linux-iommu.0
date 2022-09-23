Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2355E15B0
	for <iommu@lists.linux.dev>; Fri, 23 Sep 2022 00:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663894088; x=1695430088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MJXPMS/XhKv6zPYf3a2rF9C8OzRAinRWmgowCI7ErTw=;
  b=dSoxmKkZxF5jmGOEe3SLVvtIz5jfBIP2EnlUs0dxMbUrx2ce0kfSj1fE
   cpZnw7Ql5gLrUucMxgQ0ANw4Y2DlmCga+jhBAIkpcczgo6BcNaXRgjSEs
   RrDiqZEw5/a5oSnpe5VKDMP28XkfegEiLg4xR6AliglRcE/bEkjh2As4H
   BiEikbnzqKs8ZsprC1vTPRvDFENK2KAI1lBJ62bYTtthjuVnHKf/l/0++
   AFwzN+/Rt4SQD+02mpvfwzsG+d7jlE0H36J5VvMkgal9Ai6ozNLARTET5
   kC68moOPWPWCNH57WatV1G4fg2w8HsAO1SD3IneQQ4TRMBEpI3yWsgd0t
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="362278860"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="362278860"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 17:48:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="650759956"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 22 Sep 2022 17:48:06 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] iommu/vt-d: Remove pasid_set_eafe()
Date: Fri, 23 Sep 2022 08:42:03 +0800
Message-Id: <20220923004206.3630441-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220923004206.3630441-1-baolu.lu@linux.intel.com>
References: <20220923004206.3630441-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is not used anywhere in the tree. Remove it to avoid dead code.
No functional change intended.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20220915081645.1834555-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/pasid.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index c5e7e8b020a5..ccaf32949254 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -392,16 +392,6 @@ pasid_set_flpm(struct pasid_entry *pe, u64 value)
 	pasid_set_bits(&pe->val[2], GENMASK_ULL(3, 2), value << 2);
 }
 
-/*
- * Setup the Extended Access Flag Enable (EAFE) field (Bit 135)
- * of a scalable mode PASID entry.
- */
-static inline void
-pasid_set_eafe(struct pasid_entry *pe)
-{
-	pasid_set_bits(&pe->val[2], 1 << 7, 1 << 7);
-}
-
 static void
 pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
 				    u16 did, u32 pasid)
-- 
2.34.1

