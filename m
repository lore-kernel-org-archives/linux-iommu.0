From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] dma-mapping: remove an unnecessary NULL check
Date: Wed, 24 Apr 2019 16:27:43 +0200
Message-ID: <20190424142743.GC20974@lst.de>
References: <20190424142437.GA29490@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190424142437.GA29490@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Ian Abbott <abbotti@mev.co.uk>, Jiri Slaby <jslaby@suse.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, "kernel-janitors@vger.kernel.org H Hartley Sweeten" <hsweeten@visionengravers.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 24, 2019 at 05:24:37PM +0300, Dan Carpenter wrote:
> We already dereferenced "dev" when we called get_dma_ops() so this NULL
> check is too late.  We're not supposed to pass NULL "dev" pointers to
> dma_alloc_attrs().

Thanks, applied to the dma-mapping for-next tree.

> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> There are still at least two drivers which do pass a NULL unfortunately.
> 
> drivers/staging/comedi/drivers/comedi_isadma.c:195 comedi_isadma_alloc() error: NULL dereference inside function 'dma_alloc_coherent()'
> drivers/staging/comedi/drivers/comedi_isadma.c:227 comedi_isadma_free() error: NULL dereference inside function 'dma_free_coherent()'

This is staging code.  Per official decree from Linus we can just
ignore it, and I tend to do so to keep my sanity.

> drivers/tty/synclink.c:3667 mgsl_alloc_buffer_list_memory() error: NULL dereference inside function 'dma_alloc_coherent()'
> drivers/tty/synclink.c:3738 mgsl_free_buffer_list_memory() error: NULL dereference inside function 'dma_free_coherent()'
> drivers/tty/synclink.c:3777 mgsl_alloc_frame_memory() error: NULL dereference inside function 'dma_alloc_coherent()'
> drivers/tty/synclink.c:3811 mgsl_free_frame_memory() error: NULL dereference inside function 'dma_free_coherent()'

The !PCI case there is dead since I removed PCI support a while ago.
Looks like it is still too convoluted for static checkers to notice that,
though.
