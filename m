Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA096819
	for <iommu@lists.linux.dev>; Mon, 18 Jul 2022 01:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658106995; x=1689642995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i6wERldfINGotCZB9RRsepryrHDN3FyuIRZkpCQPpjo=;
  b=LKTEp3EceXSwzoAIJEMxemM72D9OAG8d1RVW+D0DMrCWM908RlubW0Rj
   TlwOzh6ixmYEcOpt/vBj1M5kOevnCLp5MjzOa4U8BKzxwpvBFdGWPlNh4
   MtXcdS9vvPuPDCq8QhlzhebHmCcWrlGdOOK6FrwmCeuralAXvG/rS3Mns
   ZkX4Guut+CQszKj4K84Ly0B/2cMVlmgACbhRQHQZQbedwlDqPTqWgOiEc
   vJLWegxCtsz9cTEiYS1LAptOXSe9te4ImPm88/S81LO+Q+f+QO76PW18X
   SHtduJhnQRkeoWlPku5o7cMKgzfsvSYeXA6q10ZDLFZiKwcoceGJl9YDP
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="269129951"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="269129951"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 18:16:26 -0700
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="624520461"
Received: from spr.sh.intel.com ([10.239.53.122])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 18:16:24 -0700
From: Chao Gao <chao.gao@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Chao Gao <chao.gao@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [RESEND PATCH 1/3] swiotlb: remove unused fields in io_tlb_mem
Date: Mon, 18 Jul 2022 09:16:05 +0800
Message-Id: <20220718011608.106289-2-chao.gao@intel.com>
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

Commit 20347fca71a3 ("swiotlb: split up the global swiotlb lock") splits
io_tlb_mem into multiple areas. Each area has its own lock and index. The
global ones are not used so remove them.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 include/linux/swiotlb.h | 5 -----
 kernel/dma/swiotlb.c    | 2 --
 2 files changed, 7 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index f65ff1930120..d3ae03edbbd2 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -79,11 +79,8 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
  * @used:	The number of used IO TLB block.
  * @list:	The free list describing the number of free entries available
  *		from each index.
- * @index:	The index to start searching in the next round.
  * @orig_addr:	The original address corresponding to a mapped entry.
  * @alloc_size:	Size of the allocated buffer.
- * @lock:	The lock to protect the above data structures in the map and
- *		unmap calls.
  * @debugfs:	The dentry to debugfs.
  * @late_alloc:	%true if allocated using the page allocator
  * @force_bounce: %true if swiotlb bouncing is forced
@@ -97,8 +94,6 @@ struct io_tlb_mem {
 	void *vaddr;
 	unsigned long nslabs;
 	unsigned long used;
-	unsigned int index;
-	spinlock_t lock;
 	struct dentry *debugfs;
 	bool late_alloc;
 	bool force_bounce;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index dcf1459ce723..0d0f99146360 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -253,14 +253,12 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 	mem->nslabs = nslabs;
 	mem->start = start;
 	mem->end = mem->start + bytes;
-	mem->index = 0;
 	mem->late_alloc = late_alloc;
 	mem->nareas = nareas;
 	mem->area_nslabs = nslabs / mem->nareas;
 
 	mem->force_bounce = swiotlb_force_bounce || (flags & SWIOTLB_FORCE);
 
-	spin_lock_init(&mem->lock);
 	for (i = 0; i < mem->nareas; i++) {
 		spin_lock_init(&mem->areas[i].lock);
 		mem->areas[i].index = 0;
-- 
2.25.1

