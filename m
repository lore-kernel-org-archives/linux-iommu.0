Return-Path: <SRS0=wR7u=ZM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E7FC432C0
	for <iommu@archiver.kernel.org>; Wed, 20 Nov 2019 19:36:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A9C6208CC
	for <iommu@archiver.kernel.org>; Wed, 20 Nov 2019 19:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="AQ78D3ZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9C6208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F166C8A621;
	Wed, 20 Nov 2019 19:36:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k3AUEocCrROK; Wed, 20 Nov 2019 19:36:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8F9AE8A62B;
	Wed, 20 Nov 2019 19:36:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81943C1DD8;
	Wed, 20 Nov 2019 19:36:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 832BBC18DA
 for <iommu@lists.linux-foundation.org>; Wed, 20 Nov 2019 19:36:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7C26188B28
 for <iommu@lists.linux-foundation.org>; Wed, 20 Nov 2019 19:36:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rOhdqgTg3TXg for <iommu@lists.linux-foundation.org>;
 Wed, 20 Nov 2019 19:36:16 +0000 (UTC)
X-Greylist: delayed 00:07:06 by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BF7A288B21
 for <iommu@lists.linux-foundation.org>; Wed, 20 Nov 2019 19:36:15 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id n1so1291730wra.10
 for <iommu@lists.linux-foundation.org>; Wed, 20 Nov 2019 11:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernelci-org.20150623.gappssmtp.com; s=20150623;
 h=message-id:date:mime-version:content-transfer-encoding:subject:to
 :from:cc; bh=QxyFP12MhasoDGEo27BmT72GRY9o/OilHUn1uKLS9HU=;
 b=AQ78D3ZRNLMahPB9PLYA3e4sE4N9q+5ChyZl2cDRJqXhp63tI2Grew+i0MSG8cZGGc
 7aL3SQPyLKrfBnwgIX5O3qAM+KVGZeiEBkBZMNG2S7DIS43BIntqeUL4DbMxMALwVaKe
 KsJFdosov8WB73UXKPrgjOcuYjlJWXlSH+D7cy/umVMZeH28IVr4Xh5889Zfcc5U1x5Q
 rpZfEXC91hGXxIuoxg/t7ev+HEWGpJ9B6OokDVu/9oLhMu8mZPkockIRNk9ynalB4Smc
 rIkcLsvhYqEzyxiq87zoPj4+rI1MYetpckzMcFjmOShSZw/XOH5wnSdcw+5lt6DDGlzT
 X1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:date:mime-version
 :content-transfer-encoding:subject:to:from:cc;
 bh=QxyFP12MhasoDGEo27BmT72GRY9o/OilHUn1uKLS9HU=;
 b=od2hMbYIaxZtSlBaD2BLHudRzzgLV55kZTkSEhCsOqCuMhyXEiIENhL09uSkFQMCZ5
 u3nxETv/F06KDZKrUsZUkj+NrqmifZXN9QciZrj0aJauG9+6tZrAmXi4nP1lt33rJc4G
 ZYj/XEU4QMI6DhPVZwLKbFGjvy2dPtSGXmYf44ow1bBwDQuFfxHyaBtMlZZ/dIgkQhUr
 3JyHwz1sIJ0rVO6NhFNYl6x7MLUFx0r75Qm2vzpzzOh+womUXFNvdi80NJ0kucTfpIlp
 1Am5tVOU9/a+jN4gCeZnl7ixMdLNBIqu8C8aUI/eEAXOyUScvgFXZazW4EtoaaesyVXi
 W/Aw==
X-Gm-Message-State: APjAAAUTL9Cl+DtBUZaVK6OnDxPRPRUcSEaLpBMj84JwmJ4ahRR+asN5
 VlRVX07xnfgP+Ng6HAERYyRZJg==
X-Google-Smtp-Source: APXvYqyeT8rwbaOzoRAJmIsh5JIQd1t8BEuHkQ7D784UqNRl377ltKmHmLhhDrkVy9KD5aHaXflfzw==
X-Received: by 2002:a5d:678f:: with SMTP id v15mr5464377wru.242.1574278148011; 
 Wed, 20 Nov 2019 11:29:08 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
 by smtp.gmail.com with ESMTPSA id a15sm301710wrx.81.2019.11.20.11.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 11:29:07 -0800 (PST)
Message-ID: <5dd59403.1c69fb81.f6a76.2143@mx.google.com>
Date: Wed, 20 Nov 2019 11:29:07 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Lab-Name: lab-collabora
X-Kernelci-Branch: master
X-Kernelci-Tree: next
X-Kernelci-Report-Type: bisect
X-Kernelci-Kernel: next-20191120
Subject: next/master bisection: boot on peach-pi
To: tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
 Christoph Hellwig <hch@lst.de>, broonie@kernel.org, khilman@baylibre.com,
 mgalka@collabora.com, enric.balletbo@collabora.com,
 Michael Ellerman <mpe@ellerman.id.au>
From: "kernelci.org bot" <bot@kernelci.org>
Cc: Paul Burton <paulburton@kernel.org>, "kernelci.org bot" <bot@kernelci.org>,
 James Hogan <jhogan@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 linux-mips@vger.kernel.org, iommu@lists.linux-foundation.org,
 Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell King <linux@armlinux.org.uk>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
*                                                               *
* If you do send a fix, please include this trailer:            *
*   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
*                                                               *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

next/master bisection: boot on peach-pi

Summary:
  Start:      1fef9976397f Add linux-next specific files for 20191120
  Details:    https://kernelci.org/boot/id/5dd5175059b514af0dcf54d0
  Plain log:  https://storage.kernelci.org//next/master/next-20191120/arm/exynos_defconfig/gcc-8/lab-collabora/boot-exynos5800-peach-pi.txt
  HTML log:   https://storage.kernelci.org//next/master/next-20191120/arm/exynos_defconfig/gcc-8/lab-collabora/boot-exynos5800-peach-pi.html
  Result:     b037b220e71d dma-direct: unify the dma_capable definitions

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       next
  URL:        git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  Branch:     master
  Target:     peach-pi
  CPU arch:   arm
  Lab:        lab-collabora
  Compiler:   gcc-8
  Config:     exynos_defconfig
  Test suite: boot

Breaking commit found:

-------------------------------------------------------------------------------
commit b037b220e71dcbb34cb710e00ffad2ec025b9163
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Nov 12 17:06:04 2019 +0100

    dma-direct: unify the dma_capable definitions
    
    Currently each architectures that wants to override dma_to_phys and
    phys_to_dma also has to provide dma_capable.  But there isn't really
    any good reason for that.  powerpc and mips just have copies of the
    generic one minus the latests fix, and the arm one was the inspiration
    for said fix, but misses the bus_dma_mask handling.
    Make all architectures use the generic version instead.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
    Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

diff --git a/arch/arm/include/asm/dma-direct.h b/arch/arm/include/asm/dma-direct.h
index b67e5fc1fe43..7c3001a6a775 100644
--- a/arch/arm/include/asm/dma-direct.h
+++ b/arch/arm/include/asm/dma-direct.h
@@ -14,23 +14,4 @@ static inline phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dev_addr)
 	return __pfn_to_phys(dma_to_pfn(dev, dev_addr)) + offset;
 }
 
-static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
-{
-	u64 limit, mask;
-
-	if (!dev->dma_mask)
-		return 0;
-
-	mask = *dev->dma_mask;
-
-	limit = (mask + 1) & ~mask;
-	if (limit && size > limit)
-		return 0;
-
-	if ((addr | (addr + size - 1)) & ~mask)
-		return 0;
-
-	return 1;
-}
-
 #endif /* ASM_ARM_DMA_DIRECT_H */
diff --git a/arch/mips/include/asm/dma-direct.h b/arch/mips/include/asm/dma-direct.h
index b5c240806e1b..14e352651ce9 100644
--- a/arch/mips/include/asm/dma-direct.h
+++ b/arch/mips/include/asm/dma-direct.h
@@ -2,14 +2,6 @@
 #ifndef _MIPS_DMA_DIRECT_H
 #define _MIPS_DMA_DIRECT_H 1
 
-static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
-{
-	if (!dev->dma_mask)
-		return false;
-
-	return addr + size - 1 <= *dev->dma_mask;
-}
-
 dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr);
 phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr);
 
diff --git a/arch/powerpc/include/asm/dma-direct.h b/arch/powerpc/include/asm/dma-direct.h
index a2912b47102c..e29e8a236b8d 100644
--- a/arch/powerpc/include/asm/dma-direct.h
+++ b/arch/powerpc/include/asm/dma-direct.h
@@ -2,15 +2,6 @@
 #ifndef ASM_POWERPC_DMA_DIRECT_H
 #define ASM_POWERPC_DMA_DIRECT_H 1
 
-static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
-{
-	if (!dev->dma_mask)
-		return false;
-
-	return addr + size - 1 <=
-		min_not_zero(*dev->dma_mask, dev->bus_dma_mask);
-}
-
 static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	if (!dev)
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 6db863c3eb93..991f8aa2676e 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -24,6 +24,7 @@ static inline phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dev_addr)
 
 	return paddr + ((phys_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
 }
+#endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
 
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 {
@@ -38,7 +39,6 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 
 	return end <= min_not_zero(*dev->dma_mask, dev->bus_dma_mask);
 }
-#endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
 
 #ifdef CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED
 bool force_dma_unencrypted(struct device *dev);
-------------------------------------------------------------------------------


Git bisection log:

-------------------------------------------------------------------------------
git bisect start
# good: [fd8f64df95204951c3edd4c4a7817c909d55a100] mdio_bus: Fix init if CONFIG_RESET_CONTROLLER=n
git bisect good fd8f64df95204951c3edd4c4a7817c909d55a100
# bad: [1fef9976397fc9b951ee54467eccd65e0c508785] Add linux-next specific files for 20191120
git bisect bad 1fef9976397fc9b951ee54467eccd65e0c508785
# bad: [cf8226f5c44196785f624a89d4ecc0d37a497ea5] Merge remote-tracking branch 'crypto/master'
git bisect bad cf8226f5c44196785f624a89d4ecc0d37a497ea5
# bad: [74f00449ecd89d1239b6d0c0e7b0f2b6f8df7eca] Merge remote-tracking branch 'pstore/for-next/pstore'
git bisect bad 74f00449ecd89d1239b6d0c0e7b0f2b6f8df7eca
# bad: [56caf45711a6ab3efee14944a25b619241d8a8f1] Merge remote-tracking branch 'rockchip/for-next'
git bisect bad 56caf45711a6ab3efee14944a25b619241d8a8f1
# good: [ef9980578a06d184b95661a5de904d0d3d5d0c39] Merge branch 'arm/dt' into for-next
git bisect good ef9980578a06d184b95661a5de904d0d3d5d0c39
# good: [e1351090dd4a172fb26317ae6fa846ab13c50199] ARM: Document merges
git bisect good e1351090dd4a172fb26317ae6fa846ab13c50199
# bad: [0ab68e0575be44525a043d048863a6078ab6ed0d] Merge remote-tracking branch 'arm/for-next'
git bisect bad 0ab68e0575be44525a043d048863a6078ab6ed0d
# good: [08504765f773b151ff96f75b36e6a7f1c3308ccf] Merge remote-tracking branch 'spdx/spdx-linus'
git bisect good 08504765f773b151ff96f75b36e6a7f1c3308ccf
# bad: [ce154ead79b9a97e4376785dc7b3fe20b6d9a3ea] Merge remote-tracking branch 'dma-mapping/for-next'
git bisect bad ce154ead79b9a97e4376785dc7b3fe20b6d9a3ea
# good: [0241ea8cae19b49fc1b1459f7bbe9a77f4f9cc89] modpost: free ns_deps_buf.p after writing ns_deps files
git bisect good 0241ea8cae19b49fc1b1459f7bbe9a77f4f9cc89
# good: [e380a0394c36a3a878c858418d5dd7f5f195b6fc] x86/PCI: sta2x11: use default DMA address translation
git bisect good e380a0394c36a3a878c858418d5dd7f5f195b6fc
# good: [fcbb8461fd2376ba3782b5b8bd440c929b8e4980] kbuild: remove header compile test
git bisect good fcbb8461fd2376ba3782b5b8bd440c929b8e4980
# bad: [e4d2bda544c7df90abed8aaa099b5daf1870bcf8] dma-direct: avoid a forward declaration for phys_to_dma
git bisect bad e4d2bda544c7df90abed8aaa099b5daf1870bcf8
# bad: [b037b220e71dcbb34cb710e00ffad2ec025b9163] dma-direct: unify the dma_capable definitions
git bisect bad b037b220e71dcbb34cb710e00ffad2ec025b9163
# good: [9f0e56e96c7b2039edb4bda64410216c6e9fe93f] dma-mapping: drop the dev argument to arch_sync_dma_for_*
git bisect good 9f0e56e96c7b2039edb4bda64410216c6e9fe93f
# first bad commit: [b037b220e71dcbb34cb710e00ffad2ec025b9163] dma-direct: unify the dma_capable definitions
-------------------------------------------------------------------------------
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
