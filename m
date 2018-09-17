From: Christoph Hellwig <hch@lst.de>
Subject: move swiotlb noncoherent dma support from arm64 to generic code
Date: Mon, 17 Sep 2018 17:38:17 +0200
Message-ID: <20180917153826.28052-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

this series starts with various swiotlb cleanups, then adds support for
non-cache coherent devices to the generic swiotlb support, and finally
switches arm64 to use the generic code.

Given that this series depends on patches in the dma-mapping tree, or
pending for it I've also published a git tree here:

    git://git.infradead.org/users/hch/misc.git swiotlb-noncoherent

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/swiotlb-noncoherent
