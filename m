Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0394FC433FE
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 06:21:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9356160F56;
	Tue, 10 May 2022 06:21:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HbGLaa4IUNLZ; Tue, 10 May 2022 06:21:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 62A8960F58;
	Tue, 10 May 2022 06:21:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47394C007A;
	Tue, 10 May 2022 06:21:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3702AC0081
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 06:21:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2356C8199D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 06:21:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y17O82LfMBd6 for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 06:21:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 34C5A8191E
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 06:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652163670; x=1683699670;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pRXrCzT/RrwXpbxi4XQ00QCp7eyOS42v/Go3QgjMA9U=;
 b=fm728Mkt8+xC+AYa1b4CLqQhF5Itu5yav+D/PNlnhU1jmsgTS2nNwpmU
 bxv/pu6yVSN/W9UHCcJ5vAfk4P7M2qIv/JGFedpKSos8hKhANEn8KSAWP
 g9dHZ6ndHW+X6Gf1Zh0npfeyAJB0G7U/c1KU8xxBTY07DMPnEdb/LKUCF
 NDa3unysAq1yPmx5eiSDiBJlEFEe/GQEE8KbBFdpW/p2pPBWdEzsvRFFM
 mcO/Ca284/syMlbw2Zyj+82Yxq71y3TrT12xS8itFdiTtFn2HE/0r+0vi
 GQgV5momGKVul8Sw6pHRrgpLh3zcKx6m6br45AUsLCKf/3yfXVDySXohO Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="266863645"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="266863645"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2022 23:20:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="552636333"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga002.jf.intel.com with ESMTP; 09 May 2022 23:20:47 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v6 01/12] dmaengine: idxd: Separate user and kernel pasid
 enabling
Date: Tue, 10 May 2022 14:17:27 +0800
Message-Id: <20220510061738.2761430-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
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
