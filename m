From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v4 1/9] iommu/vt-d: Global PASID name space
Date: Wed, 11 Jul 2018 14:32:44 +0800
Message-ID: <5B45A48C.7040300@linux.intel.com>
References: <1531113778-28238-1-git-send-email-baolu.lu@linux.intel.com>
	<1531113778-28238-2-git-send-email-baolu.lu@linux.intel.com>
	<20180711024843.GC2359@xz-mi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180711024843.GC2359@xz-mi>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Peter Xu <peterx-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Peter,

Thanks for looking into my patches.

On 07/11/2018 10:48 AM, Peter Xu wrote:
> On Mon, Jul 09, 2018 at 01:22:50PM +0800, Lu Baolu wrote:
>
> [...]
>
>> +#ifndef __INTEL_PASID_H
>> +#define __INTEL_PASID_H
>> +
>> +#define PASID_MIN			0x1
>> +#define PASID_MAX			0x20000
> Could I ask whether there's a reason to explicitly use 0x20000 for the
> max value?  Asked since I saw that the example in the spec gave 20
> bits for PASID (please refer to spec ver 3.0 section 3.4.3 figure
> 3-8).  Also I believe that's what I was told by Kevin.
>
> I saw that the old per-iommu max value is set to 0x20000, though I'm
> not sure whether that's still needed since if we're going to have
> two-level pasid table then AFAIU we don't need physically continuous
> memory any more (though I saw that we don't yet have two-level pasid
> table implemented):
>
> 	/* Eventually I'm promised we will get a multi-level PASID table
> 	 * and it won't have to be physically contiguous. Until then,
> 	 * limit the size because 8MiB contiguous allocations can be hard
> 	 * to come by. The limit of 0x20000, which is 1MiB for each of
> 	 * the PASID and PASID-state tables, is somewhat arbitrary. */
> 	if (iommu->pasid_max > 0x20000)
> 		iommu->pasid_max = 0x20000;

You are right.

With the scalable mode defined in vt-d v3.0, wecould use the full 20 bit
pasid. Previous max pasid was intended to save contiguous physical memory.

Best regards,
Lu Baolu
