Return-Path: <SRS0=MQAj=7J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4701DC433DF
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 16:59:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04CCB20787
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 16:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04CCB20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0407986EEB;
	Wed, 27 May 2020 16:56:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hpm9Y2Av0QzQ; Wed, 27 May 2020 16:56:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 587BD86EFE;
	Wed, 27 May 2020 16:56:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F976C016F;
	Wed, 27 May 2020 16:56:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D831C016F
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 16:56:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0CC0B87D99
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 16:56:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RpTGWsQrqRAz for <iommu@lists.linux-foundation.org>;
 Wed, 27 May 2020 16:56:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5AF3787DA2
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 16:56:22 +0000 (UTC)
IronPort-SDR: mZx3Yxe2Vv3kLz7c72shqLQwFg2YPz4Q9ux8K9OtIj+mTUVkvLyP3URviUHfjXnIcf7zatHoVp
 KSuUSpGvTE5g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2020 09:56:22 -0700
IronPort-SDR: ljnwbifSi6tpzAZRS3tJCSTDtQX25lWKO+sp42EQ+RzMLhQIPq+xmCqfGncYN7KLMv6U+22KyH
 DxL7UDXCiPgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,442,1583222400"; d="scan'208";a="302522293"
Received: from jderrick-mobl.amr.corp.intel.com ([10.209.128.69])
 by orsmga008.jf.intel.com with ESMTP; 27 May 2020 09:56:21 -0700
From: Jon Derrick <jonathan.derrick@intel.com>
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v1 1/3] iommu/vt-d: Only clear real DMA device's context
 entries
Date: Wed, 27 May 2020 10:56:15 -0600
Message-Id: <20200527165617.297470-2-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200527165617.297470-1-jonathan.derrick@intel.com>
References: <20200527165617.297470-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Cc: Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
 Jon Derrick <jonathan.derrick@intel.com>
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

Domain context mapping can encounter issues with sub-devices of a real
DMA device. A sub-device cannot have a valid context entry due to it
potentially aliasing another device's 16-bit ID. It's expected that
sub-devices of the real DMA device uses the real DMA device's requester
when context mapping.

This is an issue when a sub-device is removed where the context entry is
cleared for all aliases. Other sub-devices are still valid, resulting in
those sub-devices being stranded without valid context entries.

The correct approach is to use the real DMA device when programming the
context entries. The insertion path is correct because device_to_iommu()
will return the bus and devfn of the real DMA device. The removal path
needs to only operate on the real DMA device, otherwise the entire
context entry would be cleared for all sub-devices of the real DMA
device.

This patch also adds a helper to determine if a struct device is a
sub-device of a real DMA device.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/iommu/intel-iommu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ff5a30a..1ff45b2 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2500,6 +2500,12 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 					     flags);
 }
 
+static bool dev_is_real_dma_subdevice(struct device *dev)
+{
+	return dev && dev_is_pci(dev) &&
+	       pci_real_dma_dev(to_pci_dev(dev)) != to_pci_dev(dev);
+}
+
 static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 						    int bus, int devfn,
 						    struct device *dev,
@@ -4975,7 +4981,8 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 					PASID_RID2PASID, false);
 
 		iommu_disable_dev_iotlb(info);
-		domain_context_clear(iommu, info->dev);
+		if (!dev_is_real_dma_subdevice(info->dev))
+			domain_context_clear(iommu, info->dev);
 		intel_pasid_free_table(info->dev);
 	}
 
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
