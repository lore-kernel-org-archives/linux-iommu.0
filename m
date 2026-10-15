Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F153909A8
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 03:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035980; cv=pass; b=dAZYVND/acVpvodowhHmPNAG7tXK7G4GmJWAN4oqReIoQ21aV3z7NCNZ2/Di95c5o+RCkE72Mal4lWllwXIarc8IvDtDxUmQ61h0UKZTwqyS71flagCEhaTEGpMjccXguM7uK3AdVqQZEwHqvkyfazuxGY7dUMbdKkOoUjOv52w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035980; c=relaxed/simple;
	bh=vCYUKF1CW9W6XFavsMsHK0R2Tch2/Pg+Paf9MP4MWg8=;
	h=From:In-Reply-To:Mime-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iF96i9pc6ODx3OPk9f9rf+IfdE86XHjvV3cl0npBqE2ST0kYCgN7+svKpIasfR5e7KSM/sreAzWpplKJshu+CFlCCqES9qCQcDC/PiHW18Gwc5EgZYiDiLZbRoQugvVM7GJH83tx+7XxX8fI3GKaQr9xBHFPvrqFdO/Bekmwev0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iMgKH4F7; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iMgKH4F7"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5ba4180a65aso4381182e87.2
        for <iommu@lists.linux.dev>; Wed, 14 Oct 2026 20:46:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792035972; cv=none;
        d=google.com; s=arc-20260327;
        b=nnELYvipFzFTAQLWgdcijYWPlZCHHevEf0AXctZbhWWczIUKXFTtzCMfOTF1/bI7hx
         RXnDfZtmQndc/JvSuQWqcpebCKQ+mLfAJ3rhlEHKg/sY35yeFuV2YoaVcQ0p4IvgGvYc
         ngCgOv1uysUeIyAzkbo30w9cjKzQ+GZpKiXRmOx4DyJ0gZuV1vGx3Sv0YJ4/JhmuQYlU
         j21y78JXbtnffjRPJnpKYsmGXGzetzPFRWKSLvoH0GcTD8THR4SrpeJLiGaUAWdczG7a
         XJY3AFnF2ZTxE1Ele0Zoh8FH3QPWlkewXcC9ziXnadR42ZYFHkCBHy7N72FuOBolN5Bx
         vlLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:user-agent:dkim-signature;
        bh=d+21BlRaonYej0puQeH33HEePTVzDShA+6xV7c9sZ/A=;
        fh=GqUDMTJLvCdQ7bPe9diIGcuXey/4IKo6TZuTKJUN0C8=;
        b=JZrqIyeoEeFQTxUW+8ILiSC1rLYbGpPBYGERzhivVtd5rE0+S691qAZT7XZLK9le9D
         qxo87is5DmiS6tdECd/2zhwkAv3ucdZ4+ieHyWmBDmbZjDIW822KO0zvPRiVjj5jKBe4
         P54QTJOuSdgZKyJO+ncHT7u7UwTQu9iEeXvuHc0tNw+uH8grmAB+8DkCGCc44PK066YE
         EYdBpQVz0W00T95sh3uWQUFw+UpgV7xJKrG7cj0mmNM403DxG+D3zzXk+ctTRHLDxqXR
         RwLfRev5iZrR05coDsKWl0k9tBdh1WQ2MP9/FVUVNu3oCDpseZadwiaHmE3+3+LTawlj
         Yk4w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1792035971; x=1792640771; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:references:mime-version
         :in-reply-to:from:user-agent:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=d+21BlRaonYej0puQeH33HEePTVzDShA+6xV7c9sZ/A=;
        b=iMgKH4F7wlWcqbDEzCNYXYfaOii0pfDzUas9nQG+RxRnAIw+STEYB/wIa1sJHXSWWc
         pl2vi+YPMURWcU0yD/XkYSnVwunb7NYcxUbc4XO/JV4KqE7pUv4BR7CS1r7JeQHJx9Hb
         kglNMypIIAwK6NYMTqEJlmtY6lxbnH/KluDsE580E9eHByrNyKkyUyaWAG6QUmgfSB2T
         R5qCGNw1VgjV+ac3958jXFCwC5nvIruPvERALlVJvVPwrjVfimt8TvHiC9V1mAoKsSLX
         6S8icmXRSHNhPc540jJWz9tcZjkMideidRuRcwzjYs/fOLwB80+YsNtSnlOYql4w4kcH
         LuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792035971; x=1792640771;
        h=content-type:cc:to:subject:message-id:date:references:mime-version
         :in-reply-to:from:user-agent:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d+21BlRaonYej0puQeH33HEePTVzDShA+6xV7c9sZ/A=;
        b=IclcjDD+Lpme246OmNIls4cq880v+oIqrrCzyach4LYii4TfbaOZyhFzYrwT/SKLxn
         GzLJz8IVx3M6AAEBQhoTdIHUmRaBhwFeZjHI6Vl3QH7KxwlaFrS0p4+HSXnC/NIesI8o
         bC1R9RzyMM/ACbta6K1hG62MufDAPOjydV2ugngYohZ8lt1EHlaBzwapfvjzhSYpbfVc
         3mHgJZYquB2VjYw+YZ1AXjg64XPXer+Po4m2X639YNapxX+jbABzC7Xr2Ebh3OMoJ9Gd
         NI/bABytapqs2nbh9bAZD1tzZbUsCC9kDXJ64urApGO4ph/dg6jF4wG3t+/n/a2CWRkz
         2t9g==
X-Forwarded-Encrypted: i=1; AKwUvByZCx3wZrahekoa4LgvlvAr8c7Som4nQlRo3zanbYIRJhCo+lUdtMGCjM0qTIje15b1ehc0DA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKlorvKbWseB95I62rpfl+pp+WZJyG7qpiM818uAKMP6pnCv/9d
	G4qR4NBVBzGyPJCh/NhanEes4vfxWJCQxjZQ6Vr46MN5SOe9fEISq9V4MG36w3Bcla79V7/YdST
	N5z9PgVnaafl6NJOt5RaA3p0bImSR+6FaFkRh/4uhPQ==
X-Gm-Gg: AYBFou0Pds7JeHkFnXxa0WNUtS63XZ0iYQYTK9lTT4woJ016GDPLa4MCSKMM0uGwqzr
	j/DHIBE/NPkkwXxLwDo5S/KHv2wcApSgDueScFy1UIjtZOkxsW39yx452xc7eKqcwUlxSo4WMc7
	MHsLnflHhuz6EBCZ1nZkXlISq3aoWifhCc/sNgQhpeWj42iFKm4HxgFZxdgtR36o2RHhPC+OYHH
	BFaLgA/bZQOwmpSTDlS7ueaJpOcupAzk25Plg62+0g6BbK48NTFmvdhJyAyxq3n1HY2sgJJ4zeF
	VCXKS/jrrayttVAjpyG4ik+6+KgvZBXI+pXTxZnxboaf2iFFwb4l4yU4
X-Received: by 2002:a05:6512:3c8c:b0:5b8:f52b:8119 with SMTP id
 2adb3069b0e04-5bcde6c3488mr6491386e87.28.1792035971468; Wed, 14 Oct 2026
 20:46:11 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 14 Oct 2026 20:46:09 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 14 Oct 2026 20:46:09 -0700
User-Agent: Mozilla Thunderbird
X-Original-From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
In-Reply-To: <8557363f-c051-4267-9fbc-f4cbb13ac35e@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <arKx__kOPe4B5gDW@agluck-desk3> <8557363f-c051-4267-9fbc-f4cbb13ac35e@arm.com>
Date: Wed, 14 Oct 2026 20:46:09 -0700
X-Gm-Features: AclHuK-ifaTyE672LcfsNG1D0uvyO2aZ3Fent-KaK1PQbFh3W9LBjWXPCPycr_o
Message-ID: <CACnXVnfJvJXm58TRd92q0j2FuAt8=SYLvXn_8aYk9qNoBFj+Zw@mail.gmail.com>
Subject: Re: Resctrl and I/O
To: James Morse <james.morse@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Luck Tony <tony.luck@intel.com>, 
	xiaqinxin@huawei.com, reinette.chatre@intel.com
Cc: x86@kernel.org, iommu@lists.linux.dev, linuxarm@huawei.com, alex@ghiti.fr, 
	corbet@lwn.net, tomasz.jeznach@linux.dev, robin.murphy@arm.com, 
	fustini@kernel.org, baolin.wang@linux.alibaba.com, aou@eecs.berkeley.edu, 
	pjw@kernel.org, linux-kernel@vger.kernel.org, babu.moger@amd.com, 
	wangzhou1@hisilicon.com, linux-riscv@lists.infradead.org, will@kernel.org, 
	joro@8bytes.org, kevin.tian@intel.com, yuanzhu@bytedance.com, 
	cuiyunhui@bytedance.com, zengheng4@huawei.com, palmer@dabbelt.com, 
	shuah@kernel.org, ben.horgan@arm.com, Dave.Martin@arm.com
Content-Type: text/plain; charset="UTF-8"

Hi all,

Thank you for the helpful discussion, and sorry for the late reply.

On 9/24/26 1:13 AM, James Morse wrote:
> Hi Tony,
>
> On 22/09/2026 17:51, Luck, Tony wrote:
>> Patches for ARM[1] and RISC-V[2] are both at RFC status.
>>
>> They appear to be based on similar h/w capabilities where architecture
>> specific tags can be added to transactions from I/O devices by the IOMMU
>> servicing the device. Device enumeration is handled outside of the resctrl
>> file system.
>>
>> ARM docs say "the device name is the one listed under /sys/kernel/iommu_groups/<id>/devices/"
>
> I think using existing stuff in sysfs is a good idea.
> (Creating new things in sysfs fills me with dread!)
>
> ARM/MPAM also has platform devices that can add the CLOSID/RMID metadata.
> e.g. the GIC ITS [4] - a kind of translator for MSIs.
>
> For these we considered just using the device name as found in /sys/bus/platform/devices/,
> in the hope that can be tied back to a struct device - and we could add a callback for
> resctrl to configure the device with a CLOSID/RMID.
> (but - I've not seen a use-case for this yet - those devices generate very little traffic)
> >
> Robin M set me straight on the iommu_group:
> Strictly that is the wrong abstraction as devices are in the same group if the
> driver can't stop them communicating, e.g. PCIe peer2peer. This doesn't mean it
> can't tell the traffic apart for CLOSID/RMID labelling.
> I picked this because its the device granularity VFIO works with.
>
> Equally, a device may create multiple streams of traffic, where only the driver
> will know what each one corresponds to.
>
>
> Using iommu_group like this may need a bit more thinking....

I agree. DMA isolation groups do not necessarily match the granularity
at which QoS IDs can be assigned.

> If we can fall back to using a device as seen by sysfs, then the arch differences
> here could be invisible to user-space.
>
>
>> RISC-V says architecture specific device tokens are "devices or device groups"
>>
>> In both cases assignments are made with:
>>
>> 	# echo {device} > {group}/devices
>>
>> So now I'm looking at the capabilities of Intel RDT hardware. I'm ignoring
>> the implementation on the Granite Rapids CPU, and looking at what is described
>> in the RDT Architecture Specification[3]. Here are the highlights:
>
>
>> 1) Enumeration is split between two ACPI tables. IRDT enumerates device groups
>> and provides MMIO addresses to assign CLOSID/RMID to each group.
>
> For ARM/MPAM - this would always be driver specific. The fields may be share a register
> with other things the driver needs to consider.
> The IOMMU abstracts this for its devices, but this is still something the IOMMU driver
> needs to know about.
>
> A driver hook, with a drivers/acpi fallback would be ideal.
>

Building on James's callback suggestion, could the driver responsible
for tagging register supported devices with resctrl? Common resctrl
code could manage token lookup, group membership and assignment
cleanup, while the driver supplies the ID-programming callback.

For illustration:

     static const struct resctrl_device_ops iommu_resctrl_ops = {
         .set_ids = iommu_set_qos_ids,
     };

     /* After the device's tagging state is ready. */
     resctrl_device_register(dev, &iommu_resctrl_ops);

     /* Before releasing that state. */
     resctrl_device_unregister(dev);

For IOMMU-managed devices, the IOMMU driver could handle registration
and the callback, without changes to individual endpoint drivers.
We have an early PoC along these lines, but it is not yet ready for
an RFC.

A full sysfs path would identify the device unambiguously, but can
be long and cumbersome to use. Perhaps a bus-qualified device name under
`devices/`, such as `pci/<BDF>` or `platform/<name>`, could be an
alternative?

The token format, sub-device contexts, hardware-defined groups,
differing ID limits and detailed removal/error handling remain open.
I would appreciate your thoughts on whether this could be a useful
direction for a shared interface.

>
> Do you have arbitrary grouping of devices? e.g. a USB controller and the UART.
> Or would the grouping make some sense to the OS. e.g. all the USB devices behind
> this port.
>
> Having the UART show up when you add a USB controller to a control group is a bit odd.
>
>
>> ERDT provides
>> MMIO addresses to read event counts for RMIDs and to configure cache allocation
>> bit masks and memory bandwidth limits.
>
> Arm's IOMMU does have controls/monitors that match the spec the MPAM driver needs,
> but we currently have no way to expose them through resctrl.
> The caches on the IOMMU are also relatively small - I've not yet seen anyone show that
> setting the controls there makes a big difference.
>
>
>> 2) All I/O monitoring and control is with respect to I/O caches, not to the L3
>> caches that legacy RDT features operate on.
>
> Do you have I/O traffic that can turn up in the CPU L3 cache? I think PCIe calls
> this 'cache stashing'.
>
> Arm's IOMMU is the same - but the traffic may also show up in the L3 depending on how
> the system is put together.
>
>
>> 3) The number of RMIDs supported for I/O is lower (maybe considearbly lower)
>> than the number supported for CPU monitoring.
>
> MPAM can have this happen - and today it will sanitise the values to the lowest
> common value. Considerably lower becomes considerably upsetting!
>
> I'd be interested if we have an approach for this - the IOMMU designers would argue
> they only need one RMID per device - but the system wide sanitised value means they
> have to match the rest of the system.
>
>
> For MPAM systems this shape is a big headache because on the platforms we've seen,
> the monitoring is done at the memory-controllers - so any RMID spaces get joined
> up eventually.
>
>
>> 4) Monitoring events are I/O cache occupancy, total i/o bandwidth, and i/o miss
>> bandwidth.
>>
>> 5) Current revision (1.4) of the specification doesn't include details of
>> I/O memory bandwidth control (The "IBAD" subtable of ERDT is reserved for this).
>>
>>
>> Fitting this into resctrl
>> -------------------------
>>
>> RISC-V description of "architecture specific device tokens" sounds great.
>> I'll have to find some ares of /sys to provide the mapping of tokens to
>> "device groups".
>> There's no association with IOMMUs, so this will be some
>> other path in /sys. Perhaps under /sys/firmware/acpi since the data comes
>> from ACPI IRDT table.
>
> What about using the device behind the IOMMU instead? Presumably the kernel
> could allocate ids that don't clash with those in the IRDT, and use those
> for the IOMMU.
>
>
>> Need an info file to tell users the format and source for device tokens.
>
> I'd prefer we have one consistent way of doing this across architectures.
> Especially if we're going to add something new to sysfs.
>
>
> The sysfs path probably covers all bases - but I wouldn't want to parse that
> in the kernel.
>
>
>> I'd like to avoid limiting resctrl monitoring of CPU activity due to the small
>> number of I/O RMIDs. Perhaps don't include a "devices" file or mon_data/{i/o
>> events} files in resctrl group directories when rdtgroup::mon::rmid >=
>> num_io_rmids? But that feels clumsy.
>
> I had a half baked idea on how to do this. (which Ben has poked some holes in)
>
> Assigning a device to a ctrl/mon group needs to be able to fail. We can use this
> to re-allocate the RMID into the range the new device can use. The CPU tasks can
> be repainted to use the new value - but the obvious problem is the old data in
> the caches that uses the old RMID.
> As no new traffic will be generated for that RMID, it might be possible to keep
> it associated with the ctrl/mon group (which would now have two RMID) to keep the
> user-space view of the counters correct until the old RMID falls below the
> reallocation threshold, and it can be free'd.
>
> It's worse if we ever needed/wanted to do this with CLOSID. Two CAT bitmaps
> can be configured the same - but MBA doesn't alias in the same way. Tasks would
> be able to burst higher than the configured limit - but the size is limited by
> the size of the caches. And if no new traffic can be generated with the old
> CLOSID/RMID, then the effect can't be made to last forever.
>
>
> For a totally wild suggestion (that I don't think works here) - I had
> mooted having a second mount of resctrl for islands of the SoC where the
> properties are different. I don't think it works in this case as the IO-RMID
> presumably gets seen by some other monitors later.
>
>
>> Domains are based on I/O L3 cache instances. So a new rdt_resource with
>> new line in the schemata file for IOL3 cache masks per domain. In the
>> future when there are I/O MBA controls, new line(s) for those too.
>
>
> Thanks,
>
> James
>
>
> [4] https://support.arm.com/documentation/ihi0069/hb/?lang=en search for "MPAM" in the pdf.
>
>>
>> [1] https://lore.kernel.org/linux-iommu/20260901140802.1215508-1-xiaqinxin@huawei.com/
>> [2] https://lore.kernel.org/lkml/20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com/
>> [3] Linked from the bottom of https://www.intel.com/sdm under "Related Specifications", or
>> direct link: https://cdrdv2.intel.com/v1/dl/getContent/789566?erpm_id=1158389_ts1790091453223
>

Regards,

Zhanpeng
