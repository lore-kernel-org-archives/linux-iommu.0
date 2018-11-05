From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] iommu/dma: Zero pages manually in a length of scatterlist
Date: Mon, 5 Nov 2018 06:58:47 -0800
Message-ID: <20181105145847.GA31337@infradead.org>
References: <20181101213500.21800-1-nicoleotsuka@gmail.com>
 <63184c22-4587-be2b-8089-d2e4e0b5482d@arm.com>
 <20181102233613.GA26856@Asurada-Nvidia.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181102233613.GA26856@Asurada-Nvidia.nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 02, 2018 at 04:36:13PM -0700, Nicolin Chen wrote:
> > What if the pages came from highmem? I know that doesn't happen on arm64
> > today, but the point of this code *is* to be generic, and other users will
> > arrive eventually.
> 
> Hmm, so it probably should use sg_miter_start/stop() too? Looking
> at the flush routine doing in PAGE_SIZE for each iteration, would
> be possible to map and memset contiguous pages together? Actually
> the flush routine might be also optimized if we can map contiguous
> pages.

FYI, I have patches I plan to submit soon that gets rid of the
struct scatterlist use in this code to simplify it:

http://git.infradead.org/users/hch/misc.git/commitdiff/84e837fc3248b513f73adde49e04e7c58f605113
