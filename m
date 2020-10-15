Return-Path: <SRS0=+Hy+=DW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9A2C433E7
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 17:50:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED6202222B
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 17:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HuG1jJAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6202222B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6D3608846A;
	Thu, 15 Oct 2020 17:50:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v2xTIo3DNeyv; Thu, 15 Oct 2020 17:50:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8B96988463;
	Thu, 15 Oct 2020 17:50:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61DA3C0052;
	Thu, 15 Oct 2020 17:50:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F6C3C0051
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 17:50:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1AA5E87E4A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 17:50:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mZhA7a3sSN05 for <iommu@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 17:50:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E693487E16
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 17:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=czYagtGSHmNwaWLLRuShjGY+XMb6ror0u4Ss+K7L9v8=; b=HuG1jJACIbB24KxRXnZwhl0pLb
 ud9OeMhcUNTOjjDmzWcI9qv/5iuoARkpks0okru4PTc+utHZ9TKwK4yAgIFrmgVdkZhFXk04/23EY
 MIh1imBcrCGUiTr2PxM5Rk99+TUOXv4IOOsGtXxf+6nR1kLPaABVwwlTzQAk3AMtGA0mCp0swZvAp
 7WgD6lwL9KDU/VNQCfwm7xijjWHAv6sstTBUeFn2DLjCvdlqP2Z4BW3FYbZGuk4tDR8Xq9sCpxlO2
 /sJ+meSMm7JrVkv7FX2LU8ZzWQE+oiCRVQThtfCqOcD9niiFDQiHSdVTv6YzJHJ5Tim+N0c2UI3Pf
 5NeCjnFg==;
Received: from 213-225-9-134.nat.highway.a1.net ([213.225.9.134]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kT7O0-0000dJ-JQ; Thu, 15 Oct 2020 17:49:57 +0000
Date: Thu, 15 Oct 2020 19:47:43 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] dma-mapping updates for 5.10
Message-ID: <20201015174743.GA2648490@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

Hi Linus,

please pull the dma-mapping update for 5.10.  It contains a (clean) merge
of a later 5.9-rc commit, as I had to pull in a media subsystem revert
that is required for later commits.

There are a few trivial contextual conflicts due to the dma-mapping.h
split, for those simple keep both sides, that is the new headers added
by other trees as well as the ones added here, or the entire file
deletions in case of the arm tree.


The following changes since commit 171d4ff79f965c1f164705ef0aaea102a6ad238b:

  Merge tag 'mmc-v5.9-rc4-2' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc (2020-09-24 09:09:47 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.10

for you to fetch changes up to 2a410d09417b5344ab1f3cf001ac73a1daf8dcce:

  ARM/ixp4xx: add a missing include of dma-map-ops.h (2020-10-13 13:28:22 +0200)

----------------------------------------------------------------
dma-mapping updates for 5.10

 - rework the non-coherent DMA allocator
 - move private definitions out of <linux/dma-mapping.h>
 - lower CMA_ALIGNMENT (Paul Cercueil)
 - remove the omap1 dma address translation in favor of the common
   code
 - make dma-direct aware of multiple dma offset ranges (Jim Quinlan)
 - support per-node DMA CMA areas (Barry Song)
 - increase the default seg boundary limit (Nicolin Chen)
 - misc fixes (Robin Murphy, Thomas Tai, Xu Wang)
 - various cleanups

----------------------------------------------------------------
Barry Song (3):
      dma-contiguous: provide the ability to reserve per-numa CMA
      arm64: mm: reserve per-numa CMA to localize coherent dma buffers
      mm: cma: use CMA_MAX_NAME to define the length of cma name array

Christoph Hellwig (54):
      dma-mapping: remove the dma_dummy_ops export
      dma-debug: remove most exports
      MIPS: make dma_sync_*_for_cpu a little less overzealous
      MIPS/jazzdma: remove the unused vdma_remap function
      MIPS/jazzdma: decouple from dma-direct
      dma-mapping: fix DMA_OPS dependencies
      dma-mapping: add (back) arch_dma_mark_clean for ia64
      dma-direct: remove dma_direct_{alloc,free}_pages
      dma-direct: lift gfp_t manipulation out of__dma_direct_alloc_pages
      dma-direct: use phys_to_dma_direct in dma_direct_alloc
      dma-direct: remove __dma_to_phys
      dma-direct: rename and cleanup __phys_to_dma
      dma-mapping: move dma_common_{mmap,get_sgtable} out of mapping.c
      dma-mapping: move the dma_declare_coherent_memory documentation
      ARM/dma-mapping: remove a __arch_page_to_dma #error
      ARM/dma-mapping: remove dma_to_virt
      ARM/dma-mapping: move various helpers from dma-mapping.h to dma-direct.h
      ARM/keystone: move the DMA offset handling under ifdef CONFIG_ARM_LPAE
      usb: don't inherity DMA properties for USB devices
      dma-mapping: remove DMA_MASK_NONE
      dma-mapping: move valid_dma_direction to dma-direction.h
      dma-mapping: better document dma_addr_t and DMA_MAPPING_ERROR
      ARM/omap1: switch to use dma_direct_set_offset for lbus DMA offsets
      Merge branch 'master' of https://git.kernel.org/.../torvalds/linux into dma-mapping-for-next
      mm: turn alloc_pages into an inline function
      drm/exynos: stop setting DMA_ATTR_NON_CONSISTENT
      drm/nouveau/gk20a: stop setting DMA_ATTR_NON_CONSISTENT
      net/au1000-eth: stop using DMA_ATTR_NON_CONSISTENT
      lib82596: move DMA allocation into the callers of i82596_probe
      53c700: improve non-coherent DMA handling
      dma-mapping: add a new dma_alloc_noncoherent API
      sgiwd93: convert to dma_alloc_noncoherent
      hal2: convert to dma_alloc_noncoherent
      lib82596: convert to dma_alloc_noncoherent
      sgiseeq: convert to dma_alloc_noncoherent
      53c700: convert to dma_alloc_noncoherent
      dma-mapping: remove dma_cache_sync
      dma-mapping: add a new dma_alloc_pages API
      dma-mapping: add new {alloc,free}_noncoherent dma_map_ops methods
      dma-iommu: implement ->alloc_noncoherent
      firewire-ohci: use dma_alloc_pages
      dma-mapping: split <linux/dma-mapping.h>
      dma-contiguous: remove dma_declare_contiguous
      dma-contiguous: remove dev_set_cma_area
      dma-contiguous: remove dma_contiguous_set_default
      dma-mapping: merge <linux/dma-contiguous.h> into <linux/dma-map-ops.h>
      dma-mapping: remove <asm/dma-contiguous.h>
      dma-mapping: move dma-debug.h to kernel/dma/
      dma-mapping: move large parts of <linux/dma-direct.h> to kernel/dma
      dma-mapping: merge <linux/dma-noncoherent.h> into <linux/dma-map-ops.h>
      dma-direct check for highmem pages in dma_direct_alloc_pages
      dma-direct: factor out a dma_direct_alloc_from_pool helper
      dma-direct: simplify the DMA_ATTR_NO_KERNEL_MAPPING handling
      ARM/ixp4xx: add a missing include of dma-map-ops.h

Jim Quinlan (1):
      dma-mapping: introduce DMA range map, supplanting dma_pfn_offset

Nicolin Chen (2):
      dma-mapping: introduce dma_get_seg_boundary_nr_pages()
      dma-mapping: set default segment_boundary_mask to ULONG_MAX

Paul Cercueil (1):
      cma: decrease CMA_ALIGNMENT lower limit to 2

Robin Murphy (1):
      iommu/io-pgtable-arm: Clean up faulty sanity check

Thomas Tai (1):
      dma-direct: Fix potential NULL pointer dereference

Xu Wang (1):
      dma-debug: convert comma to semicolon

 Documentation/admin-guide/kernel-parameters.txt    |  13 +-
 Documentation/core-api/dma-api.rst                 |  99 +++----
 Documentation/core-api/dma-attributes.rst          |   8 -
 MAINTAINERS                                        |   2 +-
 arch/alpha/kernel/pci_iommu.c                      |  11 +-
 arch/arc/mm/dma.c                                  |   2 +-
 arch/arm/common/dmabounce.c                        |   3 +-
 arch/arm/include/asm/dma-contiguous.h              |  15 -
 arch/arm/include/asm/dma-direct.h                  |  35 ++-
 arch/arm/include/asm/dma-iommu.h                   |   1 -
 arch/arm/include/asm/dma-mapping.h                 |  71 -----
 arch/arm/mach-davinci/devices-da8xx.c              |  18 +-
 arch/arm/mach-highbank/highbank.c                  |   2 +-
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c        |   2 +-
 arch/arm/mach-imx/mach-mx31moboard.c               |   2 +-
 arch/arm/mach-ixp4xx/common.c                      |   1 +
 arch/arm/mach-keystone/keystone.c                  |  21 +-
 arch/arm/mach-mvebu/coherency.c                    |   2 +-
 arch/arm/mach-omap1/include/mach/memory.h          |  31 --
 arch/arm/mach-omap1/usb.c                          |  22 ++
 arch/arm/mach-shmobile/setup-rcar-gen2.c           |   2 +-
 arch/arm/mm/dma-mapping-nommu.c                    |   3 +
 arch/arm/mm/dma-mapping.c                          |   9 +-
 arch/arm/mm/init.c                                 |   2 +-
 arch/arm/xen/mm.c                                  |   2 +-
 arch/arm64/mm/dma-mapping.c                        |   2 +-
 arch/arm64/mm/init.c                               |   5 +-
 arch/c6x/mm/dma-coherent.c                         |   2 +-
 arch/csky/kernel/setup.c                           |   2 +-
 arch/csky/mm/dma-mapping.c                         |   4 +-
 arch/hexagon/kernel/dma.c                          |   2 +-
 arch/ia64/Kconfig                                  |   3 +-
 arch/ia64/hp/common/sba_iommu.c                    |   7 +-
 arch/ia64/kernel/dma-mapping.c                     |  14 +-
 arch/ia64/mm/init.c                                |   5 +-
 arch/m68k/kernel/dma.c                             |   2 +-
 arch/microblaze/kernel/dma.c                       |   3 +-
 arch/microblaze/mm/consistent.c                    |   2 +-
 arch/microblaze/mm/init.c                          |   2 +-
 arch/mips/Kconfig                                  |   1 -
 arch/mips/bmips/dma.c                              |   4 +-
 arch/mips/cavium-octeon/dma-octeon.c               |   4 +-
 arch/mips/include/asm/dma-direct.h                 |   4 +-
 arch/mips/include/asm/jazzdma.h                    |   2 -
 arch/mips/jazz/jazzdma.c                           | 105 ++-----
 arch/mips/kernel/setup.c                           |   2 +-
 arch/mips/loongson2ef/fuloong-2e/dma.c             |   4 +-
 arch/mips/loongson2ef/lemote-2f/dma.c              |   4 +-
 arch/mips/loongson64/dma.c                         |   4 +-
 arch/mips/mm/dma-noncoherent.c                     |  51 ++--
 arch/mips/pci/pci-ar2315.c                         |   4 +-
 arch/mips/pci/pci-xtalk-bridge.c                   |   4 +-
 arch/mips/sgi-ip32/ip32-dma.c                      |   4 +-
 arch/nds32/kernel/dma.c                            |   2 +-
 arch/openrisc/kernel/dma.c                         |   2 +-
 arch/parisc/Kconfig                                |   1 -
 arch/parisc/kernel/drivers.c                       |   1 +
 arch/parisc/kernel/pci-dma.c                       |   8 +-
 arch/powerpc/include/asm/dma-direct.h              |   4 +-
 arch/powerpc/include/asm/iommu.h                   |   2 +-
 arch/powerpc/include/asm/pci.h                     |   2 +-
 arch/powerpc/kernel/dma-iommu.c                    |   2 +
 arch/powerpc/kernel/iommu.c                        |  11 +-
 arch/powerpc/mm/dma-noncoherent.c                  |   2 +-
 arch/powerpc/platforms/ps3/system-bus.c            |   6 +-
 arch/powerpc/platforms/pseries/ibmebus.c           |   2 +-
 arch/powerpc/platforms/pseries/vio.c               |   4 +-
 arch/s390/kernel/setup.c                           |   2 +-
 arch/s390/pci/pci_dma.c                            |  10 +-
 arch/sh/boards/mach-ap325rxa/setup.c               |   1 +
 arch/sh/boards/mach-ecovec24/setup.c               |   1 +
 arch/sh/boards/mach-kfr2r09/setup.c                |   2 +-
 arch/sh/boards/mach-migor/setup.c                  |   2 +-
 arch/sh/boards/mach-se/7724/setup.c                |   1 +
 arch/sh/drivers/pci/fixups-dreamcast.c             |   2 +-
 arch/sh/drivers/pci/pci.c                          |   1 -
 arch/sh/drivers/pci/pcie-sh7786.c                  |   9 +-
 arch/sh/kernel/dma-coherent.c                      |   2 +-
 arch/sparc/kernel/iommu-common.c                   |  10 +-
 arch/sparc/kernel/iommu.c                          |   5 +-
 arch/sparc/kernel/ioport.c                         |   2 +-
 arch/sparc/kernel/pci_sun4v.c                      |   4 +-
 arch/sparc/mm/io-unit.c                            |   2 +-
 arch/sparc/mm/iommu.c                              |   2 +-
 arch/x86/include/asm/dma-mapping.h                 |   2 -
 arch/x86/kernel/amd_gart_64.c                      |  12 +-
 arch/x86/kernel/pci-dma.c                          |   2 +-
 arch/x86/kernel/setup.c                            |   2 +
 arch/x86/pci/sta2x11-fixup.c                       |   6 +-
 arch/x86/xen/pci-swiotlb-xen.c                     |   2 +-
 arch/xtensa/kernel/pci-dma.c                       |   3 +-
 arch/xtensa/mm/init.c                              |   2 +-
 drivers/acpi/arm64/iort.c                          |   6 +-
 drivers/acpi/scan.c                                |   2 +-
 drivers/base/core.c                                |   2 +
 drivers/base/dd.c                                  |   2 +-
 drivers/dma-buf/heaps/cma_heap.c                   |   2 +-
 drivers/firewire/ohci.c                            |  26 +-
 drivers/gpu/drm/exynos/exynos_drm_dma.c            |   2 +-
 drivers/gpu/drm/exynos/exynos_drm_gem.c            |   2 -
 drivers/gpu/drm/msm/msm_gem.c                      |   1 +
 .../gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c    |   3 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c              |   8 +-
 drivers/iommu/amd/iommu.c                          |   3 +-
 drivers/iommu/dma-iommu.c                          |  46 ++-
 drivers/iommu/intel/iommu.c                        |  10 +-
 drivers/iommu/io-pgtable-arm.c                     |   5 -
 drivers/media/platform/exynos4-is/fimc-is.c        |   1 -
 drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c |   9 +-
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c |  11 +-
 drivers/misc/mic/Kconfig                           |   1 +
 drivers/misc/mic/bus/mic_bus.c                     |   1 +
 drivers/misc/mic/bus/scif_bus.c                    |   2 +-
 drivers/misc/mic/bus/scif_bus.h                    |   2 +-
 drivers/misc/mic/bus/vop_bus.c                     |   2 +-
 drivers/misc/mic/host/mic_boot.c                   |   1 +
 drivers/net/ethernet/amd/au1000_eth.c              |  15 +-
 drivers/net/ethernet/i825xx/lasi_82596.c           |  37 +--
 drivers/net/ethernet/i825xx/lib82596.c             | 148 +++++-----
 drivers/net/ethernet/i825xx/sni_82596.c            |  23 +-
 drivers/net/ethernet/seeq/sgiseeq.c                |  28 +-
 drivers/of/address.c                               |  73 ++---
 drivers/of/device.c                                |  45 +--
 drivers/of/of_private.h                            |  11 +-
 drivers/of/unittest.c                              |  34 ++-
 drivers/parisc/ccio-dma.c                          |   6 +-
 drivers/parisc/sba_iommu.c                         |   6 +-
 drivers/pci/pci-driver.c                           |   1 +
 drivers/pci/xen-pcifront.c                         |   1 +
 drivers/pcmcia/ds.c                                |   2 +-
 drivers/remoteproc/remoteproc_core.c               |  25 +-
 drivers/remoteproc/remoteproc_virtio.c             |   2 +-
 drivers/scsi/53c700.c                              | 121 ++++----
 drivers/scsi/53c700.h                              |  17 +-
 drivers/scsi/sgiwd93.c                             |  14 +-
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c     |  10 +-
 drivers/usb/core/message.c                         |   6 -
 drivers/usb/core/usb.c                             |  12 -
 drivers/vdpa/vdpa_sim/vdpa_sim.c                   |   2 +-
 drivers/xen/swiotlb-xen.c                          |   4 +-
 include/asm-generic/Kbuild                         |   1 -
 include/asm-generic/dma-contiguous.h               |  10 -
 include/linux/cma.h                                |   2 +
 include/linux/device.h                             |   4 +-
 include/linux/dma-contiguous.h                     | 176 -----------
 include/linux/dma-direct.h                         | 198 +++++--------
 include/linux/dma-direction.h                      |   8 +-
 include/linux/dma-map-ops.h                        | 326 +++++++++++++++++++++
 include/linux/dma-mapping.h                        | 240 ++++-----------
 include/linux/dma-noncoherent.h                    | 114 -------
 include/linux/gfp.h                                |   6 +-
 kernel/dma/Kconfig                                 |  25 +-
 kernel/dma/Makefile                                |   1 +
 kernel/dma/coherent.c                              |  25 +-
 kernel/dma/contiguous.c                            | 142 ++++++++-
 kernel/dma/debug.c                                 |  19 +-
 include/linux/dma-debug.h => kernel/dma/debug.h    |  44 +--
 kernel/dma/direct.c                                | 268 ++++++++++-------
 kernel/dma/direct.h                                | 119 ++++++++
 kernel/dma/dummy.c                                 |   3 +-
 kernel/dma/mapping.c                               | 159 ++++++----
 kernel/dma/ops_helpers.c                           |  85 ++++++
 kernel/dma/pool.c                                  |   5 +-
 kernel/dma/swiotlb.c                               |   6 +-
 kernel/dma/virt.c                                  |   4 +-
 mm/Kconfig                                         |   3 +-
 mm/cma.h                                           |   2 -
 mm/hugetlb.c                                       |   4 +-
 mm/memory.c                                        |   1 -
 sound/mips/hal2.c                                  |  58 ++--
 170 files changed, 1921 insertions(+), 1699 deletions(-)
 delete mode 100644 arch/arm/include/asm/dma-contiguous.h
 delete mode 100644 include/asm-generic/dma-contiguous.h
 delete mode 100644 include/linux/dma-contiguous.h
 create mode 100644 include/linux/dma-map-ops.h
 delete mode 100644 include/linux/dma-noncoherent.h
 rename include/linux/dma-debug.h => kernel/dma/debug.h (81%)
 create mode 100644 kernel/dma/direct.h
 create mode 100644 kernel/dma/ops_helpers.c
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
