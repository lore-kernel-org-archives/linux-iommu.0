From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7 4/7] perf/amd/iommu: Declare pr_fmt and remove
 unnecessary pr_debug
Date: Thu, 12 Jan 2017 11:19:42 +0100
Message-ID: <20170112101942.5z6e6s344awbi4uk@pd.tnic>
References: <1484019227-11473-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1484019227-11473-5-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484019227-11473-5-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, joro@8bytes.org, peterz@infradead.org, mingo@redhat.com
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 09, 2017 at 09:33:44PM -0600, Suravee Suthikulpanit wrote:
> This patch declare pr_fmt for perf/amd_iommu and remove unnecessary

There's that "This patch" again.

> pr_debug.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  arch/x86/events/amd/iommu.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

...

> @@ -362,7 +360,6 @@ static int perf_iommu_add(struct perf_event *event, int flags)
>  	struct perf_amd_iommu *perf_iommu =
>  			container_of(event->pmu, struct perf_amd_iommu, pmu);
>  
> -	pr_debug("perf: amd_iommu:perf_iommu_add\n");
>  	event->hw.state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
>  
>  	/* request an iommu bank/counter */
> @@ -383,7 +380,6 @@ static void perf_iommu_del(struct perf_event *event, int flags)
>  	struct perf_amd_iommu *perf_iommu =
>  			container_of(event->pmu, struct perf_amd_iommu, pmu);
>  
> -	pr_debug("perf: amd_iommu:perf_iommu_del\n");
>  	perf_iommu_stop(event, PERF_EF_UPDATE);
>  
>  	/* clear the assigned iommu bank/counter */
> @@ -443,7 +439,7 @@ static __init int _init_perf_amd_iommu(

That function definition is real ugly, please change it to something
more like this:

static __init int
_init_perf_amd_iommu(struct perf_amd_iommu *perf_iommu, char *name)
{

>  
>  	/* Init events attributes */

This and all those "Init" comments are useless.

>  	if (_init_events_attrs(perf_iommu) != 0)

	if (_init_events_attrs(perf_iommu))

is better.

> -		pr_err("perf: amd_iommu: Only support raw events.\n");
> +		pr_err("Only support raw events.\n");

What does that mean? I'm wearing my user hat right now and looking at
dmesg and that appears and I'm wondering what this means.

IOW, please put yourself in the user's shoes and read those messages
we're issuing and try to imagine whether they make sense or could be
improved.

Also, looking at that driver more, this needs to die, like now:

#define format_group    attr_groups[0]
#define cpumask_group   attr_groups[1]
#define events_group    attr_groups[2]
#define null_group      attr_groups[3]

Like, kill it dead. Define a separate array, look what the other drivers
do, whatever, but this is too ugly to live.

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
