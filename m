From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v9 5/8] perf/amd/iommu: Modify functions to query max
	banks and counters
Date: Wed, 8 Feb 2017 20:31:40 +0100
Message-ID: <20170208193140.pzljikzicjaix6vw@pd.tnic>
References: <1486456836-17428-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1486456836-17428-6-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1486456836-17428-6-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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

On Tue, Feb 07, 2017 at 02:40:33AM -0600, Suravee Suthikulpanit wrote:
> Currently, amd_iommu_pc_get_max_[banks|counters]() use end-point
> device ID to locate an IOMMU and check the reported max banks/counters.
> The logic assumes that the IOMMU_BASE_DEVID belongs to the first IOMMU,
> and uses it to acquire a reference to the first IOMMU, which does not work
> on certain systems. Instead, modify the function to take an IOMMU index,
> and use it to query the corresponding AMD IOMMU instance.
> 
> Currently, hardcodes the IOMMU index to 0 since the current AMD IOMMU
> perf implementation only supports a single IOMMU. A subsequent
> patch will add support for multiple IOMMUs, and will use a proper IOMMU index.
> 
> Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> ---

...

> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 1b5adb4..eb654e7 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -2715,6 +2715,21 @@ bool amd_iommu_v2_supported(void)
>  }
>  EXPORT_SYMBOL(amd_iommu_v2_supported);
>  
> +struct amd_iommu *get_amd_iommu(unsigned int idx)
> +{
> +	unsigned int i = 0;
> +	struct amd_iommu *iommu, *ret = NULL;
> +
> +	for_each_iommu(iommu) {
> +		if (i++ == idx) {
> +			ret = iommu;
> +			break;

			return iommu;

no need for the assignment and the break.

> +		}
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL(get_amd_iommu);

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
