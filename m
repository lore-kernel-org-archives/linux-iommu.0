From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v7 5/7] perf/amd/iommu: Clean up perf_iommu_enable_event
Date: Thu, 12 Jan 2017 15:14:57 +0100
Message-ID: <20170112141457.aavaiabb5nerj3c3@pd.tnic>
References: <1484019227-11473-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1484019227-11473-6-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1484019227-11473-6-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Cc: peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 09, 2017 at 09:33:45PM -0600, Suravee Suthikulpanit wrote:
> This patch cleans up:
>   * Various bitwise operations in perf_iommu_enable_event
>   * Make use macros BIT(x)
> 
> This should not affect logic and functionality.
> 
> Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> ---
>  arch/x86/events/amd/iommu.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
> index 9bff41d..2403c78 100644
> --- a/arch/x86/events/amd/iommu.c
> +++ b/arch/x86/events/amd/iommu.c
> @@ -258,21 +258,21 @@ static void perf_iommu_enable_event(struct perf_event *ev)
>  	amd_iommu_pc_set_reg(0, devid, bank, cntr,
>  			     IOMMU_PC_COUNTER_SRC_REG, &reg);
>  
> -	reg = 0ULL | devid | (_GET_DEVID_MASK(ev) << 32);
> +	reg = devid | (_GET_DEVID_MASK(ev) << 32);
>  	if (reg)
> -		reg |= (1UL << 31);
> +		reg |= BIT(31);
>  	amd_iommu_pc_set_reg(0, devid, bank, cntr,
>  			     IOMMU_PC_DEVID_MATCH_REG, &reg);
>  
> -	reg = 0ULL | _GET_PASID(ev) | (_GET_PASID_MASK(ev) << 32);
> +	reg = _GET_PASID(ev) | (_GET_PASID_MASK(ev) << 32);
>  	if (reg)
> -		reg |= (1UL << 31);
> +		reg |= BIT(31);
>  	amd_iommu_pc_set_reg(0, devid, bank, cntr,
>  			     IOMMU_PC_PASID_MATCH_REG, &reg);
>  
> -	reg = 0ULL | _GET_DOMID(ev) | (_GET_DOMID_MASK(ev) << 32);
> +	reg = _GET_DOMID(ev) | (_GET_DOMID_MASK(ev) << 32);
>  	if (reg)
> -		reg |= (1UL << 31);
> +		reg |= BIT(31);
>  	amd_iommu_pc_set_reg(0, devid, bank, cntr,
>  			     IOMMU_PC_DOMID_MATCH_REG, &reg);
>  }
> -- 

Ah ok, you're doing it here, good.

For the next version of the patchset, please reorder all cleanups first
and then the patches adding functional changes/new features.

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
