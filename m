From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] Fix typo. Change tlb_range_add to iotlb_range_add and
 tlb_sync to iotlb_sync
Date: Wed, 5 Dec 2018 17:04:39 +0100
Message-ID: <20181205160439.bjbh7stdey32hjgj@8bytes.org>
References: <20181204182734.20184-1-murphyt7@tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181204182734.20184-1-murphyt7@tcd.ie>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Murphy <murphyt7@tcd.ie>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Dec 04, 2018 at 06:27:34PM +0000, Tom Murphy wrote:
> From: tom <murphyt7@tcd.ie>
> 
> Someone forgot to update this comment.
> 
> Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
> ---
>  include/linux/iommu.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
