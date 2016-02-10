From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH V3 4/5] perf/amd/iommu: Introduce get_iommu_bnk_cnt_evt_idx
Date: Wed, 10 Feb 2016 17:43:36 +0100
Message-ID: <20160210164336.GH23914@pd.tnic>
References: <1455058435-8716-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1455058435-8716-5-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1455058435-8716-5-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, andihartmann-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 09, 2016 at 04:53:54PM -0600, Suravee Suthikulpanit wrote:
> Introduce a helper function to calculate bit-index for assigning
> performance counter assignment.
> 
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> ---
>  arch/x86/kernel/cpu/perf_event_amd_iommu.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/perf_event_amd_iommu.c b/arch/x86/kernel/cpu/perf_event_amd_iommu.c
> index 2d59e20..791bbcf 100644
> --- a/arch/x86/kernel/cpu/perf_event_amd_iommu.c
> +++ b/arch/x86/kernel/cpu/perf_event_amd_iommu.c
> @@ -145,18 +145,28 @@ static struct attribute_group amd_iommu_cpumask_group = {
>  
>  /*---------------------------------------------*/
>  
> +static inline
> +int get_iommu_bnk_cnt_evt_idx(struct perf_amd_iommu *perf_iommu,
> +				  int iommu_index, int bank_index,
> +				  int cntr_index)
> +{
> +	int cntrs_per_iommu = perf_iommu->max_banks * perf_iommu->max_counters;
> +	int index = (perf_iommu->max_counters * bank_index) + cntr_index;
> +
> +	return (cntrs_per_iommu * iommu_index) + index;
> +}
> +
>  static int get_next_avail_iommu_bnk_cntr(struct perf_amd_iommu *perf_iommu)
>  {
>  	unsigned long flags;
>  	int shift, bank, cntr, retval;
> -	int max_banks = perf_iommu->max_banks;
> -	int max_cntrs = perf_iommu->max_counters;
>  
>  	raw_spin_lock_irqsave(&perf_iommu->lock, flags);
>  
> -	for (bank = 0, shift = 0; bank < max_banks; bank++) {
> -		for (cntr = 0; cntr < max_cntrs; cntr++) {
> -			shift = bank + (bank*3) + cntr;
> +	for (bank = 0, shift = 0; bank < perf_iommu->max_banks; bank++) {
> +		for (cntr = 0; cntr < perf_iommu->max_counters; cntr++) {
> +			shift = get_iommu_bnk_cnt_evt_idx(perf_iommu,
> +							      0, bank, cntr);

You don't need to break this line - let it stick out.


-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
