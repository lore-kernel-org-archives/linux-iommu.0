Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3909B7F
	for <iommu@lists.linux.dev>; Fri,  7 Jul 2023 01:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688693741; x=1720229741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TX3zfSSKDYdQMJ/lhBfeXvJtyWDmev5GpUgBT8vYQ+w=;
  b=K+XMfz45A4SUW8fcxRNuBPgeVsEuXvGW7yG+qbLR8IoEoHskiSFo9F5r
   98VXLBiV30biBHANynoAYHoj27pCeH29JoiLNB+YhIIUyuuJu31EXZy7S
   kipq7vSBPZJD0XEI4rgerha7hjfAnTUQ8M+jDqaJxFwNp7cSyTNc4FYYA
   G5mQYHl5avyTIl0FUMWYev1jD/LAHJjYPOHoYY3dawkp9V1Qlb8M6rvqm
   WM5L+7acflXjanBYw83KYMFlAeJ/jmRNyFR/sWRNMKPIJUqQeFE0vm0bE
   9VG0sZ+YGQWqBLLOHFu727PHGKsoXndXykkj0W/9U3TswGJTZ/jFw0dXC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="429832330"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="429832330"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 18:35:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="893791373"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="893791373"
Received: from fengj-mobl.ccr.corp.intel.com (HELO tinazhan-desk1.www.tendawifi.com) ([10.254.210.124])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 18:35:15 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>
Subject: [RFC PATCH 6/6] mm: Deprecate pasid field
Date: Fri,  7 Jul 2023 09:34:41 +0800
Message-Id: <20230707013441.365583-7-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707013441.365583-1-tina.zhang@intel.com>
References: <20230707013441.365583-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the pasid field, as all the information needed for sva domain
management has been moved to the newly added iommu_mm field.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 mm/init-mm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/init-mm.c b/mm/init-mm.c
index c43b7d0347312..50824dd5a949a 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -43,7 +43,6 @@ struct mm_struct init_mm = {
 	.user_ns	= &init_user_ns,
 	.cpu_bitmap	= CPU_BITS_NONE,
 #ifdef CONFIG_IOMMU_SVA
-	.pasid		= IOMMU_PASID_INVALID,
 	.iommu_mm       = &default_iommu_mm,
 #endif
 	INIT_MM_CONTEXT(init_mm)
-- 
2.34.1

