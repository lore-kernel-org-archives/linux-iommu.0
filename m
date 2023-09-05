Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3436F19B
	for <iommu@lists.linux.dev>; Tue,  5 Sep 2023 00:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693872609; x=1725408609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=68L83X6aiWQ0u3NC5lLGeeqieoz7SK8pWWYp6gdXpkU=;
  b=S/7QfByQlMUOLWNln7VTmDgxG1tBTuwhVCtw6lFv3fshoJxJqAqCnyvl
   0veWdnynArbuY6T18ZGZxPy19bq4iTMj1DISSDddHAwx2wIO5GwMnuzaM
   x5vmM8qEkGCjvtZctoSQ+QX+VbKyE4tlh0CVcjX9UpXatjppcQ44B/L5y
   rSi6m5NLvNr9sVxutd8JJKGstp8IcejR6EPihdBhiR4Cd17p4Dw6gWrzW
   y6BKZON3RrUmYcQoWDSS4xLrxjS6rzWiid4fxNxdZtIieoWerS3rcRGu4
   +Pt4lbbEdhHurE1Jy/QK4EPOc9ylP793lQLKfikuGlr9aY1YyUREnupYy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="463039991"
X-IronPort-AV: E=Sophos;i="6.02,227,1688454000"; 
   d="scan'208";a="463039991"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 17:10:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="884125154"
X-IronPort-AV: E=Sophos;i="6.02,227,1688454000"; 
   d="scan'208";a="884125154"
Received: from kechen-optiplex-9020.bj.intel.com ([10.238.157.62])
  by fmsmga001.fm.intel.com with ESMTP; 04 Sep 2023 17:09:59 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: Michael Shavit <mshavit@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v3 6/6] mm: Deprecate pasid field
Date: Tue,  5 Sep 2023 08:09:30 +0800
Message-Id: <20230905000930.24515-7-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230905000930.24515-1-tina.zhang@intel.com>
References: <20230905000930.24515-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Drop the pasid field, as all the information needed for sva domain
management has been moved to the newly added iommu_mm field.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 include/linux/mm_types.h | 1 -
 mm/init-mm.c             | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index b486f521afee..fb0e4416d9d7 100644
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

