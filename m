From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] iommu/dma: Zero pages manually in a length of scatterlist
Date: Tue, 6 Nov 2018 15:46:35 -0800
Message-ID: <20181106234633.GA11429@Asurada-Nvidia.nvidia.com>
References: <20181101213500.21800-1-nicoleotsuka@gmail.com>
 <20181104155001.GA25794@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181104155001.GA25794@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: joro@8bytes.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Christoph,

On Sun, Nov 04, 2018 at 07:50:01AM -0800, Christoph Hellwig wrote:
> On Thu, Nov 01, 2018 at 02:35:00PM -0700, Nicolin Chen wrote:
> > The __GFP_ZERO will be passed down to the generic page allocation
> > routine which zeros everything page by page. This is safe to be a
> > generic way but not efficient for iommu allocation that organizes
> > contiguous pages using scatterlist.
> > 
> > So this changes drops __GFP_ZERO from the flag, and adds a manual
> > memset after page/sg allocations, using the length of scatterlist.
> > 
> > My test result of a 2.5MB size allocation shows iommu_dma_alloc()
> > takes 46% less time, reduced from averagely 925 usec to 500 usec.
> 
> And in what case does dma_alloc_* performance even matter?

Honestly, this was amplified by running a local iommu benchmark
test. Practically dma_alloc/free() should not be that stressful,
but we cannot say the performance doesn't matter at all, right?
Though many device drivers pre-allocte memory for DMA usage, it
could matter where a driver dynamically allocates and releases.

And actually I have a related question for you: I saw that the
dma_direct_alloc() cancels the __GFP_ZERO flag and does manual
memset() after allocation. Might that be possibly related to a
performance concern? Though I don't see any performance keyword
for that part of code, especially seems that memset() was there
from the beginning.

Thanks
Nicolin
