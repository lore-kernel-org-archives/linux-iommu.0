Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA7614288
	for <iommu@lists.linux.dev>; Tue, 30 May 2023 09:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685438869; x=1716974869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bb/2NSh0FsupKWJ63NAi7JNkLNuSTtTj++ZJQlgFfKg=;
  b=ESQkRh73xShC3HSRGgSXnVk3FrvEcRFJukzR/NroHfFinQCKUkuYEH/O
   bK6M7Tzw5aKi/kZnELslvHsyU72mIHsCGQ2S1ISSICyIi1PWbNR0ntmZZ
   u0PISTIhBy9/OCd8OD3/Ym8tbdA8nOlYQI0AWQwJftN/mi8olcSrAoA6r
   k17hKuLHFy+Y+x+5/sGEjDWKbZlAkQgFCMIV253lJ4DvOijylcOEcinUK
   Iyg/m15n0VHLRr9oWir4s9gie+/X3/RSWt7Cfj1mAaBaYxIyc9xLt++4y
   VtU8YPH9Jc0G84pc6Xmv4hxUIcx1O1yRAO/MZ7OV0/Xq6szigze3sLOa6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="344365178"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="344365178"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 02:27:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="818720180"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="818720180"
Received: from tower.bj.intel.com ([10.238.157.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 02:27:47 -0700
From: Yanfei Xu <yanfei.xu@intel.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	yanfei.xu@intel.com
Subject: [PATCH 2/2] iommu/vt-d: Use BUG_ON to check NULL value of 'table'
Date: Tue, 30 May 2023 17:25:03 +0800
Message-Id: <20230530092503.152926-3-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530092503.152926-1-yanfei.xu@intel.com>
References: <20230530092503.152926-1-yanfei.xu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Checking NULL value of 'table' variable deserves a BUG_ON as the
following code will trigger a crash by dereferencing the NULL
'table' pointer. Crash in advance with BUG_ON to avoid WARN_ON
plus NULL pointer dereferencing can simplify the crash log.

Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e98f1b122b49..8aa3bfdb7f95 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1944,7 +1944,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	if (sm_supported(iommu)) {
 		unsigned long pds;
 
-		WARN_ON(!table);
+		BUG_ON(!table);
 
 		/* Setup the PASID DIR pointer: */
 		pds = context_get_sm_pds(table);
-- 
2.34.1

