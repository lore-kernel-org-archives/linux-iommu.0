Return-Path: <SRS0=HSJZ=5V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E685AC2BA19
	for <iommu@archiver.kernel.org>; Sun,  5 Apr 2020 08:34:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C198820678
	for <iommu@archiver.kernel.org>; Sun,  5 Apr 2020 08:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C198820678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A146E204F9;
	Sun,  5 Apr 2020 08:34:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XqHsLWPhKHQR; Sun,  5 Apr 2020 08:34:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 669B520242;
	Sun,  5 Apr 2020 08:34:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53422C1AE2;
	Sun,  5 Apr 2020 08:34:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDC5EC0177
 for <iommu@lists.linux-foundation.org>; Sun,  5 Apr 2020 08:34:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B77B72049A
 for <iommu@lists.linux-foundation.org>; Sun,  5 Apr 2020 08:34:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6O4WQI2IuKYy for <iommu@lists.linux-foundation.org>;
 Sun,  5 Apr 2020 08:34:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by silver.osuosl.org (Postfix) with ESMTPS id 3D73020242
 for <iommu@lists.linux-foundation.org>; Sun,  5 Apr 2020 08:34:01 +0000 (UTC)
IronPort-SDR: U+bTvg+U/31BYWibMWolSV2MZ/UD7x727/UOOm7MweXYyG/UsJG42o+u9BOpzQ5ImOiFiDI+Y6
 na6Zpy7vkZBw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Apr 2020 01:34:01 -0700
IronPort-SDR: 8lgLMzQk7ejBg+lNrY7X3j7LBje747PmG61lU0hSkpZW+xS/Xiuashs/++s4IYIfNf9iAJLEgd
 gGNy0WXlKHUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,347,1580803200"; d="scan'208";a="397179335"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by orsmga004.jf.intel.com with ESMTP; 05 Apr 2020 01:33:59 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 04/19] iommu/vt-d: Don't force PCI sub-hierarchy to use DMA
 domain
Date: Sun,  5 Apr 2020 16:30:38 +0800
Message-Id: <20200405083053.17865-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200405083053.17865-1-baolu.lu@linux.intel.com>
References: <20200405083053.17865-1-baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Before commit fa954e6831789 ("iommu/vt-d: Delegate the dma domain
to upper layer"), Intel IOMMU started off with all devices in the
identity domain, and took them out later if it found they couldn't
access all of memory. This required devices behind a PCI bridge to
use a DMA domain at the beginning because all PCI devices behind
the bridge use the same source-id in their transactions and the
domain couldn't be changed at run-time.

Intel IOMMU driver is now aligned with the default domain framework,
there's no need to keep this requirement anymore.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a29def3f3308..6f29f5f75351 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3048,31 +3048,6 @@ static int device_def_domain_type(struct device *dev)
 
 		if ((iommu_identity_mapping & IDENTMAP_GFX) && IS_GFX_DEVICE(pdev))
 			return IOMMU_DOMAIN_IDENTITY;
-
-		/*
-		 * We want to start off with all devices in the 1:1 domain, and
-		 * take them out later if we find they can't access all of memory.
-		 *
-		 * However, we can't do this for PCI devices behind bridges,
-		 * because all PCI devices behind the same bridge will end up
-		 * with the same source-id on their transactions.
-		 *
-		 * Practically speaking, we can't change things around for these
-		 * devices at run-time, because we can't be sure there'll be no
-		 * DMA transactions in flight for any of their siblings.
-		 *
-		 * So PCI devices (unless they're on the root bus) as well as
-		 * their parent PCI-PCI or PCIe-PCI bridges must be left _out_ of
-		 * the 1:1 domain, just in _case_ one of their siblings turns out
-		 * not to be able to map all of memory.
-		 */
-		if (!pci_is_pcie(pdev)) {
-			if (!pci_is_root_bus(pdev->bus))
-				return IOMMU_DOMAIN_DMA;
-			if (pdev->class >> 8 == PCI_CLASS_BRIDGE_PCI)
-				return IOMMU_DOMAIN_DMA;
-		} else if (pci_pcie_type(pdev) == PCI_EXP_TYPE_PCI_BRIDGE)
-			return IOMMU_DOMAIN_DMA;
 	}
 
 	return 0;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
