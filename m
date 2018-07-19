From: Christoph Hellwig <hch@lst.de>
Subject: use the generic dma-noncoherent code for hexagon
Date: Thu, 19 Jul 2018 05:56:32 -0700
Message-ID: <20180719125635.824-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Richard,

can you review these patches to switch hexagon to use the generic
dma-noncoherent code?  All the requirements are in mainline already
and we've switched various architectures over to it already.
