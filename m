From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/2] SWIOTLB fixes for 4.20
Date: Wed, 21 Nov 2018 14:03:31 +0100
Message-ID: <20181121130331.GA1373@lst.de>
References: <cover.1542722463.git.robin.murphy@arm.com> <20181120160818.GC2492@lst.de> <20181120163441.GD31199@char.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181120163441.GD31199@char.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, m.szyprowski@samsung.com, john.stultz@linaro.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, sstabellini@kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Nov 20, 2018 at 11:34:41AM -0500, Konrad Rzeszutek Wilk wrote:
> > Konrad, are you ok with me picking up both through the dma-mapping
> > tree?
> 
> Yes, albeit I would want Stefano to take a peek at patch #2 just in case.

Stefano, can you take a look asap?  This is a pretty trivial fix for
a nasty bug that breaks boot on real life systems.  I'd like to merge
it by tomorrow so that I can send it off to Linus for the next rc
(I will be offline for about two days after Friday morning)
