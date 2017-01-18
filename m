From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v8 2/9] perf/amd/iommu: Clean up perf_iommu_enable_event
Date: Wed, 18 Jan 2017 19:20:55 +0100
Message-ID: <20170118182055.wpgo5b5xe3m4nrql@pd.tnic>
References: <1484551416-5440-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1484551416-5440-3-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484551416-5440-3-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, joro@8bytes.org, peterz@infradead.org, mingo@redhat.com
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 16, 2017 at 01:23:29AM -0600, Suravee Suthikulpanit wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> * Clean up various bitwise operations in perf_iommu_enable_event
								  ()

It is a function.

> * Make use macros BIT(x)

"Make use"?

> This should not affect logic and functionality.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  arch/x86/events/amd/iommu.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
> index 44638d0..1aa25d8 100644
> --- a/arch/x86/events/amd/iommu.c
> +++ b/arch/x86/events/amd/iommu.c
> @@ -164,11 +164,11 @@ static int get_next_avail_iommu_bnk_cntr(struct perf_amd_iommu *perf_iommu)
>  	for (bank = 0, shift = 0; bank < max_banks; bank++) {
>  		for (cntr = 0; cntr < max_cntrs; cntr++) {
>  			shift = bank + (bank*3) + cntr;
> -			if (perf_iommu->cntr_assign_mask & (1ULL<<shift)) {
> +			if (perf_iommu->cntr_assign_mask & BIT(shift)) {

							   BIT_ULL()

otherwise you're introducing a bug.

>  				continue;
>  			} else {
> -				perf_iommu->cntr_assign_mask |= (1ULL<<shift);
> -				retval = ((u16)((u16)bank<<8) | (u8)(cntr));
> +				perf_iommu->cntr_assign_mask |= BIT(shift);

Ditto.

> +				retval = ((u16)((u16)bank << 8) | (u8)(cntr));

That's some ugly casting. Why?

(u8)(cntr) is supposed to do what exactly? Cut off to 255 if max_cntrs
grows bigger? Can that even happen?

Same for bank?

Then you're casting to u16 even though retval is int. Ah, because it can
be negative too.

How about this instead?

	retval = ((bank & 0xff) << 8) | (cntr & 0xff);

This way it is really obvious what you're trying to do.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
