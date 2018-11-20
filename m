From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 0/2] SWIOTLB fixes for 4.20
Date: Tue, 20 Nov 2018 14:09:51 +0000
Message-ID: <cover.1542722463.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de, konrad.wilk@oracle.com
Cc: m.szyprowski@samsung.com, john.stultz@linaro.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

This is what I have so far, which at least resolves the most ovbious
problems. I still haven't got very far with the USB corruption issue
I see on Juno with -rc1, but I'm yet to confirm whether that's actually
attributable to the SWIOTLB changes or something else entirely.

Robin.

Robin Murphy (2):
  swiotlb: Make DIRECT_MAPPING_ERROR viable
  swiotlb: Skip cache maintenance on map error

 include/linux/dma-direct.h | 2 +-
 kernel/dma/swiotlb.c       | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.19.1.dirty
