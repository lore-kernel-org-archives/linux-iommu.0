From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 02/10] swiotlb: Factor out slot allocation and free
Date: Mon, 29 Apr 2019 13:44:01 +0200
Message-ID: <20190429114401.GA30333@lst.de>
References: <20190421011719.14909-3-baolu.lu@linux.intel.com> <20190422164555.GA31181@lst.de> <0c6e5983-312b-0d6b-92f5-64861cd6804d@linux.intel.com> <20190423061232.GB12762@lst.de> <dff50b2c-5e31-8b4a-7fdf-99d17852746b@linux.intel.com> <20190424144532.GA21480@lst.de> <a189444b-15c9-8069-901d-8cdf9af7fc3c@linux.intel.com> <20190426150433.GA19930@lst.de> <93b3d627-782d-cae0-2175-77a5a8b3fe6e@linux.intel.com> <90182d27-5764-7676-8ca6-b2773a40cfe1@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <90182d27-5764-7676-8ca6-b2773a40cfe1@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Christoph Hellwig <hch@lst.de>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com, mika.westerberg@linux.intel.com, pengfei.xu@intel.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 29, 2019 at 12:06:52PM +0100, Robin Murphy wrote:
>
> From the reply up-thread I guess you're trying to include an optimisation 
> to only copy the head and tail of the buffer if it spans multiple pages, 
> and directly map the ones in the middle, but AFAICS that's going to tie you 
> to also using strict mode for TLB maintenance, which may not be a win 
> overall depending on the balance between invalidation bandwidth vs. memcpy 
> bandwidth. At least if we use standard SWIOTLB logic to always copy the 
> whole thing, we should be able to release the bounce pages via the flush 
> queue to allow 'safe' lazy unmaps.

Oh.  The head and tail optimization is what I missed.  Yes, for that
we'd need the offset.

> Either way I think it would be worth just implementing the straightforward 
> version first, then coming back to consider optimisations later.

Agreed, let's start simple.  Especially as large DMA mappings or
allocations should usually be properly aligned anyway, and if not we
should fix that for multiple reasons.
