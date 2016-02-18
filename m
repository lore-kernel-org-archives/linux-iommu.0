From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH V4 2/6] perf/amd/iommu: Modify functions to query max
 banks and counters
Date: Thu, 18 Feb 2016 12:11:16 +0100
Message-ID: <20160218111116.GE3694@pd.tnic>
References: <1455182127-17551-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1455182127-17551-3-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455182127-17551-3-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: joro@8bytes.org, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, andihartmann@freenet.de, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Feb 11, 2016 at 04:15:23PM +0700, Suravee Suthikulpanit wrote:
> Currently, amd_iommu_pc_get_max_[banks|counters]() require devid,
> which should not be the case.

Why?

Commit message could use an explanation.

> Also, these don't properly support
> multi-IOMMU system.
> 
> Current and future AMD systems with IOMMU that support perf counter

				"with an IOMMU that supports performance counters"

> would likely contain homogeneous IOMMUs where multiple IOMMUs are

What are homogeneous IOMMUs?

> availalbe. So, this patch modifies these function to iterate all IOMMU

Please integrate a spellchecker in your patch creation workflow:

s/availalbe/available/

> to check the max banks and counters reported by the hardware.
> 
> Reviewed-by: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> ---
>  arch/x86/events/amd/iommu.c           | 17 +++++++----------
>  arch/x86/include/asm/perf/amd/iommu.h |  7 ++-----
>  drivers/iommu/amd_iommu_init.c        | 20 ++++++++++++--------
>  3 files changed, 21 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
> index 2f96072..debf22d 100644
> --- a/arch/x86/events/amd/iommu.c
> +++ b/arch/x86/events/amd/iommu.c
> @@ -232,14 +232,6 @@ static int perf_iommu_event_init(struct perf_event *event)
>  		return -EINVAL;
>  	}
>  
> -	/* integrate with iommu base devid (0000), assume one iommu */
> -	perf_iommu->max_banks =
> -		amd_iommu_pc_get_max_banks(IOMMU_BASE_DEVID);
> -	perf_iommu->max_counters =
> -		amd_iommu_pc_get_max_counters(IOMMU_BASE_DEVID);
> -	if ((perf_iommu->max_banks == 0) || (perf_iommu->max_counters == 0))
> -		return -EINVAL;
> -
>  	/* update the hw_perf_event struct with the iommu config data */
>  	hwc->config = config;
>  	hwc->extra_reg.config = config1;
> @@ -450,6 +442,11 @@ static __init int _init_perf_amd_iommu(

Btw, that _init_perf_amd_iommu is unnecessarily split from
amd_iommu_pc_init(). You should merge those two. But that's another
patch. In that same cleanup patch you could do

s/perf_iommu/pi/g

or so because that perf_iommu local var is unnecesarily long and impairs
readability.

>  	if (_init_events_attrs(perf_iommu) != 0)
>  		pr_err("perf: amd_iommu: Only support raw events.\n");
>  
> +	perf_iommu->max_banks = amd_iommu_pc_get_max_banks();
> +	perf_iommu->max_counters = amd_iommu_pc_get_max_counters();
> +	if ((perf_iommu->max_banks == 0) || (perf_iommu->max_counters == 0))

Simplify:

	if (!perf_iommu->max_banks ||
	    !perf_iommu->max_counters)

> +		return -EINVAL;
> +
>  	/* Init null attributes */
>  	perf_iommu->null_group = NULL;
>  	perf_iommu->pmu.attr_groups = perf_iommu->attr_groups;
> @@ -460,8 +457,8 @@ static __init int _init_perf_amd_iommu(
>  		amd_iommu_pc_exit();
>  	} else {
>  		pr_info("perf: amd_iommu: Detected. (%d banks, %d counters/bank)\n",
> -			amd_iommu_pc_get_max_banks(IOMMU_BASE_DEVID),
> -			amd_iommu_pc_get_max_counters(IOMMU_BASE_DEVID));
> +			amd_iommu_pc_get_max_banks(),
> +			amd_iommu_pc_get_max_counters());
>  	}
>  
>  	return ret;
> diff --git a/arch/x86/include/asm/perf/amd/iommu.h b/arch/x86/include/asm/perf/amd/iommu.h
> index 72f64b7..97e1be5 100644
> --- a/arch/x86/include/asm/perf/amd/iommu.h
> +++ b/arch/x86/include/asm/perf/amd/iommu.h
> @@ -24,15 +24,12 @@
>  #define PC_MAX_SPEC_BNKS			64
>  #define PC_MAX_SPEC_CNTRS			16
>  
> -/* iommu pc reg masks*/
> -#define IOMMU_BASE_DEVID			0x0000
> -
>  /* amd_iommu_init.c external support functions */
>  bool amd_iommu_pc_supported(void);
>  
> -u8 amd_iommu_pc_get_max_banks(u16 devid);
> +u8 amd_iommu_pc_get_max_banks(void);
>  
> -u8 amd_iommu_pc_get_max_counters(u16 devid);
> +u8 amd_iommu_pc_get_max_counters(void);
>  
>  int amd_iommu_pc_set_reg_val(u16 devid, u8 bank, u8 cntr, u8 fxn, u64 *value);
>  
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index d30f4b2..a62b5ce 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -2251,15 +2251,17 @@ EXPORT_SYMBOL(amd_iommu_v2_supported);
>   *
>   ****************************************************************************/
>  
> -u8 amd_iommu_pc_get_max_banks(u16 devid)
> +u8 amd_iommu_pc_get_max_banks(void)
>  {
>  	struct amd_iommu *iommu;
>  	u8 ret = 0;
>  
> -	/* locate the iommu governing the devid */
> -	iommu = amd_iommu_rlookup_table[devid];
> -	if (iommu)
> +	for_each_iommu(iommu) {
> +		if (!iommu->max_banks ||
> +		    (ret && (iommu->max_banks != ret)))

What is that supposed to do?

Check that the max_banks of a previous IOMMU are == to the max_banks of
the current IOMMU?

Why? Could definitely use a comment.

> +			return 0;
>  		ret = iommu->max_banks;
> +	}
>  
>  	return ret;
>  }
> @@ -2271,15 +2273,17 @@ bool amd_iommu_pc_supported(void)
>  }
>  EXPORT_SYMBOL(amd_iommu_pc_supported);
>  
> -u8 amd_iommu_pc_get_max_counters(u16 devid)
> +u8 amd_iommu_pc_get_max_counters(void)
>  {
>  	struct amd_iommu *iommu;
>  	u8 ret = 0;
>  
> -	/* locate the iommu governing the devid */
> -	iommu = amd_iommu_rlookup_table[devid];
> -	if (iommu)
> +	for_each_iommu(iommu) {
> +		if (!iommu->max_counters ||
> +		    (ret && (iommu->max_counters != ret)))

Ditto.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
