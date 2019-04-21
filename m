Return-Path: <SRS0=OYPK=SX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2F2C282E2
	for <iommu@archiver.kernel.org>; Sun, 21 Apr 2019 01:25:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD8A520651
	for <iommu@archiver.kernel.org>; Sun, 21 Apr 2019 01:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD8A520651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 10A312CA9;
	Sun, 21 Apr 2019 01:24:46 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 269D92BE9
	for <iommu@lists.linux-foundation.org>;
	Sun, 21 Apr 2019 01:24:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BDC4814D
	for <iommu@lists.linux-foundation.org>;
	Sun, 21 Apr 2019 01:24:07 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	20 Apr 2019 18:24:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,376,1549958400"; d="scan'208";a="136008179"
Received: from allen-box.sh.intel.com ([10.239.159.136])
	by orsmga008.jf.intel.com with ESMTP; 20 Apr 2019 18:24:04 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 07/10] iommu/vt-d: Keep swiotlb on if bounce page is
	necessary
Date: Sun, 21 Apr 2019 09:17:16 +0800
Message-Id: <20190421011719.14909-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190421011719.14909-1-baolu.lu@linux.intel.com>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	alan.cox@intel.com, Mika Westerberg <mika.westerberg@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	pengfei.xu@intel.com, jacob.jun.pan@intel.com,
	mika.westerberg@linux.intel.com, Christoph Hellwig <hch@lst.de>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190421011716.cPEcuvBEzCfLcA88fQudY0_SlJzN4VuCe8NMSgEj1gI@z>

The bouce page is necessary whenever there are untrusted
devices in the system. The bounce page policy depends on
swiotlb, hence don't turn off swiotlb if untrusted devices
exist.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Mika Westerberg <mika.westerberg@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index af040602bd44..e4a164324bdd 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4528,22 +4528,27 @@ const struct attribute_group *intel_iommu_groups[] = {
 	NULL,
 };
 
-static int __init platform_optin_force_iommu(void)
+static inline bool platform_has_untrusted_device(void)
 {
+	bool has_untrusted_device = false;
 	struct pci_dev *pdev = NULL;
-	bool has_untrusted_dev = false;
-
-	if (!dmar_platform_optin() || no_platform_optin)
-		return 0;
 
 	for_each_pci_dev(pdev) {
 		if (pdev->untrusted) {
-			has_untrusted_dev = true;
+			has_untrusted_device = true;
 			break;
 		}
 	}
 
-	if (!has_untrusted_dev)
+	return has_untrusted_device;
+}
+
+static int __init platform_optin_force_iommu(void)
+{
+	if (!dmar_platform_optin() || no_platform_optin)
+		return 0;
+
+	if (!platform_has_untrusted_device())
 		return 0;
 
 	if (no_iommu || dmar_disabled)
@@ -4557,9 +4562,6 @@ static int __init platform_optin_force_iommu(void)
 		iommu_identity_mapping |= IDENTMAP_ALL;
 
 	dmar_disabled = 0;
-#if defined(CONFIG_X86) && defined(CONFIG_SWIOTLB)
-	swiotlb = 0;
-#endif
 	no_iommu = 0;
 
 	return 1;
@@ -4653,7 +4655,8 @@ int __init intel_iommu_init(void)
 	up_write(&dmar_global_lock);
 
 #if defined(CONFIG_X86) && defined(CONFIG_SWIOTLB)
-	swiotlb = 0;
+	if (!platform_has_untrusted_device())
+		swiotlb = 0;
 #endif
 	dma_ops = &intel_dma_ops;
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
