From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v4] iommu/dma: Use NUMA aware memory allocations in
 __iommu_dma_alloc_pages()
Date: Tue, 11 Dec 2018 10:30:30 +0100
Message-ID: <20181211093030.3x532vs6dwz2ucp7@8bytes.org>
References: <1543576440-222098-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1543576440-222098-1-git-send-email-john.garry@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>
Cc: robin.murphy@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, ganapatrao.kulkarni@cavium.com, hch@lst.de, m.szyprowski@samsung.com, linuxarm@huawei.com
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 30, 2018 at 07:14:00PM +0800, John Garry wrote:
> From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> 
> Change function __iommu_dma_alloc_pages() to allocate pages for DMA from
> respective device NUMA node. The ternary operator which would be for
> alloc_pages_node() is tidied along with this.
> 
> The motivation for this change is to have a policy for page allocation
> consistent with direct DMA mapping, which attempts to allocate pages local
> to the device, as mentioned in [1].
> 
> In addition, for certain workloads it has been observed a marginal
> performance improvement. The patch caused an observation of 0.9% average
> throughput improvement for running tcrypt with HiSilicon crypto engine.
> 
> We also include a modification to use kvzalloc() for kzalloc()/vzalloc()
> combination.
> 
> [1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1692998.html
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> [JPG: Added kvzalloc(), drop pages ** being device local, remove ternary operator, update message]
> Signed-off-by: John Garry <john.garry@huawei.com>

Applied, thanks.
