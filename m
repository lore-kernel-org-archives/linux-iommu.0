From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH V3 1/5] perf/amd/iommu: Consolidate and move
	perf_event_amd_iommu header
Date: Thu, 11 Feb 2016 01:56:43 +0700
Message-ID: <56BB87EB.60700@amd.com>
References: <1455058435-8716-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1455058435-8716-2-git-send-email-Suravee.Suthikulpanit@amd.com>
	<20160210164116.GG23914@pd.tnic> <56BB84AC.5080605@amd.com>
	<20160210185146.GA11024@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160210185146.GA11024-fF5Pk5pvG8Y@public.gmane.org>
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

Hi,

On 2/11/16 01:51, Borislav Petkov wrote:
>> So, I thought it might be alright to put the perf_event_amd_iommu.h
>> >here.
>> >
>> >Having the information in the file arch/x86/events/amd/iommu.h seems
>> >strange for having to specify ../../arch/x86/events/amd/iommu.h in the
>> >IOMMU driver.
>> >
>> >So, you think it would be alright if move
>> >
>> >include/linux/perf/perf_event_amd_iommu.h
>> >to
>> >arch/x86/include/perf/perf_event_amd_iommu.h
> If it feels strange to you, you can move it to arch/x86/include/asm/
> There we put the arch-specific stuff.
>
> Then you can do
>
> #include <asm/perf/amd/iommu.h>
>
> or so. I've moved it to arch/x86/events/amd/iommu.h already anyway.

Ah.. agree then ;) So, I should branch off that tree of yours with the 
file already moved. Could you point me to it?

Thanks,
Suravee
