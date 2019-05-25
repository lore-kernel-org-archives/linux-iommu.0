Return-Path: <SRS0=lyO4=TZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DF7C282CE
	for <iommu@archiver.kernel.org>; Sat, 25 May 2019 05:49:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 429B32133D
	for <iommu@archiver.kernel.org>; Sat, 25 May 2019 05:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429B32133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8D461CD9;
	Sat, 25 May 2019 05:48:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BFDB3481
	for <iommu@lists.linux-foundation.org>;
	Sat, 25 May 2019 05:48:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 58F57829
	for <iommu@lists.linux-foundation.org>;
	Sat, 25 May 2019 05:48:57 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	24 May 2019 22:48:57 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
	by fmsmga006.fm.intel.com with ESMTP; 24 May 2019 22:48:54 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v4 05/15] iommu/vt-d: Add device_def_domain_type() helper
Date: Sat, 25 May 2019 13:41:26 +0800
Message-Id: <20190525054136.27810-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190525054136.27810-1-baolu.lu@linux.intel.com>
References: <20190525054136.27810-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, dima@arista.com,
	tmurphy@arista.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

This helper returns the default domain type that the device
requires.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 40 +++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index bac226dc8360..e1663af4e01b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2958,29 +2958,37 @@ static bool device_is_rmrr_locked(struct device *dev)
 	return true;
 }
 
-static int iommu_should_identity_map(struct device *dev, int startup)
+/*
+ * Return the required default domain type for a specific device.
+ *
+ * @dev: the device in query
+ * @startup: true if this is during early boot
+ *
+ * Returns:
+ *  - IOMMU_DOMAIN_DMA: device requires a dynamic mapping domain
+ *  - IOMMU_DOMAIN_IDENTITY: device requires an identical mapping domain
+ *  - 0: both identity and dynamic domains work for this device
+ */
+static int device_def_domain_type(struct device *dev, int startup)
 {
 	if (dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(dev);
 
 		if (device_is_rmrr_locked(dev))
-			return 0;
+			return IOMMU_DOMAIN_DMA;
 
 		/*
 		 * Prevent any device marked as untrusted from getting
 		 * placed into the statically identity mapping domain.
 		 */
 		if (pdev->untrusted)
-			return 0;
+			return IOMMU_DOMAIN_DMA;
 
 		if ((iommu_identity_mapping & IDENTMAP_AZALIA) && IS_AZALIA(pdev))
-			return 1;
+			return IOMMU_DOMAIN_IDENTITY;
 
 		if ((iommu_identity_mapping & IDENTMAP_GFX) && IS_GFX_DEVICE(pdev))
-			return 1;
-
-		if (!(iommu_identity_mapping & IDENTMAP_ALL))
-			return 0;
+			return IOMMU_DOMAIN_IDENTITY;
 
 		/*
 		 * We want to start off with all devices in the 1:1 domain, and
@@ -3001,14 +3009,14 @@ static int iommu_should_identity_map(struct device *dev, int startup)
 		 */
 		if (!pci_is_pcie(pdev)) {
 			if (!pci_is_root_bus(pdev->bus))
-				return 0;
+				return IOMMU_DOMAIN_DMA;
 			if (pdev->class >> 8 == PCI_CLASS_BRIDGE_PCI)
-				return 0;
+				return IOMMU_DOMAIN_DMA;
 		} else if (pci_pcie_type(pdev) == PCI_EXP_TYPE_PCI_BRIDGE)
-			return 0;
+			return IOMMU_DOMAIN_DMA;
 	} else {
 		if (device_has_rmrr(dev))
-			return 0;
+			return IOMMU_DOMAIN_DMA;
 	}
 
 	/*
@@ -3030,7 +3038,13 @@ static int iommu_should_identity_map(struct device *dev, int startup)
 		return dma_mask >= dma_get_required_mask(dev);
 	}
 
-	return 1;
+	return (iommu_identity_mapping & IDENTMAP_ALL) ?
+			IOMMU_DOMAIN_IDENTITY : 0;
+}
+
+static inline int iommu_should_identity_map(struct device *dev, int startup)
+{
+	return device_def_domain_type(dev, startup) == IOMMU_DOMAIN_IDENTITY;
 }
 
 static int __init dev_prepare_static_identity_mapping(struct device *dev, int hw)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
