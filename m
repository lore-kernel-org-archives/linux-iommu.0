Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B53C433EF
	for <iommu@archiver.kernel.org>; Wed, 25 May 2022 18:27:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 41B0A61369;
	Wed, 25 May 2022 18:27:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SAHKtB9Zbnd4; Wed, 25 May 2022 18:27:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B7CE360BC2;
	Wed, 25 May 2022 18:27:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AE05C0039;
	Wed, 25 May 2022 18:27:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2A39C002D
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 18:27:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A0CFB40ADC
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 18:27:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MXVUPKnZTvIm for <iommu@lists.linux-foundation.org>;
 Wed, 25 May 2022 18:27:35 +0000 (UTC)
X-Greylist: delayed 00:30:18 by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4689740A63
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 18:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=uT8Xnj4FC6BD3a7OWU/LMwY3KzTfWGLU6PgbKTLE6Vs=; b=WzFTyEbEtk6x+QrqdygYkKvPTR
 OwnWn2JfLraxu6LvukWi58rtZaHA7iO/gCSK9DZVYlXwFunsJZe1lMcTro1optklP16sol53atQHO
 kJGl6+vNdopxMcIhVQ/3XnAL5Rb8IBm1Ti0qadYcZBO5F6Zdbf6O69Z+YsXEJZIR+aurnryFC0a7b
 ytoYXmNbzGrjHDpfcOyeIGGSvy7+EdYDTmqYcBVuOxDihGReq6CmHoenGlpJcLwETtXq4M6YmYEMX
 EVRYA3JZ02XjvfEBPJcOCPyR6kjQKSXcmzxs65JMGCm5FhSVXOVf/ivBBhSYEwL/ZAPw9tD3LIsIl
 UEw8CBHA==;
Received: from [2001:4bb8:18c:7298:e5ef:ac1:508a:58b5] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntvFy-00C3op-Gd; Wed, 25 May 2022 17:57:14 +0000
Date: Wed, 25 May 2022 19:57:12 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] dma-mapping updates for Linux 5.19
Message-ID: <Yo5t+HAiFg5jaSEt@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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

The following changes since commit b2d229d4ddb17db541098b83524d901257e93845:

  Linux 5.18-rc3 (2022-04-17 13:57:31 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.19-2022-05-25

for you to fetch changes up to 4a37f3dd9a83186cb88d44808ab35b78375082c9:

  dma-direct: don't over-decrypt memory (2022-05-23 15:25:40 +0200)

There is a small merge conflict with the (as of now not merged yet) iommu
tree, which removes some code modified in this pull request.  The proper
merge resolution is to still remove the modified code.

----------------------------------------------------------------
dma-mapping updates for Linux 5.19

 - don't over-decrypt memory (Robin Murphy)
 - takes min align mask into account for the swiotlb max mapping size
   (Tianyu Lan)
 - use GFP_ATOMIC in dma-debug (Mikulas Patocka)
 - fix DMA_ATTR_NO_KERNEL_MAPPING on xen/arm (me)
 - don't fail on highmem CMA pages in dma_direct_alloc_pages (me)
 - cleanup swiotlb initialization and share more code with swiotlb-xen
   (me, Stefano Stabellini)

----------------------------------------------------------------
Christoph Hellwig (19):
      dma-direct: use is_swiotlb_active in dma_direct_map_page
      swiotlb: make swiotlb_exit a no-op if SWIOTLB_FORCE is set
      swiotlb: simplify swiotlb_max_segment
      swiotlb: rename swiotlb_late_init_with_default_size
      MIPS/octeon: use swiotlb_init instead of open coding it
      x86: remove the IOMMU table infrastructure
      x86: centralize setting SWIOTLB_FORCE when guest memory encryption is enabled
      swiotlb: make the swiotlb_init interface more useful
      swiotlb: add a SWIOTLB_ANY flag to lift the low memory restriction
      swiotlb: pass a gfp_mask argument to swiotlb_init_late
      swiotlb: provide swiotlb_init variants that remap the buffer
      swiotlb: merge swiotlb-xen initialization into swiotlb
      swiotlb: remove swiotlb_init_with_tbl and swiotlb_init_late_with_tbl
      x86: remove cruft from <asm/dma-mapping.h>
      swiotlb-xen: fix DMA_ATTR_NO_KERNEL_MAPPING on arm
      dma-direct: don't fail on highmem CMA pages in dma_direct_alloc_pages
      swiotlb: don't panic when the swiotlb buffer can't be allocated
      swiotlb: use the right nslabs value in swiotlb_init_remap
      swiotlb: use the right nslabs-derived sizes in swiotlb_init_late

Mikulas Patocka (1):
      dma-debug: change allocation mode from GFP_NOWAIT to GFP_ATIOMIC

Robin Murphy (1):
      dma-direct: don't over-decrypt memory

Stefano Stabellini (1):
      arm/xen: don't check for xen_initial_domain() in xen_create_contiguous_region

Tianyu Lan (1):
      swiotlb: max mapping size takes min align mask into account

 arch/arm/include/asm/xen/page-coherent.h   |   2 -
 arch/arm/mm/init.c                         |   6 +-
 arch/arm/xen/mm.c                          |  38 ++---
 arch/arm64/include/asm/xen/page-coherent.h |   2 -
 arch/arm64/mm/init.c                       |   6 +-
 arch/ia64/include/asm/iommu_table.h        |   7 -
 arch/ia64/mm/init.c                        |   4 +-
 arch/mips/cavium-octeon/dma-octeon.c       |  15 +-
 arch/mips/loongson64/dma.c                 |   2 +-
 arch/mips/pci/pci-octeon.c                 |   2 +-
 arch/mips/sibyte/common/dma.c              |   2 +-
 arch/powerpc/include/asm/svm.h             |   4 -
 arch/powerpc/include/asm/swiotlb.h         |   1 +
 arch/powerpc/kernel/dma-swiotlb.c          |   1 +
 arch/powerpc/mm/mem.c                      |   6 +-
 arch/powerpc/platforms/pseries/setup.c     |   3 -
 arch/powerpc/platforms/pseries/svm.c       |  26 +---
 arch/riscv/mm/init.c                       |   8 +-
 arch/s390/mm/init.c                        |   3 +-
 arch/x86/include/asm/dma-mapping.h         |  12 --
 arch/x86/include/asm/gart.h                |   5 +-
 arch/x86/include/asm/iommu.h               |   8 +
 arch/x86/include/asm/iommu_table.h         | 102 -------------
 arch/x86/include/asm/swiotlb.h             |  30 ----
 arch/x86/include/asm/xen/page-coherent.h   |  24 ---
 arch/x86/include/asm/xen/page.h            |   5 -
 arch/x86/include/asm/xen/swiotlb-xen.h     |   8 +-
 arch/x86/kernel/Makefile                   |   2 -
 arch/x86/kernel/amd_gart_64.c              |   5 +-
 arch/x86/kernel/aperture_64.c              |  14 +-
 arch/x86/kernel/cpu/mshyperv.c             |   8 -
 arch/x86/kernel/pci-dma.c                  | 114 +++++++++++---
 arch/x86/kernel/pci-iommu_table.c          |  77 ----------
 arch/x86/kernel/pci-swiotlb.c              |  77 ----------
 arch/x86/kernel/tboot.c                    |   1 -
 arch/x86/kernel/vmlinux.lds.S              |  12 --
 arch/x86/mm/mem_encrypt_amd.c              |   3 -
 arch/x86/pci/sta2x11-fixup.c               |   2 +-
 arch/x86/xen/Makefile                      |   2 -
 arch/x86/xen/mmu_pv.c                      |   1 +
 arch/x86/xen/pci-swiotlb-xen.c             |  96 ------------
 drivers/iommu/amd/init.c                   |   6 -
 drivers/iommu/amd/iommu.c                  |   5 +-
 drivers/iommu/intel/dmar.c                 |   6 +-
 drivers/xen/swiotlb-xen.c                  | 231 +++++------------------------
 include/linux/dmar.h                       |   6 +-
 include/linux/swiotlb.h                    |  22 +--
 include/trace/events/swiotlb.h             |  29 ++--
 include/xen/arm/page-coherent.h            |  20 ---
 include/xen/arm/page.h                     |   1 -
 include/xen/swiotlb-xen.h                  |   2 -
 include/xen/xen-ops.h                      |   7 -
 kernel/dma/debug.c                         |   2 +-
 kernel/dma/direct.c                        |  31 ++--
 kernel/dma/direct.h                        |   2 +-
 kernel/dma/swiotlb.c                       | 186 +++++++++++------------
 56 files changed, 319 insertions(+), 983 deletions(-)
 delete mode 100644 arch/arm/include/asm/xen/page-coherent.h
 delete mode 100644 arch/arm64/include/asm/xen/page-coherent.h
 delete mode 100644 arch/ia64/include/asm/iommu_table.h
 delete mode 100644 arch/x86/include/asm/iommu_table.h
 delete mode 100644 arch/x86/include/asm/swiotlb.h
 delete mode 100644 arch/x86/include/asm/xen/page-coherent.h
 delete mode 100644 arch/x86/kernel/pci-iommu_table.c
 delete mode 100644 arch/x86/kernel/pci-swiotlb.c
 delete mode 100644 arch/x86/xen/pci-swiotlb-xen.c
 delete mode 100644 include/xen/arm/page-coherent.h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
