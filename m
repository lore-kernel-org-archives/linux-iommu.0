Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306927F
	for <iommu@lists.linux.dev>; Mon, 25 Sep 2023 02:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695609526; x=1727145526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sLavevVR2/ebOFF/RgWFP9jTGobd5rMYRFpptbLPi5Y=;
  b=BRrIDFg58VLaiRi3KRErz4WQficzAVbR1SBq9HG8pj7rpmbpNDGF7izo
   v2/NBMd3wYKNZcV1yqxpqieo8Yw5sTR+4Ne9tSXMzkUPdSTpkj7kqy951
   K02KjbK2SPi8pDPA8rOOBy8uQlH1DZ4VuqjRnhYhgz4FbYfpmczGsdEzb
   1ECLccm86rBO9E+Qhu9sug3Y26flP8x0llSDNZRC/ILm8+X+WXd2/a+Kx
   kRpyq5A3wITFe43gpLlmJ/rR0yFMWk/TlcRa2atWA52ZDqZ9xLga28cqH
   ae0TYgyrv5lv17Zm6NKmrn57MRQcSo6b6p7U7FW3pneYmthZj3Nq0mJzo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360534627"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="360534627"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 19:38:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="777505094"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="777505094"
Received: from jingxues-mobl1.ccr.corp.intel.com (HELO tinazhan-desk1.intel.com) ([10.254.214.78])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 19:38:43 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: Michael Shavit <mshavit@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v5 6/6] mm: Deprecate pasid field
Date: Mon, 25 Sep 2023 10:38:13 +0800
Message-Id: <20230925023813.575016-7-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925023813.575016-1-tina.zhang@intel.com>
References: <20230925023813.575016-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the pasid field, as all the information needed for sva domain
management has been moved to the newly added iommu_mm field.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 include/linux/mm_types.h | 1 -
 mm/init-mm.c             | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 9f4efed85f74..37f049c4b059 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -883,7 +883,6 @@ struct mm_struct {
 		struct work_struct async_put_work;
 
 #ifdef CONFIG_IOMMU_SVA
-		u32 pasid;
 		struct iommu_mm_data *iommu_mm;
 #endif
 #ifdef CONFIG_KSM
diff --git a/mm/init-mm.c b/mm/init-mm.c
index cfd367822cdd..24c809379274 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -44,9 +44,6 @@ struct mm_struct init_mm = {
 #endif
 	.user_ns	= &init_user_ns,
 	.cpu_bitmap	= CPU_BITS_NONE,
-#ifdef CONFIG_IOMMU_SVA
-	.pasid		= IOMMU_PASID_INVALID,
-#endif
 	INIT_MM_CONTEXT(init_mm)
 };
 
-- 
2.34.1

