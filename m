From: Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH] dma-mapping: bypass indirect calls for dma-direct
Date: Thu, 6 Dec 2018 18:40:27 +0100
Message-ID: <20181206184027.291947c3@redhat.com>
References: <20181206153720.10702-1-hch@lst.de>
        <20181206153720.10702-2-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206153720.10702-2-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Tariq Toukan <tariqt@mellanox.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4?= =?UTF-8?B?cmdlbnNlbg==?= <toke@toke.dk>, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, brouer@redhat.com
List-Id: iommu@lists.linux-foundation.org

On Thu,  6 Dec 2018 07:37:20 -0800
Christoph Hellwig <hch@lst.de> wrote:

> Avoid expensive indirect calls in the fast path DMA mapping
> operations by directly calling the dma_direct_* ops if we are using
> the directly mapped DMA operations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/dma-direct.h  |  17 -----
>  include/linux/dma-mapping.h | 138 +++++++++++++++++++++++++++++++-----
>  kernel/dma/direct.c         |  13 ++--
>  3 files changed, 127 insertions(+), 41 deletions(-)

Hi Christoph,

Is this patch to be applied on top of the other (41) patches I just
tested with my XDP forward workload?

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
