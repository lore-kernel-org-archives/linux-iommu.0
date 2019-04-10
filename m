From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC patch 28/41] dma/debug: Simplify stracktrace retrieval
Date: Wed, 10 Apr 2019 14:08:19 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1904101407190.3479@nanos.tec.linutronix.de>
References: <20190410102754.387743324@linutronix.de> <20190410103646.130022106@linutronix.de> <20190410110818.GA13904@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190410110818.GA13904@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Alexander Potapenko <glider@google.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, 10 Apr 2019, Christoph Hellwig wrote:

> On Wed, Apr 10, 2019 at 12:28:22PM +0200, Thomas Gleixner wrote:
> > Replace the indirection through struct stack_trace with an invocation of
> > the storage array based interface.
> 
> This seems to be missing some context, at least stack_trace_save does
> not actually exist in mainline.
> 
> Please always send the whole series out to everyone on the To and Cc
> list, otherwise patch series are not reviewable.
 
Bah. People complain about overly broad cc-lists and the context is on
lkml. But sure, I just bounced it to you.

Thanks,

	tglx
