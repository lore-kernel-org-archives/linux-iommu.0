Return-Path: <SRS0=mxFs=VA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDC6C5B57D
	for <iommu@archiver.kernel.org>; Wed,  3 Jul 2019 01:57:13 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908C52064A
	for <iommu@archiver.kernel.org>; Wed,  3 Jul 2019 01:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908C52064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E212A1079;
	Wed,  3 Jul 2019 01:57:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 20070F8D
	for <iommu@lists.linux-foundation.org>;
	Wed,  3 Jul 2019 01:57:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 95813782
	for <iommu@lists.linux-foundation.org>;
	Wed,  3 Jul 2019 01:57:09 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	02 Jul 2019 18:57:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,445,1557212400"; d="scan'208";a="190875052"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
	by fmsmga002.fm.intel.com with ESMTP; 02 Jul 2019 18:57:09 -0700
From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH RFC 1/4] iommu/vt-d: Modify device_def_domain_type() to use at
	runtime
Date: Tue,  2 Jul 2019 18:53:59 -0700
Message-Id: <f83f7a321c31e4747488c7787d53315fa25e9a31.1562116655.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1562116655.git.sai.praneeth.prakhya@intel.com>
References: <cover.1562116655.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Cc: Ashok Raj <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

device_def_domain_type() determines the domain type a device could have and
it's called only during boot. But, to change the domain of a group through
sysfs, kernel has to call this function during runtime. Hence, add an
argument to the function which lets the function know if it's being called
at boot time or runtime.

Normally, device_def_domain_type() considers the value of command line
arguments like "intel_iommu=igfx_off" or "iommu=pt" to determine the domain
type of a device, but at runtime, user request should take higher priority
over command line arguments. Hence, use 'startup' argument to modify
device_def_domain_type() such that command line argument settings apply only at
boot time.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---
 drivers/iommu/intel-iommu.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ac4172c02244..54e82415e396 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2862,15 +2862,19 @@ static bool device_is_rmrr_locked(struct device *dev)
 /*
  * Return the required default domain type for a specific device.
  *
- * @dev: the device in query
- * @startup: true if this is during early boot
+ * @dev:	The device in query
+ * @startup:	Should command line arguments (E.g: igfx_off or iommu=pt) be
+ *		considered to decide the domain type of a device? Which is
+ *		'true' while booting but 'false' if the user requests kernel to
+ *		change the domain type by writing to
+ *		/sys/kernel/iommu_groups/<group_id>/type.
  *
  * Returns:
  *  - IOMMU_DOMAIN_DMA: device requires a dynamic mapping domain
  *  - IOMMU_DOMAIN_IDENTITY: device requires an identical mapping domain
  *  - 0: both identity and dynamic domains work for this device
  */
-static int device_def_domain_type(struct device *dev)
+static int device_def_domain_type(struct device *dev, bool startup)
 {
 	if (dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(dev);
@@ -2888,8 +2892,11 @@ static int device_def_domain_type(struct device *dev)
 		if ((iommu_identity_mapping & IDENTMAP_AZALIA) && IS_AZALIA(pdev))
 			return IOMMU_DOMAIN_IDENTITY;
 
-		if ((iommu_identity_mapping & IDENTMAP_GFX) && IS_GFX_DEVICE(pdev))
-			return IOMMU_DOMAIN_IDENTITY;
+		if (startup) {
+			if ((iommu_identity_mapping & IDENTMAP_GFX) &&
+			    IS_GFX_DEVICE(pdev))
+				return IOMMU_DOMAIN_IDENTITY;
+		}
 
 		/*
 		 * We want to start off with all devices in the 1:1 domain, and
@@ -2920,8 +2927,12 @@ static int device_def_domain_type(struct device *dev)
 			return IOMMU_DOMAIN_DMA;
 	}
 
-	return (iommu_identity_mapping & IDENTMAP_ALL) ?
-			IOMMU_DOMAIN_IDENTITY : 0;
+	if (startup) {
+		if (iommu_identity_mapping & IDENTMAP_ALL)
+			return IOMMU_DOMAIN_IDENTITY;
+	}
+
+	return 0;
 }
 
 static void intel_iommu_init_qi(struct intel_iommu *iommu)
@@ -5275,7 +5286,7 @@ static int intel_iommu_add_device(struct device *dev)
 	domain = iommu_get_domain_for_dev(dev);
 	dmar_domain = to_dmar_domain(domain);
 	if (domain->type == IOMMU_DOMAIN_DMA) {
-		if (device_def_domain_type(dev) == IOMMU_DOMAIN_IDENTITY) {
+		if (device_def_domain_type(dev, true) == IOMMU_DOMAIN_IDENTITY) {
 			ret = iommu_request_dm_for_dev(dev);
 			if (ret) {
 				dmar_domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
@@ -5285,7 +5296,7 @@ static int intel_iommu_add_device(struct device *dev)
 			}
 		}
 	} else {
-		if (device_def_domain_type(dev) == IOMMU_DOMAIN_DMA) {
+		if (device_def_domain_type(dev, true) == IOMMU_DOMAIN_DMA) {
 			ret = iommu_request_dma_domain_for_dev(dev);
 			if (ret) {
 				dmar_domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
