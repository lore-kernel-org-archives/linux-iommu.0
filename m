Return-Path: <SRS0=v9UM=BK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BAFC433DF
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 08:36:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DC1F20663
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 08:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DC1F20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1A65385B48;
	Fri, 31 Jul 2020 08:36:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wKA9F2ftL-K2; Fri, 31 Jul 2020 08:36:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D7CC881E90;
	Fri, 31 Jul 2020 08:36:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDD39C004F;
	Fri, 31 Jul 2020 08:36:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 173B3C004D
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 08:36:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0006988380
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 08:36:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yQtwb-1hYhzx for <iommu@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 08:36:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6133987872
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 08:36:18 +0000 (UTC)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 010F79E672849775E290;
 Fri, 31 Jul 2020 16:36:14 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.132) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Fri, 31 Jul 2020 16:36:03 +0800
From: Barry Song <song.bao.hua@hisilicon.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v2] iommu/arm-smmu-v3: disable MSI polling if SEV polling is
 faster
Date: Fri, 31 Jul 2020 20:33:43 +1200
Message-ID: <20200731083343.18152-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.126.203.132]
X-CFilter-Loop: Reflected
Cc: Prime Zeng <prime.zeng@hisilicon.com>, linuxarm@huawei.com,
 linux-arm-kernel@lists.infradead.org
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

Different implementations may show different performance by using SEV
polling or MSI polling.
On the implementation of hi1620, tests show disabling MSI polling can
bring performance improvement.
Using 16 threads to run netperf on hns3 100G NIC with UDP packet size
in 32768bytes and set iommu to strict, TX throughput can improve from
25Gbps to 27Gbps by this patch.
This patch adds a generic function to support implementation options
based on IIDR and disables MSI polling if IIDR matches the specific
implementation tested.

Cc: Prime Zeng <prime.zeng@hisilicon.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v2: rather than disabling msipolling globally, only disable it for
 specific implementation based on IIDR

 drivers/iommu/arm-smmu-v3.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f578677a5c41..ed5a6774eb45 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -88,6 +88,12 @@
 #define IDR5_VAX			GENMASK(11, 10)
 #define IDR5_VAX_52_BIT			1
 
+#define ARM_SMMU_IIDR			0x18
+#define IIDR_VARIANT			GENMASK(19, 16)
+#define IIDR_REVISION			GENMASK(15, 12)
+#define IIDR_IMPLEMENTER		GENMASK(11, 0)
+#define IMPLEMENTER_HISILICON		0x736
+
 #define ARM_SMMU_CR0			0x20
 #define CR0_ATSCHK			(1 << 4)
 #define CR0_CMDQEN			(1 << 3)
@@ -652,6 +658,7 @@ struct arm_smmu_device {
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
 #define ARM_SMMU_OPT_PAGE0_REGS_ONLY	(1 << 1)
+#define ARM_SMMU_OPT_DISABLE_MSIPOLL    (1 << 2)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
@@ -992,7 +999,8 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 	 * Beware that Hi16xx adds an extra 32 bits of goodness to its MSI
 	 * payload, so the write will zero the entire command on that platform.
 	 */
-	if (smmu->features & ARM_SMMU_FEAT_MSI &&
+	if (!(smmu->options & ARM_SMMU_OPT_DISABLE_MSIPOLL) &&
+	    smmu->features & ARM_SMMU_FEAT_MSI &&
 	    smmu->features & ARM_SMMU_FEAT_COHERENCY) {
 		ent.sync.msiaddr = q->base_dma + Q_IDX(&q->llq, prod) *
 				   q->ent_dwords * 8;
@@ -1332,7 +1340,8 @@ static int __arm_smmu_cmdq_poll_until_consumed(struct arm_smmu_device *smmu,
 static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
 					 struct arm_smmu_ll_queue *llq)
 {
-	if (smmu->features & ARM_SMMU_FEAT_MSI &&
+	if (!(smmu->options & ARM_SMMU_OPT_DISABLE_MSIPOLL) &&
+	    smmu->features & ARM_SMMU_FEAT_MSI &&
 	    smmu->features & ARM_SMMU_FEAT_COHERENCY)
 		return __arm_smmu_cmdq_poll_until_msi(smmu, llq);
 
@@ -3693,6 +3702,21 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	return 0;
 }
 
+static void acpi_smmu_get_implementation_options(struct arm_smmu_device *smmu)
+{
+	/*
+	 * IIDR provides information about the implementation and implementer of
+	 * the SMMU
+	 */
+	u32 iidr = readl_relaxed(smmu->base + ARM_SMMU_IIDR);
+	u32 implementer = FIELD_GET(IIDR_IMPLEMENTER, iidr);
+	u32 variant = FIELD_GET(IIDR_VARIANT, iidr);
+	u32 revision = FIELD_GET(IIDR_REVISION, iidr);
+
+	if (implementer == IMPLEMENTER_HISILICON && variant == 3 && revision == 0)
+		smmu->options |= ARM_SMMU_OPT_DISABLE_MSIPOLL;
+}
+
 static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 {
 	u32 reg;
@@ -3892,6 +3916,9 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	smmu->ias = max(smmu->ias, smmu->oas);
 
+	/* set implementation-related options according to IIDR */
+	acpi_smmu_get_implementation_options(smmu);
+
 	dev_info(smmu->dev, "ias %lu-bit, oas %lu-bit (features 0x%08x)\n",
 		 smmu->ias, smmu->oas, smmu->features);
 	return 0;
-- 
2.27.0


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
