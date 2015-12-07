From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/5] iommu/io-pgtable: Indicate granule for TLB maintenance
Date: Mon, 7 Dec 2015 11:08:05 +0000
Message-ID: <20151207110804.GA23430@arm.com>
References: <cover.1449246988.git.robin.murphy@arm.com>
	<67223d4b1ff57f3f46e8c3102e663a063a50a7f7.1449246988.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <67223d4b1ff57f3f46e8c3102e663a063a50a7f7.1449246988.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, brian.starkey-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Dec 04, 2015 at 05:52:59PM +0000, Robin Murphy wrote:
> IOMMU hardware with range-based TLB maintenance commands can work
> happily with the iova and size arguments passed via the tlb_add_flush
> callback, but for IOMMUs which require separate commands per entry in
> the range, it is not straightforward to infer the necessary granularity
> when it comes to issuing the actual commands.
> 
> Add an additional argument indicating the granularity for the benefit
> of drivers needing to know, and update the ARM LPAE code appropriately
> (for non-leaf invalidations we currently just assume the worst-case
> page granularity rather than walking the table to check).
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu-v3.c    |  2 +-
>  drivers/iommu/arm-smmu.c       |  2 +-
>  drivers/iommu/io-pgtable-arm.c | 27 +++++++++++++++------------
>  drivers/iommu/io-pgtable.h     |  4 ++--
>  drivers/iommu/ipmmu-vmsa.c     |  4 ++--
>  5 files changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 4e5118a..c302b65 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1335,7 +1335,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>  }
>  
>  static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
> -					  bool leaf, void *cookie)
> +					  size_t granule, bool leaf, void *cookie)
>  {
>  	struct arm_smmu_domain *smmu_domain = cookie;
>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 47dc7a7..601e3dd 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -582,7 +582,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>  }
>  
>  static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
> -					  bool leaf, void *cookie)
> +					  size_t granule, bool leaf, void *cookie)
>  {
>  	struct arm_smmu_domain *smmu_domain = cookie;
>  	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 366a354..9088d27 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -58,8 +58,10 @@
>  	((((d)->levels - ((l) - ARM_LPAE_START_LVL(d) + 1))		\
>  	  * (d)->bits_per_level) + (d)->pg_shift)
>  
> +#define ARM_LPAE_GRANULE(d)		(1UL << (d)->pg_shift)
> +
>  #define ARM_LPAE_PAGES_PER_PGD(d)					\
> -	DIV_ROUND_UP((d)->pgd_size, 1UL << (d)->pg_shift)
> +	DIV_ROUND_UP((d)->pgd_size, ARM_LPAE_GRANULE(d))
>  
>  /*
>   * Calculate the index at level l used to map virtual address a using the
> @@ -169,7 +171,7 @@
>  /* IOPTE accessors */
>  #define iopte_deref(pte,d)					\
>  	(__va((pte) & ((1ULL << ARM_LPAE_MAX_ADDR_BITS) - 1)	\
> -	& ~((1ULL << (d)->pg_shift) - 1)))
> +	& ~(ARM_LPAE_GRANULE(d) - 1)))

Do we run the risk of truncating the VA on 32-bit ARM here?

Will
