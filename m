Return-Path: <SRS0=xflu=WZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31459C3A59F
	for <iommu@archiver.kernel.org>; Thu, 29 Aug 2019 22:47:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F23842189D
	for <iommu@archiver.kernel.org>; Thu, 29 Aug 2019 22:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SETcj59p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23842189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6B1BA59E1;
	Thu, 29 Aug 2019 22:47:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8FAF459B7
	for <iommu@lists.linux-foundation.org>;
	Thu, 29 Aug 2019 22:45:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6C5E68A6
	for <iommu@lists.linux-foundation.org>;
	Thu, 29 Aug 2019 22:45:43 +0000 (UTC)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
	hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
	id <B5d6855990000>; Thu, 29 Aug 2019 15:45:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
	by hqpgpgate101.nvidia.com (PGP Universal service);
	Thu, 29 Aug 2019 15:45:42 -0700
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Thu, 29 Aug 2019 15:45:42 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
	(172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
	Thu, 29 Aug 2019 22:45:42 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL111.nvidia.com
	(172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via
	Frontend Transport; Thu, 29 Aug 2019 22:45:42 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by
	hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
	id <B5d6855960004>; Thu, 29 Aug 2019 15:45:42 -0700
From: Krishna Reddy <vdumpa@nvidia.com>
To: 
Subject: [PATCH 3/7] iommu/arm-smmu: Add tlb_sync implementation hook
Date: Thu, 29 Aug 2019 15:47:03 -0700
Message-ID: <1567118827-26358-4-git-send-email-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1567118827-26358-1-git-send-email-vdumpa@nvidia.com>
References: <1567118827-26358-1-git-send-email-vdumpa@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1567118745; bh=Qq0A43BsZP0MLsEUdMxePp0CnQyOBmpCwcS4GNqhIwI=;
	h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	In-Reply-To:References:X-NVConfidentiality:MIME-Version:
	Content-Type;
	b=SETcj59pTDZu7dAjxr+G4/tON0DucDkrqJmjU9b2Vp/j5mVgV506/KTY7TWiES7dq
	FSnXf78/9zCbPduY/VOxiTmw46udWor3aXVXHnx0FarTAMv07rRHDKG/MAXsRUPSbZ
	ZbrJWKJKfqIPB4MR/8ZBlwqTpvrCUBWnQrP6GzMeE0Cg7O4MI6u6w8y3NPVvDXQs0g
	CnnmuEG4sd0G7f3eNmwY3plnUx4zkub4xJCp4AozN622Mm41vEs4Kf5yWY0Kp6uHFp
	2ZsLVIBt+dnk69uHRIol44KO9enc8Xajmc1K7ng75HDHnbVtuqTMauRILHDKDN5Sr8
	qBLG9txfgjuCw==
Cc: snikam@nvidia.com, thomasz@nvidia.com, jtukkinen@nvidia.com,
	mperttunen@nvidia.com, praithatha@nvidia.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	talho@nvidia.com, yhsu@nvidia.com, linux-tegra@vger.kernel.org,
	treding@nvidia.com, avanbrunt@nvidia.com,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

tlb_sync hook allows nvidia smmu handle tlb sync
across multiple SMMUs as necessary.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 drivers/iommu/arm-smmu-nvidia.c | 32 ++++++++++++++++++++++++++++++++
 drivers/iommu/arm-smmu.c        |  8 +++++---
 drivers/iommu/arm-smmu.h        |  4 ++++
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu-nvidia.c b/drivers/iommu/arm-smmu-nvidia.c
index d93ceda..a429b2c 100644
--- a/drivers/iommu/arm-smmu-nvidia.c
+++ b/drivers/iommu/arm-smmu-nvidia.c
@@ -56,11 +56,43 @@ static void nsmmu_write_reg64(struct arm_smmu_device *smmu,
 		writeq_relaxed(val, nsmmu_page(smmu, i, page) + offset);
 }
 
+static void nsmmu_tlb_sync_wait(struct arm_smmu_device *smmu, int page,
+				int sync, int status, int inst)
+{
+	u32 reg;
+	unsigned int spin_cnt, delay;
+
+	for (delay = 1; delay < TLB_LOOP_TIMEOUT; delay *= 2) {
+		for (spin_cnt = TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
+			reg = readl_relaxed(
+			      nsmmu_page(smmu, inst, page) + status);
+			if (!(reg & sTLBGSTATUS_GSACTIVE))
+				return;
+			cpu_relax();
+		}
+		udelay(delay);
+	}
+	dev_err_ratelimited(smmu->dev,
+			    "TLB sync timed out -- SMMU may be deadlocked\n");
+}
+
+static void nsmmu_tlb_sync(struct arm_smmu_device *smmu, int page,
+			   int sync, int status)
+{
+	int i;
+
+	arm_smmu_writel(smmu, page, sync, 0);
+
+	for (i = 0; i < to_nsmmu(smmu)->num_inst; i++)
+		nsmmu_tlb_sync_wait(smmu, page, sync, status, i);
+}
+
 static const struct arm_smmu_impl nsmmu_impl = {
 	.read_reg = nsmmu_read_reg,
 	.write_reg = nsmmu_write_reg,
 	.read_reg64 = nsmmu_read_reg64,
 	.write_reg64 = nsmmu_write_reg64,
+	.tlb_sync = nsmmu_tlb_sync,
 };
 
 struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 46e1641..f5454e71 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -52,9 +52,6 @@
  */
 #define QCOM_DUMMY_VAL -1
 
-#define TLB_LOOP_TIMEOUT		1000000	/* 1s! */
-#define TLB_SPIN_COUNT			10
-
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
 
@@ -244,6 +241,11 @@ static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu, int page,
 	unsigned int spin_cnt, delay;
 	u32 reg;
 
+	if (smmu->impl->tlb_sync) {
+		smmu->impl->tlb_sync(smmu, page, sync, status);
+		return;
+	}
+
 	arm_smmu_writel(smmu, page, sync, QCOM_DUMMY_VAL);
 	for (delay = 1; delay < TLB_LOOP_TIMEOUT; delay *= 2) {
 		for (spin_cnt = TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index 9645bf1..d3217f1 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -207,6 +207,8 @@ enum arm_smmu_cbar_type {
 /* Maximum number of context banks per SMMU */
 #define ARM_SMMU_MAX_CBS		128
 
+#define TLB_LOOP_TIMEOUT		1000000	/* 1s! */
+#define TLB_SPIN_COUNT			10
 
 /* Shared driver definitions */
 enum arm_smmu_arch_version {
@@ -336,6 +338,8 @@ struct arm_smmu_impl {
 	int (*cfg_probe)(struct arm_smmu_device *smmu);
 	int (*reset)(struct arm_smmu_device *smmu);
 	int (*init_context)(struct arm_smmu_domain *smmu_domain);
+	void (*tlb_sync)(struct arm_smmu_device *smmu, int page, int sync,
+			 int status);
 };
 
 static inline void __iomem *arm_smmu_page(struct arm_smmu_device *smmu, int n)
-- 
2.1.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
