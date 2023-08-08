Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D842104
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 07:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691481007; x=1723017007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=G2jQdPpYRftTNVodh55koMoZtJhLjKxrlqOJq+ORzpU=;
  b=JjRMQOrvXq1oHMNAruXPpyt2Z6NAngn+WQMWKNnxDkReodwC8/51n+bs
   AYtvyCjGyb/TbTv0u8FByiRlzhkDHzcLTwuNcnmSvLsWvlAkhO7AIB5xD
   os1k5BkhLLe2dkE+gSN3prDy8Q3T7U9I1IO5+c3gC47Uq9GJv+y26SIJ6
   md/C9CuVs/UvkSveMmUllkGngvi432nqAmkRK1/39MvItPYYdHzhZRDAY
   6IJ0cwOuA/US1rzmYRCK57jsblfjvyx0uHB3mJwQvG3Jyp6n0+snkfLtk
   Q6bswmHUkuPvKAYn7ikhlBsPi/PF2JlDz+asVRT0YgaZiq3brCJmQooN5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437078721"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="437078721"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 00:50:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="681146448"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="681146448"
Received: from kechen-optiplex-9020.bj.intel.com ([10.238.156.126])
  by orsmga003.jf.intel.com with ESMTP; 08 Aug 2023 00:50:05 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH 5/5] mm: Deprecate pasid field
Date: Tue,  8 Aug 2023 15:49:44 +0800
Message-Id: <20230808074944.7825-6-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230808074944.7825-1-tina.zhang@intel.com>
References: <20230808074944.7825-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Drop the pasid field, as all the information needed for sva domain
management has been moved to the newly added iommu_mm field.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 include/linux/mm_types.h | 1 -
 mm/init-mm.c             | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3fd65b7537f0..6cb5cc53c480 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -808,7 +808,6 @@ struct mm_struct {
 		struct work_struct async_put_work;
 
 #ifdef CONFIG_IOMMU_SVA
-		u32 pasid;
 		struct iommu_mm_data *iommu_mm;
 #endif
 #ifdef CONFIG_KSM
diff --git a/mm/init-mm.c b/mm/init-mm.c
index efa97b57acfd..69719291463e 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -42,9 +42,6 @@ struct mm_struct init_mm = {
 #endif
 	.user_ns	= &init_user_ns,
 	.cpu_bitmap	= CPU_BITS_NONE,
-#ifdef CONFIG_IOMMU_SVA
-	.pasid		= IOMMU_PASID_INVALID,
-#endif
 	INIT_MM_CONTEXT(init_mm)
 };
 
-- 
2.17.1

