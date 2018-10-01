From: Christoph Hellwig <hch@lst.de>
Subject: fix up nowarn confusion in the dma mapping layer
Date: Mon,  1 Oct 2018 13:12:55 -0700
Message-ID: <20181001201257.366-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

this series sorts out how we deal with the nowarn flags in the dma
mapping code.  We still support __GFP_NOWARN for the legacy APIs that
don't support passing the dma specific flags, but we generally want
every implementation to actually check DMA_ATTR_NO_WARN instead.
