From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7 6/7] iommu/amd: Introduce amd_iommu_get_num_iommus()
Date: Thu, 12 Jan 2017 15:21:39 +0100
Message-ID: <20170112142139.5vpivrho6zbttitf@pd.tnic>
References: <1484019227-11473-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1484019227-11473-7-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484019227-11473-7-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, joro@8bytes.org, peterz@infradead.org, mingo@redhat.com
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 09, 2017 at 09:33:46PM -0600, Suravee Suthikulpanit wrote:
> This patch introduces amd_iommu_get_num_iommus(). This is intended for

There's that "This patch" again... but you get the idea :)

> Perf AMD IOMMU driver.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> ---
>  arch/x86/events/amd/iommu.h    | 2 ++
>  drivers/iommu/amd_iommu_init.c | 7 ++++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/amd/iommu.h b/arch/x86/events/amd/iommu.h
> index 342716e..381f1c4 100644
> --- a/arch/x86/events/amd/iommu.h
> +++ b/arch/x86/events/amd/iommu.h
> @@ -25,6 +25,8 @@
>  #define PC_MAX_SPEC_CNTRS			16
>  
>  /* amd_iommu_init.c external support functions */
> +extern int amd_iommu_get_num_iommus(void);
> +
>  extern bool amd_iommu_pc_supported(void);
>  
>  extern u8 amd_iommu_pc_get_max_banks(uint idx);
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index c993c77..c3740cb 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -1329,7 +1329,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
>  
>  	/* Add IOMMU to internal data structures */
>  	list_add_tail(&iommu->list, &amd_iommu_list);
> -	iommu->index             = amd_iommus_present++;
> +	iommu->index = amd_iommus_present++;
>  
>  	if (unlikely(iommu->index >= MAX_IOMMUS)) {
>  		WARN(1, "AMD-Vi: System has more IOMMUs than supported by this driver\n");
> @@ -2717,6 +2717,11 @@ static struct amd_iommu *get_amd_iommu(uint idx)
>  	return iommu;
>  }
>  
> +int amd_iommu_get_num_iommus(void)
> +{
> +	return amd_iommus_present;
> +}

So this is strange. This amd_iommus_present is used by other iommu code
but then you're adding a getter. IMO, it should be cleaner if *all* code
is converted to use the getter now and not the naked variable.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
