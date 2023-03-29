Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D92187C
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 13:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680095890; x=1711631890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V3O6ZHB+/P6YSoGEMD9eKDXVLmfTVM7FAhkTDUEia4E=;
  b=bPPOSLwDBONMkdI1Yl8u+EWDBKUokABY+dI0ycYRc21C5AGiMTdJ8DS1
   2f0AP/HHg6aLcymxMDczSX6oLH4AivdmouwCzlUyUjeNomNr/xhpW8VXr
   udt2n71aKjTT3SF6WAP27o4zRAJRSL/x9BLfkgJ2yTtoEAQxD+mzkLD/5
   uneHRFqPvwz83LBzXADKJPUw22Bq5WdzS2AFlpZxwf9jLAVM2VTwVXafX
   N98l/wNv3142n5FBSgQHGaYJ4VmObcNA+2K5BB6v/BDdfBEoDOzyi472n
   rJFbk1C5Fvq9VXPhK0JNBv3MYqP1OGPjHAcwkCKHk+iKLQcS/ZcOMaIP6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="343293152"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="343293152"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:18:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="686821254"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="686821254"
Received: from test.bj.intel.com ([10.238.158.71])
  by fmsmga007.fm.intel.com with ESMTP; 29 Mar 2023 06:18:08 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>,
	Yongwei Ma <yongwei.ma@intel.com>
Subject: [PATCH 2/4] iommu/vt-d: Fix operand size in bitwise operation
Date: Wed, 29 Mar 2023 08:46:52 -0400
Message-Id: <20230329124654.2698853-3-tina.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230329124654.2698853-1-tina.zhang@intel.com>
References: <20230329124654.2698853-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch fixes the klocwork issues that operands in a bitwise operation have
different size at line 1692 of dmar.c, line 1898 and line 1907 of iommu.c.

Reported-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/dmar.c  | 2 +-
 drivers/iommu/intel/iommu.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 6acfe879589c..7c77a59889ea 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1689,7 +1689,7 @@ static void __dmar_enable_qi(struct intel_iommu *iommu)
 	 * is present.
 	 */
 	if (ecap_smts(iommu->ecap))
-		val |= (1 << 11) | 1;
+		val |= (1ull << 11) | 1ull;
 
 	raw_spin_lock_irqsave(&iommu->register_lock, flags);
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7c2f4bd33582..085d31a77f6f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1895,7 +1895,7 @@ context_set_sm_rid2pasid(struct context_entry *context, unsigned long pasid)
  */
 static inline void context_set_sm_dte(struct context_entry *context)
 {
-	context->lo |= (1 << 2);
+	context->lo |= (1ull << 2);
 }
 
 /*
@@ -1904,7 +1904,7 @@ static inline void context_set_sm_dte(struct context_entry *context)
  */
 static inline void context_set_sm_pre(struct context_entry *context)
 {
-	context->lo |= (1 << 4);
+	context->lo |= (1ull << 4);
 }
 
 /* Convert value to context PASID directory size field coding. */
-- 
2.34.1

