From: Huang Shijie <sjhuang@iluvatar.ai>
Subject: Re: [PATCH] lib/genalloc.c: rename addr_in_gen_pool to
 gen_pool_has_addr
Date: Fri, 28 Dec 2018 17:17:26 +0800
Message-ID: <20181228091726.GA22551@hsj-Precision-5520>
References: <20181228083950.20398-1-sjhuang@iluvatar.ai>
 <20181228084834.GA8658@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181228084834.GA8658@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@linux-foundation.org, linux@armlinux.org.uk, arnd@arndb.de, gregkh@linuxfoundation.org, m.szyprowski@samsung.com, robin.murphy@arm.com, sfr@canb.auug.org.au, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, shijie8@gmail.com
List-Id: iommu@lists.linux-foundation.org

On Fri, Dec 28, 2018 at 09:48:34AM +0100, Christoph Hellwig wrote:
> On Fri, Dec 28, 2018 at 04:39:50PM +0800, Huang Shijie wrote:
> > Follow the kernel conventions, rename addr_in_gen_pool to
> > gen_pool_has_addr.
> 
> Which convention?  The old name certainly looks more sensible to me.
I submitted a patch to export the symbol, addr_in_gen_pool.
But most the exported symbols are named like gen_pool_*.

What about I add a macro in the header genalloc.h, such as:

#define addr_in_gen_pool 	gen_pool_has_addr

> 
> If we really want to change anything about this function I'd suggest
> to drop the size argument, as the address itself should describe the
> region good enough.

Maybe others need the @size argument. I am not sure if it is right to remove
the size argument...

Thanks
Huang Shijie
