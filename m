Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC8F7FC
	for <iommu@lists.linux.dev>; Mon, 18 Jul 2022 01:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658106994; x=1689642994;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1WUb26eGG0rtceH20RMmEXVjO0dlju8oh9FxVP/TLrQ=;
  b=Vl+ZAwS/FrLRSJP7i1p+NjPx6LNaTRZhukSSrt55za0lwWkoBjNr9q8R
   X5C+cPew0aEoGWwMh0vsjENbSNLUxfSiH31FQ582zkEIfyOerWEFxFORJ
   NRAPnl6KYPLJoLKclBHvp35Gh8XAUxdZul/23bdtnPs/hOVW5FXX0IRPY
   at1ZiM9s1ahhO04SXJCKH9/OSd4c2EvzItTcGj7FYDJhzr6aMesyspTSJ
   AOpnl9TXtrCOxV/sMlsSEHYKQ7BjdFFpKC2cWfCkCNA5D03Y1sJRJIuEJ
   9vbHzmiPYdYjlx5QY/ktIU74vHAg5s327lNJKwIsNtR3B1ejcjlQ2lx4o
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="269129944"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="269129944"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 18:16:24 -0700
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="624520457"
Received: from spr.sh.intel.com ([10.239.53.122])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 18:16:22 -0700
From: Chao Gao <chao.gao@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Chao Gao <chao.gao@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [RESEND PATCH 0/3] Small fixes for swiotlb
Date: Mon, 18 Jul 2022 09:16:04 +0800
Message-Id: <20220718011608.106289-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resend reason: use correct IOMMU mailing list.
---

They are found when I try to rebase my swiotlb optimizations onto the
latest dma-mapping tree.

Patch 1 is to remove unused fields.
Patch 2-3 are to fix a corner case that area size can be smaller than the
number of slots in a segment (128). Such small areas conflict with an
implication of the mechanism used to track free slots.

Chao Gao (3):
  swiotlb: remove unused fields in io_tlb_mem
  swiotlb: consolidate rounding up default_nslabs
  swiotlb: ensure a segment doesn't cross the area boundary

 include/linux/swiotlb.h |  5 -----
 kernel/dma/swiotlb.c    | 45 ++++++++++++++++++++++++-----------------
 2 files changed, 27 insertions(+), 23 deletions(-)

-- 
2.25.1

