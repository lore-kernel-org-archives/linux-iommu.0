From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] Changing the AMD IOMMU API path to work in an atomic
 context which is necessary for any custom drivers using the IOMMU API while
 holding a spinlock.
Date: Fri, 24 Aug 2018 07:53:28 -0700
Message-ID: <20180824145328.GA7996@infradead.org>
References: <1535120929-5693-1-git-send-email-murphyt7@tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1535120929-5693-1-git-send-email-murphyt7@tcd.ie>
Sender: linux-kernel-owner@vger.kernel.org
To: murphyt7@tcd.ie
Cc: leo.duran@amd.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Aug 24, 2018 at 02:28:49PM +0000, murphyt7@tcd.ie wrote:
> From: Tom Murphy <murphyt7@tcd.ie>
> 
> ---
> 
> This patch allows the IOMMU API path in the AMD driver to be called from an atomic context.
> This is useful for anyone building a driver which needs to call the IOMMU API while holding a spinlock.

I don't think that is a good idea.  Please point to the code in the
driver and we can't probably find a better solution.
