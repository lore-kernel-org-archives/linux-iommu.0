From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] lib/genalloc.c: rename addr_in_gen_pool to
 gen_pool_has_addr
Date: Fri, 28 Dec 2018 09:48:34 +0100
Message-ID: <20181228084834.GA8658@lst.de>
References: <20181228083950.20398-1-sjhuang@iluvatar.ai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181228083950.20398-1-sjhuang@iluvatar.ai>
Sender: linux-kernel-owner@vger.kernel.org
To: Huang Shijie <sjhuang@iluvatar.ai>
Cc: akpm@linux-foundation.org, linux@armlinux.org.uk, arnd@arndb.de, gregkh@linuxfoundation.org, hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, sfr@canb.auug.org.au, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, shijie8@gmail.com
List-Id: iommu@lists.linux-foundation.org

On Fri, Dec 28, 2018 at 04:39:50PM +0800, Huang Shijie wrote:
> Follow the kernel conventions, rename addr_in_gen_pool to
> gen_pool_has_addr.

Which convention?  The old name certainly looks more sensible to me.

If we really want to change anything about this function I'd suggest
to drop the size argument, as the address itself should describe the
region good enough.
