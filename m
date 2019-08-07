Return-Path: <SRS0=TgA1=WD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E6BC19759
	for <iommu@archiver.kernel.org>; Wed,  7 Aug 2019 08:27:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31360229F5
	for <iommu@archiver.kernel.org>; Wed,  7 Aug 2019 08:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WPO618va"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31360229F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 739C7F18;
	Wed,  7 Aug 2019 08:27:16 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C1E2DE99
	for <iommu@lists.linux-foundation.org>;
	Wed,  7 Aug 2019 08:27:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 37E238A3
	for <iommu@lists.linux-foundation.org>;
	Wed,  7 Aug 2019 08:27:07 +0000 (UTC)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x778R49n037327;
	Wed, 7 Aug 2019 03:27:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1565166424;
	bh=ux/ukcAFZjt8RI619DU8FcXiJEILB94+rXCQe1oE+D4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=WPO618vavA8VhvtZr8Bd91M2uRyvsuhVwfWAVTHQRRQ7OFRSEbE2ZtvH6QXZ1XgI8
	nyHEQ6PRwQPMdbROk4NiK8Y8fAr4rdpjm7Kkf7GrQbmTs6uq4q6WFGNpHMi0vMvzr0
	Jadq6LYsVvUabLDsRAcK1NYzemCjpYa6olXZx23M=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x778R4Yw128720
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2019 03:27:04 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
	(157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5;
	Wed, 7 Aug 2019 03:27:04 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
	(157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
	Frontend Transport; Wed, 7 Aug 2019 03:27:04 -0500
Received: from gomoku.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x778QwO4046515;
	Wed, 7 Aug 2019 03:27:03 -0500
To: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH 4/8] iommu/omap: add logic to save/restore locked TLBs
Date: Wed, 7 Aug 2019 11:26:48 +0300
Message-ID: <1565166412-31195-5-git-send-email-t-kristo@ti.com>
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

The MMUs provide a mechanism to lock TLB entries to avoid
eviction and fetching of frequently used page table entries.
These TLBs lose context when the MMUs are turned OFF. Add the
logic to save and restore these locked TLBS during suspend
and resume respectively. There are no locked TLBs during
initial power ON, and they need not be saved during final
shutdown.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/iommu/omap-iommu.c | 61 +++++++++++++++++++++++++++++++++++++++++++---
 drivers/iommu/omap-iommu.h |  3 +++
 2 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index fbceae3..51bf9d7 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -883,15 +883,55 @@ static void omap_iommu_detach(struct omap_iommu *obj)
 
 	dma_unmap_single(obj->dev, obj->pd_dma, IOPGD_TABLE_SIZE,
 			 DMA_TO_DEVICE);
-	iommu_disable(obj);
 	obj->pd_dma = 0;
 	obj->iopgd = NULL;
+	iommu_disable(obj);
 
 	spin_unlock(&obj->iommu_lock);
 
 	dev_dbg(obj->dev, "%s: %s\n", __func__, obj->name);
 }
 
+static void omap_iommu_save_tlb_entries(struct omap_iommu *obj)
+{
+	struct iotlb_lock lock;
+	struct cr_regs cr;
+	struct cr_regs *tmp;
+	int i;
+
+	/* check if there are any locked tlbs to save */
+	iotlb_lock_get(obj, &lock);
+	obj->num_cr_ctx = lock.base;
+	if (!obj->num_cr_ctx)
+		return;
+
+	tmp = obj->cr_ctx;
+	for_each_iotlb_cr(obj, obj->num_cr_ctx, i, cr)
+		* tmp++ = cr;
+}
+
+static void omap_iommu_restore_tlb_entries(struct omap_iommu *obj)
+{
+	struct iotlb_lock l;
+	struct cr_regs *tmp;
+	int i;
+
+	/* no locked tlbs to restore */
+	if (!obj->num_cr_ctx)
+		return;
+
+	l.base = 0;
+	tmp = obj->cr_ctx;
+	for (i = 0; i < obj->num_cr_ctx; i++, tmp++) {
+		l.vict = i;
+		iotlb_lock_set(obj, &l);
+		iotlb_load_cr(obj, tmp);
+	}
+	l.base = obj->num_cr_ctx;
+	l.vict = i;
+	iotlb_lock_set(obj, &l);
+}
+
 /**
  * omap_iommu_runtime_suspend - disable an iommu device
  * @dev:	iommu device
@@ -901,7 +941,8 @@ static void omap_iommu_detach(struct omap_iommu *obj)
  * device, or during system/runtime suspend of the device. This
  * includes programming all the appropriate IOMMU registers, and
  * managing the associated omap_hwmod's state and the device's
- * reset line.
+ * reset line. This function also saves the context of any
+ * locked TLBs if suspending.
  **/
 static int omap_iommu_runtime_suspend(struct device *dev)
 {
@@ -910,6 +951,10 @@ static int omap_iommu_runtime_suspend(struct device *dev)
 	struct omap_iommu *obj = to_iommu(dev);
 	int ret;
 
+	/* save the TLBs only during suspend, and not for power down */
+	if (obj->domain && obj->iopgd)
+		omap_iommu_save_tlb_entries(obj);
+
 	omap2_iommu_disable(obj);
 
 	if (pdata && pdata->device_idle)
@@ -938,7 +983,8 @@ static int omap_iommu_runtime_suspend(struct device *dev)
  * device, or during system/runtime resume of the device. This
  * includes programming all the appropriate IOMMU registers, and
  * managing the associated omap_hwmod's state and the device's
- * reset line.
+ * reset line. The function also restores any locked TLBs if
+ * resuming after a suspend.
  **/
 static int omap_iommu_runtime_resume(struct device *dev)
 {
@@ -966,6 +1012,10 @@ static int omap_iommu_runtime_resume(struct device *dev)
 	if (pdata && pdata->device_enable)
 		pdata->device_enable(pdev);
 
+	/* restore the TLBs only during resume, and not for power up */
+	if (obj->domain)
+		omap_iommu_restore_tlb_entries(obj);
+
 	ret = omap2_iommu_enable(obj);
 
 	return ret;
@@ -1066,6 +1116,11 @@ static int omap_iommu_probe(struct platform_device *pdev)
 
 	obj->dev = &pdev->dev;
 	obj->ctx = (void *)obj + sizeof(*obj);
+	obj->cr_ctx = devm_kzalloc(&pdev->dev,
+				   sizeof(*obj->cr_ctx) * obj->nr_tlb_entries,
+				   GFP_KERNEL);
+	if (!obj->cr_ctx)
+		return -ENOMEM;
 
 	spin_lock_init(&obj->iommu_lock);
 	spin_lock_init(&obj->page_table_lock);
diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index aac1ca6..1d15aa8 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -73,6 +73,9 @@ struct omap_iommu {
 
 	void *ctx; /* iommu context: registres saved area */
 
+	struct cr_regs *cr_ctx;
+	u32 num_cr_ctx;
+
 	int has_bus_err_back;
 	u32 id;
 
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
