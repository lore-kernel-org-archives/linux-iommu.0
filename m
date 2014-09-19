From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 04/13 v2] iommu/arm-smmu: Convert to iommu_capable() API
	function function
Date: Fri, 19 Sep 2014 17:42:20 +0100
Message-ID: <20140919164220.GI20773@arm.com>
References: <1409914384-21191-1-git-send-email-joro@8bytes.org>
	<1409914384-21191-5-git-send-email-joro@8bytes.org>
	<20140908165136.GW26030@arm.com> <20140917085312.GE2533@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140917085312.GE2533-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Sep 17, 2014 at 09:53:12AM +0100, Joerg Roedel wrote:
> Hi Will,

Hello Joerg,

> On Mon, Sep 08, 2014 at 05:51:36PM +0100, Will Deacon wrote:
> > On Fri, Sep 05, 2014 at 11:52:56AM +0100, Joerg Roedel wrote:
> > > From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> > > 
> > > Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> > > Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> > > ---
> > >  drivers/iommu/arm-smmu.c | 35 ++++++++++++++++++++++++++---------
> > >  1 file changed, 26 insertions(+), 9 deletions(-)
> 
> Okay, so here is the updated patch:

Thanks, comments inline.

> From b5d895980849ba1a46a5250cd4cc5f3f9f28235d Mon Sep 17 00:00:00 2001
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> Date: Fri, 5 Sep 2014 10:49:34 +0200
> Subject: [PATCH 04/13] iommu/arm-smmu: Convert to iommu_capable() API function
> 
> Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index a83cc2a..f5cacf4 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1526,20 +1526,20 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
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
> -
>  	switch (cap) {
>  	case IOMMU_CAP_CACHE_COHERENCY:
> -		return features & ARM_SMMU_FEAT_COHERENT_WALK;
> +		/*
> +		 * Return false here until we have a way to find out whether the
> +		 * SMMUs in the system a coherently connected and able to force
> +		 * DMA coherency.
> +		 */

s/a/are/

However, I thought about this a bit more and the coherency isn't necessarily
a global property of the SMMU. In reality, it is dependent on the IOTLBs in
use by the domain, so it's not going to be possible to report true here in
many cases.

That means we'd need a way to say `this device is dma coherent when its
downstream IOMMU is enabled with IOMMU_CACHE mappings'. For the moment,
people will probably just add `dma-coherent' to the endpoint and dma-mapping
will request IOMMU_CACHE mappings regardless of the features advertised by
the IOMMU. In that case, it might make more sense to return `true' here as
we can always generated cacheable transactions from the SMMU. The
dma-coherent property on the device would then indicate whether those
transactions will snoop the CPU caches.

Will
