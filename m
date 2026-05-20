Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D583A451F
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 12:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779279942; cv=none; b=qxxyyKmigtsuohdqfRwMbmgIvAfbwl5W5rLNrTPq6HK0K2YOYBNv+0i/4SSsDpxBSARBT25n8XLpBKd54ZXAZttTMzHTTElXqyQ2ygD5To/HuQWy0ljhGRuV/ow+m65MFbjvWiSs9khql5Bkp7EcN1xrugW1B+uXUCJB/5M39jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779279942; c=relaxed/simple;
	bh=r4MdZFtowyPpupGPpQIEXdP9NBQqXiB54/OWs7koQOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYGHld2JTMRDZKgkbBZaOOiyRC4ZJhTmcYfgB0znXK/5gBbG+3AN62UXd4Teay94UslMQzs/RYFP8HLyolMNtEOT3mtDxhKHzItjI80Grp0N+lNtvLiMpQZ1gp/hYAzJ4vzbrAQ30+0iN2dFyoCxtZ/e2Ihv6pGO1PE/AFNy41Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=uFUScEO+; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="uFUScEO+"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 637E91AED;
	Wed, 20 May 2026 05:25:34 -0700 (PDT)
Received: from [10.57.34.79] (unknown [10.57.34.79])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0486B3F85F;
	Wed, 20 May 2026 05:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779279939; bh=r4MdZFtowyPpupGPpQIEXdP9NBQqXiB54/OWs7koQOg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uFUScEO+VDFo1Yng4NuDnsMF/miGjHvXJ8FilngCJQqFJaq8eZFNKMBuuthzdAZER
	 yLOCNQ6Bk3vnNMCN0LTgcENfRn5nQT5Zluxxfn08TTnF9G780N1uOURGxohyGZ1Frh
	 Z7uXsD5a+7KNVc0oQdfVLv16yVcughVRGzLtFI/g=
Message-ID: <7dc61855-d916-4659-8137-7f3457f6a56d@arm.com>
Date: Wed, 20 May 2026 13:25:27 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/riscv: prefer WSI on IGS=BOTH when wired IRQs are
 described
To: fangyu.yu@linux.alibaba.com, sunilvl@oss.qualcomm.com
Cc: ajones@ventanamicro.com, alex@ghiti.fr, andrew.jones@oss.qualcomm.com,
 aou@eecs.berkeley.edu, guoren@kernel.org, iommu@lists.linux.dev,
 joro@8bytes.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, palmer@dabbelt.com, pjw@kernel.org,
 tomasz.jeznach@linux.dev, will@kernel.org
References: <CAB19ukGk2AUA3yjsrBxjsUsH9pUSeeu5F6vo1FFBcd504VQPzg@mail.gmail.com>
 <20260520095411.92045-1-fangyu.yu@linux.alibaba.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260520095411.92045-1-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-05-20 10:54 am, fangyu.yu@linux.alibaba.com wrote:
>>>
>>> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>>
>>> The RISC-V IOMMU spec defines IGS=BOTH as supporting both MSI and
>>> WSI, with software selecting the path. The DT path already behaves
>>> as expected by selecting WSI when wired IRQ resources are described.
>>> The ACPI path, however, currently falls back to MSI even when
>>> firmware describes wired IRQ resources.
>>>
>>> Use firmware-described wired IRQ resources as the trigger to select
>>> WSI for IGS=BOTH:
>>>    - DT: "interrupts" present, no "msi-parent"
>>>    - ACPI: DSDT _CRS Interrupt() descriptors
>>>      (mainline does not yet parse the RIMT Interrupt Wire Array)
>>>
>>> When triggered, rewrite igs to IGS_WSI and reuse the existing WSI
>>> handling. Keep the existing behaviour otherwise.
>>>
>>> Fixes: d5f88acdd6ff ("iommu/riscv: Add support for platform msi")
>>> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>> ---
>>>   drivers/iommu/riscv/iommu-platform.c | 15 +++++++++++++++
>>>   1 file changed, 15 insertions(+)
>>>
>>> diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
>>> index 399ba8fe1b3e..bd7712231140 100644
>>> --- a/drivers/iommu/riscv/iommu-platform.c
>>> +++ b/drivers/iommu/riscv/iommu-platform.c
>>> @@ -71,6 +71,21 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
>>>          iommu->irqs_count = RISCV_IOMMU_INTR_COUNT;
>>>
>>>          igs = FIELD_GET(RISCV_IOMMU_CAPABILITIES_IGS, iommu->caps);
>>> +
>>> +       /*
>>> +        * IGS=BOTH means the IOMMU supports either MSI or WSI;
>>> +        * the spec leaves the choice to software. Use the firmware-described
>>> +        * wired interrupt resources as the trigger:
>>> +        *   - DT  : "interrupts" property present, no "msi-parent"  -> WSI
>>> +        *   - ACPI: DSDT _CRS Interrupt() present  -> WSI
>>> +        * Otherwise default to the MSI path.
>>> +        */
>>> +       if (igs == RISCV_IOMMU_CAPABILITIES_IGS_BOTH &&
>>> +           platform_irq_count(pdev) > 0) {
>>> +               dev_info(dev, "firmware describes wired IRQs; preferring WSI on IGS=BOTH\n");
>>> +               igs = RISCV_IOMMU_CAPABILITIES_IGS_WSI;
>>> +       }
>>> +
>> Won't it change the DT behavior as it doesn't check msi-parent
>> anymore?  IOW, should this be made specific to ACPI
>> by checking whether the device node is acpi node?
>>
> 
> Thanks for the review, you're right that the current condition would
> affect DT as well.
> 
> My assumption was that DT would describe either "interrupts" for WSI
> or "msi-parent" for MSI, but not both, so platform_irq_count() > 0
> would effectively imply "no msi-parent" in practice.
> 
> That said, I agree that this should be limited to the ACPI path. That
> matches the actual bug scope — only ACPI was falling back to MSI when
> wired IRQs were described — and leaves DT unchanged.
> 
> I'll respin a v2 to scope the fix to ACPI only, and tighten the commit
> message accordingly.

Why would this be specific to ACPI? AFAICS if DT specifies an 
"msi-parent" property such that an MSI domain exists, then MSIs will be 
preferred as well, since the entire function is structured to prefer 
MSIs if available, and fall back to wired if not. If the system does 
support both options then DT should describe that, same as ACPI; what 
Linux chooses to use is entirely Linux's own policy.

But if you do want to change the Linux driver's policy for some reason 
that the commit message isn't really explaining, then rearrange the 
whole switch statement; don't just add a weird hack to try to defeat the 
existing logic _in the same function_...

In general though, I would have thought preferring MSIs makes the most 
sense, since MSI vectors are generally cheaper than wires, so there's a 
better chance of being able to have unique IRQs per interrupt source, 
whereas with wires you may be stuck with a combined IRQ.

(As a side note, is there a reason this is calling of_msi_configure() on 
a platform device when of_platform_device_create_pdata() will have done 
that already?)

Thanks,
Robin.
