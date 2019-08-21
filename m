Return-Path: <SRS0=Juc9=WR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFCAC3A589
	for <iommu@archiver.kernel.org>; Wed, 21 Aug 2019 02:45:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D3EE22D6D
	for <iommu@archiver.kernel.org>; Wed, 21 Aug 2019 02:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D3EE22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 44DC08D7;
	Wed, 21 Aug 2019 02:45:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7F69E41C
	for <iommu@lists.linux-foundation.org>;
	Wed, 21 Aug 2019 02:45:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1246889B
	for <iommu@lists.linux-foundation.org>;
	Wed, 21 Aug 2019 02:45:52 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	20 Aug 2019 19:45:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,410,1559545200"; d="scan'208";a="329890060"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
	by orsmga004.jf.intel.com with ESMTP; 20 Aug 2019 19:45:50 -0700
From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 1/4] iommu/vt-d: Modify device_def_domain_type() to use at
	runtime
Date: Tue, 20 Aug 2019 19:42:09 -0700
Message-Id: <e11ba804b5e30477fe4219b12912b46af9c7f94a.1566353521.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1566353521.git.sai.praneeth.prakhya@intel.com>
References: <cover.1566353521.git.sai.praneeth.prakhya@intel.com>
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
currently it's called only during boot time. Since the function is called
only during boot time, it *always* considers command line arguments like
"intel_iommu=igfx_off" and "iommu=pt" to determine the domain type of a
device. To support changing the domain of an iommu_group through sysfs,
this function has to be called at runtime as well. Hence, modify this
function such that command line arguments are considered to determine the
domain type of a device *only* when the system is booting and ignored if
the system is already up and running.

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
 drivers/iommu/intel-iommu.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b7454ca4a87c..27c3c893530a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2859,15 +2859,14 @@ static bool device_is_rmrr_locked(struct device *dev)
 }
 
 /*
- * Return the required default domain type for a specific device.
+ * Returns the possible default domain types a device could have.
  *
- * @dev: the device in query
- * @startup: true if this is during early boot
+ * @dev: The device in query
  *
  * Returns:
- *  - IOMMU_DOMAIN_DMA: device requires a dynamic mapping domain
- *  - IOMMU_DOMAIN_IDENTITY: device requires an identical mapping domain
- *  - 0: both identity and dynamic domains work for this device
+ *  - IOMMU_DOMAIN_DMA: Device should always be in dynamic mapping domain
+ *  - IOMMU_DOMAIN_IDENTITY: Device should always be in identity mapping domain
+ *  - 0: Device could be in any domain (i.e. identity or dynamic)
  */
 static int device_def_domain_type(struct device *dev)
 {
@@ -2884,11 +2883,22 @@ static int device_def_domain_type(struct device *dev)
 		if (pdev->untrusted)
 			return IOMMU_DOMAIN_DMA;
 
+		/*
+		 * Azalia device should always be in identity domain if
+		 * check_tylersburg_isoch() decides so.
+		 */
 		if ((iommu_identity_mapping & IDENTMAP_AZALIA) && IS_AZALIA(pdev))
 			return IOMMU_DOMAIN_IDENTITY;
 
-		if ((iommu_identity_mapping & IDENTMAP_GFX) && IS_GFX_DEVICE(pdev))
-			return IOMMU_DOMAIN_IDENTITY;
+		/*
+		 * intel_iommu=igfx_off should have it's effect only during
+		 * boot.
+		 */
+		if (system_state < SYSTEM_RUNNING) {
+			if ((iommu_identity_mapping & IDENTMAP_GFX) &&
+			    IS_GFX_DEVICE(pdev))
+				return IOMMU_DOMAIN_IDENTITY;
+		}
 
 		/*
 		 * We want to start off with all devices in the 1:1 domain, and
@@ -2919,8 +2929,13 @@ static int device_def_domain_type(struct device *dev)
 			return IOMMU_DOMAIN_DMA;
 	}
 
-	return (iommu_identity_mapping & IDENTMAP_ALL) ?
-			IOMMU_DOMAIN_IDENTITY : 0;
+	/* iommu=pt should have it's effect only during boot */
+	if (system_state < SYSTEM_RUNNING) {
+		if (iommu_identity_mapping & IDENTMAP_ALL)
+			return IOMMU_DOMAIN_IDENTITY;
+	}
+
+	return 0;
 }
 
 static void intel_iommu_init_qi(struct intel_iommu *iommu)
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
