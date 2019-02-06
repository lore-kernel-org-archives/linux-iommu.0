From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] dma-direct: Export dma_direct_alloc() and
 dma_direct_free()
Date: Wed, 6 Feb 2019 07:57:50 +0100
Message-ID: <20190206065749.GA23392@lst.de>
References: <20190205110602.27717-1-thierry.reding@gmail.com> <20190205161036.GA782@lst.de> <20190205162057.GA29974@ulmo> <20190205163837.GA1222@lst.de> <20190205175611.GA7052@ulmo> <20190205180218.GB2882@lst.de> <20190205222912.GC1372@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190205222912.GC1372@mithrandir>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 05, 2019 at 11:29:12PM +0100, Thierry Reding wrote:
> > > 	https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/gpu/host1x/cdma.c#n106
> > 
> > Yes, I think we I can come up with a nicer helper for that.
> 
> One thing I could also try is to remove direct IOMMU API usage at least
> from the host1x driver. I think this might work nowadays.
> 
> For Tegra DRM we still need direct IOMMU API usage because we need to be
> able to map into an IOMMU domain without knowing the struct device *
> that we're mapping for (it could be needed by any of up to four display
> controllers). For host1x we always only have one struct device *, so the
> DMA mapping API should be good enough.

If you can convert it to plain DMA API usage, please do.

I did look into an IOMMU API memory allocator, and while we can do it
easily for coherent devices, we need some arch hooks for non-coherent
device support.  With a pending series from me we have those for arm64,
but 32-bit arm support will require a lot more work first.
