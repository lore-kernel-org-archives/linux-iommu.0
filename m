Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0412F90DB;
	Tue, 17 Feb 2026 21:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771364684; cv=none; b=PYZIm41D5/Hr5b2l64EtdVqmhIN8AAcX4bF0RQpcucBEg1k9x3RkVh3tNn9ExylrGwDQ96fL8V2S3L5QnFvG70tziwIYz6fm8n4YXxfE4x0V/57IlJ+SDjO2qvEqZzYdkCK3oF//mPR8vIkrlpTMv7AjLTHNq9xChdE+rCz/p4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771364684; c=relaxed/simple;
	bh=llZUjlDMs25pO5tBk7X48ivlpnyYwNP0g+Z4tYEfbN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUjRPRLRpbdwwe+pmL69U+C1ztS0Bk+eYQnyWfSnICHvSQZXtvcN7kuz11DVFTiyqmJqU59S+5YIrguD84/pgPO0E+GizA0salHjnVdC2AHcphV2XOzDHP1UHZiMaXLOU2FUkwNc+V1clhIQfGh5Fca/thGlGClp2BW136nDEG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIPsKrdj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIPsKrdj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F124C4CEF7;
	Tue, 17 Feb 2026 21:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771364684;
	bh=llZUjlDMs25pO5tBk7X48ivlpnyYwNP0g+Z4tYEfbN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bIPsKrdjMM58zDt2bRZdcQYmAqDCDUeAcAcW+F2TmBN98HikhDDQ7IY+l9zsKQ7TT
	 LhSYgqJQfEvjiNFurjb/Jh4qu8OmUiOZfV6dKSktQleoijUxCqINYnlczqq+9jOzHS
	 seRHmmOYNrVsbjCYRDdyu13d5f46/i1FMEW9JM+kWjtfRChEGcszTpokqcGbzFjg4W
	 j6O85nCgcRsgDpBXHe/wNhvZcU6mTWlb8tz8M/qR8MsY5XPACxN2rLmF8sP/vhinKk
	 YvYpzNP8qK9gh5+qNGV7iX6u8stoSsyaj40s6UczlNe+Om7m1h29sNmht4c1XOa1NT
	 DO0zevMKtHuaA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 1/2] iommu/vt-d: Remove dmar_readl() and dmar_readq()
Date: Tue, 17 Feb 2026 15:44:37 -0600
Message-ID: <20260217214438.3395039-2-bhelgaas@google.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217214438.3395039-1-bhelgaas@google.com>
References: <20260217214438.3395039-1-bhelgaas@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dmar_readl() and dmar_readq() do nothing other than expand to the generic
readl() and readq(), and the dmar_read*() wrappers are used inconsistently.

Remove the dmar_read*() wrappers and use readl() and readq() directly.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/iommu/intel/debugfs.c       | 18 +++++++++---------
 drivers/iommu/intel/dmar.c          | 22 +++++++++++-----------
 drivers/iommu/intel/iommu.c         | 10 +++++-----
 drivers/iommu/intel/iommu.h         |  2 --
 drivers/iommu/intel/irq_remapping.c |  2 +-
 drivers/iommu/intel/perfmon.c       | 28 ++++++++++++++--------------
 drivers/iommu/intel/prq.c           | 12 ++++++------
 7 files changed, 46 insertions(+), 48 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 617fd81a80f0..21e4e465ca58 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -133,13 +133,13 @@ static int iommu_regset_show(struct seq_file *m, void *unused)
 		 */
 		raw_spin_lock_irqsave(&iommu->register_lock, flag);
 		for (i = 0 ; i < ARRAY_SIZE(iommu_regs_32); i++) {
-			value = dmar_readl(iommu->reg + iommu_regs_32[i].offset);
+			value = readl(iommu->reg + iommu_regs_32[i].offset);
 			seq_printf(m, "%-16s\t0x%02x\t\t0x%016llx\n",
 				   iommu_regs_32[i].regs, iommu_regs_32[i].offset,
 				   value);
 		}
 		for (i = 0 ; i < ARRAY_SIZE(iommu_regs_64); i++) {
-			value = dmar_readq(iommu->reg + iommu_regs_64[i].offset);
+			value = readq(iommu->reg + iommu_regs_64[i].offset);
 			seq_printf(m, "%-16s\t0x%02x\t\t0x%016llx\n",
 				   iommu_regs_64[i].regs, iommu_regs_64[i].offset,
 				   value);
@@ -247,7 +247,7 @@ static void ctx_tbl_walk(struct seq_file *m, struct intel_iommu *iommu, u16 bus)
 		tbl_wlk.ctx_entry = context;
 		m->private = &tbl_wlk;
 
-		if (dmar_readq(iommu->reg + DMAR_RTADDR_REG) & DMA_RTADDR_SMT) {
+		if (readq(iommu->reg + DMAR_RTADDR_REG) & DMA_RTADDR_SMT) {
 			pasid_dir_ptr = context->lo & VTD_PAGE_MASK;
 			pasid_dir_size = get_pasid_dir_size(context);
 			pasid_dir_walk(m, pasid_dir_ptr, pasid_dir_size);
@@ -285,7 +285,7 @@ static int dmar_translation_struct_show(struct seq_file *m, void *unused)
 
 	rcu_read_lock();
 	for_each_active_iommu(iommu, drhd) {
-		sts = dmar_readl(iommu->reg + DMAR_GSTS_REG);
+		sts = readl(iommu->reg + DMAR_GSTS_REG);
 		if (!(sts & DMA_GSTS_TES)) {
 			seq_printf(m, "DMA Remapping is not enabled on %s\n",
 				   iommu->name);
@@ -364,13 +364,13 @@ static int domain_translation_struct_show(struct seq_file *m,
 		if (seg != iommu->segment)
 			continue;
 
-		sts = dmar_readl(iommu->reg + DMAR_GSTS_REG);
+		sts = readl(iommu->reg + DMAR_GSTS_REG);
 		if (!(sts & DMA_GSTS_TES)) {
 			seq_printf(m, "DMA Remapping is not enabled on %s\n",
 				   iommu->name);
 			continue;
 		}
-		if (dmar_readq(iommu->reg + DMAR_RTADDR_REG) & DMA_RTADDR_SMT)
+		if (readq(iommu->reg + DMAR_RTADDR_REG) & DMA_RTADDR_SMT)
 			scalable = true;
 		else
 			scalable = false;
@@ -538,8 +538,8 @@ static int invalidation_queue_show(struct seq_file *m, void *unused)
 		raw_spin_lock_irqsave(&qi->q_lock, flags);
 		seq_printf(m, " Base: 0x%llx\tHead: %lld\tTail: %lld\n",
 			   (u64)virt_to_phys(qi->desc),
-			   dmar_readq(iommu->reg + DMAR_IQH_REG) >> shift,
-			   dmar_readq(iommu->reg + DMAR_IQT_REG) >> shift);
+			   readq(iommu->reg + DMAR_IQH_REG) >> shift,
+			   readq(iommu->reg + DMAR_IQT_REG) >> shift);
 		invalidation_queue_entry_show(m, iommu);
 		raw_spin_unlock_irqrestore(&qi->q_lock, flags);
 		seq_putc(m, '\n');
@@ -620,7 +620,7 @@ static int ir_translation_struct_show(struct seq_file *m, void *unused)
 		seq_printf(m, "Remapped Interrupt supported on IOMMU: %s\n",
 			   iommu->name);
 
-		sts = dmar_readl(iommu->reg + DMAR_GSTS_REG);
+		sts = readl(iommu->reg + DMAR_GSTS_REG);
 		if (iommu->ir_table && (sts & DMA_GSTS_IRES)) {
 			irta = virt_to_phys(iommu->ir_table->base);
 			seq_printf(m, " IR table address:%llx\n", irta);
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index ec975c73cfe6..96d9878b9eb6 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -899,8 +899,8 @@ dmar_validate_one_drhd(struct acpi_dmar_header *entry, void *arg)
 		return -EINVAL;
 	}
 
-	cap = dmar_readq(addr + DMAR_CAP_REG);
-	ecap = dmar_readq(addr + DMAR_ECAP_REG);
+	cap = readq(addr + DMAR_CAP_REG);
+	ecap = readq(addr + DMAR_ECAP_REG);
 
 	if (arg)
 		iounmap(addr);
@@ -982,8 +982,8 @@ static int map_iommu(struct intel_iommu *iommu, struct dmar_drhd_unit *drhd)
 		goto release;
 	}
 
-	iommu->cap = dmar_readq(iommu->reg + DMAR_CAP_REG);
-	iommu->ecap = dmar_readq(iommu->reg + DMAR_ECAP_REG);
+	iommu->cap = readq(iommu->reg + DMAR_CAP_REG);
+	iommu->ecap = readq(iommu->reg + DMAR_ECAP_REG);
 
 	if (iommu->cap == (uint64_t)-1 && iommu->ecap == (uint64_t)-1) {
 		err = -EINVAL;
@@ -1017,8 +1017,8 @@ static int map_iommu(struct intel_iommu *iommu, struct dmar_drhd_unit *drhd)
 		int i;
 
 		for (i = 0; i < DMA_MAX_NUM_ECMDCAP; i++) {
-			iommu->ecmdcap[i] = dmar_readq(iommu->reg + DMAR_ECCAP_REG +
-						       i * DMA_ECMD_REG_STEP);
+			iommu->ecmdcap[i] = readq(iommu->reg + DMAR_ECCAP_REG +
+						  i * DMA_ECMD_REG_STEP);
 		}
 	}
 
@@ -1239,8 +1239,8 @@ static const char *qi_type_string(u8 type)
 
 static void qi_dump_fault(struct intel_iommu *iommu, u32 fault)
 {
-	unsigned int head = dmar_readl(iommu->reg + DMAR_IQH_REG);
-	u64 iqe_err = dmar_readq(iommu->reg + DMAR_IQER_REG);
+	unsigned int head = readl(iommu->reg + DMAR_IQH_REG);
+	u64 iqe_err = readq(iommu->reg + DMAR_IQER_REG);
 	struct qi_desc *desc = iommu->qi->desc + head;
 
 	if (fault & DMA_FSTS_IQE)
@@ -1322,7 +1322,7 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 		 * SID field is valid only when the ITE field is Set in FSTS_REG
 		 * see Intel VT-d spec r4.1, section 11.4.9.9
 		 */
-		iqe_err = dmar_readq(iommu->reg + DMAR_IQER_REG);
+		iqe_err = readq(iommu->reg + DMAR_IQER_REG);
 		ite_sid = DMAR_IQER_REG_ITESID(iqe_err);
 
 		writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG);
@@ -1981,8 +1981,8 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
 			source_id = dma_frcd_source_id(data);
 
 			pasid_present = dma_frcd_pasid_present(data);
-			guest_addr = dmar_readq(iommu->reg + reg +
-					fault_index * PRIMARY_FAULT_REG_LEN);
+			guest_addr = readq(iommu->reg + reg +
+					   fault_index * PRIMARY_FAULT_REG_LEN);
 			guest_addr = dma_frcd_page_addr(guest_addr);
 		}
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 705828b06e32..64284938e1ce 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -769,7 +769,7 @@ static void __iommu_flush_context(struct intel_iommu *iommu,
 
 	/* Make sure hardware complete it */
 	IOMMU_WAIT_OP(iommu, DMAR_CCMD_REG,
-		dmar_readq, (!(val & DMA_CCMD_ICC)), val);
+		readq, (!(val & DMA_CCMD_ICC)), val);
 
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 }
@@ -811,7 +811,7 @@ void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 
 	/* Make sure hardware complete it */
 	IOMMU_WAIT_OP(iommu, tlb_offset + 8,
-		dmar_readq, (!(val & DMA_TLB_IVT)), val);
+		readq, (!(val & DMA_TLB_IVT)), val);
 
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 
@@ -1533,7 +1533,7 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 	int bus, ret;
 	bool new_ext, ext;
 
-	rtaddr_reg = dmar_readq(iommu->reg + DMAR_RTADDR_REG);
+	rtaddr_reg = readq(iommu->reg + DMAR_RTADDR_REG);
 	ext        = !!(rtaddr_reg & DMA_RTADDR_SMT);
 	new_ext    = !!sm_supported(iommu);
 
@@ -4185,7 +4185,7 @@ int ecmd_submit_sync(struct intel_iommu *iommu, u8 ecmd, u64 oa, u64 ob)
 
 	raw_spin_lock_irqsave(&iommu->register_lock, flags);
 
-	res = dmar_readq(iommu->reg + DMAR_ECRSP_REG);
+	res = readq(iommu->reg + DMAR_ECRSP_REG);
 	if (res & DMA_ECMD_ECRSP_IP) {
 		ret = -EBUSY;
 		goto err;
@@ -4201,7 +4201,7 @@ int ecmd_submit_sync(struct intel_iommu *iommu, u8 ecmd, u64 oa, u64 ob)
 	dmar_writeq(iommu->reg + DMAR_ECEO_REG, ob);
 	dmar_writeq(iommu->reg + DMAR_ECMD_REG, ecmd | (oa << DMA_ECMD_OA_SHIFT));
 
-	IOMMU_WAIT_OP(iommu, DMAR_ECRSP_REG, dmar_readq,
+	IOMMU_WAIT_OP(iommu, DMAR_ECRSP_REG, readq,
 		      !(res & DMA_ECMD_ECRSP_IP), res);
 
 	if (res & DMA_ECMD_ECRSP_IP) {
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 599913fb65d5..dbd8d196d154 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -148,9 +148,7 @@
 
 #define OFFSET_STRIDE		(9)
 
-#define dmar_readq(a) readq(a)
 #define dmar_writeq(a,v) writeq(v,a)
-#define dmar_readl(a) readl(a)
 #define dmar_writel(a, v) writel(v, a)
 
 #define DMAR_VER_MAJOR(v)		(((v) & 0xf0) >> 4)
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index ecb591e98565..3fce6efea524 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -422,7 +422,7 @@ static int iommu_load_old_irte(struct intel_iommu *iommu)
 	u64 irta;
 
 	/* Check whether the old ir-table has the same size as ours */
-	irta = dmar_readq(iommu->reg + DMAR_IRTA_REG);
+	irta = readq(iommu->reg + DMAR_IRTA_REG);
 	if ((irta & INTR_REMAP_TABLE_REG_SIZE_MASK)
 	     != INTR_REMAP_TABLE_REG_SIZE)
 		return -EINVAL;
diff --git a/drivers/iommu/intel/perfmon.c b/drivers/iommu/intel/perfmon.c
index 75f493bcb353..30bd684612ad 100644
--- a/drivers/iommu/intel/perfmon.c
+++ b/drivers/iommu/intel/perfmon.c
@@ -307,7 +307,7 @@ static void iommu_pmu_event_update(struct perf_event *event)
 
 again:
 	prev_count = local64_read(&hwc->prev_count);
-	new_count = dmar_readq(iommu_event_base(iommu_pmu, hwc->idx));
+	new_count = readq(iommu_event_base(iommu_pmu, hwc->idx));
 	if (local64_xchg(&hwc->prev_count, new_count) != prev_count)
 		goto again;
 
@@ -340,7 +340,7 @@ static void iommu_pmu_start(struct perf_event *event, int flags)
 	hwc->state = 0;
 
 	/* Always reprogram the period */
-	count = dmar_readq(iommu_event_base(iommu_pmu, hwc->idx));
+	count = readq(iommu_event_base(iommu_pmu, hwc->idx));
 	local64_set((&hwc->prev_count), count);
 
 	/*
@@ -496,7 +496,7 @@ static void iommu_pmu_counter_overflow(struct iommu_pmu *iommu_pmu)
 	 * Two counters may be overflowed very close. Always check
 	 * whether there are more to handle.
 	 */
-	while ((status = dmar_readq(iommu_pmu->overflow))) {
+	while ((status = readq(iommu_pmu->overflow))) {
 		for_each_set_bit(i, (unsigned long *)&status, iommu_pmu->num_cntr) {
 			/*
 			 * Find the assigned event of the counter.
@@ -518,7 +518,7 @@ static irqreturn_t iommu_pmu_irq_handler(int irq, void *dev_id)
 {
 	struct intel_iommu *iommu = dev_id;
 
-	if (!dmar_readl(iommu->reg + DMAR_PERFINTRSTS_REG))
+	if (!readl(iommu->reg + DMAR_PERFINTRSTS_REG))
 		return IRQ_NONE;
 
 	iommu_pmu_counter_overflow(iommu->pmu);
@@ -555,7 +555,7 @@ static int __iommu_pmu_register(struct intel_iommu *iommu)
 static inline void __iomem *
 get_perf_reg_address(struct intel_iommu *iommu, u32 offset)
 {
-	u32 off = dmar_readl(iommu->reg + offset);
+	u32 off = readl(iommu->reg + offset);
 
 	return iommu->reg + off;
 }
@@ -574,7 +574,7 @@ int alloc_iommu_pmu(struct intel_iommu *iommu)
 	if (!cap_ecmds(iommu->cap))
 		return -ENODEV;
 
-	perfcap = dmar_readq(iommu->reg + DMAR_PERFCAP_REG);
+	perfcap = readq(iommu->reg + DMAR_PERFCAP_REG);
 	/* The performance monitoring is not supported. */
 	if (!perfcap)
 		return -ENODEV;
@@ -617,8 +617,8 @@ int alloc_iommu_pmu(struct intel_iommu *iommu)
 	for (i = 0; i < iommu_pmu->num_eg; i++) {
 		u64 pcap;
 
-		pcap = dmar_readq(iommu->reg + DMAR_PERFEVNTCAP_REG +
-				  i * IOMMU_PMU_CAP_REGS_STEP);
+		pcap = readq(iommu->reg + DMAR_PERFEVNTCAP_REG +
+			     i * IOMMU_PMU_CAP_REGS_STEP);
 		iommu_pmu->evcap[i] = pecap_es(pcap);
 	}
 
@@ -651,9 +651,9 @@ int alloc_iommu_pmu(struct intel_iommu *iommu)
 	 * Width.
 	 */
 	for (i = 0; i < iommu_pmu->num_cntr; i++) {
-		cap = dmar_readl(iommu_pmu->cfg_reg +
-				 i * IOMMU_PMU_CFG_OFFSET +
-				 IOMMU_PMU_CFG_CNTRCAP_OFFSET);
+		cap = readl(iommu_pmu->cfg_reg +
+			    i * IOMMU_PMU_CFG_OFFSET +
+			    IOMMU_PMU_CFG_CNTRCAP_OFFSET);
 		if (!iommu_cntrcap_pcc(cap))
 			continue;
 
@@ -675,9 +675,9 @@ int alloc_iommu_pmu(struct intel_iommu *iommu)
 
 		/* Override with per-counter event capabilities */
 		for (j = 0; j < iommu_cntrcap_egcnt(cap); j++) {
-			cap = dmar_readl(iommu_pmu->cfg_reg + i * IOMMU_PMU_CFG_OFFSET +
-					 IOMMU_PMU_CFG_CNTREVCAP_OFFSET +
-					 (j * IOMMU_PMU_OFF_REGS_STEP));
+			cap = readl(iommu_pmu->cfg_reg + i * IOMMU_PMU_CFG_OFFSET +
+				    IOMMU_PMU_CFG_CNTREVCAP_OFFSET +
+				    (j * IOMMU_PMU_OFF_REGS_STEP));
 			iommu_pmu->cntr_evcap[i][iommu_event_group(cap)] = iommu_event_select(cap);
 			/*
 			 * Some events may only be supported by a specific counter.
diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
index ff63c228e6e1..c28fbd5c14a7 100644
--- a/drivers/iommu/intel/prq.c
+++ b/drivers/iommu/intel/prq.c
@@ -81,8 +81,8 @@ void intel_iommu_drain_pasid_prq(struct device *dev, u32 pasid)
 	 */
 prq_retry:
 	reinit_completion(&iommu->prq_complete);
-	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
-	head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
+	tail = readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
+	head = readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
 	while (head != tail) {
 		struct page_req_dsc *req;
 
@@ -208,8 +208,8 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 	 */
 	writel(DMA_PRS_PPR, iommu->reg + DMAR_PRS_REG);
 
-	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
-	head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
+	tail = readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
+	head = readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
 	handled = (head != tail);
 	while (head != tail) {
 		req = &iommu->prq[head / sizeof(*req)];
@@ -268,8 +268,8 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 	if (readl(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PRO) {
 		pr_info_ratelimited("IOMMU: %s: PRQ overflow detected\n",
 				    iommu->name);
-		head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
-		tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
+		head = readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
+		tail = readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
 		if (head == tail) {
 			iopf_queue_discard_partial(iommu->iopf_queue);
 			writel(DMA_PRS_PRO, iommu->reg + DMAR_PRS_REG);
-- 
2.51.0

