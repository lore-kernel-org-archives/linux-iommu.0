From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC patch 28/41] dma/debug: Simplify stracktrace retrieval
Date: Wed, 10 Apr 2019 08:25:48 -0400
Message-ID: <20190410082548.04c2e0aa@gandalf.local.home>
References: <20190410102754.387743324@linutronix.de>
        <20190410103646.130022106@linutronix.de>
        <20190410110818.GA13904@lst.de>
        <alpine.DEB.2.21.1904101407190.3479@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1904101407190.3479@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>, LKML <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Alexander Potapenko <glider@google.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, 10 Apr 2019 14:08:19 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Wed, 10 Apr 2019, Christoph Hellwig wrote:
> > 
> > Please always send the whole series out to everyone on the To and Cc
> > list, otherwise patch series are not reviewable.  
>  
> Bah. People complain about overly broad cc-lists and the context is on
> lkml. But sure, I just bounced it to you.
> 

What I think is the best in between is to have the cover letter sent to
everyone in the patch series, and then individual patches sent to those
that need to know. git sendmail does this but quilt sendmail does
not :-(   I've been looking at fixing quilt to do the same.

-- Steve
