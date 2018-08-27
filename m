From: Christoph Hellwig <hch@lst.de>
Subject: (unknown)
Date: Mon, 27 Aug 2018 16:50:27 +0200
Message-ID: <20180827145032.9522-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Subject: 
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Paul Burton <paul.burton@mips.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Subject: [RFC] merge dma_direct_ops and dma_noncoherent_ops

While most architectures are either always or never dma coherent for a
given build, the arm, arm64, mips and soon arc architectures can have
different dma coherent settings on a per-device basis.  Additionally
some mips builds can decide at boot time if dma is coherent or not.

I've started to look into handling noncoherent dma in swiotlb, and
moving the dma-iommu ops into common code [1], and for that we need a
generic way to check if a given device is coherent or not.  Moving
this flag into struct device also simplifies the conditionally coherent
architecture implementations.

These patches are also available in a git tree given that they have
a few previous posted dependencies:

    git://git.infradead.org/users/hch/misc.git dma-direct-noncoherent-merge

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-direct-noncoherent-merge
