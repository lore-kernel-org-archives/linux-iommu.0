From: David Miller <davem@davemloft.net>
Subject: Re: net: don't pass a NULL struct device to DMA API functions v2
Date: Tue, 12 Feb 2019 09:09:38 -0800 (PST)
Message-ID: <20190212.090938.1241676476384735940.davem@davemloft.net>
References: <20190211132004.29143-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211132004.29143-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de
Cc: netdev@vger.kernel.org, nicolas.ferre@microchip.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 11 Feb 2019 14:19:56 +0100

> We still have a few drivers which pass a NULL struct device pointer
> to DMA API functions, which generally is a bad idea as the API
> implementations rely on the device not only for ops selection, but
> also the dma mask and various other attributes.
> 
> This series contains all easy conversions to pass a struct device,
> besides that there also is some arch code that needs separate handling,
> a driver that should not use the DMA API at all, and one that is
> a complete basket case to be deal with separately.
> 
> Changes since v1:
>  - fix an inverted ifdef in CAIF
>  - update the smc911x changelog
>  - split the series, this only contains the networking patches

Series applied, thanks.
