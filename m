Return-Path: <SRS0=cr9L=47=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256DBC5ACBF
	for <iommu@archiver.kernel.org>; Sat, 14 Mar 2020 01:09:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05032206FA
	for <iommu@archiver.kernel.org>; Sat, 14 Mar 2020 01:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05032206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D77392C345;
	Sat, 14 Mar 2020 01:09:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yBDNS7n3ffGn; Sat, 14 Mar 2020 01:09:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B926C241F9;
	Sat, 14 Mar 2020 01:09:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B438C18D3;
	Sat, 14 Mar 2020 01:09:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85FE5C0177
 for <iommu@lists.linux-foundation.org>; Sat, 14 Mar 2020 01:09:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7509A881BC
 for <iommu@lists.linux-foundation.org>; Sat, 14 Mar 2020 01:09:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tuup4aHYs6FE for <iommu@lists.linux-foundation.org>;
 Sat, 14 Mar 2020 01:09:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A780E886A0
 for <iommu@lists.linux-foundation.org>; Sat, 14 Mar 2020 01:09:53 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Mar 2020 18:09:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,550,1574150400"; d="scan'208";a="266912418"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 13 Mar 2020 18:09:50 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 3/6] iommu/vt-d: Don't force 32bit devices to uses DMA
 domain
Date: Sat, 14 Mar 2020 09:07:02 +0800
Message-Id: <20200314010705.30711-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200314010705.30711-1-baolu.lu@linux.intel.com>
References: <20200314010705.30711-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 Daniel Drake <drake@endlessm.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Derrick Jonathan <jonathan.derrick@intel.com>
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

Currently, if a 32bit device initially uses an identity domain,
Intel IOMMU driver will convert it forcibly to a DMA one if its
address capability is not enough for the whole system memory.
The motivation was to overcome the overhead caused by possible
bounced buffer.

Unfortunately, this improvement has led to many problems. For
example, some 32bit devices are required to use an identity
domain, forcing them to use DMA domain will cause the device
not to work anymore. On the other hand, the VMD sub-devices
share a domain but each sub-device might have different address
capability. Forcing a VMD sub-device to use DMA domain blindly
will impact the operation of other sub-devices without any
notification. Further more, PCI aliased devices (PCI bridge
and all devices beneath it, VMD devices and various devices
quirked with pci_add_dma_alias()) must use the same domain.
Forcing one device to switch to DMA domain during runtime
will cause in-fligh DMAs for other devices to abort or target
to other memory which might cause undefind system behavior.

Cc: Daniel Drake <drake@endlessm.com>
Cc: Derrick Jonathan <jonathan.derrick@intel.com>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 46 +------------------------------------
 1 file changed, 1 insertion(+), 45 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 4be549478691..eb68ba5ddf67 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3582,47 +3582,13 @@ static struct dmar_domain *get_private_domain_for_dev(struct device *dev)
 /* Check if the dev needs to go through non-identity map and unmap process.*/
 static bool iommu_need_mapping(struct device *dev)
 {
-	int ret;
-
 	if (iommu_dummy(dev))
 		return false;
 
 	if (unlikely(attach_deferred(dev)))
 		do_deferred_attach(dev);
 
-	ret = identity_mapping(dev);
-	if (ret) {
-		u64 dma_mask = *dev->dma_mask;
-
-		if (dev->coherent_dma_mask && dev->coherent_dma_mask < dma_mask)
-			dma_mask = dev->coherent_dma_mask;
-
-		if (dma_mask >= dma_direct_get_required_mask(dev))
-			return false;
-
-		/*
-		 * 32 bit DMA is removed from si_domain and fall back to
-		 * non-identity mapping.
-		 */
-		dmar_remove_one_dev_info(dev);
-		ret = iommu_request_dma_domain_for_dev(dev);
-		if (ret) {
-			struct iommu_domain *domain;
-			struct dmar_domain *dmar_domain;
-
-			domain = iommu_get_domain_for_dev(dev);
-			if (domain) {
-				dmar_domain = to_dmar_domain(domain);
-				dmar_domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
-			}
-			dmar_remove_one_dev_info(dev);
-			get_private_domain_for_dev(dev);
-		}
-
-		dev_info(dev, "32bit DMA uses non-identity mapping\n");
-	}
-
-	return true;
+	return !identity_mapping(dev);
 }
 
 static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
@@ -5185,16 +5151,6 @@ int __init intel_iommu_init(void)
 	}
 	up_write(&dmar_global_lock);
 
-#if defined(CONFIG_X86) && defined(CONFIG_SWIOTLB)
-	/*
-	 * If the system has no untrusted device or the user has decided
-	 * to disable the bounce page mechanisms, we don't need swiotlb.
-	 * Mark this and the pre-allocated bounce pages will be released
-	 * later.
-	 */
-	if (!has_untrusted_dev() || intel_no_bounce)
-		swiotlb = 0;
-#endif
 	dma_ops = &intel_dma_ops;
 
 	init_iommu_pm_ops();
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
