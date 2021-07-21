Return-Path: <SRS0=85So=MN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98113C07E9B
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 01:36:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F23C61106
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 01:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F23C61106
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F0D9260833;
	Wed, 21 Jul 2021 01:36:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7luIV88YOmjn; Wed, 21 Jul 2021 01:36:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C45086059F;
	Wed, 21 Jul 2021 01:36:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C801C0010;
	Wed, 21 Jul 2021 01:36:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1254FC000E
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 01:36:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EEAD88301D
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 01:36:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oe6h0owWIWP2 for <iommu@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 01:36:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3CB3883004
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 01:36:24 +0000 (UTC)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GTyhB2GBJzYdZb;
 Wed, 21 Jul 2021 09:30:34 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 21 Jul 2021 09:36:20 +0800
Received: from huawei.com (10.174.28.241) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 21 Jul
 2021 09:36:20 +0800
From: Bixuan Cui <cuibixuan@huawei.com>
To: <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
 <will@kernel.org>
Subject: [PATCH -next] iommu/arm-smmu-v3: Add suspend and resume support
Date: Wed, 21 Jul 2021 09:33:50 +0800
Message-ID: <20210721013350.17664-1-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.174.28.241]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Cc: jean-philippe@linaro.org, john.wanghui@huawei.com, weiyongjun1@huawei.com,
 dingtianhong@huawei.com, guohanjun@huawei.com, cuibixuan@huawei.com,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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

Add suspend and resume support for arm-smmu-v3 by low-power mode.

When the smmu is suspended, it is powered off and the registers are
cleared. So saves the msi_msg context during msi interrupt initialization
of smmu. When resume happens it calls arm_smmu_device_reset() to restore
the registers.

Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
Reviewed-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Ding Tianhong <dingtianhong@huawei.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
---

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 72 ++++++++++++++++++---
 1 file changed, 64 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 235f9bdaeaf2..bf1163acbcb1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -40,6 +40,7 @@ MODULE_PARM_DESC(disable_bypass,
 
 static bool disable_msipolling;
 module_param(disable_msipolling, bool, 0444);
+static bool bypass;
 MODULE_PARM_DESC(disable_msipolling,
 	"Disable MSI-based polling for CMD_SYNC completion.");
 
@@ -3129,11 +3130,37 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
 	doorbell &= MSI_CFG0_ADDR_MASK;
 
+	/* Saves the msg context for resume if desc->msg is empty */
+	if (desc->msg.address_lo == 0 && desc->msg.address_hi == 0) {
+		desc->msg.address_lo = msg->address_lo;
+		desc->msg.address_hi = msg->address_hi;
+		desc->msg.data = msg->data;
+	}
+
 	writeq_relaxed(doorbell, smmu->base + cfg[0]);
 	writel_relaxed(msg->data, smmu->base + cfg[1]);
 	writel_relaxed(ARM_SMMU_MEMATTR_DEVICE_nGnRE, smmu->base + cfg[2]);
 }
 
+static void arm_smmu_resume_msis(struct arm_smmu_device *smmu)
+{
+	struct msi_desc *desc;
+	struct device *dev = smmu->dev;
+
+	for_each_msi_entry(desc, dev) {
+		switch (desc->platform.msi_index) {
+		case EVTQ_MSI_INDEX:
+		case GERROR_MSI_INDEX:
+		case PRIQ_MSI_INDEX:
+			arm_smmu_write_msi_msg(desc, &(desc->msg));
+			break;
+		default:
+			continue;
+
+		}
+	}
+}
+
 static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 {
 	struct msi_desc *desc;
@@ -3184,11 +3211,17 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 	devm_add_action(dev, arm_smmu_free_msis, dev);
 }
 
-static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
+static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu, bool resume_mode)
 {
 	int irq, ret;
 
-	arm_smmu_setup_msis(smmu);
+	if (!resume_mode)
+		arm_smmu_setup_msis(smmu);
+	else {
+		/* The irq doesn't need to be re-requested during resume */
+		arm_smmu_resume_msis(smmu);
+		return;
+	}
 
 	/* Request interrupt lines */
 	irq = smmu->evtq.q.irq;
@@ -3230,7 +3263,7 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
 	}
 }
 
-static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
+static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu, bool resume_mode)
 {
 	int ret, irq;
 	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
@@ -3257,7 +3290,7 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 		if (ret < 0)
 			dev_warn(smmu->dev, "failed to enable combined irq\n");
 	} else
-		arm_smmu_setup_unique_irqs(smmu);
+		arm_smmu_setup_unique_irqs(smmu, resume_mode);
 
 	if (smmu->features & ARM_SMMU_FEAT_PRI)
 		irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
@@ -3282,7 +3315,7 @@ static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
 	return ret;
 }
 
-static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
+static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool resume_mode)
 {
 	int ret;
 	u32 reg, enables;
@@ -3392,7 +3425,7 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 		}
 	}
 
-	ret = arm_smmu_setup_irqs(smmu);
+	ret = arm_smmu_setup_irqs(smmu, resume_mode);
 	if (ret) {
 		dev_err(smmu->dev, "failed to setup irqs\n");
 		return ret;
@@ -3749,6 +3782,24 @@ static void __iomem *arm_smmu_ioremap(struct device *dev, resource_size_t start,
 	return devm_ioremap_resource(dev, &res);
 }
 
+static int __maybe_unused arm_smmu_suspend(struct device *dev)
+{
+	/*
+	 * The smmu is powered off and related registers are automatically
+	 * cleared when suspend. No need to do anything.
+	 */
+	return 0;
+}
+
+static int __maybe_unused arm_smmu_resume(struct device *dev)
+{
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+
+	arm_smmu_device_reset(smmu, true);
+
+	return 0;
+}
+
 static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	int irq, ret;
@@ -3756,7 +3807,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	resource_size_t ioaddr;
 	struct arm_smmu_device *smmu;
 	struct device *dev = &pdev->dev;
-	bool bypass;
 
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
 	if (!smmu)
@@ -3831,7 +3881,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, smmu);
 
 	/* Reset the device */
-	ret = arm_smmu_device_reset(smmu, bypass);
+	ret = arm_smmu_device_reset(smmu, false);
 	if (ret)
 		return ret;
 
@@ -3884,6 +3934,11 @@ static const struct of_device_id arm_smmu_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
 
+static const struct dev_pm_ops arm_smmu_pm_ops = {
+	.suspend = arm_smmu_suspend,
+	.resume = arm_smmu_resume,
+};
+
 static void arm_smmu_driver_unregister(struct platform_driver *drv)
 {
 	arm_smmu_sva_notifier_synchronize();
@@ -3895,6 +3950,7 @@ static struct platform_driver arm_smmu_driver = {
 		.name			= "arm-smmu-v3",
 		.of_match_table		= arm_smmu_of_match,
 		.suppress_bind_attrs	= true,
+		.pm			= &arm_smmu_pm_ops,
 	},
 	.probe	= arm_smmu_device_probe,
 	.remove	= arm_smmu_device_remove,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
