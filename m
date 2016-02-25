From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu: fix second argument of trace_map() to report
 correct paddr
Date: Thu, 25 Feb 2016 14:57:59 +0100
Message-ID: <20160225135759.GA16675@8bytes.org>
References: <1455067084-6560-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455067084-6560-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 10, 2016 at 10:18:04AM +0900, Yoshihiro Shimoda wrote:
> Since iommu_map() code added pgsize value to the paddr, trace_map()
> used wrong paddr. So, this patch adds "orig_paddr" value in the
> iommu_map() to use for the trace_map().
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/iommu/iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.
