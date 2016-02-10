From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH V3 1/5] perf/amd/iommu: Consolidate and move
	perf_event_amd_iommu header
Date: Thu, 11 Feb 2016 01:42:52 +0700
Message-ID: <56BB84AC.5080605@amd.com>
References: <1455058435-8716-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1455058435-8716-2-git-send-email-Suravee.Suthikulpanit@amd.com>
	<20160210164116.GG23914@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160210164116.GG23914-fF5Pk5pvG8Y@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, andihartmann-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Boris,

On 2/10/16 23:41, Borislav Petkov wrote:
> On Tue, Feb 09, 2016 at 04:53:51PM -0600, Suravee Suthikulpanit wrote:
>> >This patch consolidates "arch/x86/kernel/cpu/perf_event_amd_iommu.h" and
>> >"drivers/iommu/amd_iommu_proto.h", which contain duplicate function
>> >declarations, into "include/linux/perf/perf_event_amd_iommu.h"
>> >
>> >Reviewed-by: Joerg Roedel<jroedel-l3A5Bk7waGM@public.gmane.org>
>> >Signed-off-by: Suravee Suthikulpanit<Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
>> >---
>> >  arch/x86/kernel/cpu/perf_event_amd_iommu.c |  2 +-
>> >  arch/x86/kernel/cpu/perf_event_amd_iommu.h | 40 ------------------------------
>> >  drivers/iommu/amd_iommu_init.c             |  2 ++
>> >  drivers/iommu/amd_iommu_proto.h            |  7 ------
>> >  include/linux/perf/perf_event_amd_iommu.h  | 40 ++++++++++++++++++++++++++++++
>> >  5 files changed, 43 insertions(+), 48 deletions(-)
>> >  delete mode 100644 arch/x86/kernel/cpu/perf_event_amd_iommu.h
>> >  create mode 100644 include/linux/perf/perf_event_amd_iommu.h
> Is this a header which will be used on something else besides x86 or why
> is it being moved to include/linux/ ?
>
> If not, it should go into arch/x86/events/ with the rest of the perf
> private headers.
>
> ...
>

My goal here is to find a place that I can declare a set of function 
prototypes and macros used in the IOMMU driver and IOMMU PERF. These are 
exported by the AMD IOMMU and can be used by other drivers (e.g. IOMMU 
perf).

The reason I picked this location to place the header file is because 
there is already an existing include/linux/perf/arm_pmu.h file there. 
So, I thought it might be alright to put the perf_event_amd_iommu.h here.

Having the information in the file arch/x86/events/amd/iommu.h seems 
strange for having to specify ../../arch/x86/events/amd/iommu.h in the 
IOMMU driver.

So, you think it would be alright if move

include/linux/perf/perf_event_amd_iommu.h
to
arch/x86/include/perf/perf_event_amd_iommu.h


Suravee

Thanks,
Suravee
