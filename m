Return-Path: <SRS0=TgA1=WD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239C5C433FF
	for <iommu@archiver.kernel.org>; Wed,  7 Aug 2019 08:27:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC0D4229F3
	for <iommu@archiver.kernel.org>; Wed,  7 Aug 2019 08:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CnxDOTPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0D4229F3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2768CEFB;
	Wed,  7 Aug 2019 08:27:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id ECAE1EF7
	for <iommu@lists.linux-foundation.org>;
	Wed,  7 Aug 2019 08:27:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5E4AA829
	for <iommu@lists.linux-foundation.org>;
	Wed,  7 Aug 2019 08:27:10 +0000 (UTC)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x778R7qr122279;
	Wed, 7 Aug 2019 03:27:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1565166427;
	bh=xANViarARXT5927ZzN75bHfT5k3BBMObhtbSnF1uJA0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=CnxDOTPpubCDoeY1SBnDoHwOlq/R5jes4Gav1mhnvakEgih6N13s4vno0watU2xlC
	RF2ZuWi3ZfCk7RhSThKzCc/WE5mg0Rw6AIhyTGnRMEqBxEHE37I+LV0jfhJUdyBMSJ
	pgaaAcdFedTjqt3tDziQhf7Zmzheu5B0MHV1PfM0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x778R7xg101126
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2019 03:27:07 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
	(10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5;
	Wed, 7 Aug 2019 03:27:07 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
	(10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
	Frontend Transport; Wed, 7 Aug 2019 03:27:07 -0500
Received: from gomoku.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x778QwO7046515;
	Wed, 7 Aug 2019 03:27:06 -0500
To: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH 7/8] iommu/omap: add support for late attachment of iommu
	devices
Date: Wed, 7 Aug 2019 11:26:51 +0300
Message-ID: <1565166412-31195-8-git-send-email-t-kristo@ti.com>
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

Current implementation of OMAP IOMMU enforces strict ordering of device
probe, initiated by iommu and followed by remoteproc later. This doesn't
work too well with the new setup done with ti-sysc changes which may
have the devices probed at pretty much any order. To overcome this limitation,
if iommu has not been probed yet when a consumer tries to attach to it,
add the device to orphan device list which will be parsed during iommu
probe to see if any orphan devices should be attached.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/iommu/omap-iommu.c | 56 +++++++++++++++++++++++++++++++++++++++++++---
 drivers/iommu/omap-iommu.h |  4 +++-
 2 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 5e0dfca..1beb318 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -35,6 +35,15 @@
 
 static const struct iommu_ops omap_iommu_ops;
 
+struct orphan_dev {
+	struct device *dev;
+	struct list_head node;
+};
+
+static LIST_HEAD(orphan_dev_list);
+
+static DEFINE_SPINLOCK(orphan_lock);
+
 #define to_iommu(dev)	((struct omap_iommu *)dev_get_drvdata(dev))
 
 /* bitmap of the page sizes currently supported */
@@ -53,6 +62,8 @@
 static struct platform_driver omap_iommu_driver;
 static struct kmem_cache *iopte_cachep;
 
+static int _omap_iommu_add_device(struct device *dev);
+
 /**
  * to_omap_domain - Get struct omap_iommu_domain from generic iommu_domain
  * @dom:	generic iommu domain handle
@@ -1166,6 +1177,7 @@ static int omap_iommu_probe(struct platform_device *pdev)
 	struct omap_iommu *obj;
 	struct resource *res;
 	struct device_node *of = pdev->dev.of_node;
+	struct orphan_dev *orphan_dev, *tmp;
 
 	if (!of) {
 		pr_err("%s: only DT-based devices are supported\n", __func__);
@@ -1249,6 +1261,14 @@ static int omap_iommu_probe(struct platform_device *pdev)
 
 	dev_info(&pdev->dev, "%s registered\n", obj->name);
 
+	list_for_each_entry_safe(orphan_dev, tmp, &orphan_dev_list, node) {
+		err = _omap_iommu_add_device(orphan_dev->dev);
+		if (!err) {
+			list_del(&orphan_dev->node);
+			kfree(orphan_dev);
+		}
+	}
+
 	return 0;
 
 out_sysfs:
@@ -1638,7 +1658,7 @@ static phys_addr_t omap_iommu_iova_to_phys(struct iommu_domain *domain,
 	return ret;
 }
 
-static int omap_iommu_add_device(struct device *dev)
+static int _omap_iommu_add_device(struct device *dev)
 {
 	struct omap_iommu_arch_data *arch_data, *tmp;
 	struct omap_iommu *oiommu;
@@ -1647,6 +1667,8 @@ static int omap_iommu_add_device(struct device *dev)
 	struct platform_device *pdev;
 	int num_iommus, i;
 	int ret;
+	struct orphan_dev *orphan_dev;
+	unsigned long flags;
 
 	/*
 	 * Allocate the archdata iommu structure for DT-based devices.
@@ -1678,10 +1700,26 @@ static int omap_iommu_add_device(struct device *dev)
 		}
 
 		pdev = of_find_device_by_node(np);
-		if (WARN_ON(!pdev)) {
+		if (!pdev) {
 			of_node_put(np);
 			kfree(arch_data);
-			return -EINVAL;
+			spin_lock_irqsave(&orphan_lock, flags);
+			list_for_each_entry(orphan_dev, &orphan_dev_list,
+					    node) {
+				if (orphan_dev->dev == dev)
+					break;
+			}
+			spin_unlock_irqrestore(&orphan_lock, flags);
+
+			if (orphan_dev && orphan_dev->dev == dev)
+				return -EPROBE_DEFER;
+
+			orphan_dev = kzalloc(sizeof(*orphan_dev), GFP_KERNEL);
+			orphan_dev->dev = dev;
+			spin_lock_irqsave(&orphan_lock, flags);
+			list_add(&orphan_dev->node, &orphan_dev_list);
+			spin_unlock_irqrestore(&orphan_lock, flags);
+			return -EPROBE_DEFER;
 		}
 
 		oiommu = platform_get_drvdata(pdev);
@@ -1692,6 +1730,7 @@ static int omap_iommu_add_device(struct device *dev)
 		}
 
 		tmp->iommu_dev = oiommu;
+		tmp->dev = &pdev->dev;
 
 		of_node_put(np);
 	}
@@ -1726,6 +1765,17 @@ static int omap_iommu_add_device(struct device *dev)
 	return 0;
 }
 
+static int omap_iommu_add_device(struct device *dev)
+{
+	int ret;
+
+	ret = _omap_iommu_add_device(dev);
+	if (ret == -EPROBE_DEFER)
+		return 0;
+
+	return ret;
+}
+
 static void omap_iommu_remove_device(struct device *dev)
 {
 	struct omap_iommu_arch_data *arch_data = dev->archdata.iommu;
diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index 1d15aa8..18ee713 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -87,7 +87,8 @@ struct omap_iommu {
 
 /**
  * struct omap_iommu_arch_data - omap iommu private data
- * @iommu_dev: handle of the iommu device
+ * @iommu_dev: handle of the OMAP iommu device
+ * @dev: handle of the iommu device
  *
  * This is an omap iommu private data object, which binds an iommu user
  * to its iommu device. This object should be placed at the iommu user's
@@ -96,6 +97,7 @@ struct omap_iommu {
  */
 struct omap_iommu_arch_data {
 	struct omap_iommu *iommu_dev;
+	struct device *dev;
 };
 
 struct cr_regs {
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
