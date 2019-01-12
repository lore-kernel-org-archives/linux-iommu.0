From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [GIT PULL] remove dma_zalloc_coherent
Date: Sat, 12 Jan 2019 10:31:53 -0800
Message-ID: <20190112183153.GA4192@infradead.org>
References: <20190112181355.GA31454@infradead.org>
 <CAHk-=wiYxY9H-XDgawJd+Y4AM4qtK=7RQZ_GhswcUSYWw=eckA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHk-=wiYxY9H-XDgawJd+Y4AM4qtK=7RQZ_GhswcUSYWw=eckA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Sat, Jan 12, 2019 at 10:27:58AM -0800, Linus Torvalds wrote:
> So I'm still debating this myself, which is why I haven't reacted.
> 
> The reason I'm not entirely sure this makes sense is that not every
> user actually mmaps things into user space.

While that is the security reason for it, we also had quite a few
drivers just plain relying on the fact and breaking on architectures
where it didn't work.

> I'd be happier if there at least was an interface to specify "yes, I
> want zeroing". But there isn't. You did not, for example, just make
> __GFP_ZERO work. No. You just said "GFP_ZERO hasn't worked reliably,
> so we had that other interface, and now we're doing it
> unconditionally, so we can remove the other interface".
> 
> This all *despite* the fact that as far as I can tell, 95% of the
> users don't actually need or care about zeroing and don't really want
> it.

Many users don't need it for security reasons, but given that x86
and arm have dont it forever various drivers started relying on the
behavior.  That combined with the fact that DMA coherent allocation
are a slow path interface it really doesn't make much sense to
micro-optimize it and potentially break users.  If we have a user
that really cares about not zeroing we can just offer a
DMA_ATTR_SKIP_ZEROING flag for dma_alloc_attrs and switch the user
that that cares to it.  But I don't really think it is needed.
