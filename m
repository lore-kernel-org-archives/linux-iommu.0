Return-Path: <SRS0=TgA1=WD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78781C433FF
	for <iommu@archiver.kernel.org>; Wed,  7 Aug 2019 08:27:29 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D74C229F3
	for <iommu@archiver.kernel.org>; Wed,  7 Aug 2019 08:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r9RoPvV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D74C229F3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4DC2BF14;
	Wed,  7 Aug 2019 08:27:16 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 28C7EEE5
	for <iommu@lists.linux-foundation.org>;
	Wed,  7 Aug 2019 08:27:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 712A98AD
	for <iommu@lists.linux-foundation.org>;
	Wed,  7 Aug 2019 08:27:06 +0000 (UTC)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x778R3uk004248;
	Wed, 7 Aug 2019 03:27:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1565166423;
	bh=5MyWgGMqIpFePRNImDP7Pqj2enGVj9QfLqgvNMnfq+c=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=r9RoPvV6IugbTReFbuRkDZ5u0TXjdEFvrn6BT4t7/DLslr/5uQi7P6TthSqiKhiAn
	3lyqpnecA6m/DO66SBgRDgHpviRa8Xk2t6XOdN48kGraSer06sPjkTW6Iy2wDL2cu3
	QnR0ZzdZcAmd3JrgrSkTNrz0U1HNkes3KGIH5uRA=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x778R3xn100998
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2019 03:27:03 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE110.ent.ti.com
	(10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5;
	Wed, 7 Aug 2019 03:27:03 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
	(10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
	Frontend Transport; Wed, 7 Aug 2019 03:27:03 -0500
Received: from gomoku.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x778QwO3046515;
	Wed, 7 Aug 2019 03:27:02 -0500
To: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH 3/8] iommu/omap: streamline enable/disable through runtime pm
	callbacks
Date: Wed, 7 Aug 2019 11:26:47 +0300
Message-ID: <1565166412-31195-4-git-send-email-t-kristo@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565166412-31195-1-git-send-email-t-kristo@ti.com>
References: <1565166412-31195-1-git-send-email-t-kristo@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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
From: Tero Kristo via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tero Kristo <t-kristo@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Suman Anna <s-anna@ti.com>

The OMAP IOMMU devices are typically present within the respective
client processor subsystem and have their own dedicated hard-reset
line. Enabling an IOMMU requires the reset line to be deasserted
and the clocks to be enabled before programming the necessary IOMMU
registers. The IOMMU disable sequence follow the reverse order of
enabling. The OMAP IOMMU driver programs the reset lines through
pdata ops to invoke the omap_device_assert/deassert_hardreset API.
The clocks are managed through the pm_runtime framework, and the
callbacks associated with the device's pm_domain, implemented in
the omap_device layer.

Streamline the enable and disable sequences in the OMAP IOMMU
driver by implementing all the above operations within the
runtime pm callbacks. All the OMAP devices have device pm_domain
callbacks plugged in the omap_device layer for automatic runtime
management of the clocks. Invoking the reset management functions
within the runtime pm callbacks in OMAP IOMMU driver therefore
requires that the default device's pm domain callbacks in the
omap_device layer be reset, as the ordering sequence for managing
the reset lines and clocks from the pm_domain callbacks don't gel
well with the implementation in the IOMMU driver callbacks. The
omap_device_enable/omap_device_idle functions are invoked through
the newly added pdata ops.

Consolidating all the device management sequences within the
runtime pm callbacks allows the driver to easily support both
system suspend/resume and runtime suspend/resume using common
code.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/iommu/omap-iommu.c | 139 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 99 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 84b99d5..fbceae3 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -186,53 +186,18 @@ static void omap2_iommu_disable(struct omap_iommu *obj)
 
 static int iommu_enable(struct omap_iommu *obj)
 {
-	int err;
-	struct platform_device *pdev = to_platform_device(obj->dev);
-	struct iommu_platform_data *pdata = dev_get_platdata(&pdev->dev);
-
-	if (pdata && pdata->set_pwrdm_constraint) {
-		err = pdata->set_pwrdm_constraint(pdev, true, &obj->pwrst);
-		if (err) {
-			dev_warn(obj->dev, "pwrdm_constraint failed to be set, status = %d\n",
-				 err);
-		}
-	}
-
-	if (pdata && pdata->deassert_reset) {
-		err = pdata->deassert_reset(pdev, pdata->reset_name);
-		if (err) {
-			dev_err(obj->dev, "deassert_reset failed: %d\n", err);
-			return err;
-		}
-	}
-
-	pm_runtime_get_sync(obj->dev);
+	int ret;
 
-	err = omap2_iommu_enable(obj);
+	ret = pm_runtime_get_sync(obj->dev);
+	if (ret < 0)
+		pm_runtime_put_noidle(obj->dev);
 
-	return err;
+	return ret < 0 ? ret : 0;
 }
 
 static void iommu_disable(struct omap_iommu *obj)
 {
-	struct platform_device *pdev = to_platform_device(obj->dev);
-	struct iommu_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	int ret;
-
-	omap2_iommu_disable(obj);
-
 	pm_runtime_put_sync(obj->dev);
-
-	if (pdata && pdata->assert_reset)
-		pdata->assert_reset(pdev, pdata->reset_name);
-
-	if (pdata && pdata->set_pwrdm_constraint) {
-		ret = pdata->set_pwrdm_constraint(pdev, false, &obj->pwrst);
-		if (ret) {
-			dev_warn(obj->dev, "pwrdm_constraint failed to be reset, status = %d\n",
-				 ret);
-		}
-	}
 }
 
 /*
@@ -927,6 +892,85 @@ static void omap_iommu_detach(struct omap_iommu *obj)
 	dev_dbg(obj->dev, "%s: %s\n", __func__, obj->name);
 }
 
+/**
+ * omap_iommu_runtime_suspend - disable an iommu device
+ * @dev:	iommu device
+ *
+ * This function performs all that is necessary to disable an
+ * IOMMU device, either during final detachment from a client
+ * device, or during system/runtime suspend of the device. This
+ * includes programming all the appropriate IOMMU registers, and
+ * managing the associated omap_hwmod's state and the device's
+ * reset line.
+ **/
+static int omap_iommu_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct iommu_platform_data *pdata = dev_get_platdata(dev);
+	struct omap_iommu *obj = to_iommu(dev);
+	int ret;
+
+	omap2_iommu_disable(obj);
+
+	if (pdata && pdata->device_idle)
+		pdata->device_idle(pdev);
+
+	if (pdata && pdata->assert_reset)
+		pdata->assert_reset(pdev, pdata->reset_name);
+
+	if (pdata && pdata->set_pwrdm_constraint) {
+		ret = pdata->set_pwrdm_constraint(pdev, false, &obj->pwrst);
+		if (ret) {
+			dev_warn(obj->dev, "pwrdm_constraint failed to be reset, status = %d\n",
+				 ret);
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * omap_iommu_runtime_resume - enable an iommu device
+ * @dev:	iommu device
+ *
+ * This function performs all that is necessary to enable an
+ * IOMMU device, either during initial attachment to a client
+ * device, or during system/runtime resume of the device. This
+ * includes programming all the appropriate IOMMU registers, and
+ * managing the associated omap_hwmod's state and the device's
+ * reset line.
+ **/
+static int omap_iommu_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct iommu_platform_data *pdata = dev_get_platdata(dev);
+	struct omap_iommu *obj = to_iommu(dev);
+	int ret = 0;
+
+	if (pdata && pdata->set_pwrdm_constraint) {
+		ret = pdata->set_pwrdm_constraint(pdev, true, &obj->pwrst);
+		if (ret) {
+			dev_warn(obj->dev, "pwrdm_constraint failed to be set, status = %d\n",
+				 ret);
+		}
+	}
+
+	if (pdata && pdata->deassert_reset) {
+		ret = pdata->deassert_reset(pdev, pdata->reset_name);
+		if (ret) {
+			dev_err(dev, "deassert_reset failed: %d\n", ret);
+			return ret;
+		}
+	}
+
+	if (pdata && pdata->device_enable)
+		pdata->device_enable(pdev);
+
+	ret = omap2_iommu_enable(obj);
+
+	return ret;
+}
+
 static bool omap_iommu_can_register(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1001,6 +1045,15 @@ static int omap_iommu_probe(struct platform_device *pdev)
 	if (!obj)
 		return -ENOMEM;
 
+	/*
+	 * self-manage the ordering dependencies between omap_device_enable/idle
+	 * and omap_device_assert/deassert_hardreset API
+	 */
+	if (pdev->dev.pm_domain) {
+		dev_dbg(&pdev->dev, "device pm_domain is being reset\n");
+		pdev->dev.pm_domain = NULL;
+	}
+
 	obj->name = dev_name(&pdev->dev);
 	obj->nr_tlb_entries = 32;
 	err = of_property_read_u32(of, "ti,#tlb-entries", &obj->nr_tlb_entries);
@@ -1089,6 +1142,11 @@ static int omap_iommu_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct dev_pm_ops omap_iommu_pm_ops = {
+	SET_RUNTIME_PM_OPS(omap_iommu_runtime_suspend,
+			   omap_iommu_runtime_resume, NULL)
+};
+
 static const struct of_device_id omap_iommu_of_match[] = {
 	{ .compatible = "ti,omap2-iommu" },
 	{ .compatible = "ti,omap4-iommu" },
@@ -1102,6 +1160,7 @@ static int omap_iommu_remove(struct platform_device *pdev)
 	.remove	= omap_iommu_remove,
 	.driver	= {
 		.name	= "omap-iommu",
+		.pm	= &omap_iommu_pm_ops,
 		.of_match_table = of_match_ptr(omap_iommu_of_match),
 	},
 };
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
