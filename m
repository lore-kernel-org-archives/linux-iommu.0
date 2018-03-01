From: Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: RFC on Kdump and PCIe on ARM64
Date: Thu, 1 Mar 2018 14:19:09 -0500
Message-ID: <2b2de17c-8527-e49b-2ef2-2a3d1801e4f9@codeaurora.org>
References: <c5c2d8d2-0384-442a-7bc6-8929457b8447@codeaurora.org>
	<20180301190552.GK13722@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180301190552.GK13722-1RhO1Y9PlrlHTL0Zs8A6p5iNqAH0jzoTYJqu5kTmcBRl57MIdRCFDg@public.gmane.org>
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
To: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Vikram Sethi <vikrams-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "Goel, Sameer" <sgoel-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 3/1/2018 2:05 PM, Bjorn Helgaas wrote:
> [+cc Joerg, David, iommu list]
> 
> On Thu, Mar 01, 2018 at 12:44:26PM -0500, Sinan Kaya wrote:
>> Hi,
>>
>> We are seeing IOMMU faults when booting the kdump kernel on ARM64.
>>
>> [    7.220162] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x02 received:
>> [    7.226123] arm-smmu-v3 arm-smmu-v3.0.auto:            0x0000010000000002
>> [    7.232023] arm-smmu-v3 arm-smmu-v3.0.auto:            0x0000000000000000
>> [    7.237925] arm-smmu-v3 arm-smmu-v3.0.auto:            0x0000000000000000
>> [    7.243827] arm-smmu-v3 arm-smmu-v3.0.auto:            0x0000000000000000
>>
>> This is Nate's interpretation of the fault:
>>
>> "The PCI device is sending transactions just after the SMMU was
>> reset/reinitialized which is problematic because the device has not
>> yet been added to the SMMU and thus should not be doing *any* DMA.
>> DMA from the PCI devices should be quiesced prior to starting the
>> crashdump kernel or you risk overwriting portions of memory you
>> meant to preserve. In this case the SMMU was actually doing you a
>> favor by blocking these errant DMA operations!!"
>>
>> I think this makes sense especially for the IOMMU enabled case on
>> the host where an IOVA can overlap with the region of memory kdump
>> reserved for itself.
>>
>> Apparently, there has been similar concerns in the past.
>>
>> https://www.fujitsu.com/jp/documents/products/software/os/linux/catalog/LinuxConJapan2013-Indoh.pdf
>>
>> and was not addressed globally due to IOMMU+PCI driver ordering
>> issues and bugs in HW due to hot reset.
>>
>> https://lkml.org/lkml/2012/8/3/160
>>
>> Hot reset as mentioned is destructive and may not be the best
>> implementation choice.  However, most of the modern endpoints
>> support PCIE function level reset.
>>
>> One other solution is for SMMUv3 driver to reserve the kdump used
>> IOVA addresses.
>>
>> Another solution is for the SMMUv3 driver to disable PCIe devices
>> behind the SMMU if it see SMMU is already enabled.
> 
> What problem are you trying to solve?  If the IOMMU is blocking DMA
> after the kdump kernel starts up, that sounds like the desired
> behavior.
> 

Three issues:
1. I'm seeing a flood of SMMUv3 faults due to adapter using addresses from the
previous kernel. This might be OK. 
2. When the SMMUv3 driver sees that it is enabled, it resets itself and
configures it one more time. 

[    7.018304] arm-smmu-v3 arm-smmu-v3.0.auto: ias 44-bit, oas 44-bit (features 0x00001fef)
[    7.026379] arm-smmu-v3 arm-smmu-v3.0.auto: SMMU currently enabled! Resetting...

>From the moment IOMMU is disabled to the point where IOMMU get enabled again,
there is a potential for the PCIE device to corrupt the kdump kernel memory as
the bus master and memory enable bits are left enabled.

[    0.000000] crashkernel reserved: 0x000000007fe00000 - 0x00000000ffe00000 (2048 MB)

This region happens to overlap with the IOVA addresses that SMMUv3 driver on the main
kernel is allocating.

IOVA addresses start from 0xFFFFFFFF and get decremented on each allocation.

3. The last one is adapter gets into fuzzy state due to not coming out of clean state
in the second time init and being rejected by SMMUv3 multiple times.

[   16.093441] pci 0000:01:00.0: aer_status: 0x00040000, aer_mask: 0x00000000
[   16.099356] pci 0000:01:00.0: Malformed TLP
[   16.103522] pci 0000:01:00.0: aer_layer=Transaction Layer, aer_agent=Receiver ID
[   16.110900] pci 0000:01:00.0: aer_uncor_severity: 0x00062011
[   16.116543] pci 0000:01:00.0:   TLP Header: 0a00a000 00008100 01010100 00000000



-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
