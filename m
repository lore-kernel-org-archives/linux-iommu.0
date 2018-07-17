From: Fredrik Noring <noring@nocrew.org>
Subject: Re: [PATCH] dma-mapping: Relax warnings for per-device areas
Date: Tue, 17 Jul 2018 18:33:30 +0200
Message-ID: <20180717163330.GE2342@localhost.localdomain>
References: <1f8262d206c6886072d04cc93454f6e3f812bd20.1530623284.git.robin.murphy@arm.com>
 <20180705193613.GA28905@lst.de>
 <20180715122826.GB2342@localhost.localdomain>
 <20180717145725.GA22109@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180717145725.GA22109@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, m.szyprowski@samsung.com, Geoff Levand <geoff@infradead.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, JuergenUrban@gmx.de
List-Id: iommu@lists.linux-foundation.org

Hi Christoph, Geoff,

[ CC-ing Geoff to give him an opportunity to chime in about the PS3 part. ]

> > Here are three other regressions related to the coherent mask WARN_ON_ONCE:
> 
> They are a pretty strong indication that yes, you should really set
> the coherent mask if you ever do coherent allocations..

I'm unfortunately unfamiliar with the USB drivers for the PS3. Geoff, what
do you think about setting a coherent mask?

Christoph, what mask value would you suggest for the PS2 driver? Typical
DMA addresses 0-0x200000 are mapped to 0x1c000000-0x1c200000 and is memory
managed exclusively by the IOP. Robin indicated that DMA_BIT_MASK(20) or a
nonzero but useless value such as 1 are possibly candidates. It seems quite
unclear what the coherent mask actually means in this case, doesn't it?

Fredrik
