From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH V4 5/6] perf/amd/iommu: Enable support for multiple IOMMUs
Date: Tue, 23 Feb 2016 16:56:22 +0700
Message-ID: <56CC2CC6.6090803@amd.com>
References: <1455182127-17551-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1455182127-17551-6-git-send-email-Suravee.Suthikulpanit@amd.com>
	<20160218131853.GU6357@twins.programming.kicks-ass.net>
	<56CAC01F.8090800@amd.com>
	<20160222140741.GH6357@twins.programming.kicks-ass.net>
	<56CBEA4A.8070001@amd.com> <20160222222457.2824f7e0@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160222222457.2824f7e0-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andihartmann-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 02/23/2016 12:24 PM, Alex Williamson wrote:
> On Tue, 23 Feb 2016 12:12:42 +0700
> Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org> wrote:
>
>> Hi
>>
>> On 02/22/2016 09:07 PM, Peter Zijlstra wrote:
>>> On Mon, Feb 22, 2016 at 03:00:31PM +0700, Suravee Suthikulpanit wrote:
>>>>> So I really don't have time to review new muck while I'm hunting perf
>>>>> core fail, but Boris made me look at this.
>>>>>
>>>>> This is crazy, if you have multiple IOMMUs then create an event per
>>>>> IOMMU, do _NOT_ fold them all into a single event.
>>>>
>>>> These are system-wide events, which are programmed on every IOMMU the same
>>>> way. I am not sure what you meant by creating an event per IOMMU. Do you
>>>> mean I should create internal per-IOMMU struct perf_event for each event?
>>>
>>> No, I meant to expose each IOMMU individually to userspace, as a
>>> separate device.
>>>
>>> Is there never a case to profile just one of the IOMMUs ?
>>>
>>
>> I see. That's definitely doable and simpler to implement.
>>
>> I was not sure if making users specify the IOMMU instance (e.g.
>> amd_iommu_0/<ev name> , amd_iommu_1/<ev_name>, ....) would be too
>> tedious. However, this would actually give users better control of the
>> performance events, which is a good trade-off. I think it is acceptable.
>>
>> I'll make the change and send this out in V5.
>
> We already expose individual IOMMU hardware units in /sys/class/iommu/,
> you might consider trying to match the names there for the convenience
> of the user.  Looks like we use ivhd%d for AMD.  Thanks,
>
> Alex
>

Hm, the PMU for AMD IOMMU is currently shown as /sys/device/amd_iommu. I 
am not sure if /sys/device/ivhd[0|1|...] would be obvious to users that 
IVHD is really the AMD IOMMU.

Suravee
