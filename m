From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 7/8] dma/debug: Remove dma_debug_resize_entries()
Date: Thu, 6 Dec 2018 15:25:46 +0100
Message-ID: <20181206142546.GE24642@lst.de>
References: <cover.1544037783.git.robin.murphy@arm.com> <229557ee9d279393473997caa825617b6d0b19e3.1544037783.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <229557ee9d279393473997caa825617b6d0b19e3.1544037783.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com, john.garry@huawei.com
List-Id: iommu@lists.linux-foundation.org

On Wed, Dec 05, 2018 at 07:56:56PM +0000, Robin Murphy wrote:
> With no callers left, we can clean up this part of dma-debug's exposed
> internals, making way to tweak the allocation behaviour.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
