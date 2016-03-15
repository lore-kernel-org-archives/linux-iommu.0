From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH V5 02/10] perf/amd/iommu: Consolidate and move
	perf_event_amd_iommu header
Date: Tue, 15 Mar 2016 07:39:31 +0700
Message-ID: <56E759C3.5040707@amd.com>
References: <1456236764-1569-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1456236764-1569-3-git-send-email-Suravee.Suthikulpanit@amd.com>
	<20160312132224.GI6344@twins.programming.kicks-ass.net>
	<56E64B68.3090505@amd.com>
	<20160314095856.GL6344@twins.programming.kicks-ass.net>
	<56E6BE7E.8010807@amd.com> <20160314141945.GE15800@pd.tnic>
	<20160314163913.GO6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160314163913.GO6344-ndre7Fmf5hadTX5a5knrm8zTDFooKrT+cvkQGrU6aU0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, andihartmann-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Peter/Boris/Joerg,

On 3/14/16 23:39, Peter Zijlstra wrote:
> On Mon, Mar 14, 2016 at 03:19:45PM +0100, Borislav Petkov wrote:
>> On Mon, Mar 14, 2016 at 08:37:02PM +0700, Suravee Suthikulpanit wrote:
>>> Basically, we are trying to match the current Perf hierarchy for AMD IOMMU
>>> (arch/x86/events/amd/iommu.c). I can put it into
>>> arch/x86/include/asm/perf_amd_iommu.h. What would you prefer?
>>
>> Yeah, I was going to say the same thing - match the hierarchy so that
>> there are no confusions between paths. Makes sense to me.
>
> Well there's still the 'perf' vs' events' thing, but also what other
> files did you want to put there?
>
> For now I think I prefer a filename without extra directories; we can
> always move files about if there's more use later.
>
> Also, since its being used by both events/amd/iommu.c and
> drivers/iommu/amd_iommu.c you can also chose a name in the latter
> namespace.
>

Actually, I also found that there is currently the 
include/linux/amd-iommu.h, which contains extern function declarations 
defined in drivers/iommu/amd_iommu_init.c and drivers/iommu/amd_iommu_v2.c.

What if I just merge the newly introduced 
arch/x86/include/perf/amd/iommu.h into the include/linux/amd-iommu.h? I 
do not see the point of having to separate things out into two files.

Joerg, since you were maintaining that file, do you have any objection?

Thanks,
Suravee
