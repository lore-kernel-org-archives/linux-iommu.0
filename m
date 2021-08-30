Return-Path: <SRS0=sxdJ=NV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E3CC432BE
	for <iommu@archiver.kernel.org>; Mon, 30 Aug 2021 07:42:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 801556023F
	for <iommu@archiver.kernel.org>; Mon, 30 Aug 2021 07:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 801556023F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 401C360759;
	Mon, 30 Aug 2021 07:42:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z1Lzb8iNNUaD; Mon, 30 Aug 2021 07:42:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 133DB60757;
	Mon, 30 Aug 2021 07:42:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9068C0010;
	Mon, 30 Aug 2021 07:42:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D67AAC000E
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 07:42:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D37EC80E79
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 07:42:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o5qFSnxZ8OI7 for <iommu@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 07:42:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0F90F80E78
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 07:42:39 +0000 (UTC)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Gyj2C6YX1z1DDww;
 Mon, 30 Aug 2021 15:41:55 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 30 Aug 2021 15:42:35 +0800
Received: from huawei.com (10.174.28.241) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 30 Aug
 2021 15:42:34 +0800
From: Bixuan Cui <cuibixuan@huawei.com>
To: <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next v4 2/2] iommu/arm-smmu-v3: Add suspend and resume support
Date: Mon, 30 Aug 2021 15:38:58 +0800
Message-ID: <20210830073858.47084-2-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210830073858.47084-1-cuibixuan@huawei.com>
References: <20210830073858.47084-1-cuibixuan@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.28.241]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Cc: jean-philippe@linaro.org, maz@kernel.org, rafael@kernel.org,
 gregkh@linuxfoundation.org, robin.murphy@arm.com, will@kernel.org,
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
Changes in v4:
* Restore the arm_smmu_suspend() function code to the v2 version(Directly return 0 in it).

Changes in v3:
* Move the code of save msg context into msi platform (A new patch: "platform-msi: Save the msg context to desc in platform_msi_write_msg()").

* Add bypass member to the struct arm_smmu_device for per-SMMU bypass control(used by resume mode).

* Separate interrupt requests and register operations in arm_smmu_device_reset(). The arm_smmu_setup_irqs() is added to request interrupts and is called before arm_smmu_device_reset(). The arm_smmu_device_reset() resets irq registers (can also be called in resume mode).

Changes in v2:
* Using get_cached_msi_msg() instead of the descriptor to resume msi_msg
  in arm_smmu_resume_msis();

* Move arm_smmu_resume_msis() from arm_smmu_setup_unique_irqs() into
  arm_smmu_setup_irqs() and rename it to arm_smmu_resume_unique_irqs();

  Call arm_smmu_setup_unique_irqs() to configure the IRQ during probe and
  call arm_smmu_resume_unique_irqs() in resume mode to restore the IRQ
  registers to make the code more reasonable.

* Call arm_smmu_device_disable() to disable smmu and clear CR0_SMMUEN on
  suspend. Then the warning about CR0_SMMUEN being enabled can be cleared
  on resume.

* Using SET_SYSTEM_SLEEP_PM_OPS();
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 94 +++++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 2 files changed, 88 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a388e318f86e..af6752a735bb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3282,6 +3282,61 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+static void arm_smmu_reset_unique_irqs(struct arm_smmu_device *smmu)
+{
+	struct msi_desc *desc;
+	struct msi_msg msg;
+
+	desc = irq_get_msi_desc(smmu->evtq.q.irq);
+	if (desc) {
+		get_cached_msi_msg(smmu->evtq.q.irq, &msg);
+		arm_smmu_write_msi_msg(desc, &msg);
+	}
+
+	desc = irq_get_msi_desc(smmu->gerr_irq);
+	if (desc) {
+		get_cached_msi_msg(smmu->gerr_irq, &msg);
+		arm_smmu_write_msi_msg(desc, &msg);
+	}
+
+	if (smmu->features & ARM_SMMU_FEAT_PRI) {
+		desc = irq_get_msi_desc(smmu->priq.q.irq);
+		if (desc) {
+			get_cached_msi_msg(smmu->priq.q.irq, &msg);
+			arm_smmu_write_msi_msg(desc, &msg);
+		}
+	}
+}
+
+static int arm_smmu_reset_irqs(struct arm_smmu_device *smmu)
+{
+	int ret, irq;
+	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
+
+	/* Disable IRQs first */
+	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
+				      ARM_SMMU_IRQ_CTRLACK);
+	if (ret) {
+		dev_err(smmu->dev, "failed to disable irqs\n");
+		return ret;
+	}
+
+	irq = smmu->combined_irq;
+	if (!irq)
+		arm_smmu_reset_unique_irqs(smmu);
+
+	if (smmu->features & ARM_SMMU_FEAT_PRI)
+		irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
+
+	/* Enable interrupt generation on the SMMU */
+	ret = arm_smmu_write_reg_sync(smmu, irqen_flags,
+				      ARM_SMMU_IRQ_CTRL, ARM_SMMU_IRQ_CTRLACK);
+	if (ret)
+		dev_warn(smmu->dev, "failed to reset irqs\n");
+
+	return 0;
+}
+
 static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
 {
 	int ret;
@@ -3293,7 +3348,7 @@ static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
 	return ret;
 }
 
-static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
+static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 {
 	int ret;
 	u32 reg, enables;
@@ -3401,9 +3456,9 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 		}
 	}
 
-	ret = arm_smmu_setup_irqs(smmu);
+	ret = arm_smmu_reset_irqs(smmu);
 	if (ret) {
-		dev_err(smmu->dev, "failed to setup irqs\n");
+		dev_err(smmu->dev, "failed to reset irqs\n");
 		return ret;
 	}
 
@@ -3411,7 +3466,7 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
 
 	/* Enable the SMMU interface, or ensure bypass */
-	if (!bypass || disable_bypass) {
+	if (!smmu->bypass || disable_bypass) {
 		enables |= CR0_SMMUEN;
 	} else {
 		ret = arm_smmu_update_gbpa(smmu, 0, GBPA_ABORT);
@@ -3758,6 +3813,20 @@ static void __iomem *arm_smmu_ioremap(struct device *dev, resource_size_t start,
 	return devm_ioremap_resource(dev, &res);
 }
 
+static int __maybe_unused arm_smmu_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int __maybe_unused arm_smmu_resume(struct device *dev)
+{
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+
+	arm_smmu_device_reset(smmu);
+
+	return 0;
+}
+
 static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	int irq, ret;
@@ -3765,7 +3834,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	resource_size_t ioaddr;
 	struct arm_smmu_device *smmu;
 	struct device *dev = &pdev->dev;
-	bool bypass;
 
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
 	if (!smmu)
@@ -3781,7 +3849,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	}
 
 	/* Set bypass mode according to firmware probing result */
-	bypass = !!ret;
+	smmu->bypass = !!ret;
 
 	/* Base address */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -3839,8 +3907,15 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	/* Record our private device structure */
 	platform_set_drvdata(pdev, smmu);
 
+	/* Setup irqs */
+	ret = arm_smmu_setup_irqs(smmu);
+	if (ret) {
+		dev_err(smmu->dev, "failed to setup irqs\n");
+		return ret;
+	}
+
 	/* Reset the device */
-	ret = arm_smmu_device_reset(smmu, bypass);
+	ret = arm_smmu_device_reset(smmu);
 	if (ret)
 		return ret;
 
@@ -3893,6 +3968,10 @@ static const struct of_device_id arm_smmu_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
 
+static const struct dev_pm_ops arm_smmu_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(arm_smmu_suspend, arm_smmu_resume)
+};
+
 static void arm_smmu_driver_unregister(struct platform_driver *drv)
 {
 	arm_smmu_sva_notifier_synchronize();
@@ -3904,6 +3983,7 @@ static struct platform_driver arm_smmu_driver = {
 		.name			= "arm-smmu-v3",
 		.of_match_table		= arm_smmu_of_match,
 		.suppress_bind_attrs	= true,
+		.pm			= &arm_smmu_pm_ops,
 	},
 	.probe	= arm_smmu_device_probe,
 	.remove	= arm_smmu_device_remove,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 4cb136f07914..7777a7445bc2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -675,6 +675,7 @@ struct arm_smmu_device {
 
 	struct rb_root			streams;
 	struct mutex			streams_mutex;
+	bool				bypass;
 };
 
 struct arm_smmu_stream {
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
