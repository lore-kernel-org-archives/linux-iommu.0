From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH] iommu/rockchip: Fix "is stall active" check
Date: Tue, 05 Apr 2016 10:21:27 -0700
Message-ID: <5389576.zuTxjFsmO4@phil>
References: <1459865146-25308-1-git-send-email-john@metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1459865146-25308-1-git-send-email-john-HooS5bfzL4hWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: John Keeping <john-HooS5bfzL4hWk0Htik3J/w@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Am Dienstag, 5. April 2016, 15:05:46 schrieb John Keeping:
> Since commit cd6438c5f844 ("iommu/rockchip: Reconstruct to support multi
> slaves") rk_iommu_is_stall_active() always returns false because the
> bitwise AND operates on the boolean flag promoted to an integer and a
> value that is either zero or BIT(2).
> 
> Explicitly convert the right-hand value to a boolean so that both sides
> are guaranteed to be either zero or one.
> 
> rk_iommu_is_paging_enabled() does not suffer from the same problem since
> RK_MMU_STATUS_PAGING_ENABLED is BIT(0), but let's apply the same change
> for consistency and to make it clear that it's correct without needing
> to lookup the value.
> 
> Fixes: cd6438c5f844 ("iommu/rockchip: Reconstruct to support multi
> slaves") Signed-off-by: John Keeping <john-HooS5bfzL4hWk0Htik3J/w@public.gmane.org>

Nice catch, thanks.

Reviewed-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>

John, out of curiosity, how did you find that problem? Excess stall error 
messages or something else?


Thanks
Heiko

> ---
>  drivers/iommu/rockchip-iommu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c
> b/drivers/iommu/rockchip-iommu.c index a6f593a0a29e..5710a06c3049 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -315,8 +315,8 @@ static bool rk_iommu_is_stall_active(struct rk_iommu
> *iommu) int i;
> 
>  	for (i = 0; i < iommu->num_mmu; i++)
> -		active &= rk_iommu_read(iommu->bases[i], RK_MMU_STATUS) &
> -					RK_MMU_STATUS_STALL_ACTIVE;
> +		active &= !!(rk_iommu_read(iommu->bases[i], RK_MMU_STATUS) &
> +					   RK_MMU_STATUS_STALL_ACTIVE);
> 
>  	return active;
>  }
> @@ -327,8 +327,8 @@ static bool rk_iommu_is_paging_enabled(struct rk_iommu
> *iommu) int i;
> 
>  	for (i = 0; i < iommu->num_mmu; i++)
> -		enable &= rk_iommu_read(iommu->bases[i], RK_MMU_STATUS) &
> -					RK_MMU_STATUS_PAGING_ENABLED;
> +		enable &= !!(rk_iommu_read(iommu->bases[i], RK_MMU_STATUS) &
> +					   RK_MMU_STATUS_PAGING_ENABLED);
> 
>  	return enable;
>  }
