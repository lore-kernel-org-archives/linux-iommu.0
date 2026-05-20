Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941B71F8755
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284671; cv=none; b=Mcobcrf68jwOv9mZimCk8fmY41FC/lomRVaH+hF4Ms4Eo8pisQFzMBPSltLAXBT92COxLcMw0TZ/P2N2VwWQrmFHoxTsOkQ9wznxQ1qfvSFujTEzNqOxgHujnG21K8VJK8P92IAtWA8Zr38T+4MvxlzD73sHhRr8f0xO9mZgoCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284671; c=relaxed/simple;
	bh=mZQmtt7cqu15XnvN7oO5gjKNF+ApnXqCxrO5Yps7GEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YmuT95NtxAQqi6O181PrOYCPoPIphEtr26V02OefgUK9U6Nn9QUWli4dsUYNT3s8b+iRTx3Uqv1WM5chvQjGeFDbOpoX4ZJ8gZrjaCObHokuMC6tqMoi20p5Yv6cEYenQduHR1msruuFyheQVfrk1cfgRMkDxbJFKAGToOzNN/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kaf0ifTb; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kaf0ifTb"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779284660; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=4tgQVUBuWqqu3Ji7uemh9M/TAjmDBv6S5gZB8+RYvGc=;
	b=kaf0ifTbn8g4FLjRHIO9P6YC4UGY/A2VbBGW/byuNJUV5v/OT7gwyImHH7egQ8yUGXw4OIFD0yWdwpoNs70p7n9PJ0iFuDXfW93fK4mAskt9IAiYO9SqQ8MVQxgDIpbBu+Kkt10yt3GqoQegjDJtIsOKUftlxOlWdpNosY6gZGw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0X3J.yu4_1779284658;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X3J.yu4_1779284658 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 May 2026 21:44:19 +0800
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
Date: Wed, 20 May 2026 21:44:16 +0800
Message-Id: <20260520134416.28552-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <7dc61855-d916-4659-8137-7f3457f6a56d@arm.com>
References: <7dc61855-d916-4659-8137-7f3457f6a56d@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>>> Won't it change the DT behavior as it doesn't check msi-parent
>>> anymore?  IOW, should this be made specific to ACPI
>>> by checking whether the device node is acpi node?
>>>
>> 
>> Thanks for the review, you're right that the current condition would
>> affect DT as well.
>> 
>> My assumption was that DT would describe either "interrupts" for WSI
>> or "msi-parent" for MSI, but not both, so platform_irq_count() > 0
>> would effectively imply "no msi-parent" in practice.
>> 
>> That said, I agree that this should be limited to the ACPI path. That
>> matches the actual bug scope — only ACPI was falling back to MSI when
>> wired IRQs were described — and leaves DT unchanged.
>> 
>> I'll respin a v2 to scope the fix to ACPI only, and tighten the commit
>> message accordingly.
>
>Why would this be specific to ACPI? AFAICS if DT specifies an 
>"msi-parent" property such that an MSI domain exists, then MSIs will be 
>preferred as well, since the entire function is structured to prefer 
>MSIs if available, and fall back to wired if not. If the system does 
>support both options then DT should describe that, same as ACPI; what 
>Linux chooses to use is entirely Linux's own policy.
>
>But if you do want to change the Linux driver's policy for some reason 
>that the commit message isn't really explaining, then rearrange the 
>whole switch statement; don't just add a weird hack to try to defeat the 
>existing logic _in the same function_...
>
>In general though, I would have thought preferring MSIs makes the most 
>sense, since MSI vectors are generally cheaper than wires, so there's a 
>better chance of being able to have unique IRQs per interrupt source, 
>whereas with wires you may be stuck with a combined IRQ.

Thanks, Robin.

To clarify, the goal here is not to change the general MSI-vs-WSI
preference policy. The bug is that, when the hardware advertises
IGS=BOTH, DT already provides a way to select WSI by describing wired
IRQs without an msi-parent, but the ACPI path does not currently have
an equivalent way to steer the driver to WSI.

    - DT: if "msi-parent" is omitted, of_msi_get_domain() returns NULL,
      IGS=BOTH then falls through to the WSI path, so DT has a real knob
      ("don't describe MSI") to select WSI.
    - ACPI: there is no per-device equivalent. On systems with IMSIC, the
      IGS=BOTH IOMMU always enters the MSI branch and resolves a non-NULL
      msi_domain, regardless of what its own _CRS describes. The MSI fallback
      only triggers when the system has no IMSIC at all, which is a
      firmware-wide decision rather than a per-device one.

As a result, with ACPI and IGS=BOTH, the driver always uses MSI even when
firmware describes wired IRQs, so the platform cannot express the same
intent as it can with DT.

So this patch is meant to fix that ACPI gap for IGS=BOTH, not to make
WSI generally preferred over MSI. I agree the commit message should
make that bug scope explicit.

>
>(As a side note, is there a reason this is calling of_msi_configure() on 
>a platform device when of_platform_device_create_pdata() will have done 
>that already?)

Good catch, agreed.

Thanks,
Fangyu

>
>Thanks,
>Robin.
