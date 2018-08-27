From: Christoph Hellwig <hch@lst.de>
Subject: cleanup ->dma_configure calling conventions
Date: Mon, 27 Aug 2018 10:47:07 +0200
Message-ID: <20180827084711.23407-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

this series cleans up a bit how we call ->dma_configure and how
we clean up after tearing down a device that the method did set
up.
