Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35E87F9
	for <iommu@lists.linux.dev>; Tue, 31 Jan 2023 07:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675151172; x=1706687172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B3q6XG1ZtMeVnG49oTwHx8Qg7xHy4IhXHyiS5c+KM90=;
  b=DzuM2lJAMiz74iwIJdxbVUeI1fONWpxiuK+wfa+GgNrfF8LTaLYsrnjV
   jREM7NjVNx/+cJ41muK/gXCH3E55oVYyChke77bVVOo5PsYENJp2YT0Hh
   bGhXf8PMAq2cBMv2yZiDp/5UkcfHFPofa4RTDR+lwjYOcatnbDjRbraMu
   ZT/KtGq8YySL+aUGVh3GancqNZ7UXK/VS+d8qwlIXHAvrw15tuVLwU76V
   Wl6V5+UVIuRcCFtSPzK13y0lZBk20eh34X1M3C+jHzhXgOSM3F1goww3P
   eCJzqLt5JBs3msRUtpFBisYDmZ4SPSqoAWT8BzpDAnrG0S62BhDtJn6sS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="315736647"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="315736647"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 23:46:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="657775580"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="657775580"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 30 Jan 2023 23:46:08 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: kan.liang@linux.intel.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] iommu/vt-d: Add IOMMU perfmon overflow handler support
Date: Tue, 31 Jan 2023 15:37:39 +0800
Message-Id: <20230131073740.378984-12-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131073740.378984-1-baolu.lu@linux.intel.com>
References: <20230131073740.378984-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

While enabled to count events and an event occurrence causes the counter
value to increment and roll over to or past zero, this is termed a
counter overflow. The overflow can trigger an interrupt. The IOMMU
perfmon needs to handle the case properly.

New HW IRQs are allocated for each IOMMU device for perfmon. The IRQ IDs
are after the SVM range.

In the overflow handler, the counter is not frozen. It's very unlikely
that the same counter overflows again during the period. But it's
possible that other counters overflow at the same time. Read the
overflow register at the end of the handler and check whether there are
more.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20230128200428.1459118-7-kan.liang@linux.intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h   | 11 ++++-
 drivers/iommu/intel/dmar.c    |  2 +
 drivers/iommu/intel/perfmon.c | 82 +++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/svm.c     |  2 +-
 4 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index d56b3c386366..d7c61eb20f6f 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -130,6 +130,8 @@
 #define DMAR_PERFCFGOFF_REG	0x310
 #define DMAR_PERFOVFOFF_REG	0x318
 #define DMAR_PERFCNTROFF_REG	0x31c
+#define DMAR_PERFINTRSTS_REG	0x324
+#define DMAR_PERFINTRCTL_REG	0x328
 #define DMAR_PERFEVNTCAP_REG	0x380
 #define DMAR_ECMD_REG		0x400
 #define DMAR_ECEO_REG		0x408
@@ -357,6 +359,9 @@
 
 #define DMA_VCS_PAS	((u64)1)
 
+/* PERFINTRSTS_REG */
+#define DMA_PERFINTRSTS_PIS	((u32)1)
+
 #define IOMMU_WAIT_OP(iommu, offset, op, cond, sts)			\
 do {									\
 	cycles_t start_time = get_cycles();				\
@@ -635,8 +640,12 @@ struct iommu_pmu {
 	struct pmu		pmu;
 	DECLARE_BITMAP(used_mask, IOMMU_PMU_IDX_MAX);
 	struct perf_event	*event_list[IOMMU_PMU_IDX_MAX];
+	unsigned char		irq_name[16];
 };
 
+#define IOMMU_IRQ_ID_OFFSET_PRQ		(DMAR_UNITS_SUPPORTED)
+#define IOMMU_IRQ_ID_OFFSET_PERF	(2 * DMAR_UNITS_SUPPORTED)
+
 struct intel_iommu {
 	void __iomem	*reg; /* Pointer to hardware regs, virtual addr */
 	u64 		reg_phys; /* physical address of hw register set */
@@ -650,7 +659,7 @@ struct intel_iommu {
 	int		seq_id;	/* sequence id of the iommu */
 	int		agaw; /* agaw of this iommu */
 	int		msagaw; /* max sagaw of this iommu */
-	unsigned int 	irq, pr_irq;
+	unsigned int	irq, pr_irq, perf_irq;
 	u16		segment;     /* PCI segment# */
 	unsigned char 	name[13];    /* Device Name */
 
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 0e429bab436f..43db6ebe8b57 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1879,6 +1879,8 @@ static inline int dmar_msi_reg(struct intel_iommu *iommu, int irq)
 		return DMAR_FECTL_REG;
 	else if (iommu->pr_irq == irq)
 		return DMAR_PECTL_REG;
+	else if (iommu->perf_irq == irq)
+		return DMAR_PERFINTRCTL_REG;
 	else
 		BUG();
 }
diff --git a/drivers/iommu/intel/perfmon.c b/drivers/iommu/intel/perfmon.c
index 322d362b85e4..e17d9743a0d8 100644
--- a/drivers/iommu/intel/perfmon.c
+++ b/drivers/iommu/intel/perfmon.c
@@ -505,6 +505,49 @@ static void iommu_pmu_disable(struct pmu *pmu)
 	ecmd_submit_sync(iommu, DMA_ECMD_FREEZE, 0, 0);
 }
 
+static void iommu_pmu_counter_overflow(struct iommu_pmu *iommu_pmu)
+{
+	struct perf_event *event;
+	u64 status;
+	int i;
+
+	/*
+	 * Two counters may be overflowed very close. Always check
+	 * whether there are more to handle.
+	 */
+	while ((status = dmar_readq(iommu_pmu->overflow))) {
+		for_each_set_bit(i, (unsigned long *)&status, iommu_pmu->num_cntr) {
+			/*
+			 * Find the assigned event of the counter.
+			 * Accumulate the value into the event->count.
+			 */
+			event = iommu_pmu->event_list[i];
+			if (!event) {
+				pr_warn_once("Cannot find the assigned event for counter %d\n", i);
+				continue;
+			}
+			iommu_pmu_event_update(event);
+		}
+
+		dmar_writeq(iommu_pmu->overflow, status);
+	}
+}
+
+static irqreturn_t iommu_pmu_irq_handler(int irq, void *dev_id)
+{
+	struct intel_iommu *iommu = dev_id;
+
+	if (!dmar_readl(iommu->reg + DMAR_PERFINTRSTS_REG))
+		return IRQ_NONE;
+
+	iommu_pmu_counter_overflow(iommu->pmu);
+
+	/* Clear the status bit */
+	dmar_writel(iommu->reg + DMAR_PERFINTRSTS_REG, DMA_PERFINTRSTS_PIS);
+
+	return IRQ_HANDLED;
+}
+
 static int __iommu_pmu_register(struct intel_iommu *iommu)
 {
 	struct iommu_pmu *iommu_pmu = iommu->pmu;
@@ -698,6 +741,38 @@ void free_iommu_pmu(struct intel_iommu *iommu)
 	iommu->pmu = NULL;
 }
 
+static int iommu_pmu_set_interrupt(struct intel_iommu *iommu)
+{
+	struct iommu_pmu *iommu_pmu = iommu->pmu;
+	int irq, ret;
+
+	irq = dmar_alloc_hwirq(IOMMU_IRQ_ID_OFFSET_PERF + iommu->seq_id, iommu->node, iommu);
+	if (irq <= 0)
+		return -EINVAL;
+
+	snprintf(iommu_pmu->irq_name, sizeof(iommu_pmu->irq_name), "dmar%d-perf", iommu->seq_id);
+
+	iommu->perf_irq = irq;
+	ret = request_threaded_irq(irq, NULL, iommu_pmu_irq_handler,
+				   IRQF_ONESHOT, iommu_pmu->irq_name, iommu);
+	if (ret) {
+		dmar_free_hwirq(irq);
+		iommu->perf_irq = 0;
+		return ret;
+	}
+	return 0;
+}
+
+static void iommu_pmu_unset_interrupt(struct intel_iommu *iommu)
+{
+	if (!iommu->perf_irq)
+		return;
+
+	free_irq(iommu->perf_irq, iommu);
+	dmar_free_hwirq(iommu->perf_irq);
+	iommu->perf_irq = 0;
+}
+
 static int iommu_pmu_cpu_online(unsigned int cpu)
 {
 	if (cpumask_empty(&iommu_pmu_cpu_mask))
@@ -774,8 +849,14 @@ void iommu_pmu_register(struct intel_iommu *iommu)
 	if (iommu_pmu_cpuhp_setup(iommu_pmu))
 		goto unregister;
 
+	/* Set interrupt for overflow */
+	if (iommu_pmu_set_interrupt(iommu))
+		goto cpuhp_free;
+
 	return;
 
+cpuhp_free:
+	iommu_pmu_cpuhp_free(iommu_pmu);
 unregister:
 	perf_pmu_unregister(&iommu_pmu->pmu);
 err:
@@ -790,6 +871,7 @@ void iommu_pmu_unregister(struct intel_iommu *iommu)
 	if (!iommu_pmu)
 		return;
 
+	iommu_pmu_unset_interrupt(iommu);
 	iommu_pmu_cpuhp_free(iommu_pmu);
 	perf_pmu_unregister(&iommu_pmu->pmu);
 }
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index e7b9bedebcc0..7367f56c3bad 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -78,7 +78,7 @@ int intel_svm_enable_prq(struct intel_iommu *iommu)
 	}
 	iommu->prq = page_address(pages);
 
-	irq = dmar_alloc_hwirq(DMAR_UNITS_SUPPORTED + iommu->seq_id, iommu->node, iommu);
+	irq = dmar_alloc_hwirq(IOMMU_IRQ_ID_OFFSET_PRQ + iommu->seq_id, iommu->node, iommu);
 	if (irq <= 0) {
 		pr_err("IOMMU: %s: Failed to create IRQ vector for page request queue\n",
 		       iommu->name);
-- 
2.34.1

