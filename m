From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] iommu/arm-smmu: fix null-pointer dereference in
 arm_smmu_add_device
Date: Tue, 8 Aug 2017 10:26:14 +0100
Message-ID: <20170808092614.GB12887@arm.com>
References: <1502182681-8966-1-git-send-email-asavkov@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502182681-8966-1-git-send-email-asavkov@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Artem Savkov <asavkov@redhat.com>
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Artem,

Thanks for the patch.

On Tue, Aug 08, 2017 at 10:58:01AM +0200, Artem Savkov wrote:
> Commit c54451a "iommu/arm-smmu: Fix the error path in arm_smmu_add_device"
> removed fwspec assignment in legacy_binding path as redundant which is
> wrong. It needs to be updated after fwspec initialisation in
> arm_smmu_register_legacy_master() as it is dereferenced later. Without
> this there is a NULL-pointer dereference panic during boot on some hosts.
> 
> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> ---
>  drivers/iommu/arm-smmu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index b97188a..95f1c86 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1519,6 +1519,7 @@ static int arm_smmu_add_device(struct device *dev)
>  
>  	if (using_legacy_binding) {
>  		ret = arm_smmu_register_legacy_master(dev, &smmu);
> +		fwspec = dev->iommu_fwspec;
>  		if (ret)
>  			goto out_free;
>  	} else if (fwspec && fwspec->ops == &arm_smmu_ops) {

Damn, you're completely right! Robin and I bashed our heads against this for
a while and couldn't remember why the code was structured like it was, but
that explains it. Can you add a comment saying that
arm_smmu_register_legacy_master will allocate an fwspec if its initially NULL,
please?

Cheers,

Will
