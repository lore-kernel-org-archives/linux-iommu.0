From: Christoph Hellwig <hch@lst.de>
Subject: allow larger than require DMA masks
Date: Fri, 15 Feb 2019 15:45:54 +0100
Message-ID: <20190215144559.8777-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, sparclinux@vger.kernel.org, linux-parisc@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

this series finishes off converting our dma mask model to split between
device capabilities (dev->dma_mask and dev->coherent_dma_mask) and system
limitations (dev->bus_dma_mask).  We already accept larger than required
masks in most dma_map_ops implementation, in case of x86 and
implementations based on it since the dawn of time.  Only one parisc
and two sparc64 instances failed larger than required DMA masks, and
this series fixes that up and updates the documentation that devices
don't need to handle DMA mask fallbacks.
