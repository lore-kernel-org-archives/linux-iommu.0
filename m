From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 3/5] iommu/arm-smmu: Clean up DMA API usage
Date: Tue, 28 Jul 2015 11:18:10 +0100
Message-ID: <20150728101810.GG29209@arm.com>
References: <c8cc82fea26044e393ff857014d4146faac5ec1e.1438019069.git.robin.murphy@arm.com>
	<921980a38ec7d35610c68e8e94235c55318ba80c.1438019069.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <921980a38ec7d35610c68e8e94235c55318ba80c.1438019069.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>
Cc: "laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jul 27, 2015 at 07:18:10PM +0100, Robin Murphy wrote:
> With the correct DMA API calls now integrated into the io-pgtable code,
> let that handle the flushing of non-coherent page table updates.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu.c | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 9a59bef..9501668 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -610,24 +610,13 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
>  static void arm_smmu_flush_pgtable(void *addr, size_t size, void *cookie)
>  {
>  	struct arm_smmu_domain *smmu_domain = cookie;
> -	struct arm_smmu_device *smmu = smmu_domain->smmu;
> -	unsigned long offset = (unsigned long)addr & ~PAGE_MASK;
>  
> -
> -	/* Ensure new page tables are visible to the hardware walker */
> -	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK) {
> +	/*
> +	 * Ensure new page tables are visible to a coherent hardware walker.
> +	 * The page table code deals with flushing for the non-coherent case.
> +	 */
> +	if (smmu_domain->smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
>  		dsb(ishst);
> -	} else {
> -		/*
> -		 * If the SMMU can't walk tables in the CPU caches, treat them
> -		 * like non-coherent DMA since we need to flush the new entries
> -		 * all the way out to memory. There's no possibility of
> -		 * recursion here as the SMMU table walker will not be wired
> -		 * through another SMMU.
> -		 */
> -		dma_map_page(smmu->dev, virt_to_page(addr), offset, size,
> -			     DMA_TO_DEVICE);
> -	}
>  }
>  
>  static struct iommu_gather_ops arm_smmu_gather_ops = {
> @@ -899,6 +888,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  		.oas		= oas,
>  		.tlb		= &arm_smmu_gather_ops,
>  	};
> +	if (!(smmu->features & ARM_SMMU_FEAT_COHERENT_WALK))
> +		pgtbl_cfg.iommu_dev = smmu->dev;

Ideally, I'd like to set the dev unconditionally and kill the flush_pgtable
callback. See my comments on the other patch.

Will
