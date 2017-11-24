From: Konrad Rzeszutek Wilk <konrad@darnok.org>
Subject: Re: No check of the size passed to unmap_single in swiotlb
Date: Fri, 24 Nov 2017 08:33:43 -0500
Message-ID: <20171124133341.GB16160@localhost.localdomain>
References: <VI1PR04MB30715EA7212DC661481041438C220@VI1PR04MB3071.eurprd04.prod.outlook.com>
 <20171120162652.GR24312@char.us.oracle.com>
 <bb5a338c-4fd1-dbc4-e2be-663df0887504@arm.com>
 <VI1PR04MB30713D88BF08BE52B2C85D458C210@VI1PR04MB3071.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <VI1PR04MB30713D88BF08BE52B2C85D458C210@VI1PR04MB3071.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Yang <yu.yang_3@nxp.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Daniel Borkmann <daniel@iogearbox.net>, Kees Cook <keescook@chromium.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>
List-Id: iommu@lists.linux-foundation.org

..snip..
> > There doesn't seem to be much good reason for SWIOTLB to be more special
> > than other DMA API backends, and not all of them have enough internal state to
> > be able to make such a check. It's also not necessarily possible to "prevent
> > damage" anyway - if a driver does pass a bogus size for dma_unmap_single(...,
> > DMA_FROM_DEVICE), SWIOTLB might be able to keep itself internally consistent,
> > but it still can't prevent the arch code in the middle from invalidating the wrong
> > cache lines and potentially corrupting adjacent memory.
> > 
> > In short, trying to work around broken drivers is a much worse idea than just
> > fixing those drivers, and that's what we already have dma-debug for.
> > 
> > Robin.
> 
> Hi Robin,
> 
> I agree that hacking kernel to fix broken drivers is not acceptable, actually we spent days to fight driver supplier with  this, they do not want to change their code and want fix it directly in kernel. 

You could upstream the driver? That way it will be fixed.

I am not sure if you are aware but there is a staging directory
as well in Linux.
> 
> I tried Dma-debug yesterday, it works very well,  but I think only the size mismatch check may not be enough for the map entry corrupt situation, some run-time warning may be better when the real corruption happen.
> 
> For most of the dma-api backend, the size mismatch may do no harm at all, and even in SWIOTLB itself when the bounce buffer is not used, the size mismatch do no harm either. In our case, the same buggy driver works well when board has 2G DDR, but panic frequently in 4G DDR because of the use of bounce buffer and these corrupted map entries. it is hard to catch this kind of bugs, for when the corruption happen, the kernel has all kind of reasons to panic, but not even one may directly point to the real source.  
> 
> Add the warning messages is a big convenience for figure this kind of issues, at least to me and the AP driver supplier, such warnings may save weeks of hard debug time.

I would prefer that all of those warning messages go in the DMA debug
API - as you can have multiple DMA different backends.

In other words, instead of being in one implementation it would make
much more sense to be in the generic API layer.
