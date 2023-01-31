Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F831808
	for <iommu@lists.linux.dev>; Tue, 31 Jan 2023 07:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675151171; x=1706687171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/Zucbg5amTcTa+z96MaiZy75/A5VqNpeiaN9HZkfJek=;
  b=GvDbANl1OSq9Nj6CwR2dbtXl5aAz60YUbA9bgPnR8qWY3HvbgF5OzXpB
   +3rWOGBN2C/T2V0NNAd+vT+l1bT56eiP65hLLk0Oo9yIBGiik29VKhlx5
   0+wsEhfnywfnpuF/qB0WfFQNP8PN7t+B//RHkUGMKYoiL8joG5i7F6RqM
   vc3T93preQA2WTIM0q7niKuWt4z3Z3NsPDgYg65r96KGKgzEb4J8pF9bx
   uCuw99RLJZyy0LnhtyyGpT6X2JqWib97iFMXhrq3rsYj/0WMpTvL1zwQQ
   kFzWTW17uC+KbppAVRH72+cxg8RKo0EvfbzKTn7KH1/Wl7WdG5M5pTxrb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="315736625"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="315736625"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 23:46:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="657775564"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="657775564"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 30 Jan 2023 23:46:03 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: kan.liang@linux.intel.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] iommu/vt-d: Support Enhanced Command Interface
Date: Tue, 31 Jan 2023 15:37:36 +0800
Message-Id: <20230131073740.378984-9-baolu.lu@linux.intel.com>
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

The Enhanced Command Register is to submit command and operand of
enhanced commands to DMA Remapping hardware. It can supports up to 256
enhanced commands.

There is a HW register to indicate the availability of all 256 enhanced
commands. Each bit stands for each command. But there isn't an existing
interface to read/write all 256 bits. Introduce the u64 ecmdcap[4] to
store the existence of each enhanced command. Read 4 times to get all of
them in map_iommu().

Add a helper to facilitate an enhanced command launch. Make sure hardware
complete the command. Also add a helper to facilitate the check of PMU
essentials. These helpers will be used later.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20230128200428.1459118-4-kan.liang@linux.intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h | 33 ++++++++++++++++++++++
 drivers/iommu/intel/dmar.c  | 10 +++++++
 drivers/iommu/intel/iommu.c | 56 +++++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index f03d4b6bf49a..f918e83bf91c 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -130,6 +130,10 @@
 #define DMAR_PERFOVFOFF_REG	0x318
 #define DMAR_PERFCNTROFF_REG	0x31c
 #define DMAR_PERFEVNTCAP_REG	0x380
+#define DMAR_ECMD_REG		0x400
+#define DMAR_ECEO_REG		0x408
+#define DMAR_ECRSP_REG		0x410
+#define DMAR_ECCAP_REG		0x430
 #define DMAR_VCCAP_REG		0xe30 /* Virtual command capability register */
 #define DMAR_VCMD_REG		0xe00 /* Virtual command register */
 #define DMAR_VCRSP_REG		0xe10 /* Virtual command response register */
@@ -304,6 +308,26 @@
 #define DMA_CCMD_SID(s) (((u64)((s) & 0xffff)) << 16)
 #define DMA_CCMD_DID(d) ((u64)((d) & 0xffff))
 
+/* ECMD_REG */
+#define DMA_MAX_NUM_ECMD		256
+#define DMA_MAX_NUM_ECMDCAP		(DMA_MAX_NUM_ECMD / 64)
+#define DMA_ECMD_REG_STEP		8
+#define DMA_ECMD_ENABLE			0xf0
+#define DMA_ECMD_DISABLE		0xf1
+#define DMA_ECMD_FREEZE			0xf4
+#define DMA_ECMD_UNFREEZE		0xf5
+#define DMA_ECMD_OA_SHIFT		16
+#define DMA_ECMD_ECRSP_IP		0x1
+#define DMA_ECMD_ECCAP3			3
+#define DMA_ECMD_ECCAP3_ECNTS		BIT_ULL(48)
+#define DMA_ECMD_ECCAP3_DCNTS		BIT_ULL(49)
+#define DMA_ECMD_ECCAP3_FCNTS		BIT_ULL(52)
+#define DMA_ECMD_ECCAP3_UFCNTS		BIT_ULL(53)
+#define DMA_ECMD_ECCAP3_ESSENTIAL	(DMA_ECMD_ECCAP3_ECNTS |	\
+					 DMA_ECMD_ECCAP3_DCNTS |	\
+					 DMA_ECMD_ECCAP3_FCNTS |	\
+					 DMA_ECMD_ECCAP3_UFCNTS)
+
 /* FECTL_REG */
 #define DMA_FECTL_IM (((u32)1) << 31)
 
@@ -605,6 +629,7 @@ struct intel_iommu {
 	u64		cap;
 	u64		ecap;
 	u64		vccap;
+	u64		ecmdcap[DMA_MAX_NUM_ECMDCAP];
 	u32		gcmd; /* Holds TE, EAFL. Don't need SRTP, SFL, WBF */
 	raw_spinlock_t	register_lock; /* protect register handling */
 	int		seq_id;	/* sequence id of the iommu */
@@ -840,6 +865,14 @@ extern const struct iommu_ops intel_iommu_ops;
 extern int intel_iommu_sm;
 extern int iommu_calculate_agaw(struct intel_iommu *iommu);
 extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
+int ecmd_submit_sync(struct intel_iommu *iommu, u8 ecmd, u64 oa, u64 ob);
+
+static inline bool ecmd_has_pmu_essential(struct intel_iommu *iommu)
+{
+	return (iommu->ecmdcap[DMA_ECMD_ECCAP3] & DMA_ECMD_ECCAP3_ESSENTIAL) ==
+		DMA_ECMD_ECCAP3_ESSENTIAL;
+}
+
 extern int dmar_disabled;
 extern int intel_iommu_enabled;
 #else
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 7a03cadb13ff..0e429bab436f 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1017,6 +1017,16 @@ static int map_iommu(struct intel_iommu *iommu, struct dmar_drhd_unit *drhd)
 			goto release;
 		}
 	}
+
+	if (cap_ecmds(iommu->cap)) {
+		int i;
+
+		for (i = 0; i < DMA_MAX_NUM_ECMDCAP; i++) {
+			iommu->ecmdcap[i] = dmar_readq(iommu->reg + DMAR_ECCAP_REG +
+						       i * DMA_ECMD_REG_STEP);
+		}
+	}
+
 	err = 0;
 	goto out;
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 317af67b6098..e314c30d371a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5022,3 +5022,59 @@ void quirk_extra_dev_tlb_flush(struct device_domain_info *info,
 					 pasid, qdep, address, mask);
 	}
 }
+
+#define ecmd_get_status_code(res)	(((res) & 0xff) >> 1)
+
+/*
+ * Function to submit a command to the enhanced command interface. The
+ * valid enhanced command descriptions are defined in Table 47 of the
+ * VT-d spec. The VT-d hardware implementation may support some but not
+ * all commands, which can be determined by checking the Enhanced
+ * Command Capability Register.
+ *
+ * Return values:
+ *  - 0: Command successful without any error;
+ *  - Negative: software error value;
+ *  - Nonzero positive: failure status code defined in Table 48.
+ */
+int ecmd_submit_sync(struct intel_iommu *iommu, u8 ecmd, u64 oa, u64 ob)
+{
+	unsigned long flags;
+	u64 res;
+	int ret;
+
+	if (!cap_ecmds(iommu->cap))
+		return -ENODEV;
+
+	raw_spin_lock_irqsave(&iommu->register_lock, flags);
+
+	res = dmar_readq(iommu->reg + DMAR_ECRSP_REG);
+	if (res & DMA_ECMD_ECRSP_IP) {
+		ret = -EBUSY;
+		goto err;
+	}
+
+	/*
+	 * Unconditionally write the operand B, because
+	 * - There is no side effect if an ecmd doesn't require an
+	 *   operand B, but we set the register to some value.
+	 * - It's not invoked in any critical path. The extra MMIO
+	 *   write doesn't bring any performance concerns.
+	 */
+	dmar_writeq(iommu->reg + DMAR_ECEO_REG, ob);
+	dmar_writeq(iommu->reg + DMAR_ECMD_REG, ecmd | (oa << DMA_ECMD_OA_SHIFT));
+
+	IOMMU_WAIT_OP(iommu, DMAR_ECRSP_REG, dmar_readq,
+		      !(res & DMA_ECMD_ECRSP_IP), res);
+
+	if (res & DMA_ECMD_ECRSP_IP) {
+		ret = -ETIMEDOUT;
+		goto err;
+	}
+
+	ret = ecmd_get_status_code(res);
+err:
+	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
+
+	return ret;
+}
-- 
2.34.1

