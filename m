From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: Device address specific mapping of arm,mmu-500
Date: Tue, 30 May 2017 18:27:00 +0100
Message-ID: <c8cb9587-7aba-956d-88b5-f52bfbcdee23@arm.com>
References: <1b79efe2-6835-7a7a-f5ad-361391a7b967@broadcom.com>
 <20170530151437.GC23067@arm.com>
 <81637642-22d9-4868-156f-052f64bd042f@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <81637642-22d9-4868-156f-052f64bd042f@broadcom.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ray Jui <ray.jui@broadcom.com>, Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On 30/05/17 17:49, Ray Jui wrote:
> Hi Will,
> 
> On 5/30/17 8:14 AM, Will Deacon wrote:
>> On Mon, May 29, 2017 at 06:18:45PM -0700, Ray Jui wrote:
>>> I'm writing to check with you to see if the latest arm-smmu.c driver in
>>> v4.12-rc Linux for smmu-500 can support mapping that is only specific to
>>> a particular physical address range while leave the rest still to be
>>> handled by the client device. I believe this can already be supported by
>>> the device tree binding of the generic IOMMU framework; however, it is
>>> not clear to me whether or not the arm-smmu.c driver can support it.
>>>
>>> To give you some background information:
>>>
>>> We have a SoC that has PCIe root complex that has a build-in logic block
>>> to forward MSI writes to ARM GICv3 ITS. Unfortunately, this logic block
>>> has a HW bug that causes the MSI writes not parsed properly and can
>>> potentially corrupt data in the internal FIFO. A workaround is to have
>>> ARM MMU-500 takes care of all inbound transactions. I found that is
>>> working after hooking up our PCIe root complex to MMU-500; however, even
>>> with this optimized arm-smmu driver in v4.12, I'm still seeing a
>>> significant Ethernet throughput drop in both the TX and RX directions.
>>> The throughput drop is very significant at around 50% (but is already
>>> much improved compared to other prior kernel versions at 70~90%).
>>
>> Did Robin's experiments help at all with this?
>>
>> http://www.linux-arm.org/git?p=linux-rm.git;a=shortlog;h=refs/heads/iommu/perf
>>
> 
> It looks like these are new optimizations that have not yet been merged
> in v4.12? I'm going to give it a try.

Actually, most of the stuff there did land in 4.12 - only the
iommu/pgtable part is experimental stuff which hasn't been on the list
yet (but hopefully should be soon).

>>> One alternative is to only use MMU-500 for MSI writes towards
>>> GITS_TRANSLATER register in the GICv3, i.e., if I can define a specific
>>> region of physical address that I want MMU-500 to act on and leave the
>>> rest of inbound transactions to be handled directly by our PCIe
>>> controller, it can potentially work around the HW bug we have and at the
>>> same time achieve optimal throughput.
>>
>> I don't think you can bypass the SMMU for MSIs unless you give them their
>> own StreamIDs, which is likely to break things horribly in the kernel. You
>> could try to create an identity mapping, but you'll still have the
>> translation overhead and you'd probably end up having to supply your own DMA
>> ops to manage the address space. I'm assuming that you need to prevent the
>> physical address of the ITS from being allocated as an IOVA?
> 
> Will, is that a HW limitation that the SMMU cannot be used, only for MSI
> writes, in which case, the physical address range is very specific in
> our ASIC that falls in the device memory region (e.g., below 0x80000000)?

Yes, either translation is enabled or it isn't - we don't have
GART-style apertures. To segregate by address the best you can do is set
up the page tables to identity-map all of the "untranslated" address
space. As Will mentioned, if MSI writes could be distinguished from DMA
writes by Stream ID, rather than by address, then there would be more
options, but in the PCI case at least that's not generally possible.

Robin.

> In fact, what I need in this case is a static mapping from IOMMU on the
> physical address of the GITS_TRANSLATER of the GICv3 ITS, which is the
> address that MSI writes go to. This is to bypass the MSI forwarding
> logic in our PCIe controller. At the same time, I can leave the rest of
> inbound transactions to be handled by our PCIe controller without going
> through the MMU.
> 
>>
>>> Any feedback from you is greatly appreciated!
>>
>> Fix the hardware ;)
> 
> Indeed that has to happen with the next revision of the ASIC. But as you
> can see I'm getting quite desperate here trying to find an interim solution.
> 
>>
>> Will
>>
> 
> Thanks for the help!
> 
> Ray
> 
