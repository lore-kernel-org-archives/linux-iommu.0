From: Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] iommu: Add event tracing feature to iommu
Date: Wed, 14 Aug 2013 10:06:08 -0600
Message-ID: <520BAAF0.8000509@samsung.com>
References: <1375196229-2784-1-git-send-email-shuah.kh@samsung.com>
	<20130814141758.GN28811@8bytes.org>
Reply-To: shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <20130814141758.GN28811-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org, Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, fweisbec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Thanks for the feedback.

On 08/14/2013 08:17 AM, Joerg Roedel wrote:
> Hi Shuah,
>
> thanks for doing this. I have a few suggestions for improvements.
>
> On Tue, Jul 30, 2013 at 08:57:09AM -0600, Shuah Khan wrote:
>> iommu:add_device_to_group
>> iommu:remove_device_from_group
>> iommu:attach_device_to_domain
>> iommu:detach_device_from_domain
>> iommu:unmap
>> iommu:map
>
> Please send these events as seperate patches.

Is this what you have in mind or does my original patch set minus the 
amd_event and drivers/iommu/amd_iommu.c change?

Patch 1:
drivers/iommu/Makefile
drivers/iommu/iommu-traces.c
include/trace/events/iommu.h

One patch for each of the following events?

iommu:add_device_to_group
iommu:remove_device_from_group
iommu:attach_device_to_domain
iommu:detach_device_from_domain
iommu:unmap
iommu:map

>
>> iommu:amd_event
>
> This needs some more thought. For now I would prefer an event in the
> generic report_iommu_fault() routine to report page-faults from all IOMMUs
> that support this.
>

I see what you are saying. Adding event to report_iommu_fault() would 
cover all IOMMUs. I would like to work on adding an event unless you 
already have it in works.

-- Shuah


Shuah Khan
Sr. Linux Kernel Developer
Open Source Group
Samsung Research America(Silicon Valley)
shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org | (970) 672-0658
