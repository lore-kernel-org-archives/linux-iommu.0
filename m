Return-Path: <SRS0=aa3U=GS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE1BC433E0
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 12:14:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E959723772
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 12:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E959723772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A5CE284995;
	Fri, 15 Jan 2021 12:14:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GR8MFRDoJJJJ; Fri, 15 Jan 2021 12:14:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0AA0484626;
	Fri, 15 Jan 2021 12:14:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 043F1C08A1;
	Fri, 15 Jan 2021 12:14:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59607C013A;
 Fri, 15 Jan 2021 12:14:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5583386A37;
 Fri, 15 Jan 2021 12:14:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6-wTBZZUgPPU; Fri, 15 Jan 2021 12:14:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3932986B01;
 Fri, 15 Jan 2021 12:14:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABB7312FC;
 Fri, 15 Jan 2021 04:14:07 -0800 (PST)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EC86A3F70D;
 Fri, 15 Jan 2021 04:14:02 -0800 (PST)
From: Vivek Gautam <vivek.gautam@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org
Subject: [PATCH RFC v1 03/15] iommu/arm-smmu-v3: Update drivers to work with
 iommu-pasid-table
Date: Fri, 15 Jan 2021 17:43:30 +0530
Message-Id: <20210115121342.15093-4-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210115121342.15093-1-vivek.gautam@arm.com>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, mst@redhat.com,
 will.deacon@arm.com, alex.williamson@redhat.com, vivek.gautam@arm.com,
 robin.murphy@arm.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Update arm-smmu-v3 context descriptor (CD) library driver to work
with iommu-pasid-table APIs. These APIs are then used in arm-smmu-v3
drivers to manage CD tables.

Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c      | 127 +++++++++++++-----
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  16 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  47 ++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   7 +-
 drivers/iommu/iommu-pasid-table.h             |  10 +-
 5 files changed, 144 insertions(+), 63 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
index 97d1786a8a70..8a7187534706 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
@@ -8,17 +8,17 @@
 #include <linux/dma-iommu.h>
 
 #include "arm-smmu-v3.h"
+#include "../../iommu-pasid-table.h"
 
-static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
+static int arm_smmu_alloc_cd_leaf_table(struct device *dev,
 					struct arm_smmu_l1_ctx_desc *l1_desc)
 {
 	size_t size = CTXDESC_L2_ENTRIES * (CTXDESC_CD_DWORDS << 3);
 
-	l1_desc->l2ptr = dmam_alloc_coherent(smmu->dev, size,
+	l1_desc->l2ptr = dmam_alloc_coherent(dev, size,
 					     &l1_desc->l2ptr_dma, GFP_KERNEL);
 	if (!l1_desc->l2ptr) {
-		dev_warn(smmu->dev,
-			 "failed to allocate context descriptor table\n");
+		dev_warn(dev, "failed to allocate context descriptor table\n");
 		return -ENOMEM;
 	}
 	return 0;
@@ -34,35 +34,39 @@ static void arm_smmu_write_cd_l1_desc(__le64 *dst,
 	WRITE_ONCE(*dst, cpu_to_le64(val));
 }
 
-static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
+static __le64 *arm_smmu_get_cd_ptr(struct iommu_vendor_psdtable_cfg *pst_cfg,
 				   u32 ssid)
 {
 	__le64 *l1ptr;
 	unsigned int idx;
+	struct device *dev = pst_cfg->iommu_dev;
+	struct arm_smmu_cfg_info *cfgi = &pst_cfg->vendor.cfg;
+	struct arm_smmu_s1_cfg *s1cfg = cfgi->s1_cfg;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &s1cfg->cdcfg;
 	struct arm_smmu_l1_ctx_desc *l1_desc;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg.cdcfg;
+	struct iommu_pasid_table *tbl = pasid_table_cfg_to_table(pst_cfg);
 
-	if (smmu_domain->s1_cfg.s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
+	if (s1cfg->s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
 		return cdcfg->cdtab + ssid * CTXDESC_CD_DWORDS;
 
 	idx = ssid >> CTXDESC_SPLIT;
 	l1_desc = &cdcfg->l1_desc[idx];
 	if (!l1_desc->l2ptr) {
-		if (arm_smmu_alloc_cd_leaf_table(smmu, l1_desc))
+		if (arm_smmu_alloc_cd_leaf_table(dev, l1_desc))
 			return NULL;
 
 		l1ptr = cdcfg->cdtab + idx * CTXDESC_L1_DESC_DWORDS;
 		arm_smmu_write_cd_l1_desc(l1ptr, l1_desc);
 		/* An invalid L1CD can be cached */
-		arm_smmu_sync_cd(smmu_domain, ssid, false);
+		if (iommu_psdtable_sync(tbl, tbl->cookie, ssid, false))
+			return NULL;
 	}
 	idx = ssid & (CTXDESC_L2_ENTRIES - 1);
 	return l1_desc->l2ptr + idx * CTXDESC_CD_DWORDS;
 }
 
-int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
-			    struct arm_smmu_ctx_desc *cd)
+static int arm_smmu_write_ctx_desc(struct iommu_vendor_psdtable_cfg *pst_cfg,
+				   int ssid, void *cookie)
 {
 	/*
 	 * This function handles the following cases:
@@ -78,12 +82,15 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 	u64 val;
 	bool cd_live;
 	__le64 *cdptr;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_cfg_info *cfgi = &pst_cfg->vendor.cfg;
+	struct arm_smmu_s1_cfg *s1cfg = cfgi->s1_cfg;
+	struct iommu_pasid_table *tbl = pasid_table_cfg_to_table(pst_cfg);
+	struct arm_smmu_ctx_desc *cd = cookie;
 
-	if (WARN_ON(ssid >= (1 << smmu_domain->s1_cfg.s1cdmax)))
+	if (WARN_ON(ssid >= (1 << s1cfg->s1cdmax)))
 		return -E2BIG;
 
-	cdptr = arm_smmu_get_cd_ptr(smmu_domain, ssid);
+	cdptr = arm_smmu_get_cd_ptr(pst_cfg, ssid);
 	if (!cdptr)
 		return -ENOMEM;
 
@@ -111,7 +118,8 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 		 * order. Ensure that it observes valid values before reading
 		 * V=1.
 		 */
-		arm_smmu_sync_cd(smmu_domain, ssid, true);
+		if (iommu_psdtable_sync(tbl, tbl->cookie, ssid, true))
+			return -ENOSYS;
 
 		val = cd->tcr |
 #ifdef __BIG_ENDIAN
@@ -124,7 +132,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 			CTXDESC_CD_0_V;
 
 		/* STALL_MODEL==0b10 && CD.S==0 is ILLEGAL */
-		if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
+		if (cfgi->feat_flag & ARM_SMMU_FEAT_STALL_FORCE)
 			val |= CTXDESC_CD_0_S;
 	}
 
@@ -138,33 +146,55 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 	 *   without first making the structure invalid.
 	 */
 	WRITE_ONCE(cdptr[0], cpu_to_le64(val));
-	arm_smmu_sync_cd(smmu_domain, ssid, true);
+	if (iommu_psdtable_sync(tbl, tbl->cookie, ssid, true))
+		return -ENOSYS;
+
 	return 0;
 }
 
-int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
+static void arm_smmu_prepare_cd(struct iommu_vendor_psdtable_cfg *pst_cfg,
+				struct io_pgtable_cfg *pgtbl_cfg, u32 asid)
+{
+	struct arm_smmu_cfg_info *cfgi = &pst_cfg->vendor.cfg;
+	struct arm_smmu_s1_cfg *s1cfg = cfgi->s1_cfg;
+	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
+
+	s1cfg->cd.asid	= (u16)asid;
+	s1cfg->cd.ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
+	s1cfg->cd.tcr	= FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, tcr->tsz) |
+			  FIELD_PREP(CTXDESC_CD_0_TCR_TG0, tcr->tg) |
+			  FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0, tcr->irgn) |
+			  FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0, tcr->orgn) |
+			  FIELD_PREP(CTXDESC_CD_0_TCR_SH0, tcr->sh) |
+			  FIELD_PREP(CTXDESC_CD_0_TCR_IPS, tcr->ips) |
+			  CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
+	s1cfg->cd.mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
+}
+
+static int arm_smmu_alloc_cd_tables(struct iommu_vendor_psdtable_cfg *pst_cfg)
 {
 	int ret;
 	size_t l1size;
 	size_t max_contexts;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &cfg->cdcfg;
+	struct device *dev = pst_cfg->iommu_dev;
+	struct arm_smmu_cfg_info *cfgi = &pst_cfg->vendor.cfg;
+	struct arm_smmu_s1_cfg *s1cfg = cfgi->s1_cfg;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &s1cfg->cdcfg;
 
-	max_contexts = 1 << cfg->s1cdmax;
+	max_contexts = 1 << s1cfg->s1cdmax;
 
-	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
+	if (!(cfgi->feat_flag & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
 	    max_contexts <= CTXDESC_L2_ENTRIES) {
-		cfg->s1fmt = STRTAB_STE_0_S1FMT_LINEAR;
+		s1cfg->s1fmt = STRTAB_STE_0_S1FMT_LINEAR;
 		cdcfg->num_l1_ents = max_contexts;
 
 		l1size = max_contexts * (CTXDESC_CD_DWORDS << 3);
 	} else {
-		cfg->s1fmt = STRTAB_STE_0_S1FMT_64K_L2;
+		s1cfg->s1fmt = STRTAB_STE_0_S1FMT_64K_L2;
 		cdcfg->num_l1_ents = DIV_ROUND_UP(max_contexts,
 						  CTXDESC_L2_ENTRIES);
 
-		cdcfg->l1_desc = devm_kcalloc(smmu->dev, cdcfg->num_l1_ents,
+		cdcfg->l1_desc = devm_kcalloc(dev, cdcfg->num_l1_ents,
 					      sizeof(*cdcfg->l1_desc),
 					      GFP_KERNEL);
 		if (!cdcfg->l1_desc)
@@ -173,10 +203,10 @@ int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
 		l1size = cdcfg->num_l1_ents * (CTXDESC_L1_DESC_DWORDS << 3);
 	}
 
-	cdcfg->cdtab = dmam_alloc_coherent(smmu->dev, l1size, &cdcfg->cdtab_dma,
+	cdcfg->cdtab = dmam_alloc_coherent(dev, l1size, &cdcfg->cdtab_dma,
 					   GFP_KERNEL);
 	if (!cdcfg->cdtab) {
-		dev_warn(smmu->dev, "failed to allocate context descriptor\n");
+		dev_warn(dev, "failed to allocate context descriptor\n");
 		ret = -ENOMEM;
 		goto err_free_l1;
 	}
@@ -185,18 +215,20 @@ int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
 
 err_free_l1:
 	if (cdcfg->l1_desc) {
-		devm_kfree(smmu->dev, cdcfg->l1_desc);
+		devm_kfree(dev, cdcfg->l1_desc);
 		cdcfg->l1_desc = NULL;
 	}
 	return ret;
 }
 
-void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
+static void arm_smmu_free_cd_tables(struct iommu_vendor_psdtable_cfg *pst_cfg)
 {
 	int i;
 	size_t size, l1size;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg.cdcfg;
+	struct device *dev = pst_cfg->iommu_dev;
+	struct arm_smmu_cfg_info *cfgi = &pst_cfg->vendor.cfg;
+	struct arm_smmu_s1_cfg *s1cfg = cfgi->s1_cfg;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &s1cfg->cdcfg;
 
 	if (cdcfg->l1_desc) {
 		size = CTXDESC_L2_ENTRIES * (CTXDESC_CD_DWORDS << 3);
@@ -205,11 +237,11 @@ void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
 			if (!cdcfg->l1_desc[i].l2ptr)
 				continue;
 
-			dmam_free_coherent(smmu->dev, size,
+			dmam_free_coherent(dev, size,
 					   cdcfg->l1_desc[i].l2ptr,
 					   cdcfg->l1_desc[i].l2ptr_dma);
 		}
-		devm_kfree(smmu->dev, cdcfg->l1_desc);
+		devm_kfree(dev, cdcfg->l1_desc);
 		cdcfg->l1_desc = NULL;
 
 		l1size = cdcfg->num_l1_ents * (CTXDESC_L1_DESC_DWORDS << 3);
@@ -217,7 +249,30 @@ void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
 		l1size = cdcfg->num_l1_ents * (CTXDESC_CD_DWORDS << 3);
 	}
 
-	dmam_free_coherent(smmu->dev, l1size, cdcfg->cdtab, cdcfg->cdtab_dma);
+	dmam_free_coherent(dev, l1size, cdcfg->cdtab, cdcfg->cdtab_dma);
 	cdcfg->cdtab_dma = 0;
 	cdcfg->cdtab = NULL;
 }
+
+struct iommu_vendor_psdtable_ops arm_cd_table_ops = {
+	.alloc	 = arm_smmu_alloc_cd_tables,
+	.free	 = arm_smmu_free_cd_tables,
+	.prepare = arm_smmu_prepare_cd,
+	.write	 = arm_smmu_write_ctx_desc,
+	.sync	 = arm_smmu_sync_cd,
+};
+
+struct iommu_pasid_table *arm_smmu_register_cd_table(struct device *dev,
+						     void *cookie)
+{
+	struct iommu_pasid_table *tbl;
+
+	tbl = devm_kzalloc(dev, sizeof(tbl), GFP_KERNEL);
+	if (!tbl)
+		return NULL;
+
+	tbl->cookie = cookie;
+	tbl->ops = &arm_cd_table_ops;
+
+	return tbl;
+}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index e13b092e6004..033eaf6c0f6c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -11,6 +11,7 @@
 #include "arm-smmu-v3.h"
 #include "../../iommu-sva-lib.h"
 #include "../../io-pgtable-arm.h"
+#include "../../iommu-pasid-table.h"
 
 struct arm_smmu_mmu_notifier {
 	struct mmu_notifier		mn;
@@ -48,6 +49,7 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 	struct arm_smmu_ctx_desc *cd;
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain;
+	struct iommu_pasid_table *tbl;
 
 	cd = xa_load(&arm_smmu_asid_xa, asid);
 	if (!cd)
@@ -63,6 +65,7 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 
 	smmu_domain = container_of(cd, struct arm_smmu_domain, s1_cfg.cd);
 	smmu = smmu_domain->smmu;
+	tbl = smmu_domain->tbl;
 
 	ret = xa_alloc(&arm_smmu_asid_xa, &new_asid, cd,
 		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
@@ -79,7 +82,9 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 	 * be some overlap between use of both ASIDs, until we invalidate the
 	 * TLB.
 	 */
-	arm_smmu_write_ctx_desc(smmu_domain, 0, cd);
+	ret = iommu_psdtable_write(tbl, &tbl->cfg, 0, cd);
+	if (ret)
+		return ERR_PTR(-ENOSYS);
 
 	/* Invalidate TLB entries previously associated with that context */
 	arm_smmu_tlb_inv_asid(smmu, asid);
@@ -191,6 +196,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
 	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
 	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
+	struct iommu_pasid_table *tbl = smmu_domain->tbl;
 
 	mutex_lock(&sva_lock);
 	if (smmu_mn->cleared) {
@@ -202,7 +208,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	 * DMA may still be running. Keep the cd valid to avoid C_BAD_CD events,
 	 * but disable translation.
 	 */
-	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, &quiet_cd);
+	iommu_psdtable_write(tbl, &tbl->cfg, mm->pasid, &quiet_cd);
 
 	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
 	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
@@ -230,6 +236,7 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 	int ret;
 	struct arm_smmu_ctx_desc *cd;
 	struct arm_smmu_mmu_notifier *smmu_mn;
+	struct iommu_pasid_table *tbl = smmu_domain->tbl;
 
 	list_for_each_entry(smmu_mn, &smmu_domain->mmu_notifiers, list) {
 		if (smmu_mn->mn.mm == mm) {
@@ -259,7 +266,7 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 		goto err_free_cd;
 	}
 
-	ret = arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, cd);
+	ret = iommu_psdtable_write(tbl, &tbl->cfg, mm->pasid, cd);
 	if (ret)
 		goto err_put_notifier;
 
@@ -279,12 +286,13 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 	struct mm_struct *mm = smmu_mn->mn.mm;
 	struct arm_smmu_ctx_desc *cd = smmu_mn->cd;
 	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
+	struct iommu_pasid_table *tbl = smmu_domain->tbl;
 
 	if (!refcount_dec_and_test(&smmu_mn->refs))
 		return;
 
 	list_del(&smmu_mn->list);
-	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, NULL);
+	iommu_psdtable_write(tbl, &tbl->cfg, mm->pasid, NULL);
 
 	/*
 	 * If we went through clear(), we've already invalidated, and no
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 13513f2f651a..2f86c6ac42b6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -32,6 +32,7 @@
 #include <linux/amba/bus.h>
 
 #include "arm-smmu-v3.h"
+#include "../../iommu-pasid-table.h"
 
 static bool disable_bypass = true;
 module_param(disable_bypass, bool, 0444);
@@ -894,12 +895,13 @@ void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
 	arm_smmu_cmdq_issue_sync(smmu);
 }
 
-void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain, int ssid, bool leaf)
+void arm_smmu_sync_cd(void *cookie, int ssid, bool leaf)
 {
 	size_t i;
 	unsigned long flags;
 	struct arm_smmu_master *master;
 	struct arm_smmu_cmdq_batch cmds = {};
+	struct arm_smmu_domain *smmu_domain = cookie;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cmdq_ent cmd = {
 		.opcode	= CMDQ_OP_CFGI_CD,
@@ -1797,6 +1799,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s1_cfg *s1_cfg = &smmu_domain->s1_cfg;
 	struct arm_smmu_s2_cfg *s2_cfg = &smmu_domain->s2_cfg;
+	struct iommu_pasid_table *tbl = smmu_domain->tbl;
 
 	iommu_put_dma_cookie(domain);
 	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
@@ -1806,7 +1809,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 		/* Prevent SVA from touching the CD while we're freeing it */
 		mutex_lock(&arm_smmu_asid_lock);
 		if (s1_cfg->cdcfg.cdtab)
-			arm_smmu_free_cd_tables(smmu_domain);
+			iommu_psdtable_free(tbl, &tbl->cfg);
 		arm_smmu_free_asid(&s1_cfg->cd);
 		mutex_unlock(&arm_smmu_asid_lock);
 	}
@@ -1826,7 +1829,8 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	u32 asid;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
-	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
+	struct iommu_vendor_psdtable_cfg *pst_cfg;
+	struct iommu_pasid_table *tbl;
 
 	refcount_set(&cfg->cd.refs, 1);
 
@@ -1837,29 +1841,40 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_unlock;
 
+	tbl = iommu_register_pasid_table(PASID_TABLE_ARM_SMMU_V3, smmu->dev, smmu_domain);
+	if (!tbl) {
+		ret = -ENOMEM;
+		goto out_free_asid;
+	}
+
+	pst_cfg = &tbl->cfg;
+
+	pst_cfg->iommu_dev = smmu->dev;
+	pst_cfg->fmt = PASID_TABLE_ARM_SMMU_V3;
+	pst_cfg->vendor.cfg.s1_cfg = &smmu_domain->s1_cfg;
+
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB)
+		pst_cfg->vendor.cfg.feat_flag |= ARM_SMMU_FEAT_2_LVL_CDTAB;
+	if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
+		pst_cfg->vendor.cfg.feat_flag |= ARM_SMMU_FEAT_STALL_FORCE;
+
 	cfg->s1cdmax = master->ssid_bits;
 
-	ret = arm_smmu_alloc_cd_tables(smmu_domain);
+	smmu_domain->tbl = tbl;
+	ret = iommu_psdtable_alloc(tbl, pst_cfg);
 	if (ret)
 		goto out_free_asid;
 
-	cfg->cd.asid	= (u16)asid;
-	cfg->cd.ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
-	cfg->cd.tcr	= FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, tcr->tsz) |
-			  FIELD_PREP(CTXDESC_CD_0_TCR_TG0, tcr->tg) |
-			  FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0, tcr->irgn) |
-			  FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0, tcr->orgn) |
-			  FIELD_PREP(CTXDESC_CD_0_TCR_SH0, tcr->sh) |
-			  FIELD_PREP(CTXDESC_CD_0_TCR_IPS, tcr->ips) |
-			  CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
-	cfg->cd.mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
+	ret = iommu_psdtable_prepare(tbl, pst_cfg, pgtbl_cfg, asid);
+	if (ret)
+		goto out_free_cd_tables;
 
 	/*
 	 * Note that this will end up calling arm_smmu_sync_cd() before
 	 * the master has been added to the devices list for this domain.
 	 * This isn't an issue because the STE hasn't been installed yet.
 	 */
-	ret = arm_smmu_write_ctx_desc(smmu_domain, 0, &cfg->cd);
+	ret = iommu_psdtable_write(tbl, pst_cfg, 0, &cfg->cd);
 	if (ret)
 		goto out_free_cd_tables;
 
@@ -1867,7 +1882,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	return 0;
 
 out_free_cd_tables:
-	arm_smmu_free_cd_tables(smmu_domain);
+	iommu_psdtable_free(tbl, pst_cfg);
 out_free_asid:
 	arm_smmu_free_asid(&cfg->cd);
 out_unlock:
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index a50a3e4874f9..7f35fbecf280 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -713,6 +713,7 @@ struct arm_smmu_domain {
 	struct arm_smmu_s1_cfg	s1_cfg;
 	struct arm_smmu_s2_cfg	s2_cfg;
 	bool				abort;
+	struct iommu_pasid_table	*tbl;
 
 	struct iommu_domain		domain;
 
@@ -782,11 +783,7 @@ extern struct xarray arm_smmu_asid_xa;
 extern struct mutex arm_smmu_asid_lock;
 extern struct arm_smmu_ctx_desc quiet_cd;
 
-int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
-			    struct arm_smmu_ctx_desc *cd);
-int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain);
-void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain);
-void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain, int ssid, bool leaf);
+void arm_smmu_sync_cd(void *cookie, int ssid, bool leaf);
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
 bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
 int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
diff --git a/drivers/iommu/iommu-pasid-table.h b/drivers/iommu/iommu-pasid-table.h
index bd4f57656f67..7659157d14fa 100644
--- a/drivers/iommu/iommu-pasid-table.h
+++ b/drivers/iommu/iommu-pasid-table.h
@@ -123,12 +123,18 @@ static inline int iommu_psdtable_sync(struct iommu_pasid_table *tbl,
 	return 0;
 }
 
-/* A placeholder to register vendor specific pasid layer */
+struct iommu_pasid_table *arm_smmu_register_cd_table(struct device *dev,
+						     void *cookie);
+
+/* Register vendor specific pasid table management layer */
 static inline struct iommu_pasid_table *
 iommu_register_pasid_table(enum pasid_table_fmt fmt,
 			   struct device *dev, void *cookie)
 {
-	return NULL;
+	if (fmt == PASID_TABLE_ARM_SMMU_V3)
+		return arm_smmu_register_cd_table(dev, cookie);
+	else
+		return NULL;
 }
 
 #endif /* __IOMMU_PASID_TABLE_H */
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
