Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1182A79C8
	for <iommu@lists.linux.dev>; Wed, 18 Jan 2023 20:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674075032; x=1705611032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UJocoJAlSW2nm4kvzyB/lsi+hkWpPBNh1v7uJBGfzlg=;
  b=REXW3rOnHUIf9bfc/YbwOk8YKu0svHnkGWWddwhf0m8phMIr+ZhoxEOy
   FZO94xV1DihiXPCQnB2oFvo3LBz0iCpjAcp7Wr/v0LxaReKz3YY1x79Yc
   RlPiybQ/kkLSPHJnAGxchFOneHQbAzjKtH72Fq1iaZ38MD/Bx+ZVCJijo
   T+FTqR1fctaZ1fuww2YgKDmp/R54yQxUP75ez3MAlnQtJpveSkfzUlgsK
   sWZoP52LER4b0oa6QOVhMwhbdTzbO/GmMhy5vziHEFSjL7OkJhVGLEODK
   R+ix+CsRm4uYUI1GCbprNMJP7DIofm59ltST0yvlWss1YKQi2uHMTBwR1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="323784136"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="323784136"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 12:50:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="833739574"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="833739574"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga005.jf.intel.com with ESMTP; 18 Jan 2023 12:50:26 -0800
From: kan.liang@linux.intel.com
To: joro@8bytes.org,
	will@kernel.org,
	baolu.lu@linux.intel.com,
	dwmw2@infradead.org,
	robin.murphy@arm.com,
	robert.moore@intel.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 3/7] iommu/vt-d: Support Enhanced Command Interface
Date: Wed, 18 Jan 2023 12:50:02 -0800
Message-Id: <20230118205006.3182907-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230118205006.3182907-1-kan.liang@linux.intel.com>
References: <20230118205006.3182907-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The Enhanced Command Register is to submit command and operand of
enhanced commands to DMA Remapping hardware. It can supports upto 256
enhanced commands.

There is a HW register to indicate the availability of all 256 enhanced
commands. Each bit stands for each command. But there isn't an existing
interface to read/write all 256 bits. Introduce the u64 ecmdcap[4] to
store the existence of each enhanced command. Read 4 times to get
all of them in map_iommu().

Add a helper to facilitate an enhanced command launch. Make sure hardware
complete the command.

Add a helper to facilitate the check of PMU essentials.

The helpers will be used later.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 drivers/iommu/intel/dmar.c  | 68 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.h | 34 +++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 7a03cadb13ff..0f3401428d0e 100644
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
 
@@ -2426,3 +2436,61 @@ bool dmar_platform_optin(void)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dmar_platform_optin);
+
+#ifdef CONFIG_INTEL_IOMMU
+#define ecmd_get_status_code(res)	((res & 0xff) >> 1)
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
+#endif /* CONFIG_INTEL_IOMMU */
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 5bcefbea55c9..c25a574680ce 100644
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
+#define DMA_ECMD_ECCAP3_ECNTS		(1ULL << 48)
+#define DMA_ECMD_ECCAP3_DCNTS		(1ULL << 49)
+#define DMA_ECMD_ECCAP3_FCNTS		(1ULL << 52)
+#define DMA_ECMD_ECCAP3_UFCNTS		(1ULL << 53)
+#define DMA_ECMD_ECCAP3_ESSENTIAL	(DMA_ECMD_ECCAP3_ECNTS |	\
+					 DMA_ECMD_ECCAP3_DCNTS |	\
+					 DMA_ECMD_ECCAP3_FCNTS |	\
+					 DMA_ECMD_ECCAP3_UFCNTS)
+
 /* FECTL_REG */
 #define DMA_FECTL_IM (((u32)1) << 31)
 
@@ -600,6 +624,7 @@ struct intel_iommu {
 	u64		cap;
 	u64		ecap;
 	u64		vccap;
+	u64		ecmdcap[DMA_MAX_NUM_ECMDCAP];
 	u32		gcmd; /* Holds TE, EAFL. Don't need SRTP, SFL, WBF */
 	raw_spinlock_t	register_lock; /* protect register handling */
 	int		seq_id;	/* sequence id of the iommu */
@@ -841,6 +866,15 @@ extern const struct iommu_ops intel_iommu_ops;
 extern int intel_iommu_sm;
 extern int iommu_calculate_agaw(struct intel_iommu *iommu);
 extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
+extern int ecmd_submit_sync(struct intel_iommu *iommu, u8 ecmd,
+			    u64 oa, u64 ob);
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
-- 
2.35.1

