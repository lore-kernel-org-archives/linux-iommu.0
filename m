From: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC patch 28/41] dma/debug: Simplify stracktrace retrieval
Date: Thu, 11 Apr 2019 19:44:31 +0200
Message-ID: <20190411174431.GA32109@lst.de>
References: <20190410102754.387743324@linutronix.de> <20190410103646.130022106@linutronix.de> <20190410110818.GA13904@lst.de> <alpine.DEB.2.21.1904101407190.3479@nanos.tec.linutronix.de> <20190411172130.GA30189@lst.de> <20190411133602.17e8ebdf@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190411133602.17e8ebdf@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Alexander Potapenko <glider@google.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 11, 2019 at 01:36:02PM -0400, Steven Rostedt wrote:
> I guess the issue is when you get a 41 patch series, and there's only
> one patch you need to look at. There's times I get Cc'd on patch sets
> that I have no idea why I'm on the Cc. If I skim the patch set and
> don't see a relevance, I simply ignore it.

I sometimes do that as well, but then again ignoring/deleting is easy.
I wish people would think a little more on whom to Cc.  In general
I don't really need a personal Cc for drive by patches - I'll happily
pick them up from the mailing list and actually prefer it that way.
But I have received contrary feedback from people that do want to be
CCed on every little thing.
