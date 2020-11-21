Return-Path: <SRS0=4dp6=E3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CECC388F9
	for <iommu@archiver.kernel.org>; Sat, 21 Nov 2020 14:04:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1D1522210
	for <iommu@archiver.kernel.org>; Sat, 21 Nov 2020 14:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D1522210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5ADF42043D;
	Sat, 21 Nov 2020 14:04:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Ren+9l9-xnC; Sat, 21 Nov 2020 14:04:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D6C8A20366;
	Sat, 21 Nov 2020 14:04:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF87FC163C;
	Sat, 21 Nov 2020 14:04:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AEA47C0891
 for <iommu@lists.linux-foundation.org>; Sat, 21 Nov 2020 14:03:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A01DB8743B
 for <iommu@lists.linux-foundation.org>; Sat, 21 Nov 2020 14:03:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K+sWgJ2xj1Ra for <iommu@lists.linux-foundation.org>;
 Sat, 21 Nov 2020 14:03:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5E50A87422
 for <iommu@lists.linux-foundation.org>; Sat, 21 Nov 2020 14:03:58 +0000 (UTC)
IronPort-SDR: SCEmoJ6+BabNeRRiFw2CABcBz6ZJ5R7EA5JiAUlFUOAL4A9pa7Db66DMirGeL5pPVvVQEoowOS
 sjDc8gWDUWGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="168083748"
X-IronPort-AV: E=Sophos;i="5.78,359,1599548400"; d="scan'208";a="168083748"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2020 06:03:58 -0800
IronPort-SDR: SS/i7YFrzP8y/TwSwPj8rVXngNcAgBHP1fa5vzbCW6mXqStuyf/9jpWNz7cEe6JXm078IfA99d
 H9dH3VUga0hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,359,1599548400"; d="scan'208";a="431852759"
Received: from allen-box.sh.intel.com ([10.239.159.28])
 by fmsmga001.fm.intel.com with ESMTP; 21 Nov 2020 06:03:55 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v9 1/4] iommu: Move def_domain type check for untrusted device
 into core
Date: Sat, 21 Nov 2020 21:56:17 +0800
Message-Id: <20201121135620.3496419-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201121135620.3496419-1-baolu.lu@linux.intel.com>
References: <20201121135620.3496419-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

So that the vendor iommu drivers are no more required to provide the
def_domain_type callback to always isolate the untrusted devices.

Link: https://lore.kernel.org/linux-iommu/243ce89c33fe4b9da4c56ba35acebf81@huawei.com/
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c |  7 -------
 drivers/iommu/iommu.c       | 21 ++++++++++++++-------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index af3abd285214..6711f78141a4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2916,13 +2916,6 @@ static int device_def_domain_type(struct device *dev)
 	if (dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(dev);
 
-		/*
-		 * Prevent any device marked as untrusted from getting
-		 * placed into the statically identity mapping domain.
-		 */
-		if (pdev->untrusted)
-			return IOMMU_DOMAIN_DMA;
-
 		if ((iommu_identity_mapping & IDENTMAP_AZALIA) && IS_AZALIA(pdev))
 			return IOMMU_DOMAIN_IDENTITY;
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 88b0c9192d8c..3256784c0358 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1457,13 +1457,23 @@ struct iommu_group *fsl_mc_device_group(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(fsl_mc_device_group);
 
-static int iommu_get_def_domain_type(struct device *dev)
+/* Get the mandatary def_domain type for device. Otherwise, return 0. */
+static int iommu_get_mandatory_def_domain_type(struct device *dev)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
-	unsigned int type = 0;
+
+	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
+		return IOMMU_DOMAIN_DMA;
 
 	if (ops->def_domain_type)
-		type = ops->def_domain_type(dev);
+		return ops->def_domain_type(dev);
+
+	return 0;
+}
+
+static int iommu_get_def_domain_type(struct device *dev)
+{
+	int type = iommu_get_mandatory_def_domain_type(dev);
 
 	return (type == 0) ? iommu_def_domain_type : type;
 }
@@ -1645,13 +1655,10 @@ struct __group_domain_type {
 
 static int probe_get_default_domain_type(struct device *dev, void *data)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
 	struct __group_domain_type *gtype = data;
 	unsigned int type = 0;
 
-	if (ops->def_domain_type)
-		type = ops->def_domain_type(dev);
-
+	type = iommu_get_mandatory_def_domain_type(dev);
 	if (type) {
 		if (gtype->type && gtype->type != type) {
 			dev_warn(dev, "Device needs domain type %s, but device %s in the same iommu group requires type %s - using default\n",
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
