Return-Path: <SRS0=dlfR=AT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3875CC433E0
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 11:32:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 054D620772
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 11:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054D620772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A98D088CFC;
	Wed,  8 Jul 2020 11:32:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rxI4g39lAjq7; Wed,  8 Jul 2020 11:32:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BEE39810FF;
	Wed,  8 Jul 2020 11:32:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F212C0893;
	Wed,  8 Jul 2020 11:32:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93032C016F
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 11:32:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 798FE88072
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 11:32:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TLfQ1b9kiHIJ for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jul 2020 11:32:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5D37A810FF
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 11:32:53 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8752B31B;
 Wed,  8 Jul 2020 04:32:52 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2FD373F68F;
 Wed,  8 Jul 2020 04:32:51 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Subject: [PATCH 1/2] iommu/intel: Avoid SAC address trick for PCIe devices
Date: Wed,  8 Jul 2020 12:32:41 +0100
Message-Id: <e583fc6dd1fb4ffc90310ff4372ee776f9cc7a3c.1594207679.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.23.0.dirty
MIME-Version: 1.0
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jonathan.lemon@gmail.com,
 dwmw2@infradead.org, hch@lst.de, linux-arm-kernel@lists.infradead.org
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

For devices stuck behind a conventional PCI bus, saving extra cycles at
33MHz is probably fairly significant. However since native PCI Express
is now the norm for high-performance devices, the optimisation to always
prefer 32-bit addresses for the sake of avoiding DAC is starting to look
rather anachronistic. Technically 32-bit addresses do have shorter TLPs
on PCIe, but unless the device is saturating its link bandwidth with
small transfers it seems unlikely that the difference is appreciable.

What definitely is appreciable, however, is that the IOVA allocator
doesn't behave all that well once the 32-bit space starts getting full.
As DMA working sets get bigger, this optimisation increasingly backfires
and adds considerable overhead to the dma_map path for use-cases like
high-bandwidth networking.

As such, let's simply take it out of consideration for PCIe devices.
Technically this might work out suboptimal for a PCIe device stuck
behind a conventional PCI bridge, or for PCI-X devices that also have
native 64-bit addressing, but neither of those are likely to be found
in performance-critical parts of modern systems.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/intel/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9129663a7406..21b11de23a53 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3348,7 +3348,8 @@ static unsigned long intel_alloc_iova(struct device *dev,
 	/* Ensure we reserve the whole size-aligned region */
 	nrpages = __roundup_pow_of_two(nrpages);
 
-	if (!dmar_forcedac && dma_mask > DMA_BIT_MASK(32)) {
+	if (!dmar_forcedac && dma_mask > DMA_BIT_MASK(32) &&
+	    dev_is_pci(dev) && !pci_is_pcie(to_pci_dev(dev))) {
 		/*
 		 * First try to allocate an io virtual address in
 		 * DMA_BIT_MASK(32) and if that fails then try allocating
-- 
2.23.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
