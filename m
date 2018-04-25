From: David Rientjes <rientjes@google.com>
Subject: Re: [GIT PULL] dma mapping fixes for 4.17-rc3
Date: Tue, 24 Apr 2018 23:54:26 -0700 (PDT)
Message-ID: <alpine.DEB.2.21.1804242352290.51102@chino.kir.corp.google.com>
References: <20180425052225.GA2350@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180425052225.GA2350@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 25 Apr 2018, Christoph Hellwig wrote:

> The following changes since commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e:
> 
>   Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.17-3
> 
> for you to fetch changes up to 60695be2bb6b0623f8e53bd9949d582a83c6d44a:
> 
>   dma-mapping: postpone cpu addr translation on mmap (2018-04-23 14:44:24 +0200)
> 
> ----------------------------------------------------------------
> A few small dma-mapping fixes for Linux 4.17-rc3:
> 
>  - don't loop to try GFP_DMA allocations if ZONE_DMA is not actually
>    enabled (regression in 4.16)

Shouldn't that test for dev->coherent_dma_mask < DMA_BIT_MASK(32) be more 
accurately <=? 
