Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C8F4418CC
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382060; cv=none; b=DqgfUETfAsABPPCA3cRaXLB7oEdXuUqoC9X0t/2G+VZIOHqMKsuximRdt32mdVPgK3PXJePkvVPYDVh4a0xAuHCpS+9BlaqFe4KZ8YDIPEsgnZF/swpQeXfg6I7xIUIMFNe40kpebhInGx4njuIcSZOFVpCG2BhUELTslpvkhhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382060; c=relaxed/simple;
	bh=OYEP1JP8BVFHXbULzGk1wNAbCbBlFfgcJ1H95hoOhwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RC1gsoNHxOFPO7CQelmcv/+kaVPCwPNfLLuJYn3hSR5RSES3QiYQRw3Pte8Rjm2tvseHWLGoXhv6t9KWOXFcYCjQHk2k9qCI30JrnuB8hgznrM2sRmPkZ7VReiKSvTfgV7pSg5N6/1dQ6SOKwoIu2lXEjDLkgVNPzLOlAIZpzD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KJjAT3K+; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KJjAT3K+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777382055; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ZUHnJEfer0hml+VpdHPHpDcwMmO2L2tgfhLYa+ZhlhQ=;
	b=KJjAT3K+Axk0MWlmVWuAuzpBYj+xMvI+RjiSnpXeBcYTziK31IFL7Z24+jWxtwXLLduPa7TYdbnC8ylxNyUo+RsoHDb+VeiYXRYg3NfIjusIyRc4vdVGD8niG5MBnqriWpbyJs6ed5kTTEylhmKs4p4rxuoF7HObsUWBfoE+08o=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0X1ubIDQ_1777382052;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X1ubIDQ_1777382052 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 28 Apr 2026 21:14:13 +0800
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
	kvm@vger.kernel.org,
	iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [RFC PATCH 01/11] iommupt: Add RISC-V Second-stage (iohgatp) page table support
Date: Tue, 28 Apr 2026 21:13:49 +0800
Message-Id: <20260428131359.34872-2-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260428131359.34872-1-fangyu.yu@linux.alibaba.com>
References: <20260428131359.34872-1-fangyu.yu@linux.alibaba.com>
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
 drivers/iommu/generic_pt/fmt/riscv.h | 64 +++++++++++++++++++++++++---
 include/linux/generic_pt/common.h    |  5 +++
 include/linux/generic_pt/iommu.h     | 17 +++++++-
 3 files changed, 80 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/generic_pt/fmt/riscv.h b/drivers/iommu/generic_pt/fmt/riscv.h
index a7fef6266a36..4fe645e60375 100644
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
+	if (to_riscvpt(pts)->second_stage && pts->level == pts->range->top_level)
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
@@ -263,6 +281,22 @@ riscvpt_iommu_fmt_init(struct pt_iommu_riscv_64 *iommu_table,
 	case 57:
 		pt_top_set_level(&table->common, 4);
 		break;
+	/*
+	 * Second-stage (iohgatp): Sv39x4 / Sv48x4 / Sv57x4.
+	 * The top level is the same as for the first-stage counterpart.
+	 */
+	case 41:
+		pt_top_set_level(&table->common, 2);
+		table->second_stage = true;
+		break;
+	case 50:
+		pt_top_set_level(&table->common, 3);
+		table->second_stage = true;
+		break;
+	case 59:
+		pt_top_set_level(&table->common, 4);
+		table->second_stage = true;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -283,10 +317,17 @@ riscvpt_iommu_fmt_hw_info(struct pt_iommu_riscv_64 *table,
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
@@ -294,6 +335,7 @@ riscvpt_iommu_fmt_hw_info(struct pt_iommu_riscv_64 *table,
 
 #if defined(GENERIC_PT_KUNIT)
 static const struct pt_iommu_riscv_64_cfg riscv_64_kunit_fmt_cfgs[] = {
+	/* First-stage (fsc/iosatp): Sv39 / Sv48 / Sv57 */
 	[0] = { .common.features = BIT(PT_FEAT_RISCV_SVNAPOT_64K),
 		.common.hw_max_oasz_lg2 = 56,
 		.common.hw_max_vasz_lg2 = 39 },
@@ -303,6 +345,18 @@ static const struct pt_iommu_riscv_64_cfg riscv_64_kunit_fmt_cfgs[] = {
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
index fc5d0b5edadc..e82dff33ece8 100644
--- a/include/linux/generic_pt/common.h
+++ b/include/linux/generic_pt/common.h
@@ -181,6 +181,11 @@ struct pt_riscv_32 {
 
 struct pt_riscv_64 {
 	struct pt_common common;
+	/*
+	 * True when this table is used for second-stage / iohgatp
+	 * address translation.
+	 */
+	bool second_stage;
 };
 
 enum {
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

