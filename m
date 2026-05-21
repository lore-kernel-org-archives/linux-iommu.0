Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B5B3BED78
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779362490; cv=none; b=MnHwFkcWVDgCAjWn52fUe4DAsLDG5tdB216iRB4sR3GKI6wgfPjBToj9N2HRONrpCefCxbnvczpIfIGXKXXca386d532D+bOgKxjIkl6zVgoIa3mSNXe/jPKQ3LYTOLE6Jm2iRyDYFNHbmypyr75C9Q2v23IaR9o26Mr/Cv0McA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779362490; c=relaxed/simple;
	bh=q2g5SnNiPHVc5+znooDXPpav9sPR3Tzk+XTyzCWhFb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=scVkJ2ddRRc2HYI6ukEKtSYWeDOTSoUN9ZMocnV7WENcoV3Y/kjUW8mWW1PkGAwWsinV2RgQBaY0go7QRSNoEm2jv6kuU1TG+itxacDT9imUkjatw2lXcrWTCj+Dn8OQcbhBp5Au9c6rBLnsyizzEe+sMLupbvHuvjxBt6TQ2i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=t8S6AOn6; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="t8S6AOn6"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779362476; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=/h49bQbKmtlO5PbHz54FRwxmNigpG7UoN7YHAxvgj88=;
	b=t8S6AOn6pvfGOpLez4UA37or4Sn5Uxu7TjYLgAb5tKcn8skQ0d57QJwdn+O62npvjC11S0i12DuUWCiOOLd+t1zWUvAPGmrZ8xLBrSqKjhgkiLpxJCHb7eoT2P9glNgDOuFV2r2KXEk8nsxrgTq1+zM4r5vG1U3zVUkx/D57JUQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0X3Le79C_1779362473;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X3Le79C_1779362473 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 21 May 2026 19:21:14 +0800
From: fangyu.yu@linux.alibaba.com
To: robin.murphy@arm.com
Cc: ajones@ventanamicro.com,
	alex@ghiti.fr,
	andrew.jones@oss.qualcomm.com,
	aou@eecs.berkeley.edu,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	sunilvl@oss.qualcomm.com,
	tomasz.jeznach@linux.dev,
	will@kernel.org
Subject: Re: [PATCH] iommu/riscv: prefer WSI on IGS=BOTH when wired IRQs are described 
Date: Thu, 21 May 2026 19:21:12 +0800
Message-Id: <20260521112112.35022-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <c50a527c-83e7-439b-95a0-a38235c24de6@arm.com>
References: <c50a527c-83e7-439b-95a0-a38235c24de6@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>>>>> Won't it change the DT behavior as it doesn't check msi-parent
>>>>> anymore?  IOW, should this be made specific to ACPI
>>>>> by checking whether the device node is acpi node?
>>>>>
>>>>
>>>> Thanks for the review, you're right that the current condition would
>>>> affect DT as well.
>>>>
>>>> My assumption was that DT would describe either "interrupts" for WSI
>>>> or "msi-parent" for MSI, but not both, so platform_irq_count() > 0
>>>> would effectively imply "no msi-parent" in practice.
>>>>
>>>> That said, I agree that this should be limited to the ACPI path. That
>>>> matches the actual bug scope — only ACPI was falling back to MSI when
>>>> wired IRQs were described — and leaves DT unchanged.
>>>>
>>>> I'll respin a v2 to scope the fix to ACPI only, and tighten the commit
>>>> message accordingly.
>>>
>>> Why would this be specific to ACPI? AFAICS if DT specifies an
>>> "msi-parent" property such that an MSI domain exists, then MSIs will be
>>> preferred as well, since the entire function is structured to prefer
>>> MSIs if available, and fall back to wired if not. If the system does
>>> support both options then DT should describe that, same as ACPI; what
>>> Linux chooses to use is entirely Linux's own policy.
>>>
>>> But if you do want to change the Linux driver's policy for some reason
>>> that the commit message isn't really explaining, then rearrange the
>>> whole switch statement; don't just add a weird hack to try to defeat the
>>> existing logic _in the same function_...
>>>
>>> In general though, I would have thought preferring MSIs makes the most
>>> sense, since MSI vectors are generally cheaper than wires, so there's a
>>> better chance of being able to have unique IRQs per interrupt source,
>>> whereas with wires you may be stuck with a combined IRQ.
>> 
>> Thanks, Robin.
>> 
>> To clarify, the goal here is not to change the general MSI-vs-WSI
>> preference policy. The bug is that, when the hardware advertises
>> IGS=BOTH, DT already provides a way to select WSI by describing wired
>> IRQs without an msi-parent,
>
>And my point is that that sounds wrong - if the system can support both 
>then DT should have both properties, because DT describes the system, 
>not Linux policy. Of course it is presumably possible to have a reusable 
>IOMMU IP that itself supports IGS=BOTH, integrated into systems which 
>either don't have an MSI controller, or haven't connected the wires, in 
>which case only one or other property is valid to describe anyway, but 
>that's fine - IGS describes what the IOMMU is capable of sending, the 
>firmware properties describe what the rest of the system is capable of 
>receiving, and if there's any choice left in the intersection of the two 
>then that's up to the OS.

Agreed, Firmware describes hardware capability; when both options are
properly described, prefer-MSI is the right default.

>> but the ACPI path does not currently have
>> an equivalent way to steer the driver to WSI.
>> 
>>      - DT: if "msi-parent" is omitted, of_msi_get_domain() returns NULL,
>>        IGS=BOTH then falls through to the WSI path, so DT has a real knob
>>        ("don't describe MSI") to select WSI.
>>      - ACPI: there is no per-device equivalent. On systems with IMSIC, the
>>        IGS=BOTH IOMMU always enters the MSI branch and resolves a non-NULL
>>        msi_domain, regardless of what its own _CRS describes. The MSI fallback
>>        only triggers when the system has no IMSIC at all, which is a
>>        firmware-wide decision rather than a per-device one.
>> 
>> As a result, with ACPI and IGS=BOTH, the driver always uses MSI even when
>> firmware describes wired IRQs, so the platform cannot express the same
>> intent as it can with DT.
>
>What do you mean by "intent"? Again, people should not be hacking 
>firmware just to influence OS driver policy.
>
>If you mean you have a case where a system does have an MSI controller, 
>and a device which is capable of emitting MSIs, but the device's MSI 
>writes cannot reach that MSI controller, and ACPI is incapable of 
>describing that so Linux ends up incorrectly assuming that MSIs should 
>work, then you have a spec-level ACPI problem and you need to fix RIMT 
>and/or any other relevant tables/properties to be able to indicate that 
>properly; bodging the Linux IOMMU driver alone does not help other OSes, 
>nor even other MSI-capable devices under Linux.

You're right - But RIMT v1.0 lacks a per-IOMMU equivalent of IORT SMMUv3
Flags bit 4 (DeviceID mapping index valid).

I was wondering whether the old ARM IORT compatibility pattern could be
considered here: if a given RIMT IOMMU node fully populates its Interrupt
Wire Array (civ, fiv, piv, pmiv), could that be treated as a temporary
signal for the wired path until RIMT grows an explicit flag?

If that is still too policy-like for ACPI, is there any comparable
transitional pattern that would be more acceptable until RIMT gains the
missing explicit signal?

Thanks,
Fangyu

>Amusingly, that would then be the opposite problem from what we had with 
>Arm SMMU, where initially we couldn't use MSIs with ACPI at all since 
>early IORT version had no way to describe the necessary GIC DeviceID :)
>
>> So this patch is meant to fix that ACPI gap for IGS=BOTH, not to make
>> WSI generally preferred over MSI. I agree the commit message should
>> make that bug scope explicit.
>
>But even then it does change the policy in general for all ACPI systems 
>that genuinely do have both and could happily still use MSIs.
>
>Thanks,
>Robin.
