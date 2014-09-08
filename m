From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 04/12] iommu/arm-smmu: Convert to iommu_capable() API
	function
Date: Mon, 8 Sep 2014 17:51:36 +0100
Message-ID: <20140908165136.GW26030@arm.com>
References: <1409914384-21191-1-git-send-email-joro@8bytes.org>
	<1409914384-21191-5-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409914384-21191-5-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

[adding devicetree for the last paragraph]

On Fri, Sep 05, 2014 at 11:52:56AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu.c | 35 ++++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index ca18d6d..47c2cb6 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1515,20 +1515,37 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
>  	return __pfn_to_phys(pte_pfn(pte)) | (iova & ~PAGE_MASK);
>  }
>  
> -static int arm_smmu_domain_has_cap(struct iommu_domain *domain,
> -				   unsigned long cap)
> +static bool arm_smmu_capable(enum iommu_cap cap)
>  {
> -	struct arm_smmu_domain *smmu_domain = domain->priv;
> -	struct arm_smmu_device *smmu = smmu_domain->smmu;
> -	u32 features = smmu ? smmu->features : 0;
> +	struct arm_smmu_device *smmu;
> +	bool ret = false;
>  
>  	switch (cap) {
>  	case IOMMU_CAP_CACHE_COHERENCY:
> -		return features & ARM_SMMU_FEAT_COHERENT_WALK;
> +		/*
> +		 * Use ARM_SMMU_FEAT_COHERENT_WALK as an indicator on whether
> +		 * the SMMU can force coherency on the DMA transaction. If it
> +		 * supports COHERENT_WALK it must be behind a coherent
> +		 * interconnect.
> +		 * A domain can be attached to any SMMU, so to reliably support
> +		 * IOMMU_CAP_CACHE_COHERENCY all SMMUs in the system need to be
> +		 * behind a coherent interconnect.
> +		 */

I don't think we should rely on the SMMU's advertisement of the coherent
table walk to mean anything other than `the SMMU can emit cacheable page
table walks'. The actual walker is a separate observer, and could have a
different route to memory than transactions flowing through the SMMU.

In reality, all we can report here is what the SMMU (as opposed to the rest
of the system) is capable of. The SMMU can always emit cacheable
transactions for a master if a stage-1 translation is in use so, without
extending the device-tree binding, we should report true here
unconditionally.

An alternative is to extend the device-tree bindings to have something like
"dma-coherent" for the SMMU node, which would imply that the interconnect is
configured to honour snoops from the SMMU into the CPU caches. We might want
an additional property on top of that to indicate that the table walker is
also coherent (and we could check this against our ARM_SMMU_FEAT_COHERENT_WALK
flag)

Will
