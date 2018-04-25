From: David Rientjes <rientjes@google.com>
Subject: Re: [GIT PULL] dma mapping fixes for 4.17-rc3
Date: Wed, 25 Apr 2018 00:09:45 -0700 (PDT)
Message-ID: <alpine.DEB.2.21.1804250009400.51102@chino.kir.corp.google.com>
References: <20180425052225.GA2350@infradead.org> <alpine.DEB.2.21.1804242352290.51102@chino.kir.corp.google.com> <20180425065930.GA16791@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180425065930.GA16791@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 24 Apr 2018, Christoph Hellwig wrote:

> On Tue, Apr 24, 2018 at 11:54:26PM -0700, David Rientjes wrote:
> > Shouldn't that test for dev->coherent_dma_mask < DMA_BIT_MASK(32) be more 
> > accurately <=? 
> 
> No, it should really be <.  The exactly 32-bit case is already covered
> with GFP_DMA32.  Eventualy it should be < 24-bit with a separate
> GFP_DMA32 case for > 32-bit && < 64-bit.  Takashi has been working on
> that, but it is 4.18 material.
> 

Ack, thanks.
