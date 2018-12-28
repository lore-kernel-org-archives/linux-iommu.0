From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH] lib/genalloc.c: rename addr_in_gen_pool to
	gen_pool_has_addr
Date: Fri, 28 Dec 2018 15:39:58 -0800
Message-ID: <20181228153958.40cfb7a9b446225d73c585cd@linux-foundation.org>
References: <20181228083950.20398-1-sjhuang@iluvatar.ai>
	<20181228084834.GA8658@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181228084834.GA8658-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, Huang Shijie <sjhuang-/sZsJll8jXBVVK5P2UUDPg@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 28 Dec 2018 09:48:34 +0100 Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org> wrote:

> On Fri, Dec 28, 2018 at 04:39:50PM +0800, Huang Shijie wrote:
> > Follow the kernel conventions, rename addr_in_gen_pool to
> > gen_pool_has_addr.
> 
> Which convention?

That symbols from subsystem foo should be called foo_*.  Not uniformly
observed by any means, but it is a thing.

> The old name certainly looks more sensible to me.

It does read better, but it's rather a standout in this case:

q:/usr/src/25> grep EXPORT_SYMBOL lib/genalloc.c
EXPORT_SYMBOL(gen_pool_create);
EXPORT_SYMBOL(gen_pool_add_virt);
EXPORT_SYMBOL(gen_pool_virt_to_phys);
EXPORT_SYMBOL(gen_pool_destroy);
EXPORT_SYMBOL(gen_pool_alloc);
EXPORT_SYMBOL(gen_pool_alloc_algo);
EXPORT_SYMBOL(gen_pool_dma_alloc);
EXPORT_SYMBOL(gen_pool_free);
EXPORT_SYMBOL(gen_pool_for_each_chunk);
EXPORT_SYMBOL(addr_in_gen_pool);
EXPORT_SYMBOL_GPL(gen_pool_avail);
EXPORT_SYMBOL_GPL(gen_pool_size);
EXPORT_SYMBOL(gen_pool_set_algo);
EXPORT_SYMBOL(gen_pool_first_fit);
EXPORT_SYMBOL(gen_pool_first_fit_align);
EXPORT_SYMBOL(gen_pool_fixed_alloc);
EXPORT_SYMBOL(gen_pool_first_fit_order_align);
EXPORT_SYMBOL(gen_pool_best_fit);
EXPORT_SYMBOL_GPL(gen_pool_get);
EXPORT_SYMBOL(devm_gen_pool_create);
EXPORT_SYMBOL_GPL(of_gen_pool_get);
