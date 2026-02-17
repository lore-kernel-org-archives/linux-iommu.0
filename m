Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081242FBDE6;
	Tue, 17 Feb 2026 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771364686; cv=none; b=LrC6uZnjvbK52s5Lo5wq6mbcYjfMXjZp6dvi7dwNiYqkzRlpcN1hHB/MHboGRKPgKX6d+o+FXVpKaup5mMofG+24Xnsqm8+eNZsxZa+iLy/9QpC4z+FZ64PvkRWa+sY+Q/BmIoKD2zO9Df17yXZHsEomP/slVrV6VQtpo3etGF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771364686; c=relaxed/simple;
	bh=4yTaEXfbRHgMUg/EPCb/UmCBX1c5hSX7ilmhvdL8UrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvEK7UP69a4rqeLSeeOTLZ8Jv1TNYNRUP9eWa52D2qqQuH41nCeCJF7SnPvHGbIGwWXmzRCwWwChQSvK8yPVYTNcquW/HrsFEVA+GMR6N+wOBAV74HScOVoWdnCJmNwDgbbWf+vUfmjKkgeO4gZn4s+3GYlHtOnuBIXlecc84u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZWXgH8f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZWXgH8f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A21C4CEF7;
	Tue, 17 Feb 2026 21:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771364685;
	bh=4yTaEXfbRHgMUg/EPCb/UmCBX1c5hSX7ilmhvdL8UrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mZWXgH8f0cfyyBf7AGzr5A10XexziIiLwycqNYQbYqM6L1yIMNBkV/b8HpfFGyIMO
	 Wh3QZpKApOcSHaA0yGvXNdy+AooT4xJNLP0dT0+qr1K7TsWzuwx93GKYqrP0qMU1t5
	 vUYbOLc9pw543wGgaumfL9yWzd0sj5j1C1QKI/xJwEwQL8Wu2rIxO5KlzBvOJe9PmM
	 vBf0ePdWRnsFtWXe2C9e7aDXvMSBXFbK71kJ1W1FGXyjCq7BBS7W7ta5LjyzRj0ZTt
	 fX62ocZwUBaOZWN0wf4WpeAFdiHkoxCXjHQOVeJF0ZBce516NBDspvduHzSfYqOsVI
	 WULipiHcSFc+A==
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 2/2] iommu/vt-d: Remove dmar_writel() and dmar_writeq()
Date: Tue, 17 Feb 2026 15:44:38 -0600
Message-ID: <20260217214438.3395039-3-bhelgaas@google.com>
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

dmar_writel() and dmar_writeq() do nothing other than expand to the generic
writel() and writeq(), and the dmar_write*() wrappers are used
inconsistently.

Remove the dmar_write*() wrappers and use writel() and writeq() directly.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/iommu/intel/dmar.c          |  2 +-
 drivers/iommu/intel/iommu.c         | 12 ++++++------
 drivers/iommu/intel/iommu.h         |  3 ---
 drivers/iommu/intel/irq_remapping.c |  4 ++--
 drivers/iommu/intel/perfmon.c       | 22 +++++++++++-----------
 drivers/iommu/intel/prq.c           | 14 +++++++-------
 6 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 96d9878b9eb6..44d8361d2480 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1662,7 +1662,7 @@ static void __dmar_enable_qi(struct intel_iommu *iommu)
 	/* write zero to the tail reg */
 	writel(0, iommu->reg + DMAR_IQT_REG);
 
-	dmar_writeq(iommu->reg + DMAR_IQA_REG, val);
+	writeq(val, iommu->reg + DMAR_IQA_REG);
 
 	iommu->gcmd |= DMA_GCMD_QIE;
 	writel(iommu->gcmd, iommu->reg + DMAR_GCMD_REG);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 64284938e1ce..e75ce8d28be6 100644
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
@@ -4198,8 +4198,8 @@ int ecmd_submit_sync(struct intel_iommu *iommu, u8 ecmd, u64 oa, u64 ob)
 	 * - It's not invoked in any critical path. The extra MMIO
 	 *   write doesn't bring any performance concerns.
 	 */
-	dmar_writeq(iommu->reg + DMAR_ECEO_REG, ob);
-	dmar_writeq(iommu->reg + DMAR_ECMD_REG, ecmd | (oa << DMA_ECMD_OA_SHIFT));
+	writeq(ob, iommu->reg + DMAR_ECEO_REG);
+	writeq(ecmd | (oa << DMA_ECMD_OA_SHIFT), iommu->reg + DMAR_ECMD_REG);
 
 	IOMMU_WAIT_OP(iommu, DMAR_ECRSP_REG, readq,
 		      !(res & DMA_ECMD_ECRSP_IP), res);
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
 
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 3fce6efea524..ad3a8a42f70c 100644
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
index 30bd684612ad..84f5ef2c42d8 100644
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
2.51.0

