From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] dma-mapping: bypass indirect calls for dma-direct
Date: Thu, 6 Dec 2018 19:35:20 +0100
Message-ID: <20181206183520.GA30039@lst.de>
References: <20181206153720.10702-1-hch@lst.de> <20181206153720.10702-2-hch@lst.de> <20181206184027.291947c3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181206184027.291947c3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Tariq Toukan <tariqt@mellanox.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Dec 06, 2018 at 06:40:27PM +0100, Jesper Dangaard Brouer wrote:
> Is this patch to be applied on top of the other (41) patches I just
> tested with my XDP forward workload?

This is just the last patch of the git tree you tested.  All the
others were sent out separately already.
