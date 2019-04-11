From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC patch 28/41] dma/debug: Simplify stracktrace retrieval
Date: Thu, 11 Apr 2019 13:36:02 -0400
Message-ID: <20190411133602.17e8ebdf@gandalf.local.home>
References: <20190410102754.387743324@linutronix.de>
        <20190410103646.130022106@linutronix.de>
        <20190410110818.GA13904@lst.de>
        <alpine.DEB.2.21.1904101407190.3479@nanos.tec.linutronix.de>
        <20190411172130.GA30189@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190411172130.GA30189@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Alexander Potapenko <glider@google.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, 11 Apr 2019 19:21:30 +0200
Christoph Hellwig <hch@lst.de> wrote:

> > Bah. People complain about overly broad cc-lists and the context is on
> > lkml. But sure, I just bounced it to you.  
> 
> People should stop complaining about that.  Deleting a mail is a single
> keystroke.  Finding all the patches to apply them and test, or even
> to review them is a nightmare.  That is why depending on my mood I'll
> either complain like now when people do that crap, or if I feel bad
> enough just ignore them.  If you don't give me the full context you
> can't expect me to have an informed opinion.

I guess the issue is when you get a 41 patch series, and there's only
one patch you need to look at. There's times I get Cc'd on patch sets
that I have no idea why I'm on the Cc. If I skim the patch set and
don't see a relevance, I simply ignore it.

But there may be one patch I was suppose to review and I miss it. I
personally prefer to get only Cc'd on the cover letter and the patch I
need to review. Now, if that patch is dependent on other patches, then
perhaps it would be nice to be Cc'd on them too.

In other words, I much rather be Cc'd on only the patches that pertain
to me (and the supporting patches for it) then the entire series.
Especially when it's 40 patches or more.

Yes, it's a single click to delete patches that I don't need to look
at, but what I usually do in these cases is just delete the entire
series.

Note, as I do a lot with stack traces, this entire series pertains to
me and I'm happy I was on the full Cc list. But there's other examples
where it does not.

> 
> Btw, the private forwarding is the worst of all worlds - now I have
> the patches, but can't sensibly reply to them..

BTW, lore.kernel.org has a way to reply back to the list.

-- Steve
