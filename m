From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/4] dma-debug: implement dynamic entry allocation
Date: Mon, 3 Dec 2018 18:34:12 +0100
Message-ID: <20181203173412.GA8509@lst.de>
References: <cover.1543856576.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1543856576.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com, john.garry@huawei.com
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 03, 2018 at 05:28:05PM +0000, Robin Murphy wrote:
> The HNS_ENET discussion got me thinking, why not just make DMA debug
> cleverer so that (in terms of basic functionality at least) we don't
> need to worry about driver- or arch-specific configuration at all?
> 
> Patches #2 and #3 are the real meat here - #1 is just some preparatory
> cleanup motivated by moving printks around, and could be split out if
> desired; I kept #4 separate as a possible nice-to-have depending on
> what people think.

Hah, I just thought of this and suggested it a few seconds ago.
So obviously I think it is a good idea, but let me look at the details.
