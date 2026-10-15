Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF57D51B166
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792065469; cv=none; b=j0eJM+upw+1tRUthbBtjwWejLXWuxywCWstpK9R94HiwH6zxQvXJWHjEB/x7QhowFae+pv81aCaO9tQXC098Q+r7zR6jyGlfuFs7qgwgrEw7wsiGQloSpcjiWM0FkRtRuVgeqN5Y9kezwE/sb6XUX0cuzThizh3m5S0kIHcY9dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792065469; c=relaxed/simple;
	bh=i+YoRWwUTMdzBgxgYQpRg4TTlO7py0vjcCdoEbxGXdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YFRJnjiOB5ExaKc//4K7BEW/UER0YM2tX2pU3h4CHDzJjUBxEoALeX+7YbprezwbMSI4YXifobrWergL5NhdkMk/xcvsmuTinvigde0hkjdFHEDDhLVfotW32zqj/S8FkHz5WoNOcPaPeyw+b5DbdfMT51MIzrmaY0HHEyqYrUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=lZBpy6ys; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="lZBpy6ys"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lUrSdLAzDvxoTWd+40KVxrwlneH/gJqjempWLV15bz4=;
	b=lZBpy6ysL/jHDPpotkmzVPoamBTxY2G948FlR/FSxupDDncH4kPcgHY4S7W/oL0v0NVYwdZ3Q
	u3STEIU093xk9B5ooiDr8oacH+r+o/9ZCBV+19aYchtgNwzbX14sl3ruo/IyFgaE/Q8mv5wWMDC
	kk3P8ghiq63LNVQR3u39bpg=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4j55q12MJzz1prLV;
	Thu, 15 Oct 2026 19:45:17 +0800 (CST)
Received: from kwepemo500007.china.huawei.com (unknown [7.202.195.114])
	by mail.maildlp.com (Postfix) with ESMTPS id AA0B940561;
	Thu, 15 Oct 2026 19:57:37 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemo500007.china.huawei.com (7.202.195.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 15 Oct 2026 19:57:36 +0800
Message-ID: <c4ee3b65-848e-42ac-af16-e6aeee05b6b3@huawei.com>
Date: Thu, 15 Oct 2026 19:57:36 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Resctrl and I/O
To: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>, James Morse
	<james.morse@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Luck Tony
	<tony.luck@intel.com>, <reinette.chatre@intel.com>
CC: <x86@kernel.org>, <iommu@lists.linux.dev>, <linuxarm@huawei.com>,
	<alex@ghiti.fr>, <corbet@lwn.net>, <tomasz.jeznach@linux.dev>,
	<robin.murphy@arm.com>, <fustini@kernel.org>,
	<baolin.wang@linux.alibaba.com>, <aou@eecs.berkeley.edu>, <pjw@kernel.org>,
	<linux-kernel@vger.kernel.org>, <babu.moger@amd.com>,
	<wangzhou1@hisilicon.com>, <linux-riscv@lists.infradead.org>,
	<will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<yuanzhu@bytedance.com>, <cuiyunhui@bytedance.com>, <zengheng4@huawei.com>,
	<palmer@dabbelt.com>, <shuah@kernel.org>, <ben.horgan@arm.com>,
	<Dave.Martin@arm.com>
References: <arKx__kOPe4B5gDW@agluck-desk3>
 <8557363f-c051-4267-9fbc-f4cbb13ac35e@arm.com>
 <CACnXVnfJvJXm58TRd92q0j2FuAt8=SYLvXn_8aYk9qNoBFj+Zw@mail.gmail.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <CACnXVnfJvJXm58TRd92q0j2FuAt8=SYLvXn_8aYk9qNoBFj+Zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500007.china.huawei.com (7.202.195.114)



On 2026/10/15 11:46:09, Zhanpeng Zhang 
<zhangzhanpeng.jasper@bytedance.com> wrote:
> Hi all,
> 
> Thank you for the helpful discussion, and sorry for the late reply.
> 
> On 9/24/26 1:13 AM, James Morse wrote:
>> Hi Tony,
>>
>> On 22/09/2026 17:51, Luck, Tony wrote:
>>> Patches for ARM[1] and RISC-V[2] are both at RFC status.
>>>
>>> They appear to be based on similar h/w capabilities where architecture
>>> specific tags can be added to transactions from I/O devices by the IOMMU
>>> servicing the device. Device enumeration is handled outside of the resctrl
>>> file system.
>>>
>>> ARM docs say "the device name is the one listed under /sys/kernel/iommu_groups/<id>/devices/"
>>
>> I think using existing stuff in sysfs is a good idea.
>> (Creating new things in sysfs fills me with dread!)
>>
>> ARM/MPAM also has platform devices that can add the CLOSID/RMID metadata.
>> e.g. the GIC ITS [4] - a kind of translator for MSIs.
>>
>> For these we considered just using the device name as found in /sys/bus/platform/devices/,
>> in the hope that can be tied back to a struct device - and we could add a callback for
>> resctrl to configure the device with a CLOSID/RMID.
>> (but - I've not seen a use-case for this yet - those devices generate very little traffic)
>>>
>> Robin M set me straight on the iommu_group:
>> Strictly that is the wrong abstraction as devices are in the same group if the
>> driver can't stop them communicating, e.g. PCIe peer2peer. This doesn't mean it
>> can't tell the traffic apart for CLOSID/RMID labelling.
>> I picked this because its the device granularity VFIO works with.
>>
>> Equally, a device may create multiple streams of traffic, where only the driver
>> will know what each one corresponds to.
>>
>>
>> Using iommu_group like this may need a bit more thinking....
> 
> I agree. DMA isolation groups do not necessarily match the granularity
> at which QoS IDs can be assigned.
> 
>> If we can fall back to using a device as seen by sysfs, then the arch differences
>> here could be invisible to user-space.
>>
>>
>>> RISC-V says architecture specific device tokens are "devices or device groups"
>>>
>>> In both cases assignments are made with:
>>>
>>> 	# echo {device} > {group}/devices
>>>
>>> So now I'm looking at the capabilities of Intel RDT hardware. I'm ignoring
>>> the implementation on the Granite Rapids CPU, and looking at what is described
>>> in the RDT Architecture Specification[3]. Here are the highlights:
>>
>>
>>> 1) Enumeration is split between two ACPI tables. IRDT enumerates device groups
>>> and provides MMIO addresses to assign CLOSID/RMID to each group.
>>
>> For ARM/MPAM - this would always be driver specific. The fields may be share a register
>> with other things the driver needs to consider.
>> The IOMMU abstracts this for its devices, but this is still something the IOMMU driver
>> needs to know about.
>>
>> A driver hook, with a drivers/acpi fallback would be ideal.
>>
> 
> Building on James's callback suggestion, could the driver responsible
> for tagging register supported devices with resctrl? Common resctrl
> code could manage token lookup, group membership and assignment
> cleanup, while the driver supplies the ID-programming callback.
> 
> For illustration:
> 
>       static const struct resctrl_device_ops iommu_resctrl_ops = {
>           .set_ids = iommu_set_qos_ids,
>       };
> 
>       /* After the device's tagging state is ready. */
>       resctrl_device_register(dev, &iommu_resctrl_ops);
> 
>       /* Before releasing that state. */
>       resctrl_device_unregister(dev);
> 

There is a scenario where some devices simultaneously support
configuring the QOS ID on both the device side and the iommu side.
Therefore, we may need to maintain the ops as a linked list or manage
iommu_ops separately. :-)

> For IOMMU-managed devices, the IOMMU driver could handle registration
> and the callback, without changes to individual endpoint drivers.
> We have an early PoC along these lines, but it is not yet ready for
> an RFC.
> 
> A full sysfs path would identify the device unambiguously, but can
> be long and cumbersome to use. Perhaps a bus-qualified device name under
> `devices/`, such as `pci/<BDF>` or `platform/<name>`, could be an
> alternative?
> 
> The token format, sub-device contexts, hardware-defined groups,
> differing ID limits and detailed removal/error handling remain open.
> I would appreciate your thoughts on whether this could be a useful
> direction for a shared interface.
> 
>>
>> Do you have arbitrary grouping of devices? e.g. a USB controller and the UART.
>> Or would the grouping make some sense to the OS. e.g. all the USB devices behind
>> this port.
>>
>> Having the UART show up when you add a USB controller to a control group is a bit odd.
>>
>>
>>> ERDT provides
>>> MMIO addresses to read event counts for RMIDs and to configure cache allocation
>>> bit masks and memory bandwidth limits.
>>
>> Arm's IOMMU does have controls/monitors that match the spec the MPAM driver needs,
>> but we currently have no way to expose them through resctrl.
>> The caches on the IOMMU are also relatively small - I've not yet seen anyone show that
>> setting the controls there makes a big difference.
>>
>>
>>> 2) All I/O monitoring and control is with respect to I/O caches, not to the L3
>>> caches that legacy RDT features operate on.
>>
>> Do you have I/O traffic that can turn up in the CPU L3 cache? I think PCIe calls
>> this 'cache stashing'.
>>
>> Arm's IOMMU is the same - but the traffic may also show up in the L3 depending on how
>> the system is put together.
>>
>>
>>> 3) The number of RMIDs supported for I/O is lower (maybe considearbly lower)
>>> than the number supported for CPU monitoring.
>>
>> MPAM can have this happen - and today it will sanitise the values to the lowest
>> common value. Considerably lower becomes considerably upsetting!
>>
>> I'd be interested if we have an approach for this - the IOMMU designers would argue
>> they only need one RMID per device - but the system wide sanitised value means they
>> have to match the rest of the system.
>>
>>
>> For MPAM systems this shape is a big headache because on the platforms we've seen,
>> the monitoring is done at the memory-controllers - so any RMID spaces get joined
>> up eventually.
>>
>>
>>> 4) Monitoring events are I/O cache occupancy, total i/o bandwidth, and i/o miss
>>> bandwidth.
>>>
>>> 5) Current revision (1.4) of the specification doesn't include details of
>>> I/O memory bandwidth control (The "IBAD" subtable of ERDT is reserved for this).
>>>
>>>
>>> Fitting this into resctrl
>>> -------------------------
>>>
>>> RISC-V description of "architecture specific device tokens" sounds great.
>>> I'll have to find some ares of /sys to provide the mapping of tokens to
>>> "device groups".
>>> There's no association with IOMMUs, so this will be some
>>> other path in /sys. Perhaps under /sys/firmware/acpi since the data comes
>>> from ACPI IRDT table.
>>
>> What about using the device behind the IOMMU instead? Presumably the kernel
>> could allocate ids that don't clash with those in the IRDT, and use those
>> for the IOMMU.
>>
>>
>>> Need an info file to tell users the format and source for device tokens.
>>
>> I'd prefer we have one consistent way of doing this across architectures.
>> Especially if we're going to add something new to sysfs.
>>
>>
>> The sysfs path probably covers all bases - but I wouldn't want to parse that
>> in the kernel.
>>
>>
>>> I'd like to avoid limiting resctrl monitoring of CPU activity due to the small
>>> number of I/O RMIDs. Perhaps don't include a "devices" file or mon_data/{i/o
>>> events} files in resctrl group directories when rdtgroup::mon::rmid >=
>>> num_io_rmids? But that feels clumsy.
>>
>> I had a half baked idea on how to do this. (which Ben has poked some holes in)
>>
>> Assigning a device to a ctrl/mon group needs to be able to fail. We can use this
>> to re-allocate the RMID into the range the new device can use. The CPU tasks can
>> be repainted to use the new value - but the obvious problem is the old data in
>> the caches that uses the old RMID.
>> As no new traffic will be generated for that RMID, it might be possible to keep
>> it associated with the ctrl/mon group (which would now have two RMID) to keep the
>> user-space view of the counters correct until the old RMID falls below the
>> reallocation threshold, and it can be free'd.
>>
>> It's worse if we ever needed/wanted to do this with CLOSID. Two CAT bitmaps
>> can be configured the same - but MBA doesn't alias in the same way. Tasks would
>> be able to burst higher than the configured limit - but the size is limited by
>> the size of the caches. And if no new traffic can be generated with the old
>> CLOSID/RMID, then the effect can't be made to last forever.
>>
>>
>> For a totally wild suggestion (that I don't think works here) - I had
>> mooted having a second mount of resctrl for islands of the SoC where the
>> properties are different. I don't think it works in this case as the IO-RMID
>> presumably gets seen by some other monitors later.
>>
>>
>>> Domains are based on I/O L3 cache instances. So a new rdt_resource with
>>> new line in the schemata file for IOL3 cache masks per domain. In the
>>> future when there are I/O MBA controls, new line(s) for those too.
>>
>>
>> Thanks,
>>
>> James
>>
>>
>> [4] https://support.arm.com/documentation/ihi0069/hb/?lang=en search for "MPAM" in the pdf.
>>
>>>
>>> [1] https://lore.kernel.org/linux-iommu/20260901140802.1215508-1-xiaqinxin@huawei.com/
>>> [2] https://lore.kernel.org/lkml/20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com/
>>> [3] Linked from the bottom of https://www.intel.com/sdm under "Related Specifications", or
>>> direct link: https://cdrdv2.intel.com/v1/dl/getContent/789566?erpm_id=1158389_ts1790091453223
>>
> 
> Regards,
> 
> Zhanpeng

-- 
Thanks,
Qinxin

