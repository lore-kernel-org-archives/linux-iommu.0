Return-Path: <SRS0=Qw1r=KC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA295C433ED
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 10:22:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A81561463
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 10:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A81561463
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B420740143;
	Fri,  7 May 2021 10:22:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aMarn416ZppS; Fri,  7 May 2021 10:22:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7B8484064B;
	Fri,  7 May 2021 10:22:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F692C0028;
	Fri,  7 May 2021 10:22:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D7B2C0001
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 10:22:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 692D840002
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 10:22:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zXPva9K9vl65 for <iommu@lists.linux-foundation.org>;
 Fri,  7 May 2021 10:22:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 52C0B40143
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 10:22:46 +0000 (UTC)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fc5z25tfrzqT8q;
 Fri,  7 May 2021 18:19:26 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.224) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Fri, 7 May 2021 18:22:37 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 "Will Deacon" <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 "Jean-Philippe Brucker" <jean-philippe@linaro.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, "Yi Sun" <yi.y.sun@linux.intel.com>, Tian Kevin
 <kevin.tian@intel.com>
Subject: [RFC PATCH v4 07/13] iommu/arm-smmu-v3: Add support for Hardware
 Translation Table Update
Date: Fri, 7 May 2021 18:22:05 +0800
Message-ID: <20210507102211.8836-8-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210507102211.8836-1-zhukeqian1@huawei.com>
References: <20210507102211.8836-1-zhukeqian1@huawei.com>
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

If the SMMU supports it and the kernel was built with HTTU support,
enable hardware update of access and dirty flags. This is essential for
shared page tables, to reduce the number of access faults on the fault
queue. Normal DMA with io-pgtables doesn't currently use the access or
dirty flags.

We can enable HTTU even if CPUs don't support it, because the kernel
always checks for HW dirty bit and updates the PTE flags atomically.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  2 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 41 ++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  8 ++++
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index bb251cab61f3..ae075e675892 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -121,10 +121,12 @@ static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
 	if (err)
 		goto out_free_asid;
 
+	/* HA and HD will be filtered out later if not supported by the SMMU */
 	tcr = FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, 64ULL - vabits_actual) |
 	      FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0, ARM_LPAE_TCR_RGN_WBWA) |
 	      FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0, ARM_LPAE_TCR_RGN_WBWA) |
 	      FIELD_PREP(CTXDESC_CD_0_TCR_SH0, ARM_LPAE_TCR_SH_IS) |
+	      CTXDESC_CD_0_TCR_HA | CTXDESC_CD_0_TCR_HD |
 	      CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
 
 	switch (PAGE_SIZE) {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 54b2f27b81d4..4ac59a89bc76 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1010,10 +1010,17 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 		 * this substream's traffic
 		 */
 	} else { /* (1) and (2) */
+		u64 tcr = cd->tcr;
+
 		cdptr[1] = cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TTB0_MASK);
 		cdptr[2] = 0;
 		cdptr[3] = cpu_to_le64(cd->mair);
 
+		if (!(smmu->features & ARM_SMMU_FEAT_HD))
+			tcr &= ~CTXDESC_CD_0_TCR_HD;
+		if (!(smmu->features & ARM_SMMU_FEAT_HA))
+			tcr &= ~CTXDESC_CD_0_TCR_HA;
+
 		/*
 		 * STE is live, and the SMMU might read dwords of this CD in any
 		 * order. Ensure that it observes valid values before reading
@@ -1021,7 +1028,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 		 */
 		arm_smmu_sync_cd(smmu_domain, ssid, true);
 
-		val = cd->tcr |
+		val = tcr |
 #ifdef __BIG_ENDIAN
 			CTXDESC_CD_0_ENDI |
 #endif
@@ -3242,6 +3249,28 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	return 0;
 }
 
+static void arm_smmu_get_httu(struct arm_smmu_device *smmu, u32 reg)
+{
+	u32 fw_features = smmu->features & (ARM_SMMU_FEAT_HA | ARM_SMMU_FEAT_HD);
+	u32 features = 0;
+
+	switch (FIELD_GET(IDR0_HTTU, reg)) {
+	case IDR0_HTTU_ACCESS_DIRTY:
+		features |= ARM_SMMU_FEAT_HD;
+		fallthrough;
+	case IDR0_HTTU_ACCESS:
+		features |= ARM_SMMU_FEAT_HA;
+	}
+
+	if (smmu->dev->of_node)
+		smmu->features |= features;
+	else if (features != fw_features)
+		/* ACPI IORT sets the HTTU bits */
+		dev_warn(smmu->dev,
+			 "IDR0.HTTU overridden by FW configuration (0x%x)\n",
+			 fw_features);
+}
+
 static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 {
 	u32 reg;
@@ -3302,6 +3331,8 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 			smmu->features |= ARM_SMMU_FEAT_E2H;
 	}
 
+	arm_smmu_get_httu(smmu, reg);
+
 	/*
 	 * The coherency feature as set by FW is used in preference to the ID
 	 * register, but warn on mismatch.
@@ -3487,6 +3518,14 @@ static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
 	if (iort_smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE)
 		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
 
+	switch (FIELD_GET(ACPI_IORT_SMMU_V3_HTTU_OVERRIDE, iort_smmu->flags)) {
+	case IDR0_HTTU_ACCESS_DIRTY:
+		smmu->features |= ARM_SMMU_FEAT_HD;
+		fallthrough;
+	case IDR0_HTTU_ACCESS:
+		smmu->features |= ARM_SMMU_FEAT_HA;
+	}
+
 	return 0;
 }
 #else
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 46e8c49214a8..3edcd31b046e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -33,6 +33,9 @@
 #define IDR0_ASID16			(1 << 12)
 #define IDR0_ATS			(1 << 10)
 #define IDR0_HYP			(1 << 9)
+#define IDR0_HTTU			GENMASK(7, 6)
+#define IDR0_HTTU_ACCESS		1
+#define IDR0_HTTU_ACCESS_DIRTY		2
 #define IDR0_COHACC			(1 << 4)
 #define IDR0_TTF			GENMASK(3, 2)
 #define IDR0_TTF_AARCH64		2
@@ -285,6 +288,9 @@
 #define CTXDESC_CD_0_TCR_IPS		GENMASK_ULL(34, 32)
 #define CTXDESC_CD_0_TCR_TBI0		(1ULL << 38)
 
+#define CTXDESC_CD_0_TCR_HA		(1UL << 43)
+#define CTXDESC_CD_0_TCR_HD		(1UL << 42)
+
 #define CTXDESC_CD_0_AA64		(1UL << 41)
 #define CTXDESC_CD_0_S			(1UL << 44)
 #define CTXDESC_CD_0_R			(1UL << 45)
@@ -605,6 +611,8 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_BTM		(1 << 16)
 #define ARM_SMMU_FEAT_SVA		(1 << 17)
 #define ARM_SMMU_FEAT_E2H		(1 << 18)
+#define ARM_SMMU_FEAT_HA		(1 << 19)
+#define ARM_SMMU_FEAT_HD		(1 << 20)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
