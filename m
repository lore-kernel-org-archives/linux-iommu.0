Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC0DC433F5
	for <iommu@archiver.kernel.org>; Mon, 23 May 2022 17:27:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 85ED140A68;
	Mon, 23 May 2022 17:27:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gQk5ATuU9Ur0; Mon, 23 May 2022 17:27:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5DDC24020B;
	Mon, 23 May 2022 17:27:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3042CC0032;
	Mon, 23 May 2022 17:27:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2459C002D
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 17:19:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D811740A68
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 17:19:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zrnQgo377l2a for <iommu@lists.linux-foundation.org>;
 Mon, 23 May 2022 17:19:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com
 [199.106.114.39])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9206240A1D
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 17:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1653326350; x=1684862350;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dHMAzDZ8V9eE7VWggUzuRgfi+1UxoewsEYqpet3YSy4=;
 b=xh/591GzDJScKjG8EJ2mPfwzqxIyL9XRGCSf4/Lx7ydPuFriRf6v5iV6
 rPr10oHbwt7rLbsRYhlPNsmHtnrZAqGHbOX8tODgYP9h8twviHo0ga/Y8
 RYCe6vh/kMlb0gUaQIsU8lzS7Iyu+BpVHlLoWsOu1RmI6nRDU1kTRToIP Q=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 23 May 2022 10:19:09 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2022 10:19:09 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 23 May 2022 10:19:08 -0700
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 23 May 2022 10:19:04 -0700
From: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>
Subject: [PATCH] iommu/arm-smmu-qcom: Add debug support for TLB sync timeouts
Date: Mon, 23 May 2022 22:48:47 +0530
Message-ID: <20220523171847.21929-1-quic_saipraka@quicinc.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Mailman-Approved-At: Mon, 23 May 2022 17:26:59 +0000
Cc: Rob Clark <robdclark@chromium.org>,
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 quic_guptap@quicinc.com, linux-arm-kernel@lists.infradead.org
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

TLB sync timeouts can be due to various reasons such as TBU power down
or pending TCU/TBU invalidation/sync and so on. Debugging these often
require dumping of some implementation defined registers to know the
status of TBU/TCU operations and some of these registers are not
accessible in non-secure world such as from kernel and requires SMC
calls to read them in the secure world. So, add this debug support
to dump implementation defined registers for TLB sync timeout issues.

Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 50 ++++++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.c      |  2 +
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  4 ++
 3 files changed, 56 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 7820711c4560..22e9a0085475 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -5,11 +5,19 @@
 
 #include <linux/acpi.h>
 #include <linux/adreno-smmu-priv.h>
+#include <linux/delay.h>
 #include <linux/of_device.h>
 #include <linux/qcom_scm.h>
 
 #include "arm-smmu.h"
 
+#define QCOM_DUMMY_VAL	-1
+
+/* Implementation Defined Register Space 0 registers */
+#define QCOM_SMMU_STATS_SYNC_INV_TBU_ACK	0x5dc
+#define QCOM_SMMU_TBU_PWR_STATUS		0x2204
+#define QCOM_SMMU_MMU2QSS_AND_SAFE_WAIT_CNTR	0x2670
+
 struct qcom_smmu {
 	struct arm_smmu_device smmu;
 	bool bypass_quirk;
@@ -22,6 +30,46 @@ static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
 	return container_of(smmu, struct qcom_smmu, smmu);
 }
 
+static void qcom_smmu_tlb_sync(struct arm_smmu_device *smmu, int page,
+				int sync, int status)
+{
+	u32 sync_inv_ack, sync_inv_progress, tbu_pwr_status;
+	unsigned int spin_cnt, delay;
+	u32 reg;
+	int ret;
+
+	arm_smmu_writel(smmu, page, sync, QCOM_DUMMY_VAL);
+	for (delay = 1; delay < TLB_LOOP_TIMEOUT; delay *= 2) {
+		for (spin_cnt = TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
+			reg = arm_smmu_readl(smmu, page, status);
+			if (!(reg & ARM_SMMU_sTLBGSTATUS_GSACTIVE))
+				return;
+			cpu_relax();
+		}
+		udelay(delay);
+	}
+
+	sync_inv_ack = arm_smmu_readl(smmu, ARM_SMMU_IMPL_DEF0,
+				      QCOM_SMMU_STATS_SYNC_INV_TBU_ACK);
+
+	ret = qcom_scm_io_readl(smmu->ioaddr + QCOM_SMMU_TBU_PWR_STATUS,
+				&tbu_pwr_status);
+	if (ret)
+		dev_err_ratelimited(smmu->dev,
+				    "Failed to read TBU power status: %d\n", ret);
+
+	ret = qcom_scm_io_readl(smmu->ioaddr + QCOM_SMMU_MMU2QSS_AND_SAFE_WAIT_CNTR,
+				&sync_inv_progress);
+	if (ret)
+		dev_err_ratelimited(smmu->dev,
+				    "Failed to read SAFE WAIT counter: %d\n", ret);
+
+	dev_err_ratelimited(smmu->dev,
+			    "TLB sync timed out -- SMMU may be deadlocked\n"
+			    "TBU: sync_inv_ack %#x power_status %#x sync_inv_progress %#x\n",
+			    sync_inv_ack, tbu_pwr_status, sync_inv_progress);
+}
+
 static void qcom_adreno_smmu_write_sctlr(struct arm_smmu_device *smmu, int idx,
 		u32 reg)
 {
@@ -374,6 +422,7 @@ static const struct arm_smmu_impl qcom_smmu_impl = {
 	.def_domain_type = qcom_smmu_def_domain_type,
 	.reset = qcom_smmu500_reset,
 	.write_s2cr = qcom_smmu_write_s2cr,
+	.tlb_sync = qcom_smmu_tlb_sync,
 };
 
 static const struct arm_smmu_impl qcom_adreno_smmu_impl = {
@@ -382,6 +431,7 @@ static const struct arm_smmu_impl qcom_adreno_smmu_impl = {
 	.reset = qcom_smmu500_reset,
 	.alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
 	.write_sctlr = qcom_adreno_smmu_write_sctlr,
+	.tlb_sync = qcom_smmu_tlb_sync,
 };
 
 static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 2ed3594f384e..4c5b51109835 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -2099,6 +2099,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (IS_ERR(smmu->base))
 		return PTR_ERR(smmu->base);
 	ioaddr = res->start;
+	smmu->ioaddr = ioaddr;
+
 	/*
 	 * The resource size should effectively match the value of SMMU_TOP;
 	 * stash that temporarily until we know PAGESIZE to validate it with.
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 2b9b42fb6f30..8cf6567d970f 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -278,6 +278,7 @@ struct arm_smmu_device {
 	struct device			*dev;
 
 	void __iomem			*base;
+	phys_addr_t			ioaddr;
 	unsigned int			numpage;
 	unsigned int			pgshift;
 
@@ -502,6 +503,9 @@ static inline void arm_smmu_writeq(struct arm_smmu_device *smmu, int page,
 
 #define ARM_SMMU_GR0		0
 #define ARM_SMMU_GR1		1
+
+#define ARM_SMMU_IMPL_DEF0	2
+
 #define ARM_SMMU_CB(s, n)	((s)->numpage + (n))
 
 #define arm_smmu_gr0_read(s, o)		\
-- 
2.33.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
