From: Christoph Hellwig <hch@lst.de>
Subject: net: don't pass a NULL struct device to DMA API functions v2
Date: Mon, 11 Feb 2019 14:19:56 +0100
Message-ID: <20190211132004.29143-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
 - fix an inverted ifdef in CAIF
 - update the smc911x changelog
 - split the series, this only contains the networking patches
