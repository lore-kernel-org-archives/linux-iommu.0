Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC9D345CBE
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 16:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293039; cv=none; b=cwZ7+dNZ1y5HsuvLOGVK4iyfxQUT6737zpsj0xv06+jyE9pu2fWicY22nC9upinWB0QTbm2Zg/8KHwDq9OpjylDb7hHSUAL+nX8N7NI+rdt8PjM9I9sQHJFR4ZBJL2IG6GCKo/DWBnfUUlyOa2J9GRrePw9Q19zMrN5oLduO7xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293039; c=relaxed/simple;
	bh=wT0Kf9XYz5aihDzOJ28mIvVStKTBggksUVtIvMXrrBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ww3NraAaaEk4IN+rLnSk7IKkHh5z19DS/X/S9yHf5NuUO4+/r6XasP3qQuMy1h9JcPWwzaHVcrDhVSTyfHVgC69TZZcHkdNT1+p9epXbwEs8UP37M47yUw3775zwCpUmniySn7PWWo8Z+CSMcSmCP2uQHEYiFoblXW1C8EFRtcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QFSHEz8h; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QFSHEz8h"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DC282936;
	Wed, 20 May 2026 09:03:51 -0700 (PDT)
Received: from [10.57.34.79] (unknown [10.57.34.79])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 488A63F7B4;
	Wed, 20 May 2026 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779293036; bh=wT0Kf9XYz5aihDzOJ28mIvVStKTBggksUVtIvMXrrBw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QFSHEz8huXoTn6S3CeR0sEceXExvaU7/foYh7978ty6GnYVdS0LLPBBXGYvYBCznB
	 yJLIPZzsKmtk2mGKCTtI/v4udgKiawrimm6BQ7nTvfw7SP2mwg4vqqUdS5rodIT5U2
	 86EwP5usGE3/+l/b82aaXBBjKIevxRTkCMXoTdZg=
Message-ID: <c50a527c-83e7-439b-95a0-a38235c24de6@arm.com>
Date: Wed, 20 May 2026 17:03:49 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/riscv: prefer WSI on IGS=BOTH when wired IRQs are
 described
To: fangyu.yu@linux.alibaba.com
Cc: ajones@ventanamicro.com, alex@ghiti.fr, andrew.jones@oss.qualcomm.com,
 aou@eecs.berkeley.edu, guoren@kernel.org, iommu@lists.linux.dev,
 joro@8bytes.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, palmer@dabbelt.com, pjw@kernel.org,
 sunilvl@oss.qualcomm.com, tomasz.jeznach@linux.dev, will@kernel.org
References: <7dc61855-d916-4659-8137-7f3457f6a56d@arm.com>
 <20260520134416.28552-1-fangyu.yu@linux.alibaba.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260520134416.28552-1-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-05-20 2:44 pm, fangyu.yu@linux.alibaba.com wrote:
>>>> Won't it change the DT behavior as it doesn't check msi-parent
>>>> anymore?  IOW, should this be made specific to ACPI
>>>> by checking whether the device node is acpi node?
>>>>
>>>
>>> Thanks for the review, you're right that the current condition would
>>> affect DT as well.
>>>
>>> My assumption was that DT would describe either "interrupts" for WSI
>>> or "msi-parent" for MSI, but not both, so platform_irq_count() > 0
>>> would effectively imply "no msi-parent" in practice.
>>>
>>> That said, I agree that this should be limited to the ACPI path. That
>>> matches the actual bug scope — only ACPI was falling back to MSI when
>>> wired IRQs were described — and leaves DT unchanged.
>>>
>>> I'll respin a v2 to scope the fix to ACPI only, and tighten the commit
>>> message accordingly.
>>
>> Why would this be specific to ACPI? AFAICS if DT specifies an
>> "msi-parent" property such that an MSI domain exists, then MSIs will be
>> preferred as well, since the entire function is structured to prefer
>> MSIs if available, and fall back to wired if not. If the system does
>> support both options then DT should describe that, same as ACPI; what
>> Linux chooses to use is entirely Linux's own policy.
>>
>> But if you do want to change the Linux driver's policy for some reason
>> that the commit message isn't really explaining, then rearrange the
>> whole switch statement; don't just add a weird hack to try to defeat the
>> existing logic _in the same function_...
>>
>> In general though, I would have thought preferring MSIs makes the most
>> sense, since MSI vectors are generally cheaper than wires, so there's a
>> better chance of being able to have unique IRQs per interrupt source,
>> whereas with wires you may be stuck with a combined IRQ.
> 
> Thanks, Robin.
> 
> To clarify, the goal here is not to change the general MSI-vs-WSI
> preference policy. The bug is that, when the hardware advertises
> IGS=BOTH, DT already provides a way to select WSI by describing wired
> IRQs without an msi-parent,

And my point is that that sounds wrong - if the system can support both 
then DT should have both properties, because DT describes the system, 
not Linux policy. Of course it is presumably possible to have a reusable 
IOMMU IP that itself supports IGS=BOTH, integrated into systems which 
either don't have an MSI controller, or haven't connected the wires, in 
which case only one or other property is valid to describe anyway, but 
that's fine - IGS describes what the IOMMU is capable of sending, the 
firmware properties describe what the rest of the system is capable of 
receiving, and if there's any choice left in the intersection of the two 
then that's up to the OS.

> but the ACPI path does not currently have
> an equivalent way to steer the driver to WSI.
> 
>      - DT: if "msi-parent" is omitted, of_msi_get_domain() returns NULL,
>        IGS=BOTH then falls through to the WSI path, so DT has a real knob
>        ("don't describe MSI") to select WSI.
>      - ACPI: there is no per-device equivalent. On systems with IMSIC, the
>        IGS=BOTH IOMMU always enters the MSI branch and resolves a non-NULL
>        msi_domain, regardless of what its own _CRS describes. The MSI fallback
>        only triggers when the system has no IMSIC at all, which is a
>        firmware-wide decision rather than a per-device one.
> 
> As a result, with ACPI and IGS=BOTH, the driver always uses MSI even when
> firmware describes wired IRQs, so the platform cannot express the same
> intent as it can with DT.

What do you mean by "intent"? Again, people should not be hacking 
firmware just to influence OS driver policy.

If you mean you have a case where a system does have an MSI controller, 
and a device which is capable of emitting MSIs, but the device's MSI 
writes cannot reach that MSI controller, and ACPI is incapable of 
describing that so Linux ends up incorrectly assuming that MSIs should 
work, then you have a spec-level ACPI problem and you need to fix RIMT 
and/or any other relevant tables/properties to be able to indicate that 
properly; bodging the Linux IOMMU driver alone does not help other OSes, 
nor even other MSI-capable devices under Linux.

Amusingly, that would then be the opposite problem from what we had with 
Arm SMMU, where initially we couldn't use MSIs with ACPI at all since 
early IORT version had no way to describe the necessary GIC DeviceID :)

> So this patch is meant to fix that ACPI gap for IGS=BOTH, not to make
> WSI generally preferred over MSI. I agree the commit message should
> make that bug scope explicit.

But even then it does change the policy in general for all ACPI systems 
that genuinely do have both and could happily still use MSIs.

Thanks,
Robin.
