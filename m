From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/iova: fix underflow bug in
 __alloc_and_insert_iova_range
Date: Fri, 7 Apr 2017 13:59:33 +0200
Message-ID: <20170407115933.GA7266@8bytes.org>
References: <1491543380-10275-1-git-send-email-nwatters@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1491543380-10275-1-git-send-email-nwatters@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nate Watterson <nwatters@codeaurora.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, okaya@codeaurora.org, robin.murphy@arm.com, manoj.iyer@canonical.com
List-Id: iommu@lists.linux-foundation.org

On Fri, Apr 07, 2017 at 01:36:20AM -0400, Nate Watterson wrote:
> Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
> ---
>  drivers/iommu/iova.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
