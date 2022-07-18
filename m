Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F397FC
	for <iommu@lists.linux.dev>; Mon, 18 Jul 2022 01:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658106995; x=1689642995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MSWP29tqWJG1PAHv7yFlPylCea0BZGM4/LHBRM52PJQ=;
  b=HL7At/GKGF6iiQehNhBFLBM1WFPg5ykecYyJbaKEPLG9N8j0h8YQ1ZVC
   1WdqBK7KVxDmlEK/5V7wzQIy6bdQfXx8TNaOrCYdYOmvJuy2VerC026vO
   A3HMmln+00HwqfTXj2BHs1wmp3zfB3rRlS3T2zCMD/ABmPfNpjhNylJfJ
   OXlcAxTJaWTPu+gSDhRfEm3nMdh+GPVUbr83V3jAZq3HnMLpykrVkTLgp
   V7hRgTDPWqXOWMQNN/MthlLGG46fTTNgbzC7/Q4D1WRrlBwNvxLwsYXvH
   ntgpKysSez0vNmoE6UuOKxn9Hz1kbuJHuIq+VQRD2KIwWeVekDM116/F3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="269129954"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="269129954"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 18:16:28 -0700
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="624520466"
Received: from spr.sh.intel.com ([10.239.53.122])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 18:16:26 -0700
From: Chao Gao <chao.gao@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Chao Gao <chao.gao@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [RESEND PATCH 2/3] swiotlb: consolidate rounding up default_nslabs
Date: Mon, 18 Jul 2022 09:16:06 +0800
Message-Id: <20220718011608.106289-3-chao.gao@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220718011608.106289-1-chao.gao@intel.com>
References: <20220718011608.106289-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

default_nslabs are rounded up in two cases with exactly same comments.
Add a simple wrapper to reduce duplicate code/comments. It is preparatory
to adding more logics into the round-up.

No functional change intended.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 kernel/dma/swiotlb.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 0d0f99146360..9ab87d6d47bc 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -88,6 +88,22 @@ struct io_tlb_area {
 	spinlock_t lock;
 };
 
+/*
+ * Round up number of slabs to the next power of 2. The last area is going
+ * be smaller than the rest if default_nslabs is not power of two.
+ *
+ * Return true if default_nslabs is rounded up.
+ */
+static bool round_up_default_nslabs(void)
+{
+	if (!default_nareas || is_power_of_2(default_nslabs))
+		return false;
+
+	default_nslabs = roundup_pow_of_two(default_nslabs);
+
+	return true;
+}
+
 static void swiotlb_adjust_nareas(unsigned int nareas)
 {
 	if (!is_power_of_2(nareas))
@@ -96,16 +112,9 @@ static void swiotlb_adjust_nareas(unsigned int nareas)
 	default_nareas = nareas;
 
 	pr_info("area num %d.\n", nareas);
-	/*
-	 * Round up number of slabs to the next power of 2.
-	 * The last area is going be smaller than the rest if
-	 * default_nslabs is not power of two.
-	 */
-	if (nareas && !is_power_of_2(default_nslabs)) {
-		default_nslabs = roundup_pow_of_two(default_nslabs);
+	if (round_up_default_nslabs())
 		pr_info("SWIOTLB bounce buffer size roundup to %luMB",
 			(default_nslabs << IO_TLB_SHIFT) >> 20);
-	}
 }
 
 static int __init
@@ -154,17 +163,10 @@ void __init swiotlb_adjust_size(unsigned long size)
 	if (default_nslabs != IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT)
 		return;
 
-	/*
-	 * Round up number of slabs to the next power of 2.
-	 * The last area is going be smaller than the rest if
-	 * default_nslabs is not power of two.
-	 */
 	size = ALIGN(size, IO_TLB_SIZE);
 	default_nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
-	if (default_nareas) {
-		default_nslabs = roundup_pow_of_two(default_nslabs);
+	if (round_up_default_nslabs())
 		size = default_nslabs << IO_TLB_SHIFT;
-	}
 
 	pr_info("SWIOTLB bounce buffer size adjusted to %luMB", size >> 20);
 }
-- 
2.25.1

