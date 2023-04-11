Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1014B211C
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 06:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681195716; x=1712731716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fHc/Dt3WZSFDnH//DR0PtW4o8sOEHZYZ41tbx+9UmIU=;
  b=lm9ZHzPA7MJ6GUc9skxtZ5EuZ9l8BjQwKK2XcMM/7BjlrQMl0eYpF/1p
   mMtOVUV1CM1sZVS1EaJu7++8CalIUBG0X25ET37imi9fvE5Ye31O9RVIi
   5S5Oe4ewhdZ+B3BIZ9pHVyvjpLbEDmQwJTwM1t+5nOQn4PHzuA/S99G/P
   1gIOMFNZzbflud/s+qD8QfSypjNbkGK0P4w1Hq91bykzpUmaN2I/tNBaf
   p2C/waS6W79F2DGn+Nm7+I8aUMa5Wg78w/RNZjUfy6Q4dKCd2gZCOHX18
   NAQfRHRRnSqr/zWzClIsrkeJ9AqYKETrIFuVxFKBfasFsaZvFPPVbhYtc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341028601"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341028601"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 23:48:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="1018256620"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018256620"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 10 Apr 2023 23:48:33 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/17] iommu/vt-d: Fix operand size in bitwise operation
Date: Tue, 11 Apr 2023 14:48:09 +0800
Message-Id: <20230411064815.31456-12-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411064815.31456-1-baolu.lu@linux.intel.com>
References: <20230411064815.31456-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tina Zhang <tina.zhang@intel.com>

The patch fixes the klocwork issues that operands in a bitwise operation
have different size at line 1692 of dmar.c, line 1898 and line 1907 of
iommu.c.

Reported-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Link: https://lore.kernel.org/r/20230406065944.2773296-2-tina.zhang@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c  | 2 +-
 drivers/iommu/intel/iommu.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 23828d189c2a..f0f51c957ccb 100644
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
index f4e536fd5a28..acbf82fa90e7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1870,7 +1870,7 @@ context_set_sm_rid2pasid(struct context_entry *context, unsigned long pasid)
  */
 static inline void context_set_sm_dte(struct context_entry *context)
 {
-	context->lo |= (1 << 2);
+	context->lo |= BIT_ULL(2);
 }
 
 /*
@@ -1879,7 +1879,7 @@ static inline void context_set_sm_dte(struct context_entry *context)
  */
 static inline void context_set_sm_pre(struct context_entry *context)
 {
-	context->lo |= (1 << 4);
+	context->lo |= BIT_ULL(4);
 }
 
 /* Convert value to context PASID directory size field coding. */
-- 
2.34.1

