From: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC patch 28/41] dma/debug: Simplify stracktrace retrieval
Date: Thu, 11 Apr 2019 19:21:30 +0200
Message-ID: <20190411172130.GA30189@lst.de>
References: <20190410102754.387743324@linutronix.de> <20190410103646.130022106@linutronix.de> <20190410110818.GA13904@lst.de> <alpine.DEB.2.21.1904101407190.3479@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904101407190.3479@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>, LKML <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Alexander Potapenko <glider@google.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 10, 2019 at 02:08:19PM +0200, Thomas Gleixner wrote:
> On Wed, 10 Apr 2019, Christoph Hellwig wrote:
> 
> > On Wed, Apr 10, 2019 at 12:28:22PM +0200, Thomas Gleixner wrote:
> > > Replace the indirection through struct stack_trace with an invocation of
> > > the storage array based interface.
> > 
> > This seems to be missing some context, at least stack_trace_save does
> > not actually exist in mainline.
> > 
> > Please always send the whole series out to everyone on the To and Cc
> > list, otherwise patch series are not reviewable.
>  
> Bah. People complain about overly broad cc-lists and the context is on
> lkml. But sure, I just bounced it to you.

People should stop complaining about that.  Deleting a mail is a single
keystroke.  Finding all the patches to apply them and test, or even
to review them is a nightmare.  That is why depending on my mood I'll
either complain like now when people do that crap, or if I feel bad
enough just ignore them.  If you don't give me the full context you
can't expect me to have an informed opinion.

Btw, the private forwarding is the worst of all worlds - now I have
the patches, but can't sensibly reply to them..
