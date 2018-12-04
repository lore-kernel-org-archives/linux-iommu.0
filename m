From: Christoph Hellwig <hch@lst.de>
Subject: merge swiotlb support into dma_direct_ops
Date: Tue,  4 Dec 2018 08:16:40 -0800
Message-ID: <20181204161645.8038-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, linux-ia64@vger.kernel.org, iommu@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Konrad and others,

can you review this series?  It merges the swiotlb support into the
DMA direct ops so that we don't have to duplicate the dma mapping logic
in multiple places.

Note that this is based on the dma_mapping_error series for which I'd
still like to collect a few more reviews, so pulling the git tree might
be easiest for testing.

The git tree is available here:

    git://git.infradead.org/users/hch/misc.git swiotlb-merge

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/swiotlb-merge
