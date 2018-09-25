From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] Changing the AMD IOMMU API path to work in an atomic
 context which is necessary for any custom drivers using the IOMMU API while
 holding a spinlock.
Date: Tue, 25 Sep 2018 11:09:48 +0200
Message-ID: <20180925090948.k62lms4t5qduwnpo@8bytes.org>
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
> This patch allows the IOMMU API path in the AMD driver to be called
> from an atomic context.  This is useful for anyone building a driver
> which needs to call the IOMMU API while holding a spinlock.

A bit more context would be helpful here. This is a pretty intrusive
change since we will drain the memory allocators atomic pools now while
building page-tables. This needs some more justification than just 'some
drivers might need it'.

Further, if we really address this problem it needs to happen through
the IOMMU-API, because the functions you are patching are called from
iommu_map()/iommu_unmap(), and these functions are allowed to sleep.

So the required approach here would be to introduce something like
iommu_map_atomic()/iommu_unmap_atomic() and implement call-backs for
that in more than just one driver.

Regards,

	Joerg
