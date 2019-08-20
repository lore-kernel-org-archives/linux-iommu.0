Return-Path: <SRS0=xQF/=WQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54741C3A5A0
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 01:24:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0821222CEC
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 01:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0821222CEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C6F18C5C;
	Tue, 20 Aug 2019 01:24:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 12F08AEF
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 01:24:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5AF2D89B
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 01:24:19 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9301B68B02; Tue, 20 Aug 2019 03:24:15 +0200 (CEST)
Date: Tue, 20 Aug 2019 03:24:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stefan Wahren <wahrenst@gmx.net>
Subject: Re: Build regression in Linux 5.3-rc5 with CONFIG_XEN=y
Message-ID: <20190820012415.GA21178@lst.de>
References: <ebd95b7c-d265-cbf1-be50-945db1dd06ad@gmx.net>
	<825549ed-8aa4-b418-8812-15a9d3cc153e@arm.com>
	<0b019cdc-6f0e-c37f-2be7-c24293acb8cd@gmx.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0b019cdc-6f0e-c37f-2be7-c24293acb8cd@gmx.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
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

Hi Stefan,

please try the patch below.

---
From e0570628d96faa50ebfc94ce8e545968336db225 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Tue, 20 Aug 2019 10:08:38 +0900
Subject: arm: select the dma-noncoherent symbols for all swiotlb builds

We need to provide the arch hooks for non-coherent dma-direct
and swiotlb for all swiotlb builds, not just when LPAS is enabled.
Without that the Xen build that selects SWIOTLB indirectly through
SWIOTLB_XEN fails to build.

Fixes: ad3c7b18c5b3 ("arm: use swiotlb for bounce buffering on LPAE configs")
Reported-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/Kconfig    | 4 ++++
 arch/arm/mm/Kconfig | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 33b00579beff..24360211534a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -7,6 +7,8 @@ config ARM
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
+	select ARCH_HAS_DMA_COHERENT_TO_PFN if SWIOTLB
+	select ARCH_HAS_DMA_MMAP_PGPROT if SWIOTLB
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KEEPINITRD
@@ -18,6 +20,8 @@ config ARM
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_STRICT_MODULE_RWX if MMU
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if SWIOTLB
+	select ARCH_HAS_SYNC_DMA_FOR_CPU if SWIOTLB
 	select ARCH_HAS_TEARDOWN_DMA_OPS if MMU
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAVE_CUSTOM_GPIO_H
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index c54cd7ed90ba..c1222c0e9fd3 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -664,10 +664,6 @@ config ARM_LPAE
 		!CPU_32v4 && !CPU_32v3
 	select PHYS_ADDR_T_64BIT
 	select SWIOTLB
-	select ARCH_HAS_DMA_COHERENT_TO_PFN
-	select ARCH_HAS_DMA_MMAP_PGPROT
-	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
-	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	help
 	  Say Y if you have an ARMv7 processor supporting the LPAE page
 	  table format and you would like to access memory beyond the
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
