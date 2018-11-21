From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3] iommu/dma: Use NUMA aware memory allocations in
 __iommu_dma_alloc_pages()
Date: Wed, 21 Nov 2018 16:07:18 +0000
Message-ID: <20181121160718.GB24883@arm.com>
References: <1542812051-178935-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1542812051-178935-1-git-send-email-john.garry@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>
Cc: joro@8bytes.org, robin.murphy@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, ganapatrao.kulkarni@cavium.com, hch@lst.de, m.szyprowski@samsung.com, linuxarm@huawei.com
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 21, 2018 at 10:54:10PM +0800, John Garry wrote:
> From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> 
> Change function __iommu_dma_alloc_pages() to allocate pages for DMA from
> respective device NUMA node. The ternary operator which would be for
> alloc_pages_node() is tidied along with this.
> 
> We also include a change to use kvzalloc() for kzalloc()/vzalloc()
> combination.
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> [JPG: Added kvzalloc(), drop pages ** being device local, tidied ternary operator]
> Signed-off-by: John Garry <john.garry@huawei.com>

Weird, you're missing a diffstat here.

Anyway, the patch looks fine to me, but it would be nice if you could
justify the change with some numbers. Do you actually see an improvement
from this change?

Will
