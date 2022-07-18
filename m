Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6747D7FC
	for <iommu@lists.linux.dev>; Mon, 18 Jul 2022 01:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658106997; x=1689642997;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mf+ou5sUbNJrHFghDywBtdNo5AKN4S9liviBGsFpQzU=;
  b=fwM0wO/5Y8IWsWgJJVETlXw7j2HzC4XCusW7TbgcXQ+xS5h5Z0EeFM/e
   X4I8OJSbq1M2D9Cu6Tp258yFXcOn7qBQXog4+uvxMpIXOxHE8gCyHjPpG
   yTg4McdmOepx9eJruFhbQV2b7HWjRqfEL7eehoyaSit255M6nzdn6wxdb
   /+RnqQP8M7+aEWoxMy+weajk1cslqBMK53Hl6zn1FifZAOsnrXr88mqRL
   v0aIiuEkf0ukZVQDQKYJckafupOGdOsWH74gUoCGFtqxUgeQRhjgAeIfB
   u7jDudciOuY7Nb3AFTPX1oltws2pOvEY9s1equ8owHuUx1iuC2TvX269o
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="269129959"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="269129959"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 18:16:30 -0700
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="624520476"
Received: from spr.sh.intel.com ([10.239.53.122])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 18:16:28 -0700
From: Chao Gao <chao.gao@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Chao Gao <chao.gao@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [RESEND PATCH 3/3] swiotlb: ensure a segment doesn't cross the area boundary
Date: Mon, 18 Jul 2022 09:16:07 +0800
Message-Id: <20220718011608.106289-4-chao.gao@intel.com>
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

Free slots tracking assumes that slots in a segment can be allocated to
fulfill a request. This implies that slots in a segment should belong to
the same area. Although the possibility of a violation is low, it is better
to explicitly enforce segments won't span multiple areas by adjusting the
number of slabs when configuring areas.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 kernel/dma/swiotlb.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 9ab87d6d47bc..70fd73fc357a 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -91,12 +91,21 @@ struct io_tlb_area {
 /*
  * Round up number of slabs to the next power of 2. The last area is going
  * be smaller than the rest if default_nslabs is not power of two.
+ * The number of slot in an area should be a multiple of IO_TLB_SEGSIZE,
+ * otherwise a segment may span two or more areas. It conflicts with free
+ * contiguous slots tracking: free slots are treated contiguous no matter
+ * whether they cross an area boundary.
  *
  * Return true if default_nslabs is rounded up.
  */
 static bool round_up_default_nslabs(void)
 {
-	if (!default_nareas || is_power_of_2(default_nslabs))
+	if (!default_nareas)
+		return false;
+
+	if (default_nslabs < IO_TLB_SEGSIZE * default_nareas)
+		default_nslabs = IO_TLB_SEGSIZE * default_nareas;
+	else if (is_power_of_2(default_nslabs))
 		return false;
 
 	default_nslabs = roundup_pow_of_two(default_nslabs);
-- 
2.25.1

