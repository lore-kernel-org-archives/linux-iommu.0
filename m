From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 15/16] iommu: introduce page response function
Date: Fri, 8 Dec 2017 13:51:57 +0000
Message-ID: <8873d7e9-8857-90af-73f2-f3e60ac9e15d@arm.com>
References: <1510944914-54430-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1510944914-54430-16-git-send-email-jacob.jun.pan@linux.intel.com>
	<93661c1c-2d3b-295f-0b9d-52e50ea9e1d0@arm.com>
	<20171204133715.50c45136@jacob-builder>
	<a6cfc27a-6121-1e67-6e0d-f94a383bcd6f@arm.com>
	<20171206112521.1edf8e9b@jacob-builder>
	<39fcbbd2-2e6a-f05a-8cb4-8e3ad4ead369@arm.com>
	<20171207171733.5e62bcf7@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171207171733.5e62bcf7@jacob-builder>
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

On 08/12/17 01:17, Jacob Pan wrote:
[...]
>> Sounds good. Timeout seems a bit complicated to implement (and how do
>> we guess what timeout would work?), so maybe it's simpler to enforce
>> a quota of outstanding faults per VM, for example half of the shared
>> queue size (the number can be chosen by the IOMMU driver). If a VM
>> has that many outstanding faults, then any new fault is immediately
>> terminated by the host. A bit rough but it might be enough to
>> mitigate the problem initially, and we can always tweak it later (for
>> instance disable faulting if a guest doesn't ever reply).
>>
> I have to make a correction/clarification, even though vt-d has a per
> iommu shared queue for prq but we do not stall. Ashok reminded me that.
> So there is no constraint on IOMMU if one of the guests does not
> respond. All the pressure is on the device which may have limited # of
> pending PR.

Right that makes more sense, for PRI the IOMMU doesn't need to keep page
request state internally. Then it seems the problem only exists for Stall
and someone's going to have a fun time working around it in the SMMU driver :(

>> Seems like VFIO should enforce this quota, since the IOMMU layer
>> doesn't know which device is assigned to which VM. If it's the IOMMU
>> that enforces quotas per device and a VM has 15 devices assigned,
>> then the guest can still DoS the IOMMU.
>>
> I still think timeout makes more sense than quota in that a VM could
> be under quota but failed to respond to one of the devices forever.
> I agree it is hard to devise a good timeout limit but since this is to
> prevent rare faults, we could pick a relatively large timeout. And we
> only tracks the longest pending timeout per device. The error condition
> we try to prevent is not necessarily only stall buffer overflow but
> timeout also, right?

Handling timeouts is less crucial than making sure a guest doesn't
monopolize all the shared resources, in my opinion. If a guest can't reply
to the injected faults, it's not really our problem as long as it doesn't
affect fault injection for other guests. We can reset the device and clean
pending faults when the guest terminates or resets the device.

I guess it's similar to IRQ injection, you don't care if the guest
acknowledges your interrupt or not as long as you make sure it is delivered.

Thanks,
Jean
