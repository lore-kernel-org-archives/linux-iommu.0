Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEA930C142
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163905; cv=none; b=KdRjIsd5IYx1CyIlJ6jhSquXB2WZCPTd9x1hPoRl1//LoOy6zKSY65lewZbg4AXILYEvTPOZdwqciT2YqP3RgGanwRiOcaHjyjAh4OmaoRgCWQ6T08SkN/8Me+R1F8SJe7AMioHWFauI/omc4eZ56v0mdiAj7zM6vdmm9vPxQMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163905; c=relaxed/simple;
	bh=Fv4Qq52Od0IG4/8dw1STkdtFPA5yd3S8c31Fe9oTN7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ng4zEG7m3f1PT6bNtpgfGpr/ypbaGOAnGo7TkG50ZYxdMrQLI3R76OZijpbVGI+ANU9OwLeTkbOwy8jSIEEqDRmO8ZFoS+dXJUoRtQxsQODu7cxlPriMZrtGPVNMAmNCApmgW8nP9igPvULTb2HJtKVocPcPTVDaih1AemAu0Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WBKT8Pqx; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WBKT8Pqx"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5BA91682;
	Mon, 27 Jul 2026 07:51:37 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 275623F86F;
	Mon, 27 Jul 2026 07:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785163901; bh=Fv4Qq52Od0IG4/8dw1STkdtFPA5yd3S8c31Fe9oTN7E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WBKT8PqxYEsdfiqhz5lApHSw8bmvY8ZftVOYhzc7A9GWLBkAZK5ixHk/m/HgE/0sz
	 puonVk8rEZ95mq0umcLqb56wYu1fhTwkD83/uFOgJ/KDI3IQWhtESjZWXBPTy3d5Ur
	 Wt9HYMnpUnRlpINkpZ0BGKfYmdewHxd8E/RHLtJg=
Message-ID: <910d1492-ad3b-4201-93c6-208be1dcde7d@arm.com>
Date: Mon, 27 Jul 2026 15:51:32 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fixing TegraDRM on multi_v7_defconfig / Enabling DMA API with
 tegra-smmu
To: Mikko Perttunen <mperttunen@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-tegra@vger.kernel.org, "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <erKxvAxkSpOaODz6rOpDbQ@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <erKxvAxkSpOaODz6rOpDbQ@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/07/2026 8:35 am, Mikko Perttunen wrote:
> Greetings everyone.
> 
> I've been looking at enabling more CI for 32-bit Tegra platforms
> recently, and I ran into a problem with TegraDRM not probing on
> tegra30-cardhu, but only on multi_v7_defconfig.
> 
> I traced the issue to the following sequence of events:
> 
> 1. On multi_v7_defconfig, CONFIG_ARM_DMA_USE_IOMMU is enabled, while on
>     tegra_defconfig it is not. This causes arm_setup_iommu_dma_ops to run
>     on TegraDRM devices.
> 
> 2. Some of these devices will be placed in a single IOMMU group by the
>     tegra-smmu driver. When arm_setup_iommu_dma_ops is called, depending
>     on probe deferrals, the group may have only the currently probing
>     device, or a previously deferred device and the new device.
> 
>     arm_setup_iommu_dma_ops calls iommu_attach_device. If the device is
>     alone in its group, this succeeds. If not, this fails. If
>     iommu_attach_device fails for every device in the group, everything
>     is "fine" and TegraDRM goes to probe and work fine. Hence let's
>     assume we have one device that succeeded the attach.
> 
> 3. iommu_device_use_default_domain gets called and succeeds on the first
>     device in the group. On the second device in the group, it fails
>     since group->owner_cnt was already 1. The custom ARM DMA IOMMU
>     implementation uses a custom UNMANAGED domain so the domain !=
>     default_domain check evaluates to true.
> 
> 4. Devices fail to probe which leads TegraDRM overall not to probe.
> 
> I've thought of the following options to fix this:
> 
> 1. Match behavior with tegra_defconfig: Figure out a way to not run
>     arm_setup_iommu_dma_ops for this situation (ideally any multi-device
>     group situation). However, I'd also like to enable DMA API with
>     tegra-smmu to get rid of the manual IOMMU API code paths in TegraDRM,
>     so this is not a particularly satisfying route.
> 
> 2. Improve the legacy path: Fix the ARM IOMMU DMA code to support
>     groups, and add an exception in iommu_device_use_default_domain. But
>     I presume we don't want such non-trivial modifications to that code
>     at this point.
> 
> 3. Modernize: Support CONFIG_IOMMU_DMA on ARM -- since there is an issue
>     with per-SoC quirks, I think this should be done one SoC at a time.
>     So come up with a way to dynamically pick between the legacy and
>     IOMMU_DMA paths. Perhaps if the SMMU driver explicitly requests the
>     DMA domain type, use the modern path. Currently, CONFIG_IOMMU_DMA and
>     CONFIG_ARM_DMA_USE_IOMMU are mutually exclusive so that has to be
>     changed.
> 
> FWIW, if we are to move to using DMA API with TegraDRM, one blocker
> would have to be resolved: boot splashes scanning out while the DMA
> domain is being set up. Since we cannot really use the iommu-addresses
> reserved-region device tree bindings with these old devices, my thought
> is to leave the display memory clients in bypass in tegra-smmu until the
> display driver has quiesced the hardware and can then call into
> tegra-smmu to enable translation.
> 
> Please let me know what you think and whom I missed in the To/Cc fields.

TBH I rather feel like the time for converting ARM to iommu-dma has 
passed - there are drivers which rely on specific behaviours of the ARM 
IOVA allocator which iommu-dma does not match, and meanwhile iommu-dma 
continues to grow more server-specific features which would be nothing 
but bloat on ARMv7 systems with <=2GB of RAM and no virtualisation. At 
this point I'm inclined to treat the existing DMA ops as legacy code 
like with alpha/sparc/etc.

While there is technically an option 4, to have tegra-smmu do what 
ipmmu-vmsa and mtk_iommu_v1 do and go coercing the ARM dma_iommu_mapping 
into groups behind the arch code's back, I am also still hoping to get 
rid of that and the messy probe_finalize step altogether. FWIW my 
preference would be some form of option 2 - off-hand I imagine you could 
probably get most of the way there by propagating the ARM mapping 
through group->iommudata (ironically tegra-smmu being the only driver in 
the way of that - looks like it could probably do its internal group 
accounting explicitly in release_device instead), plus one or two 
special cases to recognise ARM DMA domains in the core code as you say. 
The more involved, but ultimately neater, option would be to turn the 
ARM mapping inside-out and make it a proper domain cookie type with the 
ARM code providing its own definitions of iommu_{get,put}_dma_cookie() 
and iommu_setup_dma_ops(), so it could then work as a proper 
IOMMU_DOMAIN_DMA default domain, and we can lose the current 
ARM-specific identity domain bodges as well. I reckon the impact of that 
to core code shouldn't be much worse than the existing special-cases it 
would replace, while on the arch side it should effectively only really 
redistribute the current arm_setup_iommu_dma_ops() path, so functionally 
pretty low risk as well. It's just liable to be fiddly to do in 
manageable steps rather than one giant patch changing everything at once...

Cheers,
Robin.
