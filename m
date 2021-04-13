Return-Path: <SRS0=gU7u=JK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C299C433ED
	for <iommu@archiver.kernel.org>; Tue, 13 Apr 2021 08:55:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DFE9613AE
	for <iommu@archiver.kernel.org>; Tue, 13 Apr 2021 08:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFE9613AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1A6694057B;
	Tue, 13 Apr 2021 08:55:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 30jfz2J3py-R; Tue, 13 Apr 2021 08:55:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 56F594056B;
	Tue, 13 Apr 2021 08:55:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C8B4C000C;
	Tue, 13 Apr 2021 08:55:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7590BC000A
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 08:55:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6473C83E33
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 08:55:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MbXdwWO5qA_A for <iommu@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 08:55:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4A06484158
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 08:55:20 +0000 (UTC)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FKK9j5xlfzPpKl;
 Tue, 13 Apr 2021 16:52:25 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.224) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 13 Apr 2021 16:55:10 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 "Will Deacon" <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Yi Sun
 <yi.y.sun@linux.intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Tian Kevin
 <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 05/12] iommu/arm-smmu-v3: Enable HTTU for stage1 with
 io-pgtable mapping
Date: Tue, 13 Apr 2021 16:54:50 +0800
Message-ID: <20210413085457.25400-6-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210413085457.25400-1-zhukeqian1@huawei.com>
References: <20210413085457.25400-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.187.224]
X-CFilter-Loop: Reflected
Cc: jiangkunkun@huawei.com, Cornelia Huck <cohuck@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, lushenming@huawei.com,
 Alex Williamson <alex.williamson@redhat.com>, wanghaibin.wang@huawei.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Kunkun Jiang <jiangkunkun@huawei.com>

As nested mode is not upstreamed now, we just aim to support dirty
log tracking for stage1 with io-pgtable mapping (means not support
SVA mapping). If HTTU is supported, we enable HA/HD bits in the SMMU
CD, and set DBM bit for writable TTD.

The dirty state information is encoded using the access permission
bits AP[2] (stage 1) or S2AP[1] (stage 2) in conjunction with the
DBM (Dirty Bit Modifier) bit, where DBM means writable and AP[2]/
S2AP[1] means dirty.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 +++
 drivers/iommu/io-pgtable-arm.c              | 7 ++++++-
 include/linux/io-pgtable.h                  | 3 +++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b6d965504f44..369c0ea7a104 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1921,6 +1921,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 			  FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0, tcr->orgn) |
 			  FIELD_PREP(CTXDESC_CD_0_TCR_SH0, tcr->sh) |
 			  FIELD_PREP(CTXDESC_CD_0_TCR_IPS, tcr->ips) |
+			  CTXDESC_CD_0_TCR_HA | CTXDESC_CD_0_TCR_HD |
 			  CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
 	cfg->cd.mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
 
@@ -2026,6 +2027,8 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 
 	if (smmu_domain->non_strict)
 		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
+	if (smmu->features & ARM_SMMU_FEAT_HD)
+		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_ARM_HD;
 
 	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
 	if (!pgtbl_ops)
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 87def58e79b5..94d790b8ed27 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -72,6 +72,7 @@
 
 #define ARM_LPAE_PTE_NSTABLE		(((arm_lpae_iopte)1) << 63)
 #define ARM_LPAE_PTE_XN			(((arm_lpae_iopte)3) << 53)
+#define ARM_LPAE_PTE_DBM		(((arm_lpae_iopte)1) << 51)
 #define ARM_LPAE_PTE_AF			(((arm_lpae_iopte)1) << 10)
 #define ARM_LPAE_PTE_SH_NS		(((arm_lpae_iopte)0) << 8)
 #define ARM_LPAE_PTE_SH_OS		(((arm_lpae_iopte)2) << 8)
@@ -81,7 +82,7 @@
 
 #define ARM_LPAE_PTE_ATTR_LO_MASK	(((arm_lpae_iopte)0x3ff) << 2)
 /* Ignore the contiguous bit for block splitting */
-#define ARM_LPAE_PTE_ATTR_HI_MASK	(((arm_lpae_iopte)6) << 52)
+#define ARM_LPAE_PTE_ATTR_HI_MASK	(((arm_lpae_iopte)13) << 51)
 #define ARM_LPAE_PTE_ATTR_MASK		(ARM_LPAE_PTE_ATTR_LO_MASK |	\
 					 ARM_LPAE_PTE_ATTR_HI_MASK)
 /* Software bit for solving coherency races */
@@ -379,6 +380,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 					   int prot)
 {
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
 	arm_lpae_iopte pte;
 
 	if (data->iop.fmt == ARM_64_LPAE_S1 ||
@@ -386,6 +388,9 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 		pte = ARM_LPAE_PTE_nG;
 		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
 			pte |= ARM_LPAE_PTE_AP_RDONLY;
+		else if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_HD)
+			pte |= ARM_LPAE_PTE_DBM;
+
 		if (!(prot & IOMMU_PRIV))
 			pte |= ARM_LPAE_PTE_AP_UNPRIV;
 	} else {
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index a4c9ca2c31f1..64cee6831c97 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -82,6 +82,8 @@ struct io_pgtable_cfg {
 	 *
 	 * IO_PGTABLE_QUIRK_ARM_OUTER_WBWA: Override the outer-cacheability
 	 *	attributes set in the TCR for a non-coherent page-table walker.
+	 *
+	 * IO_PGTABLE_QUIRK_ARM_HD: Support hardware management of dirty status.
 	 */
 	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0)
 	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1)
@@ -89,6 +91,7 @@ struct io_pgtable_cfg {
 	#define IO_PGTABLE_QUIRK_NON_STRICT	BIT(4)
 	#define IO_PGTABLE_QUIRK_ARM_TTBR1	BIT(5)
 	#define IO_PGTABLE_QUIRK_ARM_OUTER_WBWA	BIT(6)
+	#define IO_PGTABLE_QUIRK_ARM_HD		BIT(7)
 	unsigned long			quirks;
 	unsigned long			pgsize_bitmap;
 	unsigned int			ias;
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
