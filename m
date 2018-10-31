From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH 4/6] dma-mapping: merge direct and noncoherent ops
Date: Wed, 31 Oct 2018 14:24:13 +0000 (GMT)
Message-ID: <alpine.LFD.2.21.1810311414200.20378@eddie.linux-mips.org>
References: <20180914095808.22202-1-hch@lst.de> <20180914095808.22202-5-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180914095808.22202-5-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Paul Burton <paul.burton@mips.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Christoph,

On Fri, 14 Sep 2018, Christoph Hellwig wrote:

> All the cache maintainance is already stubbed out when not enabled,
> but merging the two allows us to nicely handle the case where
> cache maintainance is required for some devices, but not others.

 FYI, you commit bc3ec75de545 ("dma-mapping: merge direct and noncoherent 
ops") has caused:

fddi0: DMA command request failed!
fddi0: Adapter open failed!

with the `defxx' driver on my R4400SC TURBOchannel DECstation (but not the 
R3400 one) and consequently the interface does not work anymore.  Both are 
non-coherent cache systems, however the R3400 implements the write-through 
policy while the policy of the R4400SC is write-back (it also has 1MiB of 
secondary cache), which I suspect is the reason of the difference.

 I'll be experimenting with this commit to figure out what the real cause 
is, but it'll take a while as my resources are limited, so I'm sending 
this early heads-up in case you or someone else has an idea what might be 
going wrong here.

  Maciej
