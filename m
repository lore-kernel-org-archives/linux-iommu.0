From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [RFC v2 2/4] iommu/arm-smmu-v3: Add tlbi_on_map option
Date: Thu, 5 Oct 2017 17:14:47 +0200
Message-ID: <c354646d-4191-50a3-22a8-86a4008ad5f4@redhat.com>
References: <1502459130-6234-1-git-send-email-eric.auger@redhat.com>
 <1502459130-6234-3-git-send-email-eric.auger@redhat.com>
 <20170817163424.GC30719@arm.com>
 <20170818053639-mutt-send-email-mst@kernel.org>
 <20170822220457-mutt-send-email-mst@kernel.org>
 <20170823102517.GE27301@arm.com>
 <cc18b752-97fd-f95f-fdef-478adc06e505@redhat.com>
 <20170823164255.GB590@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170823164255.GB590@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, robin.murphy@arm.com, Jean-Philippe.Brucker@arm.com, christoffer.dall@linaro.org, Marc.Zyngier@arm.com, alex.williamson@redhat.com, peterx@redhat.com, tn@semihalf.com, bharat.bhushan@nxp.com
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On 23/08/2017 18:42, Will Deacon wrote:
> Hi Eric,
> 
> On Wed, Aug 23, 2017 at 02:36:53PM +0200, Auger Eric wrote:
>> On 23/08/2017 12:25, Will Deacon wrote:
>>> On Tue, Aug 22, 2017 at 10:09:15PM +0300, Michael S. Tsirkin wrote:
>>>> On Fri, Aug 18, 2017 at 05:49:42AM +0300, Michael S. Tsirkin wrote:
>>>>> On Thu, Aug 17, 2017 at 05:34:25PM +0100, Will Deacon wrote:
>>>>>> On Fri, Aug 11, 2017 at 03:45:28PM +0200, Eric Auger wrote:
>>>>>>> When running a virtual SMMU on a guest we sometimes need to trap
>>>>>>> all changes to the translation structures. This is especially useful
>>>>>>> to integrate with VFIO. This patch adds a new option that forces
>>>>>>> the IO_PGTABLE_QUIRK_TLBI_ON_MAP to be applied on LPAE page tables.
>>>>>>>
>>>>>>> TLBI commands then can be trapped.
>>>>>>>
>>>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>>>>
>>>>>>> ---
>>>>>>> v1 -> v2:
>>>>>>> - rebase on v4.13-rc2
>>>>>>> ---
>>>>>>>  Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt | 4 ++++
>>>>>>>  drivers/iommu/arm-smmu-v3.c                             | 5 +++++
>>>>>>>  2 files changed, 9 insertions(+)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
>>>>>>> index c9abbf3..ebb85e9 100644
>>>>>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
>>>>>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
>>>>>>> @@ -52,6 +52,10 @@ the PCIe specification.
>>>>>>>                          devicetree/bindings/interrupt-controller/msi.txt
>>>>>>>                        for a description of the msi-parent property.
>>>>>>>  
>>>>>>> +- tlbi-on-map       : invalidate caches whenever there is an update of
>>>>>>> +                      any remapping structure (updates to not-present or
>>>>>>> +                      present entries).
>>>>>>> +
>>>>>>
>>>>>> My position on this hasn't changed, so NAK for this patch. If you want to
>>>>>> emulate something outside of the SMMUv3 architecture, please do so, but
>>>>>> don't pretend that it's an SMMUv3.
>>>>>>
>>>>>> Will
>>>>>
>>>>> What if the emulated device does not list arm,smmu-v3, listing
>>>>> qemu,ssmu-v3 as compatible? Would that address the concern?
>>>>
>>>> Will, can you comment on this please? Are you open to reusing the code
>>>> in drivers/iommu/arm-smmu-v3.c to support a paravirtual device that does
>>>> not claim to be compatible with smmuv3 but does try to behave very close to
>>>> it except it can cache non-present structures? Or would you rather
>>>> the code to support this is forked to qemu-smmu-v3.c?
>>>
>>> I still don't understand why this is preferable to a PV IOMMU
>>> implementation. Not only is this proposing to issue TLB maintenance on
>>> map, but the maintenance command itself is entirely made up. Why not just
>>> have a map command? Anyway, I'm reluctant to add this hack to the driver until:
>>>
>>>   1. There is a compelling reason to pursue this approach instead of a
>>>      PV approach (including performance measurements).
>>>
>>>   2. There is a specification for the QEMU fork of the ARM SMMUv3
>>>      architecture, including the semantics of the new command being proposed
>>>      and what exactly the TLB maintenance requirements are on map (for
>>>      example, what if I change an STE or a CD -- are they cached too?).
>> I am not sure I catch this last point. At the moment whenever the smmuv3
>> driver issues data structure invalidation commands (CMD_CFGI_*), those
>> are trapped and I replay the mappings on host side. I have not changed
>> anything on that side.
> 
> But STEs and CDs have very similar rules to TLBs: you don't need to issue
> invalidation if the data structure is transitioning from invalid to valid.

While looking at chapter "4.8 virtualisation" of the smmuv3 spec, I
understand that if we were to use the 2 stages we would need to trap on
STE updates since they are owned by the hyp.

Spec says "updates to a guest STE are accompanied by a CMD_CFGI_STE (or
similar) issued from the guest. So I understand invalidation of CDs are
not mandated by the spec but invalidation of STEs if the data structure
is transitioning from invalid to valid would be requested. Is that
correct? I fail to understand if this is currently done by the smmuv3
driver though.


> If you're caching those in QEMU, how do you keep them up-to-date? I can
> also guarantee you that there will be additional data structures added
> in future versions of the architecture, so you'll need to consider how
> you want to operate when running on newer hardware.
> 
>> I introduced a new map implementation defined command because the per
>> page CMD_TLBI_NH_VA IOVA invalidation command was not efficient/usable
>> with use cases such as DPDK on guest. I understood the spec provisions
>> for such implementation defined commands.

Also if we were to use dual stage, command queue accesses still would be
trapped. So if a guest invalidates a hugepage it would send a storm of
granule sized invalidations and each would be trapped. So maybe it does
not happen often but I guess it would be pretty inefficient.

On intel I understand the IOTLB Invalidation Descriptor has an AM field
(address-mask) which specifies the number of contiguous second level
pages that needs to be invalidated. When invalidating a large-page
transaction, the driver can use the appropriate mask value (0 for 4KB, 9
for 2MB, 18 for 1GB).

Thanks

Eric
> 
> Whilst there is a space for IMP DEF commands, this doesn't generally mean
> that they can be repurposed by software. What if the underlying hardware
> has an IMP DEF command that you want to export? Besides, my main points
> here are that your command isn't well-specified and if you have to add
> a command, why not just add a "map" command (i.e. implement a PV interface
> instead)?
> 
>>>   3. The ACPI IORT spec is updated to recognise this implementation
>>>
>>>   4. There is an implementation that can use the guest page tables directly,
>>>      because that may well make all of this moot.
>> Most probably I will come back to you with questions on stage 1 + stage2
>> enablement and "4.8 Virtualisation" chapter of smmuv3 spec. Besides I
>> also need to get access to some HW with smmuv3 ;-)
> 
> Ok.
> 
> Will
> 
