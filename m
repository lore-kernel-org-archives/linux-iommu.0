Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B803ED5D9
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 11:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778153846; cv=none; b=ePt7q+811Fu53YnH3QUG1bn/zVtZ+5es25Cmzra5W97fYuWci4Hod7373/MEtSLCHUftwFb5j3CtnPj4ciaJpxLXDKaDnSXHSqDDd2KAcRYytYBt3PpOlF4brzGpCjQc8qIhYuDJZy0dm8GBQxBXhqvF4DxDKxRW8B5LZT/KtSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778153846; c=relaxed/simple;
	bh=YyzgnuFA90twudD6q82NIg+uJNptTvPRS3eG8ZuX5oY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WpDfV2Ye13XbR/RYrMxQQl05wNSC6oe/Ae7nW1QhwtKqZIq3sL3vroRq/b0iIoE53Dm6X08WL67QtyFkhnoFRDuoyCoikmTBm5oLVmcgyPSM7cXwzxYb0J94OhNwIj+bnCPZlFmjWWASTMMrFih/EKDh4ufzvJgP0Nf5HCDp5Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OOYcLXef; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OOYcLXef"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778153834; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=oSq7eCXtjOsx2ohWmDqI2E1f3GZbwF4QYb8Qk+5aDsU=;
	b=OOYcLXefotFvgxDw1OhFy2TIVLyKybDybpyyq0YKe7DYd2hE9HlUl36oAjgJhRW69/YNCmyQcE1wjC1qsiWAP4cv7d3wjmBOeZ50Zh+dTsc09bOPVIJ/SboLsAvxvs4rSgvTD98wdRNM8AzSKbfioxzGDvuFId3UOFi3UQ30HhY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X2UVF-A_1778153831;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X2UVF-A_1778153831 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 May 2026 19:37:12 +0800
From: fangyu.yu@linux.alibaba.com
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	tjeznach@rivosinc.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	vasant.hegde@amd.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	skhawaja@google.com,
	jgg@nvidia.com
Cc: guoren@kernel.org,
	andrew.jones@oss.qualcomm.com,
	kvm@vger.kernel.org,
	iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [RFC PATCH v2 01/10] iommupt: Add RISC-V Second-stage (iohgatp) page table support
Date: Thu,  7 May 2026 19:36:57 +0800
Message-Id: <20260507113706.11400-2-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260507113706.11400-1-fangyu.yu@linux.alibaba.com>
References: <20260507113706.11400-1-fangyu.yu@linux.alibaba.com>
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
 drivers/iommu/generic_pt/fmt/riscv.h | 61 +++++++++++++++++++++++++---
 include/linux/generic_pt/common.h    |  5 ++-
 include/linux/generic_pt/iommu.h     | 17 +++++++-
 3 files changed, 76 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/generic_pt/fmt/riscv.h b/drivers/iommu/generic_pt/fmt/riscv.h
index a7fef6266a36..777887335696 100644
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
@@ -124,6 +133,14 @@ riscvpt_entry_num_contig_lg2(const struct pt_state *pts)
 
 static inline unsigned int riscvpt_num_items_lg2(const struct pt_state *pts)
 {
+	/*
+	 * Second-stage (iohgatp) root page tables have 4x the usual number of
+	 * entries (2048 = 2^11 instead of 512 = 2^9) to cover the 2 extra GPA
+	 * bits in Sv39x4/Sv48x4/Sv57x4.  Only the root (top) level is
+	 * enlarged; all other levels remain at the standard 9-bit index width.
+	 */
+	if (pts_feature(pts, PT_FEAT_RISCV_S2) && pts->level == pts->range->top_level)
+		return PT_TABLEMEM_LG2SZ - ilog2(sizeof(u64)) + 2;
 	return PT_TABLEMEM_LG2SZ - ilog2(sizeof(u64));
 }
 #define pt_num_items_lg2 riscvpt_num_items_lg2
@@ -254,6 +271,7 @@ riscvpt_iommu_fmt_init(struct pt_iommu_riscv_64 *iommu_table,
 	struct pt_riscv *table = &iommu_table->riscv_64pt;
 
 	switch (cfg->common.hw_max_vasz_lg2) {
+	/* First-stage (fsc/iosatp): Sv39 / Sv48 / Sv57 */
 	case 39:
 		pt_top_set_level(&table->common, 2);
 		break;
@@ -263,6 +281,19 @@ riscvpt_iommu_fmt_init(struct pt_iommu_riscv_64 *iommu_table,
 	case 57:
 		pt_top_set_level(&table->common, 4);
 		break;
+	/*
+	 * Second-stage (iohgatp): Sv39x4 / Sv48x4 / Sv57x4.
+	 * The top level is the same as for the first-stage counterpart.
+	 */
+	case 41:
+		pt_top_set_level(&table->common, 2);
+		break;
+	case 50:
+		pt_top_set_level(&table->common, 3);
+		break;
+	case 59:
+		pt_top_set_level(&table->common, 4);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -283,10 +314,17 @@ riscvpt_iommu_fmt_hw_info(struct pt_iommu_riscv_64 *table,
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
+	 * The union members fsc_iosatp_mode and iohgatp_mode occupy the same
+	 * byte; the caller selects the appropriate name based on domain type.
+	 *
+	 * See "Table 3. Encodings of iosatp.MODE field" (DC.tc.SXL = 0) and
+	 * "Table 2. Encoding of iohgatp.MODE field" in the RISC-V IOMMU spec.
 	 */
 	info->fsc_iosatp_mode = top_range->top_level + 6;
 }
@@ -294,6 +332,7 @@ riscvpt_iommu_fmt_hw_info(struct pt_iommu_riscv_64 *table,
 
 #if defined(GENERIC_PT_KUNIT)
 static const struct pt_iommu_riscv_64_cfg riscv_64_kunit_fmt_cfgs[] = {
+	/* First-stage (fsc/iosatp): Sv39 / Sv48 / Sv57 */
 	[0] = { .common.features = BIT(PT_FEAT_RISCV_SVNAPOT_64K),
 		.common.hw_max_oasz_lg2 = 56,
 		.common.hw_max_vasz_lg2 = 39 },
@@ -303,6 +342,18 @@ static const struct pt_iommu_riscv_64_cfg riscv_64_kunit_fmt_cfgs[] = {
 	[2] = { .common.features = BIT(PT_FEAT_RISCV_SVNAPOT_64K),
 		.common.hw_max_oasz_lg2 = 56,
 		.common.hw_max_vasz_lg2 = 57 },
+	/*
+	 * Second-stage (iohgatp): Sv39x4 / Sv48x4 / Sv57x4.
+	 */
+	[3] = { .common.features = BIT(PT_FEAT_RISCV_SVNAPOT_64K),
+		.common.hw_max_oasz_lg2 = 56,
+		.common.hw_max_vasz_lg2 = 41 },
+	[4] = { .common.features = 0,
+		.common.hw_max_oasz_lg2 = 56,
+		.common.hw_max_vasz_lg2 = 50 },
+	[5] = { .common.features = BIT(PT_FEAT_RISCV_SVNAPOT_64K),
+		.common.hw_max_oasz_lg2 = 56,
+		.common.hw_max_vasz_lg2 = 59 },
 };
 #define kunit_fmt_cfgs riscv_64_kunit_fmt_cfgs
 enum {
diff --git a/include/linux/generic_pt/common.h b/include/linux/generic_pt/common.h
index fc5d0b5edadc..59448125159e 100644
--- a/include/linux/generic_pt/common.h
+++ b/include/linux/generic_pt/common.h
@@ -188,7 +188,10 @@ enum {
 	 * Support the 64k contiguous page size following the Svnapot extension.
 	 */
 	PT_FEAT_RISCV_SVNAPOT_64K = PT_FEAT_FMT_START,
-
+	/*
+	 * Using second-stage / iohgatp address translation.
+	 */
+	PT_FEAT_RISCV_S2,
 };
 
 struct pt_x86_64 {
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index dd0edd02a48a..f27d229ff318 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -328,7 +328,22 @@ struct pt_iommu_riscv_64_cfg {
 
 struct pt_iommu_riscv_64_hw_info {
 	u64 ppn;
-	u8 fsc_iosatp_mode;
+	union {
+		/*
+		 * First-stage (fsc/iosatp) MODE encoding:
+		 *   8 = Sv39, 9 = Sv48, 10 = Sv57
+		 * Used to program DC.fsc.iosatp.MODE.
+		 */
+		u8 fsc_iosatp_mode;
+		/*
+		 * Second-stage (iohgatp) MODE encoding:
+		 *   8 = Sv39x4, 9 = Sv48x4, 10 = Sv57x4
+		 * Used to program DC.iohgatp.MODE.
+		 * The numeric values are identical to fsc_iosatp_mode;
+		 * the caller selects the interpretation based on domain type.
+		 */
+		u8 iohgatp_mode;
+	};
 };
 
 IOMMU_FORMAT(riscv_64, riscv_64pt);
-- 
2.50.1

