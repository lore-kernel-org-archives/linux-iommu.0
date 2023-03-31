Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8EF15C0
	for <iommu@lists.linux.dev>; Fri, 31 Mar 2023 03:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680232448; x=1711768448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7FrU50kzzq4nVGrXo2UroNYkyLCDrVOYwSZeMpyDQpE=;
  b=ErtIe6O1Q4Lodw/wsbW960ozbtWZo68r44/NY3O/SimSDhgJACRUmQMX
   U512GqXL8E21WinJUmO191opLjJWekoYySa575VFOGfhpsdZWjnAAyqqs
   chnIPa9YO6ZP4HaOcPpkr1goGTYKc8XNbax19d76UktzyErFEOAzwBmKS
   J/EYDOUPvaNo9qNZmQIhYMpPFt7jHqXPRagbSR2YWXUQQUuL4xf4sKkht
   5jPYvwOVBfq0zc39UcyDdY/1iqgT/IyQczl2KmC8yW8EtQ8d0tVN4cKCd
   76GpsB8vlgQ5vQbiJHmpNZnJeBLMwYDyBzxTqXSl5qW7Eb9RubLqLGlRX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="342991716"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="342991716"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 20:14:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="635144731"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="635144731"
Received: from test.bj.intel.com ([10.238.158.71])
  by orsmga003.jf.intel.com with ESMTP; 30 Mar 2023 20:13:49 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>,
	Yongwei Ma <yongwei.ma@intel.com>
Subject: [PATCH v2 1/7] iommu/vt-d: Fix operand size in bitwise operation
Date: Thu, 30 Mar 2023 22:42:30 -0400
Message-Id: <20230331024236.2716001-2-tina.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331024236.2716001-1-tina.zhang@intel.com>
References: <20230331024236.2716001-1-tina.zhang@intel.com>
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
index 6acfe879589c..01d0ca0019f2 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1689,7 +1689,7 @@ static void __dmar_enable_qi(struct intel_iommu *iommu)
 	 * is present.
 	 */
 	if (ecap_smts(iommu->ecap))
-		val |= (1 << 11) | 1;
+		val |= BIT_ULL(11) | BIT_ULL(0);
 
 	raw_spin_lock_irqsave(&iommu->register_lock, flags);
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7c2f4bd33582..5d6018b81959 100644
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

