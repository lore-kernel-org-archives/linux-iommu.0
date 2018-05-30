From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 04/22] iommu/vt-d: add bind_pasid_table function
Date: Wed, 30 May 2018 12:53:53 +0100
Message-ID: <a07a0a0a-ebdd-c81a-7ed6-cff19e6078d7@arm.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1523915351-54415-5-git-send-email-jacob.jun.pan@linux.intel.com>
	<20180417131047.0a9c310f@w520.home>
	<AM4PR0802MB2369F739C91B630CA99B3D3BA3B40@AM4PR0802MB2369.eurprd08.prod.outlook.com>
	<20180420164251.5245f822@jacob-builder>
	<20180529140915.1f174689@w520.home>
	<AADFC41AFE54684AB9EE6CBC0274A5D1911E59C4@SHSMSX101.ccr.corp.intel.com>
	<20180529211746.74f1dd23@w520.home>
	<AADFC41AFE54684AB9EE6CBC0274A5D1911E5F06@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D1911E5F06-0J0gbvR4kThpB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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
To: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Wysocki,
	Rafael J" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 30/05/18 04:45, Tian, Kevin wrote:
>>>>>> On SMMUv3 the minimum alignment for base_ptr is 64 bytes, so a
>>>> guest
>>>>>> under a vSMMU might pass a pointer that's not aligned on 4k.
>>>>>>
>>>>> PASID table pointer for VT-d is 4K aligned.
>>>>>> Maybe this information could be part of the data passed to
>> userspace
>>>>>> about IOMMU table formats and features? They're not part of this
>>>>>> series, but I think we wanted to communicate IOMMU-specific
>> features
>>>>>> via sysfs.
>>>>>>
>>>>> Agreed, I believe Yi Liu is working on a sysfs interface such that QEMU
>>>>> can match IOMMU model and features.
>>>>
>>>> Digging this up again since v5 still has this issue.  The IOMMU API is
>>>> a kernel internal abstraction of the IOMMU.  sysfs is a userspace
>>>> interface.  Are we suggesting that the /only/ way to make use of the
>>>> internal IOMMU API here is to have a user provided opaque pasid table
>>>> that we can't even do minimal compatibility sanity testing on and we
>>>> simply hope that hardware covers all the fault conditions without
>>>> taking the host down with it?  I guess we have to assume the latter
>>>> since the user has full control of the table, but I have a hard time
>>>> getting past lack of internal ability to use the interface and no
>>>> ability to provide even the slimmest sanity testing.  Thanks,
>>>>
>>>
>>> checking size, alignment, ... is OK, which I think is already considered
>>> by vendor IOMMU driver. However sanity testing table format might
>>> be difficult. The initial table provided by guest is likely just all ZEROs.
>>> whatever format violation may be caught only when a PASID entry
>>> is updated...
>>
>> There's sanity testing the actual contents of the table, which I agree
>> would be difficult and would likely require some sort of shadowing at
>> additional overhead, but what about even basic consistency checking?
>> For example, is it possible that due to hardware variations a user
>> might generate a table which works on some systems but not others?
>> What
>> if two table formats are sufficiently similar that the IOMMU driver
>> puts an incompatible table in place but it continuously generates
>> faults, how do we debug that?  As an intermediary in this whole process
>> I'd really rather be able to identify that the user claims to be
>> providing a TypeA table but the IOMMU only supports TypeB, so clearly
>> this won't work.  I don't see that we have that capability.  Thanks,
>
> I remember we ever discussed to define some vendor/model ID,
> which can be retrieved by user space and then passed back when
> doing table binding. Then above simple model matching check can
> be done accordingly. It is actually a basic requirement when using 
> virtio-iommu, same driver expecting to work on all vendor IOMMUs.
> 
> However I don't remember whether/where that logic is implemented
> in this series (especially when there are two tracks moving in parallel).
> I'll leave to Jacob/Jean to further comment.

For Arm we do need some form of sanity checking. As each architecture
version brings a new set of features that may be supported and enabled
individually, we need to communicate fine-grained features to users.
They describes the general capability of the physical IOMMU, and also
which fields are available in the PASID table (entries are 512-bits and
leave some space for future extensions).

In the past I briefly tried using a ioctl-based interface through VFIO
only, but it seemed more complicated to extend than sysfs for this kind
of probing.

Note that the following is from my own prototype. I'm not sure how much
Yi Liu's implementation differs but I think this was roughly what we
agreed on last time. In sysfs an IOMMU device is described with:

* A model number, for example intel-vtd=1, arm-smmu-v3=2.
* Properties and features, describing in detail what the pIOMMU device
  and driver support.

/sys/class/iommu/<iommu-dev>/<model>/<property>

For example an SMMUv3:

The model number is described as a property
/sys/class/iommu/smmu.0x00000000e0600000/arm-smmu-v3/model = 2

A few feature bits and values:
.../arm-smmu-v3/asid_bits	// max address space ID bits, %d
.../arm-smmu-v3/ssid_bits	// max substream ID (PASID) bits, %d
.../arm-smmu-v3/input_bits	// max input address size, %d
.../arm-smmu-v3/output_bits	// max output address size, %d
.../arm-smmu-v3/btm		// broadcast TLB maintenance, enabled/disabled
.../arm-smmu-v3/httu		// Hardware table update, access+dirty/access/none
.../arm-smmu-v3/stall		// transaction stalling, enabled/disabled/force

(Note that the base pointer alignment previously discussed could be
implied by the model number, or added explicitly here.)

Which page table formats are supported:
.../arm-smmu-v3/pgtable_format/lpae-64
.../arm-smmu-v3/pgtable_format/v7s
I'm not sure yet what values these will have, they might simply contain
arbitrary format numbers because fields available in the page tables can
be deduced from the above features bits. (Out of laziness, in my
prototype I just describe a preferred format in a pgtable_format file)

As you can imagine I'd rather not pass the fine details back to the
kernel in bind_pasid_table. The list of features is growing, and
describing them is a pain. It could be done for debugging purpose, but
all we'd be achieving is telling the kernel that userspace has read the
values, not that the guest intends to use them. The guest selects
features by writing PASID table entries, which aren't read by the host.

If the guest writes invalid values in the PASID table then yes, we have
to rely on the hardware to contain the fault and not bring the host down
with it. If the IOMMU cannot do that, then the driver really shouldn't
implement bind_pasid_table... Otherwise, a fault while reading the PASID
table can be injected into the guest as an unrecoverable fault
(IOMMU_FAULT_REASON_PASID_INVALID or IOMMU_FAULT_REASON_PGD_FETCH in
patch 10) or printed by the host when debugging.

However I think the model number should be added to pasid_table_config.
For one thing it gives us a simple sanity-check, but it also tells which
other fields are valid in pasid_table_config. Arm-smmu-v3 needs at least
two additional 8-bit fields describing the PASID table format (number of
levels and PASID0 behaviour), which are written to device context tables
when installing the PASID table pointer.

Compatibility: new optional features are easy to add to a given model,
just add a new sysfs file. If in the future, the host describes a new
feature that is mandatory, or implements a different PASID table format,
how does it ensure that user understands it? Perhaps use a new model
number for this, e.g. "arm-smmu-v3-a=3", with similar features. I think
it would be the same if the host stops supporting a feature for a given
model, because they are ABI. But we can also define default values from
the start, for example "if ssid_bits file isn't present, default value
is 0 - PASID not supported"

Thanks,
Jean
