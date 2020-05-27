Return-Path: <SRS0=MQAj=7J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7D7C433E0
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 16:59:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D31B20787
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 16:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D31B20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BB4DA86F06;
	Wed, 27 May 2020 16:56:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VrXv3x4URTsn; Wed, 27 May 2020 16:56:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0F46186EE8;
	Wed, 27 May 2020 16:56:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF5F7C0890;
	Wed, 27 May 2020 16:56:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5BADC016F
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 16:56:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A203787E91
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 16:56:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IIdfCvUk6o9C for <iommu@lists.linux-foundation.org>;
 Wed, 27 May 2020 16:56:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 108E787D99
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 16:56:23 +0000 (UTC)
IronPort-SDR: sNdzJvuyZzczcZunXx2LqCEshKP2S6S/AmYmkfY09ErXnuoHMzX4YewEDPeMF4qp1Ea8FCg9HZ
 99IatW0lDK6w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2020 09:56:22 -0700
IronPort-SDR: RqmHfxYy8/LbxXwmLvdQBUf3l+FxLpr7XnwFVqArBcCm2GmEJ7S1hV1rS8DTLVRtwbYdckTLWa
 SPB6jkPEwAAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,442,1583222400"; d="scan'208";a="302522300"
Received: from jderrick-mobl.amr.corp.intel.com ([10.209.128.69])
 by orsmga008.jf.intel.com with ESMTP; 27 May 2020 09:56:22 -0700
From: Jon Derrick <jonathan.derrick@intel.com>
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v1 2/3] iommu/vt-d: Allocate domain info for real DMA
 sub-devices
Date: Wed, 27 May 2020 10:56:16 -0600
Message-Id: <20200527165617.297470-3-jonathan.derrick@intel.com>
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

Sub-devices of a real DMA device might exist on a separate segment than
the real DMA device and its IOMMU. These devices should still have a
valid device_domain_info, but the current dma alias model won't
allocate info for the subdevice.

This patch adds a segment member to struct device_domain_info and uses
the sub-device's BDF so that these sub-devices won't alias to other
devices.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/iommu/intel-iommu.c | 19 +++++++++++++++----
 include/linux/intel-iommu.h |  1 +
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 1ff45b2..6d39b9b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2463,7 +2463,7 @@ static void do_deferred_attach(struct device *dev)
 	struct device_domain_info *info;
 
 	list_for_each_entry(info, &device_domain_list, global)
-		if (info->iommu->segment == segment && info->bus == bus &&
+		if (info->segment == segment && info->bus == bus &&
 		    info->devfn == devfn)
 			return info;
 
@@ -2520,8 +2520,18 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	if (!info)
 		return NULL;
 
-	info->bus = bus;
-	info->devfn = devfn;
+	if (!dev_is_real_dma_subdevice(dev)) {
+		info->bus = bus;
+		info->devfn = devfn;
+		info->segment = iommu->segment;
+	} else {
+		struct pci_dev *pdev = to_pci_dev(dev);
+
+		info->bus = pdev->bus->number;
+		info->devfn = pdev->devfn;
+		info->segment = pci_domain_nr(pdev->bus);
+	}
+
 	info->ats_supported = info->pasid_supported = info->pri_supported = 0;
 	info->ats_enabled = info->pasid_enabled = info->pri_enabled = 0;
 	info->ats_qdep = 0;
@@ -2561,7 +2571,8 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 
 	if (!found) {
 		struct device_domain_info *info2;
-		info2 = dmar_search_domain_by_dev_info(iommu->segment, bus, devfn);
+		info2 = dmar_search_domain_by_dev_info(info->segment, info->bus,
+						       info->devfn);
 		if (info2) {
 			found      = info2->domain;
 			info2->dev = dev;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 21633ce..4100bd2 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -609,6 +609,7 @@ struct device_domain_info {
 	struct list_head auxiliary_domains; /* auxiliary domains
 					     * attached to this device
 					     */
+	u32 segment;		/* PCI segment number */
 	u8 bus;			/* PCI bus number */
 	u8 devfn;		/* PCI devfn number */
 	u16 pfsid;		/* SRIOV physical function source ID */
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
