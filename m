From: Lutz Vieweg <lvml-i6VILw57VWU@public.gmane.org>
Subject: Re: [E1000-devel] AMD-Vi: Event logged IO_PAGE_FAULT - ixgbe Detected
	Tx Unit Hang - Reset adapter - master disable timed out
Date: Mon, 29 Aug 2016 14:30:30 +0200
Message-ID: <nq19t5$p54$5@blaine.gmane.org>
References: <loom.20160606T232112-817@post.gmane.org>	<CAKgT0UfEGS_QzM1phGKRV1hDgcnAwX-BqMkyQ6KJUOv82_kCiA@mail.gmail.com>	<nj64hf$9v5$1@ger.gmane.org>	<CAKgT0UfKUkrsXqLm4KdjXgLZ6QXZp5Rf-yYA3pBSzc1=ghJ4CQ@mail.gmail.com>	<njbvjb$40r$1@ger.gmane.org>	<CAKgT0UeFM1jYTU83YFohxUHWuJeTYfWDpdFM2CDQCutmf_vXvA@mail.gmail.com>	<5759A009.8040200@5t9.de>	<CAKT61h9cNnGDNugoWXYcpN1VjVK3Hn-VOW+TwHahj5EXzfsXgA@mail.gmail.com>
	<575EEFFB.20004@5t9.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <575EEFFB.20004-i6VILw57VWU@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: e1000-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 06/13/2016 07:40 PM, Lutz Vieweg wrote:
> On 06/13/2016 04:46 AM, Wan ZongShun wrote:
>> Firstly, I need to know if your ethernet card works well now or not
>> after you set iommu=pt.
>
> Too early to tell - the NIC worked for the last 4 days now without
> failing, however, that is only about the same time as it took after
> the upgrade to linux-4.6.1 before the bug was encountered, first.

I can now say that after using the option iommu=pt with linux-4.6.1,
the machine ran for > 2 months without problems.

For other reasons (btrfs-stuff) I had to upgrade the machine to
linux-4.7.2 last week, and the "iommu=pt" option wasn't active
after this upgrade.
It only took 4 days until the
  "AMD-Vi: Event logged IO_PAGE_FAULT...  ixgbe Detected Tx Unit Hang"
issue occured again.

So this evening, I'll reboot linux-4.7.2 with "iommu=pt" again,
as that really seemed to help.

Regards,

Lutz Vieweg



>> If your ethernet card with 64bit(not 32bit) DMA addressable cap, that
>> is ok, you will not be impacted by bounce buffer.
>
>> But iommu=pt is a terrible option, that make all devices bypass the iommu.
>
> Why is that terrible? The documentation I found on what iommu=pt actually
> means were pretty scarce, but I noticed how many places recommended to use
> this option for 10G NICs.
>
>> If you want to get further help, Please try:
>>
>> (1)Please add 'amd_iommu_dump' option in your kernel boot option, and
>> send your full kernel logs, lspci info, don't add iommu=pt.
>> (2) Add amd_iommu=fullflush option to kernel boot option, just try it.
>
> Will try that when the NIC becomes unavailable again.
>
>>> One more thing I find curious, but this didn't change with "iommu=pt":
>>>>
>>>> [    0.000000] AGP: Checking aperture...
>>>> [    0.000000] AGP: No AGP bridge found
>>>> [    0.000000] AGP: Node 0: aperture [bus addr 0x00000000-0x01ffffff]
>>>> (32MB)
>>>> [    0.000000] AGP: Your BIOS doesn't leave an aperture memory hole
>>>> [    0.000000] AGP: Please enable the IOMMU option in the BIOS setup
>>>> [    0.000000] AGP: This costs you 64MB of RAM
>>>> [    0.000000] AGP: Mapping aperture over RAM [mem 0xcc000000-0xcfffffff]
>>>> (65536KB)
>>>
>>> I checked and the IOMMU-option is definitely enabled in the BIOS setup.
>>> So I assume right that these message are irrelevant (since AGP as a whole
>>> is irrelevant on this server)?
>>
>> Please cat /proc/iomem, send the information.
>
> Here it is:
>> 00000000-00000fff : reserved
>> 00001000-00097bff : System RAM
>> 00097c00-0009ffff : reserved
>> 000a0000-000bffff : PCI Bus 0000:00
>> 000c0000-000c7fff : Video ROM
>> 000ce800-000d43ff : Adapter ROM
>> 000d4800-000d57ff : Adapter ROM
>> 000e6000-000fffff : reserved
>>   000f0000-000fffff : System ROM
>> 00100000-d7e7ffff : System RAM
>>   01000000-01688c05 : Kernel code
>>   01688c06-01d4f53f : Kernel data
>>   01eea000-02174fff : Kernel bss
>> d7e80000-d7e8dfff : RAM buffer
>> d7e8e000-d7e8ffff : reserved
>> d7e90000-d7eb3fff : ACPI Tables
>> d7eb4000-d7edffff : ACPI Non-volatile Storage
>> d7ee0000-d7ffffff : reserved
>> d9000000-daffffff : PCI Bus 0000:40
>>   d9000000-d90003ff : IOAPIC 2
>>   d9010000-d9013fff : amd_iommu
>> db000000-dcffffff : PCI Bus 0000:00
>>   db000000-dbffffff : PCI Bus 0000:01
>>     db000000-dbffffff : 0000:01:04.0
>>       db000000-dbffffff : mgadrmfb_vram
>>   dcd00000-dcffffff : PCI Bus 0000:04
>>     dcdfc000-dcdfffff : 0000:04:00.0
>>       dcdfc000-dcdfffff : ixgbe
>>     dce00000-dcffffff : 0000:04:00.0
>>       dce00000-dcffffff : ixgbe
>> dd000000-dfffffff : PCI Bus 0000:00
>>   def00000-df7fffff : PCI Bus 0000:01
>>     deffc000-deffffff : 0000:01:04.0
>>       deffc000-deffffff : mgadrmfb_mmio
>>     df000000-df7fffff : 0000:01:04.0
>>   dfaf6000-dfaf6fff : 0000:00:12.1
>>     dfaf6000-dfaf6fff : ohci_hcd
>>   dfaf7000-dfaf7fff : 0000:00:12.0
>>     dfaf7000-dfaf7fff : ohci_hcd
>>   dfaf8400-dfaf87ff : 0000:00:11.0
>>     dfaf8400-dfaf87ff : ahci
>>   dfaf8800-dfaf88ff : 0000:00:12.2
>>     dfaf8800-dfaf88ff : ehci_hcd
>>   dfaf8c00-dfaf8cff : 0000:00:13.2
>>     dfaf8c00-dfaf8cff : ehci_hcd
>>   dfaf9000-dfaf9fff : 0000:00:13.1
>>     dfaf9000-dfaf9fff : ohci_hcd
>>   dfafa000-dfafafff : 0000:00:13.0
>>     dfafa000-dfafafff : ohci_hcd
>>   dfafb000-dfafbfff : 0000:00:14.5
>>     dfafb000-dfafbfff : ohci_hcd
>>   dfb00000-dfbfffff : PCI Bus 0000:02
>>     dfb1c000-dfb1ffff : 0000:02:00.1
>>       dfb1c000-dfb1ffff : igb
>>     dfb20000-dfb3ffff : 0000:02:00.1
>>     dfb40000-dfb5ffff : 0000:02:00.1
>>       dfb40000-dfb5ffff : igb
>>     dfb60000-dfb7ffff : 0000:02:00.1
>>       dfb60000-dfb7ffff : igb
>>     dfb9c000-dfb9ffff : 0000:02:00.0
>>       dfb9c000-dfb9ffff : igb
>>     dfba0000-dfbbffff : 0000:02:00.0
>>     dfbc0000-dfbdffff : 0000:02:00.0
>>       dfbc0000-dfbdffff : igb
>>     dfbe0000-dfbfffff : 0000:02:00.0
>>       dfbe0000-dfbfffff : igb
>>   dfc00000-dfcfffff : PCI Bus 0000:03
>>     dfc3c000-dfc3ffff : 0000:03:00.0
>>       dfc3c000-dfc3ffff : mpt2sas
>>     dfc40000-dfc7ffff : 0000:03:00.0
>>       dfc40000-dfc7ffff : mpt2sas
>>     dfc80000-dfcfffff : 0000:03:00.0
>>   dfd00000-dfdfffff : PCI Bus 0000:04
>>     dfd80000-dfdfffff : 0000:04:00.0
>>   dfe00000-dfffffff : PCI Bus 0000:05
>>     dfeb0000-dfebffff : 0000:05:00.0
>>       dfeb0000-dfebffff : mpt2sas
>>     dfec0000-dfefffff : 0000:05:00.0
>>       dfec0000-dfefffff : mpt2sas
>>     dff00000-dfffffff : 0000:05:00.0
>> e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
>>   e0000000-efffffff : reserved
>>     e0000000-efffffff : pnp 00:0a
>> f6000000-f6003fff : amd_iommu
>> fec00000-fec003ff : IOAPIC 0
>> fec10000-fec1001f : pnp 00:04
>> fec20000-fec203ff : IOAPIC 1
>> fed00000-fed003ff : HPET 2
>>   fed00000-fed003ff : PNP0103:00
>> fed40000-fed44fff : PCI Bus 0000:00
>> fee00000-fee00fff : Local APIC
>>   fee00000-fee00fff : pnp 00:03
>> ffb80000-ffbfffff : pnp 00:04
>> ffe00000-ffffffff : reserved
>>   ffe50000-ffe5e05f : pnp 00:04
>> 100000000-2026ffffff : System RAM
>> 2027000000-2027ffffff : RAM buffer
>
> Regards,
>
> Lutz Vieweg
>
