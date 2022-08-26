Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7980928E8
	for <iommu@lists.linux.dev>; Fri, 26 Aug 2022 09:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661507483; x=1693043483;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FyBesxBopP4WUfvr9s3m3ayI6JGta6ovjzfVKeQey/k=;
  b=IOx8bJQ9pSL5Jr5K9zxIZp0I8T8wJCfNvqlCN+YCHFMBDDyOl5YO1ET/
   x1N2Ei+k9RtI1JzceKm3n8OBu/NGdRmQAqg8IHNw8dSFDQLCQYla7HM7Y
   qJhfRtK/dvpxURpdtRXxDQZIMKdVEOBN8b/I7Y+ULYPjF64DUkuVDKLi0
   8F+evCKZrWygpgKh5Ut6HdJOak/7C5d+xMRMooP3XkbYkbgWS5IJLJren
   tTfB9t7rL6T486w/JEX1xpD29geHdl98rRc4lxm5+6HPX5AxdCDLrjIsN
   3hdnHY+2Il+ubGnHl0uJDH1LsTxyL+pKhYhXSpMHSMjkB2RAb94GUuo+D
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="274865152"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="274865152"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 02:50:57 -0700
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="671399096"
Received: from spr.sh.intel.com ([10.239.53.122])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 02:50:55 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: hch@infradead.org,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	Chao Gao <chao.gao@intel.com>
Subject: [PATCH] swiotlb: fix a typo
Date: Fri, 26 Aug 2022 17:50:46 +0800
Message-Id: <20220826095046.880626-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"overwirte" isn't a word. It should be "overwrite".

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
BTW, I am wondering if copying the original buffer to the tlb buffer
unconditionally will leak the original buffer to the VMM, especially
when VMM isn't trusted e.g., by confidential VMs. Would it be better
to zero the tlb buffer for dir == DMA_FROM_DEVICE?

 kernel/dma/swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c5a9190b218f..f67e5f50ee3c 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -765,7 +765,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	/*
 	 * When dir == DMA_FROM_DEVICE we could omit the copy from the orig
 	 * to the tlb buffer, if we knew for sure the device will
-	 * overwirte the entire current content. But we don't. Thus
+	 * overwrite the entire current content. But we don't. Thus
 	 * unconditional bounce may prevent leaking swiotlb content (i.e.
 	 * kernel memory) to user-space.
 	 */
-- 
2.25.1

