From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] avoid indirect calls for DMA direct mappings
Date: Thu, 6 Dec 2018 10:28:22 -0800
Message-ID: <CAHk-=wgz6PFCm+XMWN31dRHzA3JcNP0x0Y-z5NMMw3dHhrDXAw@mail.gmail.com>
References: <20181206153720.10702-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206153720.10702-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, brouer@redhat.com, tariqt@mellanox.com, ilias.apalodimas@linaro.org, toke@toke.dk, robin.murphy@arm.com, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Dec 6, 2018 at 7:37 AM Christoph Hellwig <hch@lst.de> wrote:
>
> This patch adds a check if we are using dma_direct_ops in each fast path
> DMA operation, and just uses a direct call instead.  For the XDP workload
> this increases the number of packets per second from 7,438,283 to
> 9,610,088, so it provides a very significant speedup.

May I suggest re-doing the logic a bit?

You do things like this:

+       if (ops->unmap_page) {
+               if (dma_is_direct(ops))
+                       dma_direct_unmap_page(dev, addr, size, dir, attrs);
+               else
+                       ops->unmap_page(dev, addr, size, dir, attrs);
+       }

which is counterproductive because it checks for the fast case *after*
you've done a load (and a check) that is entirely pointless for the
fast case.

Put another way, you made the fast case unnecessarily slow.

If this fast case matters (and the whole point of the series is that
it *does* matter), then you should make sure that

 (a) the dma_is_direct() function/macro uses "likely()" for the test

and

 (b) the code is organized like this instead:

+       if (dma_is_direct(ops))
+               dma_direct_unmap_page(dev, addr, size, dir, attrs);
+       else if (ops->unmap_page)
+               ops->unmap_page(dev, addr, size, dir, attrs);

because now you avoid that unnecessary conditional for the common
case, and you hopefully never even access the pointer (because you
know what's behind it: the direct ops cases that you're
short-circuiting).

In fact, as a further micro-optimization it might be a good idea to
just specify that the dma_is_direct() ops is a special pointer
(perhaps even just say that "NULL means it's direct"), because that
then makes the fast-case test much simpler (avoids a whole nasty
constant load, and testing for NULL in particular is often much
better).

But that further micro-optimization absolutely *requires* that the ops
pointer test comes first. So making that ordering change is not only
"better code generation for the fast case to avoid extra cache
accesses", it also allows future optimizations.

                     Linus
