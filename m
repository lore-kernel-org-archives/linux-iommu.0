Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E645BC2D0A3
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 17:33:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E6612151B
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 17:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="oAjEwr76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6612151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 05B262E149;
	Fri,  6 Nov 2020 17:33:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eQkBkF6N0sL5; Fri,  6 Nov 2020 17:33:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 389292E142;
	Fri,  6 Nov 2020 17:33:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23FC1C088B;
	Fri,  6 Nov 2020 17:33:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 079F4C088B
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 17:33:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E4FD886A78
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 17:33:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oa_zeEOr0Eb4 for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 17:33:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EBBCF86A54
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 17:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QghfGn0XJlLalBYUlEV3tKSl1nQDSW7GcuVBagc2hq4=; b=oAjEwr76TG6NvxLQ6kuNQsWpFf
 Z+k+ic3yRFpJ1nQs2zquoS7aZCtAV4GbSDqKqm9B6cdICtbKyaGqJ4H6IjZPjNpdtl2v7gcLFTmPr
 i4quG8H0mgGrAlVVtdoH2v5j5VFNbOWzgFJDI49oE4OcSJtyoVg3ZQW3auqLoSfbrmkVbRCMix8RS
 OEbjP1xCjDKn3C2oFyTXmTqOtAJnJq19YJSGZEDGL6W66eBoKK1Zhfc7VJFbptWOcqM1wb0pSWeK1
 Z7srBW+/DJ9DSjWucbzDVqsWWxKifdPiAVpFF2bHQFYF98f4ljdv6zHJmh93Rbm3sJoMWrWmR8M9C
 IoAT3nFg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1kb56Z-0002PV-5l; Fri, 06 Nov 2020 10:00:54 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1kb56U-0004so-1K; Fri, 06 Nov 2020 10:00:46 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Fri,  6 Nov 2020 10:00:21 -0700
Message-Id: <20201106170036.18713-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, dan.j.williams@intel.com,
 iweiny@intel.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org,
 daniel.vetter@ffwll.ch, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [RFC PATCH 00/15] Userspace P2PDMA with O_DIRECT NVMe devices
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: John Hubbard <jhubbard@nvidia.com>, Ira Weiny <iweiny@intel.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>, Stephen Bates <sbates@raithlin.com>,
 Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
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

This RFC enables P2PDMA transfers in userspace between NVMe drives using
existing O_DIRECT operations or the NVMe passthrough IOCTL.

This is accomplished by allowing userspace to allocate chunks of any CMB
by mmaping the NVMe ctrl device (Patches 14 and 15). The resulting memory
will be backed by P2P pages and can be passed only to O_DIRECT
operations. A flag is added to GUP() in Patch 10 and Patches 11 through 13
wire this flag up based on whether the block queue indicates P2PDMA
support.

The above is pretty straight forward and (I hope) largely uncontroversial.
However, the one significant problem in all this is that, presently,
pci_p2pdma_map_sg() requires a homogeneous SGL with all P2PDMA pages or
none. Enhancing GUP to support enforcing this rule would require a huge
hack that I don't expect would be all that pallatable. So this RFC takes
the approach of removing the requirement of having a homogeneous SGL.

With the new common dma-iommu infrastructure, this patchset adds
support for P2PDMA pages into dma_map_sg() which will support AMD,
Intel (soon) and dma-direct implementations. (Other IOMMU
implementations would then be unsupported, notably ARM and PowerPC).

The other major blocker is that in order to implement support for
P2PDMA pages in dma_map_sg(), a flag is necessary to determine if a
given dma_addr_t points to P2PDMA memory or to an IOVA so that it can
be unmapped appropriately in dma_unmap_sg(). The (ugly) approach this
RFC takes is to use the top bit in the dma_length field and ensure
callers are prepared for it using a new DMA_ATTR_P2PDMA flag.

I suspect, the ultimate solution to this blocker will be to implement
some kind of new dma_op that doesn't use the SGL. Ideas have been
thrown around in the past for one that maps some kind of novel dma_vec
directly from a bio_vec. This will become a lot easier to implement if
more dma_ops providers get converted to the new dma-iommu
implementation, but this will take time.

Alternative ideas or other feedback welcome.

This series is based on v5.10-rc2 with Lu Baolu's (and Tom Murphy's)
v4 patchset for converting the Intel IOMMU to dma-iommu[1]. A git
branch is available here:

  https://github.com/sbates130272/linux-p2pmem/  p2pdma_user_cmb_rfc

Thanks,

Logan

[1] https://lkml.kernel.org/lkml/20200927063437.13988-1-baolu.lu@linux.intel.com/T/#u.


Logan Gunthorpe (15):
  PCI/P2PDMA: Don't sleep in upstream_bridge_distance_warn()
  PCI/P2PDMA: Attempt to set map_type if it has not been set
  PCI/P2PDMA: Introduce pci_p2pdma_should_map_bus() and
    pci_p2pdma_bus_offset()
  lib/scatterlist: Add flag for indicating P2PDMA segments in an SGL
  dma-direct: Support PCI P2PDMA pages in dma-direct map_sg
  dma-mapping: Add flags to dma_map_ops to indicate PCI P2PDMA support
  iommu/dma: Support PCI P2PDMA pages in dma-iommu map_sg
  nvme-pci: Check DMA ops when indicating support for PCI P2PDMA
  nvme-pci: Convert to using dma_map_sg for p2pdma pages
  mm: Introduce FOLL_PCI_P2PDMA to gate getting PCI P2PDMA pages
  iov_iter: Introduce iov_iter_get_pages_[alloc_]flags()
  block: Set FOLL_PCI_P2PDMA in __bio_iov_iter_get_pages()
  block: Set FOLL_PCI_P2PDMA in bio_map_user_iov()
  PCI/P2PDMA: Introduce pci_mmap_p2pmem()
  nvme-pci: Allow mmaping the CMB in userspace

 block/bio.c                 |   7 +-
 block/blk-map.c             |   7 +-
 drivers/dax/super.c         |   7 +-
 drivers/iommu/dma-iommu.c   |  63 +++++++++++--
 drivers/nvme/host/core.c    |  14 ++-
 drivers/nvme/host/nvme.h    |   3 +-
 drivers/nvme/host/pci.c     |  50 ++++++----
 drivers/pci/p2pdma.c        | 178 +++++++++++++++++++++++++++++++++---
 include/linux/dma-map-ops.h |   3 +
 include/linux/dma-mapping.h |  16 ++++
 include/linux/memremap.h    |   4 +-
 include/linux/mm.h          |   1 +
 include/linux/pci-p2pdma.h  |  17 ++++
 include/linux/scatterlist.h |   4 +
 include/linux/uio.h         |  21 ++++-
 kernel/dma/direct.c         |  33 ++++++-
 kernel/dma/mapping.c        |   8 ++
 lib/iov_iter.c              |  25 ++---
 mm/gup.c                    |  28 +++---
 mm/huge_memory.c            |   8 +-
 mm/memory-failure.c         |   4 +-
 mm/memremap.c               |  14 ++-
 22 files changed, 427 insertions(+), 88 deletions(-)


base-commit: 5ba8a2512e8c5f5cf9b7309dc895612f0a77a399
--
2.20.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
