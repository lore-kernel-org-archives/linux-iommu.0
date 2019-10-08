Return-Path: <SRS0=3Hvu=YB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9301DC4360C
	for <iommu@archiver.kernel.org>; Tue,  8 Oct 2019 14:33:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C298206C2
	for <iommu@archiver.kernel.org>; Tue,  8 Oct 2019 14:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C298206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A0DCB100D;
	Tue,  8 Oct 2019 14:33:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6280EFE0
	for <iommu@lists.linux-foundation.org>;
	Tue,  8 Oct 2019 13:58:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D5AD08B0
	for <iommu@lists.linux-foundation.org>;
	Tue,  8 Oct 2019 13:58:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(Authenticated sender: eballetbo) with ESMTPSA id B380B28BFB9
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/rockchip: Don't loop until failure to count interrupts
Date: Tue,  8 Oct 2019 15:58:43 +0200
Message-Id: <20191008135843.30640-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 08 Oct 2019 14:33:02 +0000
Cc: heiko@sntech.de, dianders@chromium.org, linux-rockchip@lists.infradead.org,
	iommu@lists.linux-foundation.org, mka@chromium.org,
	groeck@chromium.org, kernel@collabora.com, bleung@chromium.org,
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

As platform_get_irq() now prints an error when the interrupt does not
exist, counting interrupts by looping until failure causes the printing
of scary messages like:

 rk_iommu ff924000.iommu: IRQ index 1 not found
 rk_iommu ff914000.iommu: IRQ index 1 not found
 rk_iommu ff903f00.iommu: IRQ index 1 not found
 rk_iommu ff8f3f00.iommu: IRQ index 1 not found
 rk_iommu ff650800.iommu: IRQ index 1 not found

Fix this by using the platform_irq_count() helper to avoid touching
non-existent interrupts.

Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to platform_get_irq*()")
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/iommu/rockchip-iommu.c | 35 +++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 26290f310f90..8c6318bd1b37 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1136,7 +1136,7 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	struct rk_iommu *iommu;
 	struct resource *res;
 	int num_res = pdev->num_resources;
-	int err, i, irq;
+	int err, i, irq, num_irqs;
 
 	iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
 	if (!iommu)
@@ -1219,20 +1219,28 @@ static int rk_iommu_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
-	i = 0;
-	while ((irq = platform_get_irq(pdev, i++)) != -ENXIO) {
-		if (irq < 0)
-			return irq;
+	num_irqs = platform_irq_count(pdev);
+	if (num_irqs < 0) {
+		err = num_irqs;
+		goto err_disable_pm_runtime;
+	}
+
+	for (i = 0; i < num_irqs; i++) {
+		irq = platform_get_irq(pdev, i);
+		if (irq < 0) {
+			err = irq;
+			goto err_disable_pm_runtime;
+		}
 
 		err = devm_request_irq(iommu->dev, irq, rk_iommu_irq,
 				       IRQF_SHARED, dev_name(dev), iommu);
-		if (err) {
-			pm_runtime_disable(dev);
-			goto err_remove_sysfs;
-		}
+		if (err)
+			goto err_disable_pm_runtime;
 	}
 
 	return 0;
+err_disable_pm_runtime:
+	pm_runtime_disable(dev);
 err_remove_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);
 err_put_group:
@@ -1245,10 +1253,15 @@ static int rk_iommu_probe(struct platform_device *pdev)
 static void rk_iommu_shutdown(struct platform_device *pdev)
 {
 	struct rk_iommu *iommu = platform_get_drvdata(pdev);
-	int i = 0, irq;
+	int i, irq, num_irqs;
 
-	while ((irq = platform_get_irq(pdev, i++)) != -ENXIO)
+	num_irqs = platform_irq_count(pdev);
+	for (i = 0; i < num_irqs; i++) {
+		irq = platform_get_irq(pdev, i);
+		if (irq < 0)
+			continue;
 		devm_free_irq(iommu->dev, irq, iommu);
+	}
 
 	pm_runtime_force_suspend(&pdev->dev);
 }
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
