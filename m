Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2CDED2
	for <iommu@lists.linux.dev>; Thu,  6 Apr 2023 07:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680766273; x=1712302273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=waUCA6QyGfyDMZj8IcUkKRhTm5zbB59Dh1hqTAB+cRE=;
  b=YLd9mkwohZXdxgauPcYLww95JhRNMD3kIQWV7Mx8xnk4Qeyq2x0nrjEQ
   shq/rVjkVXh6SxijgS7vu2MzXi3aSsF7+H/N99SCHXyMf7Fw9dAyBQuXw
   5wAd8WFVG9e7X2LDZQnf5a7Q0lwYmFC2O73LgtivD6drrW5A3IOnCFgcb
   kU7NDOS2jGctbKoG45x6xeQUW8SmIjPOC5pmbxGsp/IlbsxD6J+eHswHP
   YZ7QC2dQTHyqTGpLM/0MYwymPWPZTso+9VKhyDyIXuiVUPZAAVFfW0q2V
   /viuuEcQA+ttTay24YEZvxbedWAdaIYwisD/JKi0val9rIyDDLmI61pjS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="428956738"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="428956738"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 00:31:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="687033966"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="687033966"
Received: from test.bj.intel.com ([10.238.158.71])
  by orsmga002.jf.intel.com with ESMTP; 06 Apr 2023 00:31:09 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>,
	Yongwei Ma <yongwei.ma@intel.com>
Subject: [v3 1/7] iommu/vt-d: Fix operand size in bitwise operation
Date: Thu,  6 Apr 2023 02:59:38 -0400
Message-Id: <20230406065944.2773296-2-tina.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230406065944.2773296-1-tina.zhang@intel.com>
References: <20230406065944.2773296-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch fixes the klocwork issues that operands in a bitwise operation
have different size at line 1692 of dmar.c, line 1898 and line 1907 of
iommu.c.

Reported-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/dmar.c  | 2 +-
 drivers/iommu/intel/iommu.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 23828d189c2a6..f0f51c957ccbc 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1690,7 +1690,7 @@ static void __dmar_enable_qi(struct intel_iommu *iommu)
 	 * is present.
 	 */
 	if (ecap_smts(iommu->ecap))
-		val |= (1 << 11) | 1;
+		val |= BIT_ULL(11) | BIT_ULL(0);
 
 	raw_spin_lock_irqsave(&iommu->register_lock, flags);
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7c2f4bd335823..5d6018b819590 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1895,7 +1895,7 @@ context_set_sm_rid2pasid(struct context_entry *context, unsigned long pasid)
  */
 static inline void context_set_sm_dte(struct context_entry *context)
 {
-	context->lo |= (1 << 2);
+	context->lo |= BIT_ULL(2);
 }
 
 /*
@@ -1904,7 +1904,7 @@ static inline void context_set_sm_dte(struct context_entry *context)
  */
 static inline void context_set_sm_pre(struct context_entry *context)
 {
-	context->lo |= (1 << 4);
+	context->lo |= BIT_ULL(4);
 }
 
 /* Convert value to context PASID directory size field coding. */
-- 
2.34.1

