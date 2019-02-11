From: Christoph Hellwig <hch@lst.de>
Subject: fbdev: don't pass a NULL struct device to DMA API functions v2
Date: Mon, 11 Feb 2019 14:28:33 +0100
Message-ID: <20190211132836.29594-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

We still have a few drivers which pass a NULL struct device pointer
to DMA API functions, which generally is a bad idea as the API
implementations rely on the device not only for ops selection, but
also the dma mask and various other attributes.

This series contains all easy conversions to pass a struct device,
besides that there also is some arch code that needs separate handling,
a driver that should not use the DMA API at all, and one that is
a complete basket case to be deal with separately.

Changes since v1:
 - split the series, this only contains the fbdev patches
