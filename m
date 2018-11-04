From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] iommu/dma: Zero pages manually in a length of scatterlist
Date: Sun, 4 Nov 2018 07:50:01 -0800
Message-ID: <20181104155001.GA25794@infradead.org>
References: <20181101213500.21800-1-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181101213500.21800-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: joro@8bytes.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 01, 2018 at 02:35:00PM -0700, Nicolin Chen wrote:
> The __GFP_ZERO will be passed down to the generic page allocation
> routine which zeros everything page by page. This is safe to be a
> generic way but not efficient for iommu allocation that organizes
> contiguous pages using scatterlist.
> 
> So this changes drops __GFP_ZERO from the flag, and adds a manual
> memset after page/sg allocations, using the length of scatterlist.
> 
> My test result of a 2.5MB size allocation shows iommu_dma_alloc()
> takes 46% less time, reduced from averagely 925 usec to 500 usec.

And in what case does dma_alloc_* performance even matter?
