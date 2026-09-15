Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50AE3EC816
	for <iommu@lists.linux.dev>; Tue, 15 Sep 2026 03:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442922; cv=none; b=rjhCfpB/BXZJv8omlArezwYp11M41zAf/Xv5fLFCR2yqoa5GG32QS67OPE3Jp16fCcHhDhCIJ9B0RlHbkmBKDtZcLCUw8WF/BXMAcKVqNJExFDn5AoMzYeMy5H1TqXkzK8T3VFNLVJStJBfimxl2xiG9a2OVUXc/5GpQtujnstI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442922; c=relaxed/simple;
	bh=T9WWqFJHchi/0d/r1QqY1VcFw/wXeEsnz4BNMR0PRPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BrI8NEHYVs9neDiH2FeQ9iSEhCmAzUBneZoNGQgg/xgfYkfa+Ccg6WUZPUggoUZO7rAE547a5ovNzo3QyEwETyCPo1ljZYJgfG6g3T0koN9yJpK/JVvYm5TM3w2cX1yiAYKCnwFcy0UrKZYTv5RcAtxh7AtDSngyXMCRWCfpW/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gAkeWCFU; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gAkeWCFU"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789442916; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=vV2Y5T1kVnTXHiV+qTqs8GbZEVnLFhK5H2hev57N6Io=;
	b=gAkeWCFUHZ3rFcp4f4D325IjRULrl/pFfrR0H0i7WPBxVb3z1RJKTacURCXRsBoChBJ7lpQ8NoOd++BnvbC2GOlZ/CZ/vdh19Q/8dfaAl9v1Art6QMOl3oinq9likhyNGoX9xzsJcqxlnkIVFspQknnJO5SQ/SZBy/PInjsVMYA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=26;SR=0;TI=SMTPD_---0XB.uvNY_1789442913;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XB.uvNY_1789442913 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Sep 2026 11:28:34 +0800
From: fangyu.yu@linux.alibaba.com
To: tomasz.jeznach@linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	baolu.lu@linux.intel.com,
	jroedel@suse.de,
	zong.li@sifive.com,
	andrew.jones@oss.qualcomm.com,
	anup@brainfault.org,
	jgg@nvidia.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	atish.patra@linux.dev,
	skhawaja@google.com,
	vasant.hegde@amd.com,
	joerg.roedel@amd.com
Cc: fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org
Subject: [RFC PATCH v4 01/10] iommupt: Add RISC-V Second-stage (iohgatp) page table support
Date: Tue, 15 Sep 2026 11:28:20 +0800
Message-Id: <20260915032828.11250-2-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260915032828.11250-1-fangyu.yu@linux.alibaba.com>
References: <20260915032828.11250-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

Add support for Sv39x4/Sv48x4/Sv57x4 Second-stage page tables used by
the RISC-V IOMMU iohgatp register. The x4 root page table is 16 KiB
instead of the usual 4 KiB, covering 2 extra GPA bits (hw_max_vasz_lg2
= 41/50/59).

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/generic_pt/fmt/iommu_riscv64.c |   2 +-
 drivers/iommu/generic_pt/fmt/riscv.h         | 109 +++++++++++++++----
 include/linux/generic_pt/common.h            |   4 +
 include/linux/generic_pt/iommu.h             |  11 ++
 4 files changed, 102 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/generic_pt/fmt/iommu_riscv64.c b/drivers/iommu/generic_pt/fmt/iommu_riscv64.c
index 1bb74114fb02..fa61839e5599 100644
--- a/drivers/iommu/generic_pt/fmt/iommu_riscv64.c
+++ b/drivers/iommu/generic_pt/fmt/iommu_riscv64.c
@@ -8,7 +8,7 @@
 	(BIT(PT_FEAT_SIGN_EXTEND) | BIT(PT_FEAT_FLUSH_RANGE) | \
 	 BIT(PT_FEAT_RISCV_SVNAPOT_64K) |                      \
 	 BIT(PT_FEAT_DETAILED_GATHER) |                        \
-	 BIT(PT_FEAT_RISCV_SVPBMT))
+	 BIT(PT_FEAT_RISCV_SVPBMT) | BIT(PT_FEAT_RISCV_S2))
 #define PT_FORCE_ENABLED_FEATURES BIT(PT_FEAT_DETAILED_GATHER)
 
 #include "iommu_template.h"
diff --git a/drivers/iommu/generic_pt/fmt/riscv.h b/drivers/iommu/generic_pt/fmt/riscv.h
index ae9a76514416..d4445e463fa9 100644
--- a/drivers/iommu/generic_pt/fmt/riscv.h
+++ b/drivers/iommu/generic_pt/fmt/riscv.h
@@ -37,7 +37,16 @@ enum {
 	PT_MAX_OUTPUT_ADDRESS_LG2 = 34,
 	PT_MAX_TOP_LEVEL = 1,
 #else
-	PT_MAX_VA_ADDRESS_LG2 = 57,
+	/*
+	 * PT_MAX_VA_ADDRESS_LG2 is the upper bound accepted by the generic
+	 * pt_iommu_init() range check.  It must cover both first-stage and
+	 * second-stage (G-stage) modes:
+	 *
+	 *   First-stage  (fsc/iosatp): Sv39=39, Sv48=48, Sv57=57
+	 *   Second-stage (iohgatp):    Sv39x4=41, Sv48x4=50, Sv57x4=59
+	 *
+	 */
+	PT_MAX_VA_ADDRESS_LG2 = 59,
 	PT_MAX_OUTPUT_ADDRESS_LG2 = 56,
 	PT_MAX_TOP_LEVEL = 4,
 #endif
@@ -126,6 +135,12 @@ riscvpt_entry_num_contig_lg2(const struct pt_state *pts)
 
 static inline unsigned int riscvpt_num_items_lg2(const struct pt_state *pts)
 {
+	/*
+	 * It is not allowed to call pt_num_items_lg2() at the top level, this
+	 * API restriction is specifically an optimization avoid overheads
+	 * dealing with concatenated tables here.
+	 */
+	PT_WARN_ON(pts->level == pts->range->top_level);
 	return PT_TABLEMEM_LG2SZ - ilog2(sizeof(u64));
 }
 #define pt_num_items_lg2 riscvpt_num_items_lg2
@@ -261,20 +276,41 @@ riscvpt_iommu_fmt_init(struct pt_iommu_riscv_64 *iommu_table,
 		       const struct pt_iommu_riscv_64_cfg *cfg)
 {
 	struct pt_riscv *table = &iommu_table->riscv_64pt;
-
-	switch (cfg->common.hw_max_vasz_lg2) {
-	case 39:
-		pt_top_set_level(&table->common, 2);
-		break;
-	case 48:
-		pt_top_set_level(&table->common, 3);
-		break;
-	case 57:
-		pt_top_set_level(&table->common, 4);
-		break;
-	default:
-		return -EINVAL;
+	unsigned int top_level;
+
+	if (pt_feature(&table->common, PT_FEAT_RISCV_S2)) {
+		/* Second-stage (iohgatp): Sv39x4 / Sv48x4 / Sv57x4. */
+		switch (cfg->common.hw_max_vasz_lg2) {
+		case 41:
+			top_level = 2;
+			break;
+		case 50:
+			top_level = 3;
+			break;
+		case 59:
+			top_level = 4;
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else {
+		/* First-stage (fsc/iosatp): Sv39 / Sv48 / Sv57. */
+		switch (cfg->common.hw_max_vasz_lg2) {
+		case 39:
+			top_level = 2;
+			break;
+		case 48:
+			top_level = 3;
+			break;
+		case 57:
+			top_level = 4;
+			break;
+		default:
+			return -EINVAL;
+		}
 	}
+
+	pt_top_set_level(&table->common, top_level);
 	table->common.max_oasz_lg2 =
 		min(PT_MAX_OUTPUT_ADDRESS_LG2, cfg->common.hw_max_oasz_lg2);
 	return 0;
@@ -292,30 +328,57 @@ riscvpt_iommu_fmt_hw_info(struct pt_iommu_riscv_64 *table,
 	PT_WARN_ON(top_phys & ~PT_TOP_PHYS_MASK);
 
 	/*
-	 * See Table 3. Encodings of iosatp.MODE field" for DC.tx.SXL = 0:
-	 *  8 = Sv39 = top level 2
-	 *  9 = Sv38 = top level 3
-	 *  10 = Sv57 = top level 4
+	 * Both first-stage (fsc/iosatp) and second-stage (iohgatp) share the
+	 * same MODE numeric values for a given top level:
+	 *   top_level 2 -> MODE 8  (Sv39 / Sv39x4)
+	 *   top_level 3 -> MODE 9  (Sv48 / Sv48x4)
+	 *   top_level 4 -> MODE 10 (Sv57 / Sv57x4)
+	 *
+	 * See "Table 3. Encodings of iosatp.MODE field" (DC.tc.SXL = 0) and
+	 * "Table 2. Encoding of iohgatp.MODE field" in the RISC-V IOMMU spec.
 	 */
-	info->fsc_iosatp_mode = top_range->top_level + 6;
+	if (pt_feature(&table->riscv_64pt.common, PT_FEAT_RISCV_S2))
+		info->iohgatp_mode = top_range->top_level + 6;
+	else
+		info->fsc_iosatp_mode = top_range->top_level + 6;
 }
 #define pt_iommu_fmt_hw_info riscvpt_iommu_fmt_hw_info
 
 #if defined(GENERIC_PT_KUNIT)
 static const struct pt_iommu_riscv_64_cfg riscv_64_kunit_fmt_cfgs[] = {
-	[0] = { .common.features = BIT(PT_FEAT_RISCV_SVNAPOT_64K),
+	/* First-stage (fsc/iosatp): Sv39 / Sv48 / Sv57 */
+	[0] = { .common.features = BIT(PT_FEAT_SIGN_EXTEND) |
+				      BIT(PT_FEAT_RISCV_SVNAPOT_64K),
 		.common.hw_max_oasz_lg2 = 56,
 		.common.hw_max_vasz_lg2 = 39 },
-	[1] = { .common.features = 0,
+	[1] = { .common.features = BIT(PT_FEAT_SIGN_EXTEND),
 		.common.hw_max_oasz_lg2 = 56,
 		.common.hw_max_vasz_lg2 = 48 },
-	[2] = { .common.features = BIT(PT_FEAT_RISCV_SVNAPOT_64K),
+	[2] = { .common.features = BIT(PT_FEAT_SIGN_EXTEND) |
+				      BIT(PT_FEAT_RISCV_SVNAPOT_64K),
 		.common.hw_max_oasz_lg2 = 56,
 		.common.hw_max_vasz_lg2 = 57 },
+	/*
+	 * Second-stage (iohgatp): Sv39x4 / Sv48x4 / Sv57x4.
+	 */
+	[3] = { .common.features = BIT(PT_FEAT_RISCV_S2) |
+				      BIT(PT_FEAT_RISCV_SVNAPOT_64K),
+		.common.hw_max_oasz_lg2 = 56,
+		.common.hw_max_vasz_lg2 = 41 },
+	[4] = { .common.features = BIT(PT_FEAT_RISCV_S2),
+		.common.hw_max_oasz_lg2 = 56,
+		.common.hw_max_vasz_lg2 = 50 },
+	[5] = { .common.features = BIT(PT_FEAT_RISCV_S2) |
+				      BIT(PT_FEAT_RISCV_SVNAPOT_64K),
+		.common.hw_max_oasz_lg2 = 56,
+		.common.hw_max_vasz_lg2 = 59 },
 };
 #define kunit_fmt_cfgs riscv_64_kunit_fmt_cfgs
+/* Sign extension is only valid for first-stage configs, not S2. */
 enum {
-	KUNIT_FMT_FEATURES = BIT(PT_FEAT_RISCV_SVNAPOT_64K),
+	KUNIT_FMT_FEATURES = BIT(PT_FEAT_SIGN_EXTEND) |
+			     BIT(PT_FEAT_RISCV_SVNAPOT_64K) |
+			     BIT(PT_FEAT_RISCV_S2),
 };
 #endif
 
diff --git a/include/linux/generic_pt/common.h b/include/linux/generic_pt/common.h
index 07ef1c8341a4..f2e130c2b804 100644
--- a/include/linux/generic_pt/common.h
+++ b/include/linux/generic_pt/common.h
@@ -197,6 +197,10 @@ enum {
 	 * Support Svpbmt extension: encode page-based memory type (PBMT) in PTEs.
 	 */
 	PT_FEAT_RISCV_SVPBMT,
+	/*
+	 * Using second-stage / iohgatp address translation.
+	 */
+	PT_FEAT_RISCV_S2,
 
 };
 
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index dd0edd02a48a..2eed9b78f56c 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -328,7 +328,18 @@ struct pt_iommu_riscv_64_cfg {
 
 struct pt_iommu_riscv_64_hw_info {
 	u64 ppn;
+	/*
+	 * First-stage (fsc/iosatp) MODE encoding:
+	 *   8 = Sv39, 9 = Sv48, 10 = Sv57
+	 * Used to program DC.fsc.iosatp.MODE.
+	 */
 	u8 fsc_iosatp_mode;
+	/*
+	 * Second-stage (iohgatp) MODE encoding:
+	 *   8 = Sv39x4, 9 = Sv48x4, 10 = Sv57x4
+	 * Used to program DC.iohgatp.MODE.
+	 */
+	u8 iohgatp_mode;
 };
 
 IOMMU_FORMAT(riscv_64, riscv_64pt);
-- 
2.50.1

