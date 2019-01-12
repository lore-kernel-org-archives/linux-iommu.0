From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] remove dma_zalloc_coherent
Date: Sat, 12 Jan 2019 10:27:58 -0800
Message-ID: <CAHk-=wiYxY9H-XDgawJd+Y4AM4qtK=7RQZ_GhswcUSYWw=eckA@mail.gmail.com>
References: <20190112181355.GA31454@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190112181355.GA31454@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: iommu@lists.linux-foundation.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Sat, Jan 12, 2019 at 10:14 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> Lets see if this works better as a pull request than the
> plain patches:

So I'm still debating this myself, which is why I haven't reacted.

The reason I'm not entirely sure this makes sense is that not every
user actually mmaps things into user space.

And now if somebody for some reason doesn't want the overhead, there
is really *no* way to say that.

Maybe nobody cares. But from what I can tell, the mmap case is
actually really quite rare (well, at least the regular
"dma_mmap_attrs/coherent()" kind).

I'd be happier if there at least was an interface to specify "yes, I
want zeroing". But there isn't. You did not, for example, just make
__GFP_ZERO work. No. You just said "GFP_ZERO hasn't worked reliably,
so we had that other interface, and now we're doing it
unconditionally, so we can remove the other interface".

This all *despite* the fact that as far as I can tell, 95% of the
users don't actually need or care about zeroing and don't really want
it.

So explain that.

              Linus
