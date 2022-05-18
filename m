Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98225C433F5
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 17:37:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 401EB4192D;
	Wed, 18 May 2022 17:37:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 60xclLWQv0Ms; Wed, 18 May 2022 17:37:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CB1B54175B;
	Wed, 18 May 2022 17:37:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1CDBC0039;
	Wed, 18 May 2022 17:37:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C5D8C002D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 17:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 09BFB84122
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 17:37:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8ovDqPXPWO14 for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 17:37:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id F1BD5840D1
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 17:37:04 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CB6723A;
 Wed, 18 May 2022 10:37:04 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1BC3F3F718;
 Wed, 18 May 2022 10:37:03 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH] iommu/dma: Add config for PCI SAC address trick
Date: Wed, 18 May 2022 18:36:59 +0100
Message-Id: <ef8abf1c6b0839e39b272738fc7bc4d9699c8bcb.1652895419.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.35.3.dirty
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, hch@lst.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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
high-bandwidth networking. We've increasingly bandaged the allocator
in attempts to mitigate this, but it remains fundamentally at odds with
other valid requirements to try as hard as possible to satisfy a request
within the given limit; what we really need is to just avoid this odd
notion of a speculative allocation when it isn't beneficial anyway.

Unfortunately that's where things get awkward... Having been present on
x86 for 15 years or so now, it turns out there are systems which fail to
properly define the upper limit of usable IOVA space for certain devices
and this trick was the only thing letting them work OK. I had a similar
ulterior motive for a couple of early arm64 systems when originally
adding it to iommu-dma, but those really should now be fixed with proper
firmware bindings, and other arm64 users really need it out of the way,
so let's just leave it default-on for x86.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/Kconfig     | 24 ++++++++++++++++++++++++
 drivers/iommu/dma-iommu.c |  2 +-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index c79a0df090c0..bf9b295f1c89 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -144,6 +144,30 @@ config IOMMU_DMA
 	select IRQ_MSI_IOMMU
 	select NEED_SG_DMA_LENGTH
 
+config IOMMU_DMA_PCI_SAC_OPT
+	bool "Enable 64-bit legacy PCI optimisation by default"
+	depends on IOMMU_DMA
+	default X86
+	help
+	  Enable by default an IOMMU optimisation for 64-bit legacy PCI devices,
+	  wherein the DMA API layer will always first try to allocate a 32-bit
+	  DMA address suitable for a single address cycle, before falling back
+	  to allocating from the full usable address range. If your system has
+	  64-bit legacy PCI devices in 32-bit slots where using dual address
+	  cycles reduces DMA throughput significantly, this optimisation may be
+	  beneficial to overall performance.
+
+	  If you have a modern PCI Express based system, it should usually be
+	  safe to say "n" here and avoid the potential extra allocation overhead.
+	  However, beware that this optimisation has also historically papered
+	  over bugs where the IOMMU address range above 32 bits is not fully
+	  usable. If device DMA problems and/or IOMMU faults start occurring
+	  with IOMMU translation enabled after disabling this option, it is
+	  likely a sign of a latent driver or firmware/BIOS bug.
+
+	  If this option is not set, the optimisation can be enabled at
+	  boot time with the "iommu.forcedac=0" command-line argument.
+
 # Shared Virtual Addressing
 config IOMMU_SVA
 	bool
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 09f6e1c0f9c0..c8d409d3f861 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -66,7 +66,7 @@ struct iommu_dma_cookie {
 };
 
 static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
-bool iommu_dma_forcedac __read_mostly;
+bool iommu_dma_forcedac __read_mostly = !IS_ENABLED(CONFIG_IOMMU_DMA_PCI_SAC_OPT);
 
 static int __init iommu_dma_forcedac_setup(char *str)
 {
-- 
2.35.3.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
