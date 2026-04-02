Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7023D37CD46
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 07:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113226; cv=none; b=gos9MBHMG+J02T5Wu6/hDfLQ8wd92dgSg274ZbJzKuJDLnJA8eO72kqVp8cu5M13Q6MOw3L2erD6suhrr9fAbF2JxIaAvJQCie1dJsDVGbfj9OXD70/Ydu4ZAL8FpGKWkZfFpAC0o/8X9l4tcSnsOBWCINBLgd6KavUAUP2AWYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113226; c=relaxed/simple;
	bh=r3nyFCWQlBFbexJdHzJvghbchhPXTHeSh6JtQNWO8Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Otc5ZMGWivSqdaBIvHbQTDeA6Uz6yd2ixv/p7eAG2ONxELWzzz7x1zFznwcWdusdBU5aiFI+knAFgu6aizNOzg3PirmuVWnlNSdF5F5wGIz37rTi520jgphB0o72Kjvt30MfG6Q63TLOkuiLZ8wKOGb0Ccf1IfCTPlGtK0q7//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ds5FXmL/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ds5FXmL/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775113224; x=1806649224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r3nyFCWQlBFbexJdHzJvghbchhPXTHeSh6JtQNWO8Tg=;
  b=Ds5FXmL/0LfJTzo9p5qsnR/zAK8d0bQvzQ5uFQRX62qyXcXIoY4OvKc/
   oTPQRgGb2vL/vTfJbSKGRqDaSndf//j2Ds/TkSb2OPXQEAtbecA5XIfPB
   laXU4swOErI3KNi6dfiMhULwqh4LfM8L/rQXW78q9ghHQw/Lr3zyg8EFB
   D0v4nCCar+PPSxyty0Gm4nkfo2BpWTd1ALNb2CwUVCB+mTrdT6YRmya9j
   owXjCTQGFxm/eVRjRHs0aZtcH9wOiiExs3h7df7Fy0ndKRXAHvbxgEZ4u
   sypEHnO+uaIGvKhaJ1w/tNxOEMVLV56zwMH2rMlUqykq2ieuaRyJEOGNp
   w==;
X-CSE-ConnectionGUID: t5nsmy5gSEiINImhaVJpNQ==
X-CSE-MsgGUID: dl9qoU7oQ6q73npq8F6jug==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76053652"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="76053652"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 00:00:24 -0700
X-CSE-ConnectionGUID: m4ZeuaxHQxilYY7rqznPGg==
X-CSE-MsgGUID: //SQA9lbSoGsyO1Nrlk0Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="231847875"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa005.jf.intel.com with ESMTP; 02 Apr 2026 00:00:23 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] iommu/vt-d: Remove dmar_writel() and dmar_writeq()
Date: Thu,  2 Apr 2026 14:57:29 +0800
Message-ID: <20260402065734.1687476-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402065734.1687476-1-baolu.lu@linux.intel.com>
References: <20260402065734.1687476-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

dmar_writel() and dmar_writeq() do nothing other than expand to the generic
writel() and writeq(), and the dmar_write*() wrappers are used
inconsistently.

Remove the dmar_write*() wrappers and use writel() and writeq() directly.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Link: https://lore.kernel.org/r/20260217214438.3395039-3-bhelgaas@google.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h         |  3 ---
 drivers/iommu/intel/dmar.c          |  2 +-
 drivers/iommu/intel/iommu.c         | 12 ++++++------
 drivers/iommu/intel/irq_remapping.c |  4 ++--
 drivers/iommu/intel/perfmon.c       | 22 +++++++++++-----------
 drivers/iommu/intel/prq.c           | 14 +++++++-------
 6 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index dbd8d196d154..10331364c0ef 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -148,9 +148,6 @@
 
 #define OFFSET_STRIDE		(9)
 
-#define dmar_writeq(a,v) writeq(v,a)
-#define dmar_writel(a, v) writel(v, a)
-
 #define DMAR_VER_MAJOR(v)		(((v) & 0xf0) >> 4)
 #define DMAR_VER_MINOR(v)		((v) & 0x0f)
 
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index ae8b5ed70f22..cd04c3f56eec 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1661,7 +1661,7 @@ static void __dmar_enable_qi(struct intel_iommu *iommu)
 	/* write zero to the tail reg */
 	writel(0, iommu->reg + DMAR_IQT_REG);
 
-	dmar_writeq(iommu->reg + DMAR_IQA_REG, val);
+	writeq(val, iommu->reg + DMAR_IQA_REG);
 
 	iommu->gcmd |= DMA_GCMD_QIE;
 	writel(iommu->gcmd, iommu->reg + DMAR_GCMD_REG);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4cb39000cd91..297415fe726d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -697,7 +697,7 @@ static void iommu_set_root_entry(struct intel_iommu *iommu)
 		addr |= DMA_RTADDR_SMT;
 
 	raw_spin_lock_irqsave(&iommu->register_lock, flag);
-	dmar_writeq(iommu->reg + DMAR_RTADDR_REG, addr);
+	writeq(addr, iommu->reg + DMAR_RTADDR_REG);
 
 	writel(iommu->gcmd | DMA_GCMD_SRTP, iommu->reg + DMAR_GCMD_REG);
 
@@ -765,7 +765,7 @@ static void __iommu_flush_context(struct intel_iommu *iommu,
 	val |= DMA_CCMD_ICC;
 
 	raw_spin_lock_irqsave(&iommu->register_lock, flag);
-	dmar_writeq(iommu->reg + DMAR_CCMD_REG, val);
+	writeq(val, iommu->reg + DMAR_CCMD_REG);
 
 	/* Make sure hardware complete it */
 	IOMMU_WAIT_OP(iommu, DMAR_CCMD_REG,
@@ -806,8 +806,8 @@ void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 	raw_spin_lock_irqsave(&iommu->register_lock, flag);
 	/* Note: Only uses first TLB reg currently */
 	if (val_iva)
-		dmar_writeq(iommu->reg + tlb_offset, val_iva);
-	dmar_writeq(iommu->reg + tlb_offset + 8, val);
+		writeq(val_iva, iommu->reg + tlb_offset);
+	writeq(val, iommu->reg + tlb_offset + 8);
 
 	/* Make sure hardware complete it */
 	IOMMU_WAIT_OP(iommu, tlb_offset + 8,
@@ -4201,8 +4201,8 @@ int ecmd_submit_sync(struct intel_iommu *iommu, u8 ecmd, u64 oa, u64 ob)
 	 * - It's not invoked in any critical path. The extra MMIO
 	 *   write doesn't bring any performance concerns.
 	 */
-	dmar_writeq(iommu->reg + DMAR_ECEO_REG, ob);
-	dmar_writeq(iommu->reg + DMAR_ECMD_REG, ecmd | (oa << DMA_ECMD_OA_SHIFT));
+	writeq(ob, iommu->reg + DMAR_ECEO_REG);
+	writeq(ecmd | (oa << DMA_ECMD_OA_SHIFT), iommu->reg + DMAR_ECMD_REG);
 
 	IOMMU_WAIT_OP(iommu, DMAR_ECRSP_REG, readq,
 		      !(res & DMA_ECMD_ECRSP_IP), res);
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 21e54e40a17f..25c26f706984 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -465,8 +465,8 @@ static void iommu_set_irq_remapping(struct intel_iommu *iommu, int mode)
 
 	raw_spin_lock_irqsave(&iommu->register_lock, flags);
 
-	dmar_writeq(iommu->reg + DMAR_IRTA_REG,
-		    (addr) | IR_X2APIC_MODE(mode) | INTR_REMAP_TABLE_REG_SIZE);
+	writeq((addr) | IR_X2APIC_MODE(mode) | INTR_REMAP_TABLE_REG_SIZE,
+	       iommu->reg + DMAR_IRTA_REG);
 
 	/* Set interrupt-remapping table pointer */
 	writel(iommu->gcmd | DMA_GCMD_SIRTP, iommu->reg + DMAR_GCMD_REG);
diff --git a/drivers/iommu/intel/perfmon.c b/drivers/iommu/intel/perfmon.c
index 3f75f567f210..eb1df7a9b3c7 100644
--- a/drivers/iommu/intel/perfmon.c
+++ b/drivers/iommu/intel/perfmon.c
@@ -99,20 +99,20 @@ IOMMU_PMU_ATTR(filter_page_table,	"config2:32-36",	IOMMU_PMU_FILTER_PAGE_TABLE);
 #define iommu_pmu_set_filter(_name, _config, _filter, _idx, _econfig)		\
 {										\
 	if ((iommu_pmu->filter & _filter) && iommu_pmu_en_##_name(_econfig)) {	\
-		dmar_writel(iommu_pmu->cfg_reg + _idx * IOMMU_PMU_CFG_OFFSET +	\
-			    IOMMU_PMU_CFG_SIZE +				\
-			    (ffs(_filter) - 1) * IOMMU_PMU_CFG_FILTERS_OFFSET,	\
-			    iommu_pmu_get_##_name(_config) | IOMMU_PMU_FILTER_EN);\
+		writel(iommu_pmu_get_##_name(_config) | IOMMU_PMU_FILTER_EN,	\
+		       iommu_pmu->cfg_reg + _idx * IOMMU_PMU_CFG_OFFSET +	\
+		       IOMMU_PMU_CFG_SIZE +					\
+		       (ffs(_filter) - 1) * IOMMU_PMU_CFG_FILTERS_OFFSET);	\
 	}									\
 }
 
 #define iommu_pmu_clear_filter(_filter, _idx)					\
 {										\
 	if (iommu_pmu->filter & _filter) {					\
-		dmar_writel(iommu_pmu->cfg_reg + _idx * IOMMU_PMU_CFG_OFFSET +	\
-			    IOMMU_PMU_CFG_SIZE +				\
-			    (ffs(_filter) - 1) * IOMMU_PMU_CFG_FILTERS_OFFSET,	\
-			    0);							\
+		writel(0,							\
+		       iommu_pmu->cfg_reg + _idx * IOMMU_PMU_CFG_OFFSET +	\
+		       IOMMU_PMU_CFG_SIZE +					\
+		       (ffs(_filter) - 1) * IOMMU_PMU_CFG_FILTERS_OFFSET);	\
 	}									\
 }
 
@@ -411,7 +411,7 @@ static int iommu_pmu_assign_event(struct iommu_pmu *iommu_pmu,
 	hwc->idx = idx;
 
 	/* config events */
-	dmar_writeq(iommu_config_base(iommu_pmu, idx), hwc->config);
+	writeq(hwc->config, iommu_config_base(iommu_pmu, idx));
 
 	iommu_pmu_set_filter(requester_id, event->attr.config1,
 			     IOMMU_PMU_FILTER_REQUESTER_ID, idx,
@@ -510,7 +510,7 @@ static void iommu_pmu_counter_overflow(struct iommu_pmu *iommu_pmu)
 			iommu_pmu_event_update(event);
 		}
 
-		dmar_writeq(iommu_pmu->overflow, status);
+		writeq(status, iommu_pmu->overflow);
 	}
 }
 
@@ -524,7 +524,7 @@ static irqreturn_t iommu_pmu_irq_handler(int irq, void *dev_id)
 	iommu_pmu_counter_overflow(iommu->pmu);
 
 	/* Clear the status bit */
-	dmar_writel(iommu->reg + DMAR_PERFINTRSTS_REG, DMA_PERFINTRSTS_PIS);
+	writel(DMA_PERFINTRSTS_PIS, iommu->reg + DMAR_PERFINTRSTS_REG);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
index c28fbd5c14a7..1460b57db129 100644
--- a/drivers/iommu/intel/prq.c
+++ b/drivers/iommu/intel/prq.c
@@ -259,7 +259,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
 
-	dmar_writeq(iommu->reg + DMAR_PQH_REG, tail);
+	writeq(tail, iommu->reg + DMAR_PQH_REG);
 
 	/*
 	 * Clear the page request overflow bit and wake up all threads that
@@ -325,9 +325,9 @@ int intel_iommu_enable_prq(struct intel_iommu *iommu)
 		       iommu->name);
 		goto free_iopfq;
 	}
-	dmar_writeq(iommu->reg + DMAR_PQH_REG, 0ULL);
-	dmar_writeq(iommu->reg + DMAR_PQT_REG, 0ULL);
-	dmar_writeq(iommu->reg + DMAR_PQA_REG, virt_to_phys(iommu->prq) | PRQ_ORDER);
+	writeq(0ULL, iommu->reg + DMAR_PQH_REG);
+	writeq(0ULL, iommu->reg + DMAR_PQT_REG);
+	writeq(virt_to_phys(iommu->prq) | PRQ_ORDER, iommu->reg + DMAR_PQA_REG);
 
 	init_completion(&iommu->prq_complete);
 
@@ -348,9 +348,9 @@ int intel_iommu_enable_prq(struct intel_iommu *iommu)
 
 int intel_iommu_finish_prq(struct intel_iommu *iommu)
 {
-	dmar_writeq(iommu->reg + DMAR_PQH_REG, 0ULL);
-	dmar_writeq(iommu->reg + DMAR_PQT_REG, 0ULL);
-	dmar_writeq(iommu->reg + DMAR_PQA_REG, 0ULL);
+	writeq(0ULL, iommu->reg + DMAR_PQH_REG);
+	writeq(0ULL, iommu->reg + DMAR_PQT_REG);
+	writeq(0ULL, iommu->reg + DMAR_PQA_REG);
 
 	if (iommu->pr_irq) {
 		free_irq(iommu->pr_irq, iommu);
-- 
2.43.0

