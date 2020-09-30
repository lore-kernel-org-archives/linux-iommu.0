Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC182C4727F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 08:56:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA7B720659
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 08:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GUmCkkS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7B720659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 62E0787211;
	Wed, 30 Sep 2020 08:56:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wA1-bFQEhIQw; Wed, 30 Sep 2020 08:56:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5BAE486FFB;
	Wed, 30 Sep 2020 08:56:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30B46C0890;
	Wed, 30 Sep 2020 08:56:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3BD2C016F
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:55:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5F3EC20445
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:55:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DjzWflpalU9C for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 08:55:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by silver.osuosl.org (Postfix) with ESMTPS id E6603203D0
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=Hc4ZwUam31VwnraGp3u9+lkEQz3nnsxSY58s3rx8EN0=; b=GUmCkkS5M+DSSMVNpa1ARhdAOA
 xO1GX/XB3fZ+wQwodHpr/baxLfM1+ws4Gny5Pxmnfo3SlUOIvRDrw39kG2TLkTY5ygx0ry4qqSeGJ
 IPWIRMCwy3u3fH/caphz5js/VXACSaObZ5Bfp+MoemoiCRqD5eQCtYvXVlyzBXwIAOZ+dQV8nHd4k
 JmW/GH/dHH8+I20mR3g4P/17KMvXn0UuDKyD8IfOTCnG0K5pB8msoYd5hKoxs0zxM5HADDe6wGyWA
 1h3S1M0SgisK5DoRE9WkQVgagY0SFWqcncFM8t6V8sgMAtAVbeQJ8CmDT5lLkrTJP4gWCrpZ69Cwo
 VSXIwEqw==;
Received: from [2001:4bb8:180:7b62:c70:4a89:bc61:4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNXtv-0003s2-OW; Wed, 30 Sep 2020 08:55:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: clean up the DMA mapping headers
Date: Wed, 30 Sep 2020 10:55:39 +0200
Message-Id: <20200930085548.920261-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-arch@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

Hi all,

this series cleans up the dma-mapping headers by moving everything not
required by normal drivers out of <linux/dma-mapping.h> into a new
<linux/dma-map-ops.h> and then folding most other DMA mapping related
headers either into the new dma-map-ops.h one, or by moving them to
kernel/dma/ and thus out of the global scope.  A bunch of cleanups
for the DMA CMA code are thrown in as well, as they help keeping the
exposed bits in the header small.

Diffstat:
 arch/arm/include/asm/dma-contiguous.h             |   15 
 b/Documentation/admin-guide/kernel-parameters.txt |    2 
 b/MAINTAINERS                                     |    2 
 b/arch/alpha/kernel/pci_iommu.c                   |    2 
 b/arch/arc/mm/dma.c                               |    2 
 b/arch/arm/common/dmabounce.c                     |    1 
 b/arch/arm/include/asm/dma-iommu.h                |    1 
 b/arch/arm/include/asm/dma-mapping.h              |    1 
 b/arch/arm/mach-davinci/devices-da8xx.c           |   18 -
 b/arch/arm/mach-highbank/highbank.c               |    2 
 b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c     |    2 
 b/arch/arm/mach-imx/mach-mx31moboard.c            |    2 
 b/arch/arm/mach-mvebu/coherency.c                 |    2 
 b/arch/arm/mach-shmobile/setup-rcar-gen2.c        |    2 
 b/arch/arm/mm/dma-mapping-nommu.c                 |    1 
 b/arch/arm/mm/dma-mapping.c                       |    5 
 b/arch/arm/mm/init.c                              |    2 
 b/arch/arm/xen/mm.c                               |    2 
 b/arch/arm64/mm/dma-mapping.c                     |    2 
 b/arch/arm64/mm/init.c                            |    3 
 b/arch/c6x/mm/dma-coherent.c                      |    2 
 b/arch/csky/kernel/setup.c                        |    2 
 b/arch/csky/mm/dma-mapping.c                      |    4 
 b/arch/hexagon/kernel/dma.c                       |    2 
 b/arch/ia64/hp/common/sba_iommu.c                 |    2 
 b/arch/ia64/kernel/dma-mapping.c                  |    2 
 b/arch/ia64/mm/init.c                             |    2 
 b/arch/m68k/kernel/dma.c                          |    2 
 b/arch/microblaze/kernel/dma.c                    |    3 
 b/arch/microblaze/mm/consistent.c                 |    2 
 b/arch/microblaze/mm/init.c                       |    2 
 b/arch/mips/jazz/jazzdma.c                        |    2 
 b/arch/mips/kernel/setup.c                        |    2 
 b/arch/mips/mm/dma-noncoherent.c                  |    3 
 b/arch/nds32/kernel/dma.c                         |    2 
 b/arch/openrisc/kernel/dma.c                      |    2 
 b/arch/parisc/kernel/drivers.c                    |    1 
 b/arch/parisc/kernel/pci-dma.c                    |    2 
 b/arch/powerpc/include/asm/iommu.h                |    2 
 b/arch/powerpc/include/asm/pci.h                  |    2 
 b/arch/powerpc/mm/dma-noncoherent.c               |    2 
 b/arch/powerpc/platforms/ps3/system-bus.c         |    2 
 b/arch/powerpc/platforms/pseries/ibmebus.c        |    2 
 b/arch/powerpc/platforms/pseries/vio.c            |    2 
 b/arch/s390/kernel/setup.c                        |    2 
 b/arch/s390/pci/pci_dma.c                         |    2 
 b/arch/sh/boards/mach-ap325rxa/setup.c            |    1 
 b/arch/sh/boards/mach-ecovec24/setup.c            |    1 
 b/arch/sh/boards/mach-kfr2r09/setup.c             |    2 
 b/arch/sh/boards/mach-migor/setup.c               |    2 
 b/arch/sh/boards/mach-se/7724/setup.c             |    1 
 b/arch/sh/drivers/pci/fixups-dreamcast.c          |    2 
 b/arch/sh/drivers/pci/pci.c                       |    1 
 b/arch/sh/kernel/dma-coherent.c                   |    2 
 b/arch/sparc/kernel/iommu.c                       |    2 
 b/arch/sparc/kernel/ioport.c                      |    2 
 b/arch/sparc/kernel/pci_sun4v.c                   |    1 
 b/arch/sparc/mm/io-unit.c                         |    2 
 b/arch/sparc/mm/iommu.c                           |    2 
 b/arch/x86/include/asm/dma-mapping.h              |    2 
 b/arch/x86/kernel/amd_gart_64.c                   |    1 
 b/arch/x86/kernel/pci-dma.c                       |    2 
 b/arch/x86/kernel/setup.c                         |    2 
 b/arch/x86/xen/pci-swiotlb-xen.c                  |    2 
 b/arch/xtensa/kernel/pci-dma.c                    |    3 
 b/arch/xtensa/mm/init.c                           |    2 
 b/drivers/acpi/arm64/iort.c                       |    2 
 b/drivers/acpi/scan.c                             |    2 
 b/drivers/base/dd.c                               |    2 
 b/drivers/dma-buf/heaps/cma_heap.c                |    2 
 b/drivers/gpu/drm/exynos/exynos_drm_dma.c         |    2 
 b/drivers/gpu/drm/msm/msm_gem.c                   |    1 
 b/drivers/iommu/amd/iommu.c                       |    3 
 b/drivers/iommu/dma-iommu.c                       |    3 
 b/drivers/iommu/intel/iommu.c                     |    4 
 b/drivers/media/platform/exynos4-is/fimc-is.c     |    1 
 b/drivers/misc/mic/bus/mic_bus.c                  |    1 
 b/drivers/misc/mic/bus/scif_bus.c                 |    2 
 b/drivers/misc/mic/bus/scif_bus.h                 |    2 
 b/drivers/misc/mic/bus/vop_bus.c                  |    2 
 b/drivers/misc/mic/host/mic_boot.c                |    1 
 b/drivers/of/device.c                             |    1 
 b/drivers/parisc/ccio-dma.c                       |    1 
 b/drivers/parisc/sba_iommu.c                      |    1 
 b/drivers/pci/pci-driver.c                        |    1 
 b/drivers/pci/xen-pcifront.c                      |    1 
 b/drivers/remoteproc/remoteproc_core.c            |    1 
 b/drivers/remoteproc/remoteproc_virtio.c          |    2 
 b/drivers/vdpa/vdpa_sim/vdpa_sim.c                |    2 
 b/drivers/xen/swiotlb-xen.c                       |    2 
 b/include/asm-generic/Kbuild                      |    1 
 b/include/linux/dma-direct.h                      |  108 -------
 b/include/linux/dma-map-ops.h                     |  339 ++++++++++++++++++++++
 b/include/linux/dma-mapping.h                     |  172 -----------
 b/kernel/dma/Kconfig                              |    2 
 b/kernel/dma/coherent.c                           |    1 
 b/kernel/dma/contiguous.c                         |   42 ++
 b/kernel/dma/debug.c                              |    5 
 b/kernel/dma/debug.h                              |   44 --
 b/kernel/dma/direct.c                             |    4 
 b/kernel/dma/direct.h                             |  119 +++++++
 b/kernel/dma/dummy.c                              |    2 
 b/kernel/dma/mapping.c                            |    5 
 b/kernel/dma/ops_helpers.c                        |    3 
 b/kernel/dma/pool.c                               |    3 
 b/kernel/dma/swiotlb.c                            |    2 
 b/kernel/dma/virt.c                               |    2 
 b/mm/memory.c                                     |    1 
 include/asm-generic/dma-contiguous.h              |   10 
 include/linux/dma-contiguous.h                    |  182 -----------
 include/linux/dma-noncoherent.h                   |  109 -------
 111 files changed, 620 insertions(+), 737 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
