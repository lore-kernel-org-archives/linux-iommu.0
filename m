From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/io-pgtable-arm: Convert to IOMMU API TLB sync
Date: Fri, 22 Sep 2017 16:43:22 +0100
Message-ID: <20170922154322.GA27080@arm.com>
References: <a472d061559a6afcc4631e881e9420944471f461.1505747866.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <a472d061559a6afcc4631e881e9420944471f461.1505747866.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Sep 18, 2017 at 04:21:53PM +0100, Robin Murphy wrote:
> Now that the core API issues its own post-unmap TLB sync call, push that
> operation out from the io-pgtable-arm internals into the users. For now,
> we leave the invalidation implicit in the unmap operation, since none of
> the current users would benefit much from any change to that.
> 
> CC: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> CC: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu-v3.c    |  6 ++++++
>  drivers/iommu/arm-smmu.c       | 18 +++++++++++++-----
>  drivers/iommu/io-pgtable-arm.c |  7 +------
>  drivers/iommu/ipmmu-vmsa.c     |  6 ++++++
>  4 files changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index e67ba6c40faf..6a866e029173 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1743,6 +1743,11 @@ arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
>  	return ops->unmap(ops, iova, size);
>  }
>  
> +static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
> +{
> +	__arm_smmu_tlb_sync(to_smmu_domain(domain)->smmu);
> +}
> +
>  static phys_addr_t
>  arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
>  {
> @@ -1963,6 +1968,7 @@ static struct iommu_ops arm_smmu_ops = {
>  	.map			= arm_smmu_map,
>  	.unmap			= arm_smmu_unmap,
>  	.map_sg			= default_iommu_map_sg,
> +	.iotlb_sync		= arm_smmu_iotlb_sync,
>  	.iova_to_phys		= arm_smmu_iova_to_phys,
>  	.add_device		= arm_smmu_add_device,
>  	.remove_device		= arm_smmu_remove_device,
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 3bdb799d3b4b..c4b7efe08ce4 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -250,6 +250,7 @@ enum arm_smmu_domain_stage {
>  struct arm_smmu_domain {
>  	struct arm_smmu_device		*smmu;
>  	struct io_pgtable_ops		*pgtbl_ops;
> +	const struct iommu_gather_ops	*tlb_ops;

Hmmm.... I *suppose* that means there's a way to the TLB invalidation
functions from the iommu_device field of the io_pgtable_cfg via something
like iommu_ops_from_fwnode, but it feels horribly ugly doing that so I'm
happy to keep the extra gather_ops pointer in the io_pgtable_cfg for now.

This patch and the subsequent one look fine to me, but I'd like to go a
step further and hook-up the add_flush callback too so that it can be
(mostly) removed from the io_pgtable code and make the *_fast operations
even cheaper for VFIO when it starts using them.

So,

Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>

Joerg, do you reckon it's worth merging this as-is, or should we also
hook up add_flush before implementing this?

Will
