Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF9417EE
	for <iommu@lists.linux.dev>; Fri, 19 Aug 2022 08:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660898747; x=1692434747;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FEm9dKbVADtF2TWenZ71YMTaKEFg+RMwqpGYzA7uQ+I=;
  b=WSNYkecfcatrE8vqODktbkF9AWqCp4UyfSQlYbPxYaGEpdcttCTChlYF
   9a60ZmbDgVbljLawBx/Ug8LyK1Xxm23pdDai0P5t48TKQEktLX13p2Znr
   XlpDwrxLUrQsWRInpXZDK4OT0pDjlm4Ya+1Js4J9wVVZmUZ79IF4N6ULU
   /VYQ9kcAg9z+kYfSL3Ca+Fb1SOdmDOQ0xSGX73YVE9Sem07RlMxOo/jWR
   KJsSaIx/wamzxi4jlwnB37uaEBvkJ8OvhAf9UdriD5EV0xg1Ewu+W2SNg
   ofeH7gKjAGTIzV0EtD1UnxBMopHg7KyRJf4kzrD7NTem4vA/anOsrmDdo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="276012980"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="276012980"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 01:45:47 -0700
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="668495401"
Received: from spr.sh.intel.com ([10.239.53.122])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 01:45:44 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: hch@infradead.org,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	jxgao@google.com,
	konrad.wilk@oracle.com,
	Chao Gao <chao.gao@intel.com>
Subject: [PATCH v2] swiotlb: avoid potential left shift overflow
Date: Fri, 19 Aug 2022 16:45:37 +0800
Message-Id: <20220819084537.52374-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The second operand passed to slot_addr() is declared as int or unsigned int
in all call sites. The left-shift to get the offset of a slot can overflow
if swiotlb size is larger than 4G.

Convert the macro to an inline function and declare the second argument as
phys_addr_t to avoid the potential overflow.

Fixes: 26a7e094783d ("swiotlb: refactor swiotlb_tbl_map_single")
Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 kernel/dma/swiotlb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c5a9190b218f..41ea9fb3efe1 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -579,7 +579,10 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 	}
 }
 
-#define slot_addr(start, idx)	((start) + ((idx) << IO_TLB_SHIFT))
+static inline phys_addr_t slot_addr(phys_addr_t start, phys_addr_t idx)
+{
+	return start + (idx << IO_TLB_SHIFT);
+}
 
 /*
  * Carefully handle integer overflow which can occur when boundary_mask == ~0UL.

base-commit: 5c850d31880e00f063fa2a3746ba212c4bcc510f
-- 
2.25.1

