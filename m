Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99141187C
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 13:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680095885; x=1711631885;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HWZu/2WyT5i4D8WkwigG9MfuZicAqjUH9kkpqjSI7o4=;
  b=DyHM53yOjMBFj82O2uVCpo6GcrYlWjAm8vn8hRQlGb1cYnefsYByMZTY
   L4sDyGSQfnVUL0aJX7xmfsyVSbCeFSaHdrNhlc7f/zbQzq6zwNvBnoSZ3
   tGpzfKAhCdqKTgUGMxHLpQt0dkFDoGlK7vyaPGGwACvBMRrGSsdPrh95b
   dn3OPWRnEepUfxE4uc8rGPlxsdhqByj96FqsJcIdp/3lYzY4Yl3h6IqPb
   n3AFdtBMCT9r67fDXJpiBeaNArY9+0SNOqjOugwWfLoyqxTy55OYHs3ZG
   KB09WoNyAyfUvin/YjGbtsfg8LWkSeToZf3Q6yoJIOfIPAbX8ZHlnA5wj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="343293137"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="343293137"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:18:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="686821214"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="686821214"
Received: from test.bj.intel.com ([10.238.158.71])
  by fmsmga007.fm.intel.com with ESMTP; 29 Mar 2023 06:18:03 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH 0/4] iommu/vt-d: Several fixes for intel iommu driver
Date: Wed, 29 Mar 2023 08:46:50 -0400
Message-Id: <20230329124654.2698853-1-tina.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series includes several small fixes.

Tina Zhang (4):
  iommu/vt-d: Fix null pointer access in invalidate_range callback
  iommu/vt-d: Fix operand size in bitwise operation
  iommu/vt-d: Fix quoted string split across lines
  iommu/vt-d: Replace BUG()/BUG_ON() with WARN_ON/WARN_ON_ONCE()

 drivers/iommu/intel/dmar.c  |  8 ++++---
 drivers/iommu/intel/iommu.c | 46 ++++++++++++++++++++++---------------
 drivers/iommu/intel/svm.c   |  2 +-
 3 files changed, 34 insertions(+), 22 deletions(-)

-- 
2.34.1

