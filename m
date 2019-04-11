From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC patch 28/41] dma/debug: Simplify stracktrace retrieval
Date: Wed, 10 Apr 2019 23:09:33 -0400
Message-ID: <20190410230933.7d1138b3@oasis.local.home>
References: <20190410102754.387743324@linutronix.de>
        <20190410103646.130022106@linutronix.de>
        <20190411030201.uko3njal44w2ea4b@treble>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190411030201.uko3njal44w2ea4b@treble>
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Alexander Potapenko <glider@google.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, 10 Apr 2019 22:02:01 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> >  #ifdef CONFIG_STACKTRACE
> > -	struct		 stack_trace stacktrace;
> > -	unsigned long	 st_entries[DMA_DEBUG_STACKTRACE_ENTRIES];
> > +	unsigned int	st_len;
> > +	unsigned long	st_entries[DMA_DEBUG_STACKTRACE_ENTRIES];  
> 
> nit: st_entries isn't very readable.  Thanks to the magic of compilers,
> the characters are free, so why not call them "stacktrace_entries" and
> "stacktrace_len".

But doesn't that slow down the time it takes to compile?

/me runs...

-- Steve
