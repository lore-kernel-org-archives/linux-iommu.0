From: Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [RFC] avoid indirect calls for DMA direct mappings
Date: Thu, 6 Dec 2018 18:43:51 +0100
Message-ID: <20181206184351.4d9ece54@redhat.com>
References: <20181206153720.10702-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206153720.10702-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Tariq Toukan <tariqt@mellanox.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4?= =?UTF-8?B?cmdlbnNlbg==?= <toke@toke.dk>, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, brouer@redhat.com
List-Id: iommu@lists.linux-foundation.org

On Thu,  6 Dec 2018 07:37:19 -0800
Christoph Hellwig <hch@lst.de> wrote:

> Hi all,
> 
> a while ago Jesper reported major performance regressions due to the
> spectre v2 mitigations in his XDP forwarding workloads.  A large part
> of that is due to the DMA mapping API indirect calls.
> 
> It turns out that the most common implementation of the DMA API is the
> direct mapping case, and now that we have merged almost all duplicate
> implementations of that into a single generic one is easily feasily to
> direct calls for this fast path.
> 
> This patch adds a check if we are using dma_direct_ops in each fast path
> DMA operation, and just uses a direct call instead.  For the XDP workload
> this increases the number of packets per second from 7,438,283 to
> 9,610,088, so it provides a very significant speedup.

Full test report avail here:
 https://github.com/xdp-project/xdp-project/blob/master/areas/dma/dma01_test_hellwig_direct_dma.org


> Note that the patch depends on a lot of work either queued up in the
> DMA mapping tree, or still out on the list from review, so to actually
> try the patch you probably want this git tree:
> 
> 
>     git://git.infradead.org/users/hch/misc.git dma-direct-calls
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-direct-calls
> 



-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
