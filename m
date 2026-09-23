Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A470357D18
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790183617; cv=none; b=WvcSUCXj7/Xw1VoxzCeQAQ1kyWmSwKFgrcRgywI/bbAemyToLdJM6AdzrgmhGpEufcJEYkLnRwDZZ9HgOpUl7GWfm6aLOHYgWkrtwM02G5qMTjv83BL51DoetahHSRGfSjx6jD0Z11rj5Y+Qu/PsaEtqJaYeWuRjsHrgx7qEUD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790183617; c=relaxed/simple;
	bh=kKcD10YfKOjOhO9AKT3lVc0OW49OXp0A436pFWlkGLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OrnzZrDFj68Ywp3P26yxOqLXk10EDtrbocCua+rT+QIIjr1x7ue+rcdiaC7ke0nnuMhFEX8s1nFzpussPpSXZeX6e7w707EgSPYzIMKcAqzsRHUsJ9cXY1cWem9himQaJERO14DlsQxV+snd0/yD9+u5BWPDxE3c94MBaSyKnHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BiP5lkrw; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BiP5lkrw"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F8A81516;
	Wed, 23 Sep 2026 10:13:31 -0700 (PDT)
Received: from [10.2.212.14] (eglon.cambridge.arm.com [10.2.212.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA8BD3F86F;
	Wed, 23 Sep 2026 10:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790183614; bh=kKcD10YfKOjOhO9AKT3lVc0OW49OXp0A436pFWlkGLI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BiP5lkrwxmpdxyCbk6P86k78M9Kgakg9p+nsaf8PZq4oMzj2ad2rt5NQahRnjGXXZ
	 V3xG7GTOgW1/4Er2gN9+bcdck3szQz//EpUmB8jwKqEGSmYSPq4JAyR3XIIe3Inxtw
	 6lfn/OBUESxDFn5SNVMOtLj+aP3Ld8710wcNABjE=
Message-ID: <8557363f-c051-4267-9fbc-f4cbb13ac35e@arm.com>
Date: Wed, 23 Sep 2026 18:13:27 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Resctrl and I/O
To: "Luck, Tony" <tony.luck@intel.com>, alex@ghiti.fr, aou@eecs.berkeley.edu,
 babu.moger@amd.com, baolin.wang@linux.alibaba.com, ben.horgan@arm.com,
 corbet@lwn.net, cuiyunhui@bytedance.com, Dave.Martin@arm.com,
 fustini@kernel.org, jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com,
 palmer@dabbelt.com, pjw@kernel.org, reinette.chatre@intel.com,
 robin.murphy@arm.com, shuah@kernel.org, tomasz.jeznach@linux.dev,
 wangzhou1@hisilicon.com, will@kernel.org, xiaqinxin@huawei.com,
 yuanzhu@bytedance.com, zengheng4@huawei.com,
 zhangzhanpeng.jasper@bytedance.com
Cc: x86@kernel.org, iommu@lists.linux.dev, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <arKx__kOPe4B5gDW@agluck-desk3>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <arKx__kOPe4B5gDW@agluck-desk3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Tony,

On 22/09/2026 17:51, Luck, Tony wrote:
> Patches for ARM[1] and RISC-V[2] are both at RFC status.
> 
> They appear to be based on similar h/w capabilities where architecture
> specific tags can be added to transactions from I/O devices by the IOMMU
> servicing the device. Device enumeration is handled outside of the resctrl
> file system.
> 
> ARM docs say "the device name is the one listed under /sys/kernel/iommu_groups/<id>/devices/"

I think using existing stuff in sysfs is a good idea.
(Creating new things in sysfs fills me with dread!)

ARM/MPAM also has platform devices that can add the CLOSID/RMID metadata.
e.g. the GIC ITS [4] - a kind of translator for MSIs.

For these we considered just using the device name as found in /sys/bus/platform/devices/,
in the hope that can be tied back to a struct device - and we could add a callback for
resctrl to configure the device with a CLOSID/RMID.
(but - I've not seen a use-case for this yet - those devices generate very little traffic)


Robin M set me straight on the iommu_group:
Strictly that is the wrong abstraction as devices are in the same group if the
driver can't stop them communicating, e.g. PCIe peer2peer. This doesn't mean it
can't tell the traffic apart for CLOSID/RMID labelling.
I picked this because its the device granularity VFIO works with.

Equally, a device may create multiple streams of traffic, where only the driver
will know what each one corresponds to.


Using iommu_group like this may need a bit more thinking....
If we can fall back to using a device as seen by sysfs, then the arch differences
here could be invisible to user-space.


> RISC-V says architecture specific device tokens are "devices or device groups"
> 
> In both cases assignments are made with:
> 
> 	# echo {device} > {group}/devices
> 
> So now I'm looking at the capabilities of Intel RDT hardware. I'm ignoring
> the implementation on the Granite Rapids CPU, and looking at what is described
> in the RDT Architecture Specification[3]. Here are the highlights:


> 1) Enumeration is split between two ACPI tables. IRDT enumerates device groups
> and provides MMIO addresses to assign CLOSID/RMID to each group.

For ARM/MPAM - this would always be driver specific. The fields may be share a register
with other things the driver needs to consider.
The IOMMU abstracts this for its devices, but this is still something the IOMMU driver
needs to know about.

A driver hook, with a drivers/acpi fallback would be ideal.


Do you have arbitrary grouping of devices? e.g. a USB controller and the UART.
Or would the grouping make some sense to the OS. e.g. all the USB devices behind
this port.

Having the UART show up when you add a USB controller to a control group is a bit odd.


> ERDT provides
> MMIO addresses to read event counts for RMIDs and to configure cache allocation
> bit masks and memory bandwidth limits.

Arm's IOMMU does have controls/monitors that match the spec the MPAM driver needs,
but we currently have no way to expose them through resctrl.
The caches on the IOMMU are also relatively small - I've not yet seen anyone show that
setting the controls there makes a big difference.


> 2) All I/O monitoring and control is with respect to I/O caches, not to the L3
> caches that legacy RDT features operate on.

Do you have I/O traffic that can turn up in the CPU L3 cache? I think PCIe calls
this 'cache stashing'.

Arm's IOMMU is the same - but the traffic may also show up in the L3 depending on how
the system is put together.


> 3) The number of RMIDs supported for I/O is lower (maybe considearbly lower)
> than the number supported for CPU monitoring.

MPAM can have this happen - and today it will sanitise the values to the lowest
common value. Considerably lower becomes considerably upsetting!

I'd be interested if we have an approach for this - the IOMMU designers would argue
they only need one RMID per device - but the system wide sanitised value means they
have to match the rest of the system.


For MPAM systems this shape is a big headache because on the platforms we've seen,
the monitoring is done at the memory-controllers - so any RMID spaces get joined
up eventually.


> 4) Monitoring events are I/O cache occupancy, total i/o bandwidth, and i/o miss
> bandwidth.
> 
> 5) Current revision (1.4) of the specification doesn't include details of
> I/O memory bandwidth control (The "IBAD" subtable of ERDT is reserved for this).
> 
> 
> Fitting this into resctrl
> -------------------------
> 
> RISC-V description of "architecture specific device tokens" sounds great.
> I'll have to find some ares of /sys to provide the mapping of tokens to
> "device groups".
> There's no association with IOMMUs, so this will be some
> other path in /sys. Perhaps under /sys/firmware/acpi since the data comes
> from ACPI IRDT table.

What about using the device behind the IOMMU instead? Presumably the kernel
could allocate ids that don't clash with those in the IRDT, and use those
for the IOMMU.


> Need an info file to tell users the format and source for device tokens.

I'd prefer we have one consistent way of doing this across architectures.
Especially if we're going to add something new to sysfs.


The sysfs path probably covers all bases - but I wouldn't want to parse that
in the kernel.


> I'd like to avoid limiting resctrl monitoring of CPU activity due to the small
> number of I/O RMIDs. Perhaps don't include a "devices" file or mon_data/{i/o
> events} files in resctrl group directories when rdtgroup::mon::rmid >=
> num_io_rmids? But that feels clumsy.

I had a half baked idea on how to do this. (which Ben has poked some holes in)

Assigning a device to a ctrl/mon group needs to be able to fail. We can use this
to re-allocate the RMID into the range the new device can use. The CPU tasks can
be repainted to use the new value - but the obvious problem is the old data in
the caches that uses the old RMID.
As no new traffic will be generated for that RMID, it might be possible to keep
it associated with the ctrl/mon group (which would now have two RMID) to keep the
user-space view of the counters correct until the old RMID falls below the
reallocation threshold, and it can be free'd.

It's worse if we ever needed/wanted to do this with CLOSID. Two CAT bitmaps
can be configured the same - but MBA doesn't alias in the same way. Tasks would
be able to burst higher than the configured limit - but the size is limited by
the size of the caches. And if no new traffic can be generated with the old
CLOSID/RMID, then the effect can't be made to last forever.


For a totally wild suggestion (that I don't think works here) - I had
mooted having a second mount of resctrl for islands of the SoC where the
properties are different. I don't think it works in this case as the IO-RMID
presumably gets seen by some other monitors later.


> Domains are based on I/O L3 cache instances. So a new rdt_resource with
> new line in the schemata file for IOL3 cache masks per domain. In the
> future when there are I/O MBA controls, new line(s) for those too.


Thanks,

James


[4] https://support.arm.com/documentation/ihi0069/hb/?lang=en search for "MPAM" in the pdf.

> 
> [1] https://lore.kernel.org/linux-iommu/20260901140802.1215508-1-xiaqinxin@huawei.com/
> [2] https://lore.kernel.org/lkml/20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com/
> [3] Linked from the bottom of https://www.intel.com/sdm under "Related Specifications", or
> direct link: https://cdrdv2.intel.com/v1/dl/getContent/789566?erpm_id=1158389_ts1790091453223

