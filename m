From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] dma-direct: Export dma_direct_alloc() and
 dma_direct_free()
Date: Tue, 5 Feb 2019 17:38:37 +0100
Message-ID: <20190205163837.GA1222@lst.de>
References: <20190205110602.27717-1-thierry.reding@gmail.com> <20190205161036.GA782@lst.de> <20190205162057.GA29974@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190205162057.GA29974@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 05, 2019 at 05:20:57PM +0100, Thierry Reding wrote:
> The problem is that if I use dma_alloc_coherent(), then the memory will
> already be mapped via the SMMU at that point and then the driver, not
> knowing that memory has already been mapped, will attempt to map an IOVA
> which will cause an SMMU fault when the host1x tries to access the
> memory.
> 
> I didn't find an equivalent to arm_iommu_detach_device() for non-ARM,
> but then stumbled across this and thought it was rather convenient for
> these cases. If there's a better way to deal with this situation, I'd be
> happy to do so.

So you basically do a dma_direct_alloc + iommu_map?  Can you send me
a pointer to your code?  Maybe we need to add a proper IOMMU-layer
API for that.
