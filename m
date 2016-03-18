From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH V5 02/10] perf/amd/iommu: Consolidate and move
	perf_event_amd_iommu header
Date: Fri, 18 Mar 2016 14:07:25 +0700
Message-ID: <56EBA92D.7010906@amd.com>
References: <1456236764-1569-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1456236764-1569-3-git-send-email-Suravee.Suthikulpanit@amd.com>
	<20160312132224.GI6344@twins.programming.kicks-ass.net>
	<56E64B68.3090505@amd.com>
	<20160314095856.GL6344@twins.programming.kicks-ass.net>
	<56E6BE7E.8010807@amd.com> <20160314141945.GE15800@pd.tnic>
	<20160314163913.GO6344@twins.programming.kicks-ass.net>
	<56E759C3.5040707@amd.com> <20160315104017.GA4559@pd.tnic>
	<20160315105318.GU6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160315105318.GU6344-ndre7Fmf5hadTX5a5knrm8zTDFooKrT+cvkQGrU6aU0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, andihartmann-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi

On 03/15/2016 05:53 PM, Peter Zijlstra wrote:
> On Tue, Mar 15, 2016 at 11:40:17AM +0100, Borislav Petkov wrote:
>> On Tue, Mar 15, 2016 at 07:39:31AM +0700, Suravee Suthikulpanit wrote:
>>> What if I just merge the newly introduced arch/x86/include/perf/amd/iommu.h
>>> into the include/linux/amd-iommu.h? I do not see the point of having to
>>> separate things out into two files.
>>
>> Except that this header has x86-specific stuff and include/linux/ is
>> arch-agnostic.
>
> Which would suggest that header is placed wrong, because I would expect
> the amd-iommu to really be rather x86 specific. Or is AMD making ARM
> parts for which this is useful too?
>

Actually the exposed APIs (in both files) are from the AMD IOMMU driver, 
which is not necessary x86-specific. They mostly use struct pci_dev, 
which is also arch-agnostic. It is correct that the current IOMMU IP is 
only available in x86 systems. However, if AMD plans to use the IOMMU IP 
in the ARM-based processors in the future, putting these into 
include/linux/amd-iommu.h would work better.

Thanks,
Suravee
