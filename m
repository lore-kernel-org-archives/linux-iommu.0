From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v8 5/9] perf/amd/iommu: Modify functions to query max
	banks and counters
Date: Sun, 22 Jan 2017 20:53:26 +0100
Message-ID: <20170122195326.y5stvlexrobetfeq@pd.tnic>
References: <1484551416-5440-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1484551416-5440-6-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1484551416-5440-6-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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

On Mon, Jan 16, 2017 at 01:23:32AM -0600, Suravee Suthikulpanit wrote:
> Currently, amd_iommu_pc_get_max_[banks|counters]() use end-point
> device ID to locate an IOMMU and check the reported max banks/counters.
> The logic assumes that the IOMMU_BASE_DEVID belongs to the first IOMMU,
> and uses it to acquire a reference to the first IOMMU, which does not work
> on certain systems. Instead, we modify the function to take IOMMU index,
							     ^
s/we //							    an

> and use it to query the corresponded AMD IOMMU instance.

corresponding

> Note that we currently hard-code the IOMMU index to 0, since the current
> AMD IOMMU perf implementation only supports single IOMMU. Subsequent patch
					     ^		   ^
					     a		   A subsequent ...

> will add support for multi-IOMMU, and will use proper IOMMU index.
						^
s/multi-IOMMU/multiple IOMMUs/			a/the 

> 
> This patch also removes unnecessary function declaration in
> amd_iommu_proto.h.

This sentence can go away: never write "what" the patch is doing -
always "why" it is doing it.

> 
> Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> ---
>  arch/x86/events/amd/iommu.c     | 17 +++++++----------
>  arch/x86/events/amd/iommu.h     |  7 ++-----
>  drivers/iommu/amd_iommu_init.c  | 36 ++++++++++++++++++++++--------------
>  drivers/iommu/amd_iommu_proto.h |  2 --
>  4 files changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
> index 3f1c18a..ec7e873 100644
> --- a/arch/x86/events/amd/iommu.c
> +++ b/arch/x86/events/amd/iommu.c
> @@ -239,14 +239,6 @@ static int perf_iommu_event_init(struct perf_event *event)
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
> @@ -453,6 +445,11 @@ static __init int _init_perf_amd_iommu(
>  		return ret;
>  	}
>  
> +	perf_iommu->max_banks = amd_iommu_pc_get_max_banks(0);
> +	perf_iommu->max_counters = amd_iommu_pc_get_max_counters(0);

Align vertically on the "=".

> +	if (!perf_iommu->max_banks || !perf_iommu->max_counters)
> +		return -EINVAL;
> +
>  	perf_iommu->null_group = NULL;
>  	perf_iommu->pmu.attr_groups = perf_iommu->attr_groups;
>  
-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
