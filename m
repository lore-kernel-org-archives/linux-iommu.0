Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BB0156C47
	for <iommu@lists.linux.dev>; Wed,  3 Apr 2024 23:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712187686; cv=none; b=Tf4mY+Jp2CLdj2ReYjlfiBFjwxbhvM1WMJD4R3ASUDdVD1VK4aKaQI4ymX8Ghvcn3kMsYj6kCAK2+xoS/isbGpziP1mAIUMZLbdnyGY6ow7MWEPT0q2XsRpp1tNXe21yuu2Fz5Hmsd/4/R1KbYvBCKzTEVB/A6zXr9QW4WZL9uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712187686; c=relaxed/simple;
	bh=R0NMhwyttFNi30mNMusJuV2if3D+ISCNB1cUl8jQ7g8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sZarE33EweTrHfZyz6N6KMJz65gI3RbjtHrwckgDdG6AtmgdZ8YtGiaJnWuWFKNTaaS//4c0MT93xDup3UXJOlpUBqtNPdxC0U47pFNR+CYKtKkQ7hzL/1454lZ2uGDGLplj8iqeLrm4zREMCZFM1lkCya4YIIrWJPjaQx4pW1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iasPQvtT; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iasPQvtT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712187685; x=1743723685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R0NMhwyttFNi30mNMusJuV2if3D+ISCNB1cUl8jQ7g8=;
  b=iasPQvtTQYgpfBx8bwGkFCejzAk03pZrYtLMNIhf5TseDywJT9nd9hW/
   /GEVb8NAJq59JRI52p+vi0tzBxxjqdir9HHTF3N4eysnYWevoKNpI8O1+
   +flvfVdjq9+ThasYgIbzhRN0FaR9KPdCmWG3m3J8qhKQ5KoXf++QIS2Gt
   /uvluVtcoMJdkKF8jmVJyqloN42AIzTmPiTqk837PhOIHPN1MXNin9SeM
   pJ/MDViMv1h5i3arzTGxsyaiXcLEW95w0JsRWQNG4oyUtL7gL9gBGlVpX
   EInfBedzKOg2Zx5+rHX0kSd0uG1LbgnrU9IazTn94JOBOCMEsT4FlcMrN
   Q==;
X-CSE-ConnectionGUID: YlnHqpZmQlCvfz85lwWdFQ==
X-CSE-MsgGUID: jxdo8ORpSxCbL2R922Ik2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="10419005"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="10419005"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 16:41:24 -0700
X-CSE-ConnectionGUID: Q10ReuZnTZe7oJMWgT0BxA==
X-CSE-MsgGUID: 5abMbITQTraYkx/CpSsmxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="19052516"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by orviesa006.jf.intel.com with ESMTP; 03 Apr 2024 16:41:24 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: sivanich@hpe.com,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	steve.wahl@hpe.com,
	russ.anderson@hpe.com,
	Peter Zijlstra <peterz@infradead.org>,
	"Will Deacon" <will@kernel.org>,
	"Robin Murphy" <robin.murphy@arm.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 2/2] iommu/vt-d: Share DMAR fault IRQ to prevent vector exhaustion
Date: Wed,  3 Apr 2024 16:45:48 -0700
Message-Id: <20240403234548.989061-2-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240403234548.989061-1-jacob.jun.pan@linux.intel.com>
References: <20240403234548.989061-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DMAR fault interrupt is used for per-IOMMU unrecoverable fault reporting,
it occurs only if there is a kernel programming error or serious hardware
failure. In other words, they should never occur under normal circumstances.

However, we are permanently occupying IRQ vectors per DMAR unit. On a
dual-socket Saphire Rapids system, DMAR fault interrupts can consume 16
vectors on BSP, which can lead to vector exhaustion. The effort to spread
vectors to each socket only partially alleviates the problem.

This patch leverages the shared IRQ mechanism such that only a single IRQ
vector is consumed for all the DMAR units on a system. When any DMAR faults
occur, all DMAR handlers are called to check their own fault records.

After this patch /proc/interrupts will show the list of DMAR units that share
the fault interrupt, e.g.

24 DMAR-MSI   14-edge      dmar14, dmar13, dmar12, dmar11, dmar10, dmar9,
dmar8, dmar7, dmar6, dmar5, dmar4, dmar3, dmar2, dmar1, dmar0, dmar15

Link: https://lore.kernel.org/lkml/20240325115638.342716e5@jacob-builder/t/#mc08892e405456428773bcc3b0bbe8971886c5ab9

Reported-by: Dimitri Sivanich <sivanich@hpe.com>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/dmar.c  | 71 +++++++++++++++++++++++++++++--------
 drivers/iommu/intel/iommu.h |  1 +
 2 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index ab325af93f71..cf68464b3404 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1182,7 +1182,6 @@ static void free_iommu(struct intel_iommu *iommu)
 			iommu->pr_irq = 0;
 		}
 		free_irq(iommu->fault_irq, iommu);
-		dmar_free_hwirq(iommu->fault_irq);
 		iommu->fault_irq = 0;
 	}
 
@@ -1956,9 +1955,8 @@ void dmar_msi_mask(struct irq_data *data)
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 }
 
-void dmar_msi_write(int irq, struct msi_msg *msg)
+static void dmar_msi_write_msg(struct intel_iommu *iommu, int irq, struct msi_msg *msg)
 {
-	struct intel_iommu *iommu = irq_get_handler_data(irq);
 	int reg = dmar_msi_reg(iommu, irq);
 	unsigned long flag;
 
@@ -1969,6 +1967,13 @@ void dmar_msi_write(int irq, struct msi_msg *msg)
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 }
 
+void dmar_msi_write(int irq, struct msi_msg *msg)
+{
+	struct intel_iommu *iommu = irq_get_handler_data(irq);
+
+	dmar_msi_write_msg(iommu, irq, msg);
+}
+
 void dmar_msi_read(int irq, struct msi_msg *msg)
 {
 	struct intel_iommu *iommu = irq_get_handler_data(irq);
@@ -2098,27 +2103,63 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static inline void dmar_fault_irq_unmask(struct intel_iommu *iommu)
+{
+	unsigned long flag;
+
+	raw_spin_lock_irqsave(&iommu->register_lock, flag);
+	writel(0, iommu->reg + DMAR_FECTL_REG);
+	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
+}
+
 int dmar_set_interrupt(struct intel_iommu *iommu)
 {
-	int irq, ret;
+	static int dmar_irq;
+	int ret;
 
-	/*
-	 * Check if the fault interrupt is already initialized.
-	 */
+	/* Don't initialize it twice for a given iommu */
 	if (iommu->fault_irq)
 		return 0;
+	/*
+	 * There is one shared interrupt for all IOMMUs to prevent vector
+	 * exhaustion.
+	 */
+	if (!dmar_irq) {
+		int irq = dmar_alloc_hwirq(iommu->seq_id, iommu->node, iommu);
 
-	irq = dmar_alloc_hwirq(iommu->seq_id, iommu->node, iommu);
-	if (irq > 0) {
-		iommu->fault_irq = irq;
+		if (irq <= 0) {
+			pr_err("No free IRQ vectors\n");
+			return -EINVAL;
+		}
+		dmar_irq = irq;
+		iommu->fault_irq = dmar_irq;
+		iommu->flags |= VTD_FLAG_FAULT_IRQ_OWNER;
 	} else {
-		pr_err("No free IRQ vectors\n");
-		return -EINVAL;
-	}
+		struct msi_msg msg;
 
-	ret = request_irq(irq, dmar_fault, IRQF_NO_THREAD, iommu->name, iommu);
-	if (ret)
+		/*
+		 * Get the MSI message from the shared interrupt and write
+		 * it to the iommu MSI registers. Must assign fault_irq to get
+		 * the MSI register offset.
+		 */
+		iommu->fault_irq = dmar_irq;
+		dmar_msi_read(dmar_irq, &msg);
+		dmar_msi_write_msg(iommu, dmar_irq, &msg);
+	}
+	ret = request_irq(dmar_irq, dmar_fault, IRQF_NO_THREAD | IRQF_SHARED | IRQF_NOBALANCING, iommu->name, iommu);
+	if (ret) {
 		pr_err("Can't request irq\n");
+		return ret;
+	}
+
+	/*
+	 * Only the owner IOMMU of the shared IRQ has its fault event
+	 * interrupt unmasked after request_irq(), the rest are explicitly
+	 * unmasked.
+	 */
+	if (!(iommu->flags & VTD_FLAG_FAULT_IRQ_OWNER))
+		dmar_fault_irq_unmask(iommu);
+
 	return ret;
 }
 
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index deebd4817d27..128f6cdaebac 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -536,6 +536,7 @@ enum {
 #define VTD_FLAG_TRANS_PRE_ENABLED	(1 << 0)
 #define VTD_FLAG_IRQ_REMAP_PRE_ENABLED	(1 << 1)
 #define VTD_FLAG_SVM_CAPABLE		(1 << 2)
+#define VTD_FLAG_FAULT_IRQ_OWNER	(1 << 3)
 
 #define sm_supported(iommu)	(intel_iommu_sm && ecap_smts((iommu)->ecap))
 #define pasid_supported(iommu)	(sm_supported(iommu) &&			\
-- 
2.25.1

