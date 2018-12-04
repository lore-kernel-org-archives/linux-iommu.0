From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/4] dma-debug: Refactor dma_debug_entry allocation
Date: Tue, 4 Dec 2018 15:27:31 +0100
Message-ID: <20181204142731.GB2767@lst.de>
References: <cover.1543856576.git.robin.murphy@arm.com> <a827949d4fde7f8eca805e3b09c2eb7fb16d8bec.1543856576.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a827949d4fde7f8eca805e3b09c2eb7fb16d8bec.1543856576.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com, john.garry@huawei.com
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 03, 2018 at 05:28:07PM +0000, Robin Murphy wrote:
> Make prealloc_memory() a little more general and robust so that it
> serves for runtime reallocations too. The first thing we can do with
> that is clean up dma_debug_resize_entries() quite a bit.

Maybe also renamed it to dma_debug_alloc_entries or something like
that?

Otherwise this looks fine to me.
