From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v7 00/22] Generic DT bindings for PCI IOMMUs and ARM SMMU
Date: Thu, 15 Sep 2016 18:46:47 +0200
Message-ID: <1838c65d-5944-8946-781c-b420bea1acab@redhat.com>
References: <cover.1473695704.git.robin.murphy@arm.com>
 <11ebd81e-2ea5-5ff3-35b3-be95f03e05bd@redhat.com>
 <d03ea5e7-59f1-8b49-4ba2-d05fc2030ebc@arm.com>
 <04a0a682-4fdc-8d62-57cd-efdf730582c6@redhat.com>
 <c2645c5e-edd3-2b31-4311-0ca621a915e2@arm.com>
 <4d87d5f2-0350-b5f8-ffc3-4e9377cf1f87@redhat.com>
 <fc4ce398-4eeb-f2ca-b964-e9f466be79c4@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fc4ce398-4eeb-f2ca-b964-e9f466be79c4-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,
On 15/09/2016 12:15, Robin Murphy wrote:
> On 15/09/16 10:29, Auger Eric wrote:
>> Hi Robin,
>>
>> On 14/09/2016 14:53, Robin Murphy wrote:
>>> On 14/09/16 13:32, Auger Eric wrote:
>>>> Hi,
>>>> On 14/09/2016 12:35, Robin Murphy wrote:
>>>>> On 14/09/16 09:41, Auger Eric wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 12/09/2016 18:13, Robin Murphy wrote:
>>>>>>> Hi all,
>>>>>>>
>>>>>>> To any more confusing fixups and crazily numbered extra patches, here's
>>>>>>> a quick v7 with everything rebased into the right order. The significant
>>>>>>> change this time is to implement iommu_fwspec properly from the start,
>>>>>>> which ends up being far simpler and more robust than faffing about
>>>>>>> introducing it somewhere 'less intrusive' to move toward core code later.
>>>>>>>
>>>>>>> New branch in the logical place:
>>>>>>>
>>>>>>> git://linux-arm.org/linux-rm iommu/generic-v7
>>>>>>
>>>>>> For information, as discussed privately with Robin I experience some
>>>>>> regressions with the former and now deprecated dt description.
>>>>>>
>>>>>> on my AMD Overdrive board and my old dt description I now only see a
>>>>>> single group:
>>>>>>
>>>>>> /sys/kernel/iommu_groups/
>>>>>> /sys/kernel/iommu_groups/0
>>>>>> /sys/kernel/iommu_groups/0/devices
>>>>>> /sys/kernel/iommu_groups/0/devices/e0700000.xgmac
>>>>>>
>>>>>> whereas I formerly see
>>>>>>
>>>>>> /sys/kernel/iommu_groups/
>>>>>> /sys/kernel/iommu_groups/3
>>>>>> /sys/kernel/iommu_groups/3/devices
>>>>>> /sys/kernel/iommu_groups/3/devices/0000:00:00.0
>>>>>> /sys/kernel/iommu_groups/1
>>>>>> /sys/kernel/iommu_groups/1/devices
>>>>>> /sys/kernel/iommu_groups/1/devices/e0700000.xgmac
>>>>>> /sys/kernel/iommu_groups/4
>>>>>> /sys/kernel/iommu_groups/4/devices
>>>>>> /sys/kernel/iommu_groups/4/devices/0000:00:02.2
>>>>>> /sys/kernel/iommu_groups/4/devices/0000:01:00.1
>>>>>> /sys/kernel/iommu_groups/4/devices/0000:00:02.0
>>>>>> /sys/kernel/iommu_groups/4/devices/0000:01:00.0
>>>>>> /sys/kernel/iommu_groups/2
>>>>>> /sys/kernel/iommu_groups/2/devices
>>>>>> /sys/kernel/iommu_groups/2/devices/e0900000.xgmac
>>>>>> /sys/kernel/iommu_groups/0
>>>>>> /sys/kernel/iommu_groups/0/devices
>>>>>> /sys/kernel/iommu_groups/0/devices/f0000000.pcie
>>>>>>
>>>>>> This is the group topology without ACS override. Applying the non
>>>>>> upstreamed "pci: Enable overrides for missing ACS capabilities" I used
>>>>>> to see separate groups for each PCIe components. Now I don't see any
>>>>>> difference with and without ACS override.
>>>>>
>>>>> OK, having reproduced on my Juno, the problem looks to be that
>>>>> of_for_each_phandle() leaves err set to -ENOENT after successfully
>>>>> walking a phandle list, which makes __find_legacy_master_phandle()
>>>>> always bail out after the first SMMU.
>>>>>
>>>>> Can you confirm that the following diff fixes things for you?
>>>>
>>>> Well it improves but there are still differences in the group topology.
>>>> The PFs now are in group 0.
>>>>
>>>> root@trusty:~# lspci -nk
>>>> 00:00.0 0600: 1022:1a00
>>>>         Subsystem: 1022:1a00
>>>> 00:02.0 0600: 1022:1a01
>>>> 00:02.2 0604: 1022:1a02
>>>>         Kernel driver in use: pcieport
>>>> 01:00.0 0200: 8086:1521 (rev 01)
>>>>         Subsystem: 8086:0002
>>>>         Kernel driver in use: igb
>>>> 01:00.1 0200: 8086:1521 (rev 01)
>>>>         Subsystem: 8086:0002
>>>>         Kernel driver in use: igb
>>>>
>>>>
>>>> with your series + fix:
>>>> /sys/kernel/iommu_groups/
>>>> /sys/kernel/iommu_groups/3
>>>> /sys/kernel/iommu_groups/3/devices
>>>> /sys/kernel/iommu_groups/3/devices/0000:00:00.0
>>>> /sys/kernel/iommu_groups/1
>>>> /sys/kernel/iommu_groups/1/devices
>>>> /sys/kernel/iommu_groups/1/devices/e0700000.xgmac
>>>> /sys/kernel/iommu_groups/4
>>>> /sys/kernel/iommu_groups/4/devices
>>>> /sys/kernel/iommu_groups/4/devices/0000:00:02.2
>>>> /sys/kernel/iommu_groups/4/devices/0000:00:02.0
>>>> /sys/kernel/iommu_groups/2
>>>> /sys/kernel/iommu_groups/2/devices
>>>> /sys/kernel/iommu_groups/2/devices/e0900000.xgmac
>>>> /sys/kernel/iommu_groups/0
>>>> /sys/kernel/iommu_groups/0/devices
>>>> /sys/kernel/iommu_groups/0/devices/0000:01:00.1
>>>> /sys/kernel/iommu_groups/0/devices/f0000000.pcie
>>>> /sys/kernel/iommu_groups/0/devices/0000:01:00.0
>>>>
>>>> Before (4.8-rc5):
>>>>
>>>> /sys/kernel/iommu_groups/
>>>> /sys/kernel/iommu_groups/3
>>>> /sys/kernel/iommu_groups/3/devices
>>>> /sys/kernel/iommu_groups/3/devices/0000:00:00.0
>>>> /sys/kernel/iommu_groups/1
>>>> /sys/kernel/iommu_groups/1/devices
>>>> /sys/kernel/iommu_groups/1/devices/e0700000.xgmac
>>>> /sys/kernel/iommu_groups/4
>>>> /sys/kernel/iommu_groups/4/devices
>>>> /sys/kernel/iommu_groups/4/devices/0000:00:02.2
>>>> /sys/kernel/iommu_groups/4/devices/0000:01:00.1
>>>> /sys/kernel/iommu_groups/4/devices/0000:00:02.0
>>>> /sys/kernel/iommu_groups/4/devices/0000:01:00.0
>>>> /sys/kernel/iommu_groups/2
>>>> /sys/kernel/iommu_groups/2/devices
>>>> /sys/kernel/iommu_groups/2/devices/e0900000.xgmac
>>>> /sys/kernel/iommu_groups/0
>>>> /sys/kernel/iommu_groups/0/devices
>>>> /sys/kernel/iommu_groups/0/devices/f0000000.pcie
>>>
>>> Your DT claims that f0000000.pcie (i.e. the "platform device" side of
>>> the host controller) owns the IDs 0x100 0x101 0x102 0x103 0x200 0x201
>>> 0x202 0x203 0x300 0x301 0x302 0x303 0x400 0x401 0x402 0x403. Thus when
>>> new devices (the PCI PFs) come along *also* claiming those IDs (via the
>>> RID-to-SID assumption), we now detect the aliasing and assign them to
>>> the existing group.
>>>
>>> The only way that DT worked without SMR conflicts before is that
>>> f0000000.pcie wasn't actually getting attached to a domain, thus wasn't
>>> getting SMRs allocated (ISTR you _did_ get conflicts back when we first
>>> tried to switch on default domains; that was probably the reason).
>>
>> Thanks for your explanations. meanwhile I converted the overdrive dt to
>> the new syntax and it works properly.
> 
> Yay!
> 
>> However I noticed there are MSI frame iommu mapping although the
>> device's domain is the default one. There is no check currently in
>> 21/22. I guess this isn't needed?
> 
> Au contraire ;)
;-)

 With the generic binding, default domains are properly
> implemented, i.e. they have translation, so anything not mapped will
> fault. I *had* to write patch 21 as part of this series, since having
> DMA ops for PCI devices at the cost of breaking all MSIs was clearly not
> a viable solution. If you see mappings, then it's because someone is
> using MSIs - so if you fancy, you can try rewinding back to patch 19 or
> 20 to watch them get stuck.
Hum OK; thanks for the explanation. With that implementation however,
don't we face back the issue we encountered in early stage of default
domain implementation:

With this sample config (AMD overdrive + I350-T2 + 2VFs per PF) I fill
the 8 context banks. Whereas practically we didn't need them before?

00:00.0 0600: 1022:1a00
	Subsystem: 1022:1a00
00:02.0 0600: 1022:1a01
00:02.2 0604: 1022:1a02
	Kernel driver in use: pcieport
01:00.0 0200: 8086:1521 (rev 01)
	Subsystem: 8086:0002
	Kernel driver in use: igb
01:00.1 0200: 8086:1521 (rev 01)
	Subsystem: 8086:0002
	Kernel driver in use: igb
01:10.0 0200: 8086:1520 (rev 01) -> context 5
	Subsystem: 8086:0002
	Kernel driver in use: vfio-pci
01:10.1 0200: 8086:1520 (rev 01) -> context 7
	Subsystem: 8086:0002
	Kernel driver in use: igbvf
01:10.4 0200: 8086:1520 (rev 01) -> context 6
	Subsystem: 8086:0002
	Kernel driver in use: igbvf
01:10.5 0200: 8086:1520 (rev 01) -> shortage
	Subsystem: 8086:0002
	Kernel driver in use: igbvf

So I can't even do passthrough anymore with that config. Is there
anything wrong in my setup/understanding?

Thanks

Eric

> 
> Robin.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
