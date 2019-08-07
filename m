Return-Path: <SRS0=TgA1=WD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D66FC433FF
	for <iommu@archiver.kernel.org>; Wed,  7 Aug 2019 08:27:39 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25065229F3
	for <iommu@archiver.kernel.org>; Wed,  7 Aug 2019 08:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sursHPen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25065229F3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9815FF08;
	Wed,  7 Aug 2019 08:27:16 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7B302E80
	for <iommu@lists.linux-foundation.org>;
	Wed,  7 Aug 2019 08:27:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F0C218A3
	for <iommu@lists.linux-foundation.org>;
	Wed,  7 Aug 2019 08:27:07 +0000 (UTC)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x778R5nA037332;
	Wed, 7 Aug 2019 03:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1565166425;
	bh=1JkVX/39+KcVKzo2wo4bvlUKzsw8HEs170pX/7orxlk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=sursHPendOIjxBu9oHX9zp4nJT2vuIUhVypZpdFeJCrGCqvlkp0U14SVp/bT+UvQ1
	rOM4fSSvYsx2B56gA5hgCBJUORR/qjgCK15ExLSg7OjoE0NeG+3Inj7i4Jahl0jvT8
	bmGX34j3YBNCGCjwziWfdq+Jr/WfBuudNaiS8Jf8=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x778R52v099112
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2019 03:27:05 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE114.ent.ti.com
	(157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5;
	Wed, 7 Aug 2019 03:27:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
	(157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
	Frontend Transport; Wed, 7 Aug 2019 03:27:05 -0500
Received: from gomoku.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x778QwO5046515;
	Wed, 7 Aug 2019 03:27:04 -0500
To: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH 5/8] iommu/omap: Add system suspend/resume support
Date: Wed, 7 Aug 2019 11:26:49 +0300
Message-ID: <1565166412-31195-6-git-send-email-t-kristo@ti.com>
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

The MMU registers for the remote processors lose their context
in Open Switch Retention (OSWR) or device OFF modes. Hence, the
context of the IOMMU needs to be saved before it is put into any
of these lower power state (OSWR/OFF) and restored before it is
powered up to ON again. The IOMMUs need to be active as long as
the client devices that are present behind the IOMMU are active.

This patch adds the dev_pm_ops callbacks to provide the system
suspend/resume functionality through the appropriate runtime
PM callbacks. The PM runtime_resume and runtime_suspend callbacks
are already used to enable, configure and disable the IOMMUs during
the attaching and detaching of the client devices to the IOMMUs,
and the new PM callbacks reuse the same code by invoking the
pm_runtime_force_suspend() and pm_runtime_force_resume() API. The
functionality in dev_pm_ops .prepare() checks if the IOMMU device
was already runtime suspended, and skips invoking the suspend/resume
PM callbacks. The suspend/resume PM callbacks are plugged in through
the 'late' pm ops to ensure that the IOMMU devices will be suspended
only after its master devices (remoteproc devices) are suspended and
restored before them.

NOTE:
There are two other existing API, omap_iommu_save_ctx() and
omap_iommu_restore_ctx(). These are left as is to support
suspend/resume of devices on legacy OMAP3 SoC.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/iommu/omap-iommu.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 51bf9d7..694cd38 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -65,6 +65,9 @@ static struct omap_iommu_domain *to_omap_domain(struct iommu_domain *dom)
 /**
  * omap_iommu_save_ctx - Save registers for pm off-mode support
  * @dev:	client device
+ *
+ * This should be treated as an deprecated API. It is preserved only
+ * to maintain existing functionality for OMAP3 ISP driver.
  **/
 void omap_iommu_save_ctx(struct device *dev)
 {
@@ -92,6 +95,9 @@ void omap_iommu_save_ctx(struct device *dev)
 /**
  * omap_iommu_restore_ctx - Restore registers for pm off-mode support
  * @dev:	client device
+ *
+ * This should be treated as an deprecated API. It is preserved only
+ * to maintain existing functionality for OMAP3 ISP driver.
  **/
 void omap_iommu_restore_ctx(struct device *dev)
 {
@@ -1021,6 +1027,23 @@ static int omap_iommu_runtime_resume(struct device *dev)
 	return ret;
 }
 
+/**
+ * omap_iommu_suspend_prepare - prepare() dev_pm_ops implementation
+ * @dev:	iommu device
+ *
+ * This function performs the necessary checks to determine if the IOMMU
+ * device needs suspending or not. The function checks if the runtime_pm
+ * status of the device is suspended, and returns 1 in that case. This
+ * results in the PM core to skip invoking any of the Sleep PM callbacks
+ * (suspend, suspend_late, resume, resume_early etc).
+ */
+static int omap_iommu_prepare(struct device *dev)
+{
+	if (pm_runtime_status_suspended(dev))
+		return 1;
+	return 0;
+}
+
 static bool omap_iommu_can_register(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1198,6 +1221,9 @@ static int omap_iommu_remove(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops omap_iommu_pm_ops = {
+	.prepare = omap_iommu_prepare,
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				     pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(omap_iommu_runtime_suspend,
 			   omap_iommu_runtime_resume, NULL)
 };
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
