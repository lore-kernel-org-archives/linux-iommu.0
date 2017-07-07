From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/mtk: Avoid redundant TLB syncs locally
Date: Fri, 7 Jul 2017 11:06:13 +0800
Message-ID: <1499396773.2256.1.camel@mhfsdcap03>
References: <367e86d1e73867eaf0467732c10c7dc74380f97c.1499360104.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <367e86d1e73867eaf0467732c10c7dc74380f97c.1499360104.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 2017-07-06 at 17:55 +0100, Robin Murphy wrote:
> Under certain circumstances, the io-pgtable code may end up issuing two
> TLB sync operations without any intervening invalidations. This goes
> badly for the M4U hardware, since it means the second sync ends up
> polling for a non-existent operation to finish, and as a result times
> out and warns. The io_pgtable_tlb_* helpers implement a high-level
> optimisation to avoid issuing the second sync at all in such cases, but
> in order to work correctly that requires all pagetable operations to be
> serialised under a lock, thus is no longer applicable to all io-pgtable
> users.
> 
> Since we're the only user actually relying on this flag for correctness,
> let's reimplement it locally to avoid the headache of trying to make the
> high-level version concurrency-safe for other users.
> 
> CC: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> CC: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

Thanks Robin.

Tested-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

> ---
>  drivers/iommu/mtk_iommu.c | 6 ++++++
>  drivers/iommu/mtk_iommu.h | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 5d14cd15198d..91c6d367ab35 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -129,6 +129,7 @@ static void mtk_iommu_tlb_add_flush_nosync(unsigned long iova, size_t size,
>  	writel_relaxed(iova, data->base + REG_MMU_INVLD_START_A);
>  	writel_relaxed(iova + size - 1, data->base + REG_MMU_INVLD_END_A);
>  	writel_relaxed(F_MMU_INV_RANGE, data->base + REG_MMU_INVALIDATE);
> +	data->tlb_flush_active = true;
>  }
>  
>  static void mtk_iommu_tlb_sync(void *cookie)
> @@ -137,6 +138,10 @@ static void mtk_iommu_tlb_sync(void *cookie)
>  	int ret;
>  	u32 tmp;
>  
> +	/* Avoid timing out if there's nothing to wait for */
> +	if (!data->tlb_flush_active)
> +		return;
> +
>  	ret = readl_poll_timeout_atomic(data->base + REG_MMU_CPE_DONE, tmp,
>  					tmp != 0, 10, 100000);
>  	if (ret) {
> @@ -146,6 +151,7 @@ static void mtk_iommu_tlb_sync(void *cookie)
>  	}
>  	/* Clear the CPE status */
>  	writel_relaxed(0, data->base + REG_MMU_CPE_DONE);
> +	data->tlb_flush_active = false;
>  }
>  
>  static const struct iommu_gather_ops mtk_iommu_gather_ops = {
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index 2a28eadeea0e..c06cc91b5d9a 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -47,6 +47,7 @@ struct mtk_iommu_data {
>  	struct iommu_group		*m4u_group;
>  	struct mtk_smi_iommu		smi_imu;      /* SMI larb iommu info */
>  	bool                            enable_4GB;
> +	bool				tlb_flush_active;
>  
>  	struct iommu_device		iommu;
>  };
