Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63986194C65;
	Thu, 19 Sep 2024 07:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726732478; cv=none; b=fUFWPAKwxOZhVHjp+foZxAgg8c/D6Od/EAY/O3VWmYhZBJWtryvR0a1SQLiCjj3UG3xzVXibn1vEyGlDzFiYf90CsPElVFN+M3ihHvfHTrkQPOg8wWg1ZK+VsDZCCG0SwKIRJcso9FL+5OXX/Vybd+DelGmhMFRaBJpQCUIGfbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726732478; c=relaxed/simple;
	bh=QqRxWzgp15BviLllbfSY1mp7jXqkbdNL+8LzmwSNstU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GkOP95ZDW1Ofp5Chf7AF5FSSu1VkRuurnnJygp7riuyLnKBQe3u4MXYU2+1PBfP1Nuf+GQZ4t+T4Lb8wgpJzoA39F2XqkQ/8atNKfUZZBvzBrvmb3aBAI9oI/TuHVHYuOn3lKnk3R70vMIN2etn6jhKcagxQywXmTB3GY9/B4xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CbSHQyFK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CbSHQyFK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=BDPUx770ruE0a07XK3iQ1bQ7vxJsCBOZDgJ2x6Gx7p8=; b=CbSHQyFKRTjCHEsME9G/slkL6X
	ENeUUQcfGLRGcMguy3o/pYreJfuXMZjVTIuN83y7kgq/KcOOxJuL7bG/7Q4bhv7JcJ0CLL75UrxdE
	so1RXdTCJ2Ti46x1pdxASLTjdfSm7TwVdJ5JNUxDtas1mjpk2JXWA//WD7hDmm6XOdyajHNSYmkuY
	snbtsbYlcZbAnFzdzZ42YhqaRYIRvdZkftFozwPSVctg/NRROFJzjKnS2I/AHdIsaZyQN6ZxmbPew
	Byj4rsodStrYyv+NW5XzHJRMNaLO5EKQMMTLC+8RO+81iu+oOni+T31b2ahcbphD4PKsIe+o2PThU
	8JmOhtTg==;
Received: from [62.218.44.93] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1srBzL-00000009icQ-453m;
	Thu, 19 Sep 2024 07:54:08 +0000
Date: Thu, 19 Sep 2024 09:54:05 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping updates for Linux 6.12
Message-ID: <ZuvYnXzbM2qfXQPT@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.12-2024-09-19

for you to fetch changes up to a5fb217f13f74b2af2ab366ffad522bae717f93c:

  dma-mapping: reflow dma_supported (2024-09-12 16:28:00 +0200)

----------------------------------------------------------------
dma-mapping updates for linux 6.12

 - support DMA zones for arm64 systems where memory starts at > 4GB
   (Baruch Siach, Catalin Marinas)
 - support direct calls into dma-iommu and thus obsolete dma_map_ops for
   many common configurations (Leon Romanovsky)
 - add DMA-API tracing (Sean Anderson)
 - remove the not very useful return value from various dma_set_* APIs
   (Christoph Hellwig)
 - misc cleanups and minor optimizations (Chen Y, Yosry Ahmed,
   Christoph Hellwig)

----------------------------------------------------------------
Baruch Siach (2):
      arm64: mm: fix DMA zone when dma-ranges is missing
      arm64: mm: keep low RAM dma zone

Catalin Marinas (2):
      dma-mapping: replace zone_dma_bits by zone_dma_limit
      arm64: support DMA zone above 4GB

Chen Yu (1):
      dma-direct: optimize page freeing when it is not addressable

Christoph Hellwig (7):
      scsi: check that busses support the DMA API before setting dma parameters
      dma-mapping: don't return errors from dma_set_min_align_mask
      dma-mapping: don't return errors from dma_set_seg_boundary
      dma-mapping: don't return errors from dma_set_max_seg_size
      vdpa_sim: don't select DMA_OPS
      dma-mapping: clearly mark DMA ops as an architecture feature
      dma-mapping: reflow dma_supported

Leon Romanovsky (4):
      dma-mapping: call ->unmap_page and ->unmap_sg unconditionally
      dma-mapping: direct calls for dma-iommu
      dma-mapping: use IOMMU DMA calls for common alloc/free page calls
      dma-mapping: reliably inform about DMA support for IOMMU

Sean Anderson (1):
      dma-mapping: add tracing for dma-mapping API calls

Yosry Ahmed (1):
      dma-mapping: use bit masking to check VM_DMA_COHERENT

 MAINTAINERS                                        |   1 +
 arch/Kconfig                                       |   9 +
 arch/alpha/Kconfig                                 |   2 +-
 arch/arm/Kconfig                                   |   2 +-
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/mm/init.c                               |  39 ++-
 arch/mips/Kconfig                                  |   2 +-
 arch/parisc/Kconfig                                |   2 +-
 arch/powerpc/Kconfig                               |   2 +-
 arch/powerpc/mm/mem.c                              |   5 +-
 arch/s390/Kconfig                                  |   2 +-
 arch/s390/mm/init.c                                |   2 +-
 arch/sparc/Kconfig                                 |   2 +-
 arch/x86/Kconfig                                   |   2 +-
 drivers/accel/qaic/qaic_drv.c                      |   4 +-
 drivers/dma/idma64.c                               |   4 +-
 drivers/dma/pl330.c                                |   5 +-
 drivers/dma/qcom/bam_dma.c                         |   6 +-
 drivers/dma/sh/rcar-dmac.c                         |   4 +-
 drivers/dma/ste_dma40.c                            |   6 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |   6 +-
 drivers/iommu/Kconfig                              |   2 +-
 drivers/iommu/dma-iommu.c                          | 104 +++----
 drivers/iommu/intel/Kconfig                        |   1 -
 drivers/macintosh/macio_asic.c                     |   4 +-
 .../media/common/videobuf2/videobuf2-dma-contig.c  |   3 +-
 drivers/media/pci/intel/ipu6/Kconfig               |   7 +-
 drivers/media/pci/intel/ipu6/ipu6.c                |   4 +-
 drivers/mmc/host/mmci_stm32_sdmmc.c                |   3 +-
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |   6 +-
 drivers/scsi/lpfc/lpfc_init.c                      |   7 +-
 drivers/scsi/scsi_lib.c                            |  11 +-
 drivers/vdpa/Kconfig                               |  10 +-
 drivers/xen/Kconfig                                |   4 +-
 include/linux/device.h                             |   7 +-
 include/linux/dma-direct.h                         |   2 +-
 include/linux/dma-map-ops.h                        |  19 +-
 include/linux/dma-mapping.h                        |  25 +-
 include/linux/iommu-dma.h                          | 155 ++++++++++
 include/trace/events/dma.h                         | 341 +++++++++++++++++++++
 kernel/dma/Kconfig                                 |   7 +-
 kernel/dma/Makefile                                |   4 +-
 kernel/dma/direct.c                                |   8 +-
 kernel/dma/dummy.c                                 |  21 ++
 kernel/dma/mapping.c                               | 115 ++++++-
 kernel/dma/ops_helpers.c                           |  14 +-
 kernel/dma/pool.c                                  |   4 +-
 kernel/dma/remap.c                                 |   6 +-
 kernel/dma/swiotlb.c                               |   6 +-
 49 files changed, 782 insertions(+), 226 deletions(-)
 create mode 100644 include/linux/iommu-dma.h
 create mode 100644 include/trace/events/dma.h
