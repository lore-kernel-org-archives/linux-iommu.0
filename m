From: Nadav Amit <nadav.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Avoid write-tearing on PTE clear
Date: Fri, 3 Jun 2016 10:55:39 -0700
Message-ID: <6472FEA9-15E1-4157-BE76-181F5263E13C@gmail.com>
References: <1463824283-1683-1-git-send-email-namit@vmware.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1463824283-1683-1-git-send-email-namit-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Ping?

Nadav Amit <namit-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org> wrote:

> When a PTE is cleared, the write may be teared or perform by multiple
> writes. In addition, in 32-bit kernel, writes are currently performed
> using a single 64-bit write, which does not guarantee order.
> 
> The byte-code right now does not seem to cause a problem, but it may
> still occur in theory.
> 
> Avoid this scenario by using WRITE_ONCE, and order the writes on
> 32-bit kernels.
> 
> Signed-off-by: Nadav Amit <namit-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
> ---
> drivers/iommu/intel-iommu.c | 19 ++++++++++++++++++-
> 1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index e1852e8..4f488a5 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -326,9 +326,26 @@ struct dma_pte {
> 	u64 val;
> };
> 
> +#ifndef CONFIG_64BIT
> +union split_dma_pte {
> +	struct {
> +		u32 val_low;
> +		u32 val_high;
> +	};
> +	u64 val;
> +};
> +#endif
> +
> static inline void dma_clear_pte(struct dma_pte *pte)
> {
> -	pte->val = 0;
> +#ifdef CONFIG_64BIT
> +	WRITE_ONCE(pte->val, 0);
> +#else
> +	union split_dma_pte *sdma_pte = (union split_dma_pte *)pte;
> +
> +	WRITE_ONCE(sdma_pte->val_low, 0);
> +	sdma_pte->val_high = 0;
> +#endif
> }
> 
> static inline u64 dma_pte_addr(struct dma_pte *pte)
> -- 
> 2.7.4
