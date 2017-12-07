From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 15/16] iommu: introduce page response function
Date: Thu, 7 Dec 2017 12:56:55 +0000
Message-ID: <39fcbbd2-2e6a-f05a-8cb4-8e3ad4ead369@arm.com>
References: <1510944914-54430-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1510944914-54430-16-git-send-email-jacob.jun.pan@linux.intel.com>
	<93661c1c-2d3b-295f-0b9d-52e50ea9e1d0@arm.com>
	<20171204133715.50c45136@jacob-builder>
	<a6cfc27a-6121-1e67-6e0d-f94a383bcd6f@arm.com>
	<20171206112521.1edf8e9b@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171206112521.1edf8e9b@jacob-builder>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Kumar,
	Sanjay K" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 06/12/17 19:25, Jacob Pan wrote:
[...]
>>   For SMMUv3, the stall buffer may be shared between devices on some
>>   implementations, in which case the guest could prevent other
>> devices to stall by letting the buffer fill up.
>>   -> We might have to keep track of stalls in the host driver and set
>> a credit or timeout to each stall, if it comes to that.
>>   -> In addition, send a terminate-all-stalls command when changing
>> the device's domain.
>>
> We have the same situation in VT-d with shared queue which in turn may
> affect other guests. Letting host driver maintain record of pending page
> request seems the best way to go. VT-d has a way to drain PRQ per PASID
> and RID combination. I guess this is the same as your
> "terminate-all-stalls" but with finer control? Or
> "terminate-all-stalls" only applies to a given device.

That command terminates all stalls for a given device (for all PASIDs).
It's a bit awkward to implement but should be enough to ensure that we
don't leak any outstanding faults to the next VM.

> Seems we can implement a generic timeout/credit mechanism in IOMMU
> driver with model specific action to drain/terminate. The timeout value
> can also be model specific.

Sounds good. Timeout seems a bit complicated to implement (and how do we
guess what timeout would work?), so maybe it's simpler to enforce a quota
of outstanding faults per VM, for example half of the shared queue size
(the number can be chosen by the IOMMU driver). If a VM has that many
outstanding faults, then any new fault is immediately terminated by the
host. A bit rough but it might be enough to mitigate the problem
initially, and we can always tweak it later (for instance disable faulting
if a guest doesn't ever reply).

Seems like VFIO should enforce this quota, since the IOMMU layer doesn't
know which device is assigned to which VM. If it's the IOMMU that enforces
quotas per device and a VM has 15 devices assigned, then the guest can
still DoS the IOMMU.

[...]
>>> + * @type: group or stream response  
>>
>> The page request doesn't provide this information
>>
> this is vt-d specific. it is in the vt-d page request descriptor and
> response descriptors are different depending on the type.
> Since we intend the generic data to be super set of models, I add this
> field.

But don't you need to add the stream type to enum iommu_fault_type, in
patch 8? Otherwise the guest can't know what type to set in the response.

Thanks,
Jean
