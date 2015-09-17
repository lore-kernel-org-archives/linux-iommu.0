From: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v8 03/13] KVM: Define a new interface
	kvm_intr_is_single_vcpu()
Date: Thu, 17 Sep 2015 16:24:53 +0200
Message-ID: <55FACD35.1030602@redhat.com>
References: <1442393409-2623-1-git-send-email-feng.wu@intel.com>
	<1442393409-2623-4-git-send-email-feng.wu@intel.com>
	<55F934F5.7040605@redhat.com>
	<E959C4978C3B6342920538CF579893F002716FFA@SHSMSX104.ccr.corp.intel.com>
	<55FA8AED.6090700@redhat.com>
	<E959C4978C3B6342920538CF579893F002718968@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <E959C4978C3B6342920538CF579893F002718968-0J0gbvR4kTg/UvCtAeCM4rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

>> On 17/09/2015 05:17, Wu, Feng wrote:
>>>>>>> +	if (irq->dest_mode == APIC_DEST_PHYSICAL) {
>>>>>>> +		if (irq->dest_id == 0xFF)
>>>>>>> +			goto out;
>>>>>>> +
>>>>>>> +		if (irq->dest_id >= ARRAY_SIZE(map->phys_map)) {
>>>>>
>>>>> Warning here is wrong, the guest can trigger it.
>>> Could you please share more information about how the guest
>>> triggers these conditions (including the following two), Thanks
>>> a lot!
>>
>> irq->dest_id is a 16-bit value, so it can be > 255.
> 
> Yes, irq->dest_id is defined as u32, but by looking the current KVM
> code, seems desst_id is used as an u8 variable, even in x2apic mode
> the dest_id will not beyond 255 (except for broadcast dest in in x2apic
> mode). Correct me if I am wrong. Thanks a lot!

Actually you're right, the MSI destination is only 8 bits.  I was
confused because of

#define	 MSI_ADDR_DEST_ID_MASK		0x00ffff0

in arch/x86/include/asm/msidef.h.  But there may be a bug, see below...

>>> +		if (cid >= ARRAY_SIZE(map->logical_map)) {
>>> +			WARN_ON_ONCE(1);
>>
>> In x2apic mode irq->dest_id could have bits 12..15 set.
> 
> cid is gotten from bit 16 ..31 of the ldr (in apic_logical_id()), and
> in x2apic mode, ldr is constructed in kvm_apic_set_x2apic_id() as
> below:
> 
> u32 ldr = ((id >> 4) << 16) | (1 << (id & 0xf));
> 
> So in fact, cid is (id >> 4), I cannot think of why cid can beyond 15.

I think kvm_apic_match_logical_addr for MSI and IOAPIC interrupts is
buggy in x2apic mode.

It does:

        if (apic_x2apic_mode(apic))
                return ((logical_id >> 16) == (mda >> 16))
                       && (logical_id & mda & 0xffff) != 0;

But mda is only 8-bits for MSI and IOAPIC interrupts.

Radim, should kvm_apic_mda also handle the !ipi && x2apic_mda && dest_id
!= APIC_BROADCAST case?  It never triggers with Linux because it uses
only the physical mode (that's not super-easy to see;
ioapic_set_affinity looks for the RTEs in irq_data->chip_data and that
is allocated with kzalloc).

> Do I miss something here? Thanks!

No, you were right.

But still I think the WARNs are unnecessary; it is conceivable that some
future chipset adds support for more than 8-bits in the dest_id.

Paolo

> Thanks,
> Feng
> 
>>
>> Paolo
