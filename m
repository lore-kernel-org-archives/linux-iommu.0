Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE99AC433F5
	for <iommu@archiver.kernel.org>; Mon,  2 May 2022 01:51:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC78E60E79;
	Mon,  2 May 2022 01:51:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7gCvKzEmPYCw; Mon,  2 May 2022 01:51:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5F5B560E76;
	Mon,  2 May 2022 01:51:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49989C0039;
	Mon,  2 May 2022 01:51:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFC3DC002D
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 01:51:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BB283409A3
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 01:51:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bou0iLa9KBCJ for <iommu@lists.linux-foundation.org>;
 Mon,  2 May 2022 01:51:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 71409408D3
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 01:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651456309; x=1682992309;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pRXrCzT/RrwXpbxi4XQ00QCp7eyOS42v/Go3QgjMA9U=;
 b=XL64Sm7GgBw7k3xclWRi+rBwqKdUiBMhyjAlfQGMPNBYE5oMQUUG9SQj
 8inPRzALG76swwUmLqoOBkCGiGVX6aZLZ8geXu2GD3LDvl8sr+67VcAdv
 GOib2yB3CpblyZKP65M5cpYfvWbUwBmsXj1biUdCDfvHkLeOabt2Cn+0q
 /xGo1AZ0/KmhPfJkyhW42Xzqri+29+s6r9XgF5bkAYWVJ7lN301nZS049
 i8YRbWV86JZ3MKhmenh5kyNhqu812GYqnNQ4GJN4ciXQPSfWBBsPvPJJ5
 rBeJ5fcENybC28jvOaGkgsoenDW73z/U51L38i6GQQbLEUlunPq3X0Ljk w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="254535319"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; d="scan'208";a="254535319"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2022 18:51:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; d="scan'208";a="707406444"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 01 May 2022 18:51:45 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v5 01/12] dmaengine: idxd: Separate user and kernel pasid
 enabling
Date: Mon,  2 May 2022 09:48:31 +0800
Message-Id: <20220502014842.991097-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220502014842.991097-1-baolu.lu@linux.intel.com>
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

From: Dave Jiang <dave.jiang@intel.com>

The idxd driver always gated the pasid enabling under a single knob and
this assumption is incorrect. The pasid used for kernel operation can be
independently toggled and has no dependency on the user pasid (and vice
versa). Split the two so they are independent "enabled" flags.

Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Link: https://lore.kernel.org/linux-iommu/20220315050713.2000518-10-jacob.jun.pan@linux.intel.com/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/dma/idxd/idxd.h |  6 ++++++
 drivers/dma/idxd/cdev.c |  4 ++--
 drivers/dma/idxd/init.c | 30 ++++++++++++++++++------------
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index da72eb15f610..ccbefd0be617 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -239,6 +239,7 @@ enum idxd_device_flag {
 	IDXD_FLAG_CONFIGURABLE = 0,
 	IDXD_FLAG_CMD_RUNNING,
 	IDXD_FLAG_PASID_ENABLED,
+	IDXD_FLAG_USER_PASID_ENABLED,
 };
 
 struct idxd_dma_dev {
@@ -469,6 +470,11 @@ static inline bool device_pasid_enabled(struct idxd_device *idxd)
 	return test_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
 }
 
+static inline bool device_user_pasid_enabled(struct idxd_device *idxd)
+{
+	return test_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
+}
+
 static inline bool device_swq_supported(struct idxd_device *idxd)
 {
 	return (support_enqcmd && device_pasid_enabled(idxd));
diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index b9b2b4a4124e..7df996deffbe 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -99,7 +99,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	ctx->wq = wq;
 	filp->private_data = ctx;
 
-	if (device_pasid_enabled(idxd)) {
+	if (device_user_pasid_enabled(idxd)) {
 		sva = iommu_sva_bind_device(dev, current->mm, NULL);
 		if (IS_ERR(sva)) {
 			rc = PTR_ERR(sva);
@@ -152,7 +152,7 @@ static int idxd_cdev_release(struct inode *node, struct file *filep)
 	if (wq_shared(wq)) {
 		idxd_device_drain_pasid(idxd, ctx->pasid);
 	} else {
-		if (device_pasid_enabled(idxd)) {
+		if (device_user_pasid_enabled(idxd)) {
 			/* The wq disable in the disable pasid function will drain the wq */
 			rc = idxd_wq_disable_pasid(wq);
 			if (rc < 0)
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 993a5dcca24f..e1b5d1e4a949 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -513,16 +513,19 @@ static int idxd_probe(struct idxd_device *idxd)
 
 	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
 		rc = iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA);
-		if (rc == 0) {
-			rc = idxd_enable_system_pasid(idxd);
-			if (rc < 0) {
-				iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
-				dev_warn(dev, "Failed to enable PASID. No SVA support: %d\n", rc);
-			} else {
-				set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
-			}
-		} else {
+		if (rc) {
+			/*
+			 * Do not bail here since legacy DMA is still
+			 * supported, both user and in-kernel DMA with
+			 * PASID rely on SVA feature.
+			 */
 			dev_warn(dev, "Unable to turn on SVA feature.\n");
+		} else {
+			set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
+			if (idxd_enable_system_pasid(idxd))
+				dev_warn(dev, "No in-kernel DMA with PASID.\n");
+			else
+				set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
 		}
 	} else if (!sva) {
 		dev_warn(dev, "User forced SVA off via module param.\n");
@@ -561,7 +564,8 @@ static int idxd_probe(struct idxd_device *idxd)
  err:
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
-	iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
+	if (device_user_pasid_enabled(idxd) || device_pasid_enabled(idxd))
+		iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
 	return rc;
 }
 
@@ -574,7 +578,8 @@ static void idxd_cleanup(struct idxd_device *idxd)
 	idxd_cleanup_internals(idxd);
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
-	iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
+	if (device_user_pasid_enabled(idxd) || device_pasid_enabled(idxd))
+		iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
 }
 
 static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
@@ -691,7 +696,8 @@ static void idxd_remove(struct pci_dev *pdev)
 	free_irq(irq_entry->vector, irq_entry);
 	pci_free_irq_vectors(pdev);
 	pci_iounmap(pdev, idxd->reg_base);
-	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
+	if (device_user_pasid_enabled(idxd) || device_pasid_enabled(idxd))
+		iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
 	pci_disable_device(pdev);
 	destroy_workqueue(idxd->wq);
 	perfmon_pmu_remove(idxd);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
