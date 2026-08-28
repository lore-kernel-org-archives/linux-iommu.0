Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D463B3EAC75
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 08:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787906979; cv=none; b=U5LdgloA3IloB6LC086EOkX893sdvRBLhSlCHYp16ZrFluXsemssHPR/CcZlCTT7+aBj1HU61Nm6MVc63fwZ2Y4e1JvLWO+tHb03CIPKPetPPzOiFITRHFsPT175xGFN0n0O6c5nWIDuJlyXPArXmVa7jJpuyT7ChJpKUnz86VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787906979; c=relaxed/simple;
	bh=JT1Ftk35FAfhVGpWG1mrRpS3WjZHYy5b6S3/sobw3fY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVEXTe+vBdySDld8CN+IFmFX0AkSSaKn9XOrBTTBYfjkCUwrnPA8G/Kf5Qd9F/P2B8kzczwZlRIKY71kUE4db2sWzRoMMkIz7uUMUJmfK9jKpdCpBOkhdhIlA/FKgOcjZxTZokyK5uQn7yN0jUcM4kJ25Dp024jotZV12turKsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzrntH/F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzrntH/F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678D51F00A3E
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 08:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787906972;
	bh=iTWaHzCUhsUqSvPXQIT56fUgv/7xsB7jv15+ZqkCd+Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YzrntH/FKApkQCnp2DkZ/OqeTiGAQeaXPbc1DsrTDPhD67cQ6oCY5KBVfr1EktH01
	 y7pz8TmoeBXQqwnEmSeK/MWG/bdhBneVuI1ongPR5dM31PqIgbuqyu/S8fV/qeK2uq
	 Zxmm+OMGOv8Z4BM38wd5HK4A2w7+4C+uxEJItUmI9PX6pt6XIXDIj4hkTR8Fagqwv3
	 5HHXmdGLvDbl1jpbxypBHgfzUQi7ZeTchhd1oalz4MKS2piROQBJ1CNn0KnfT1js8H
	 ochtkwVugVELi6gGVgzyMmitAErmbOzDA62jiUOgOXyZ0PweKcleGOXidT/l5ECdWP
	 ht7VYfgOz+XVg==
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49b96837ca3so2528705e9.3
        for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 01:49:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoBT8sgl8vuMroigJmXrdc2TC10soeuGrepSYv9KpG3emJNp1iWpg4H933AMyq+9IPW099ZjA==@lists.linux.dev
X-Gm-Message-State: AFuF++k8TbdozDH1Pbj8VgeSrh1+eOjHZxRlfU+yV8tF34PBPYcaNiZG
	Ibv9xMsyufrJTIf9R36STY0h4XhTxTXM2HW4bagSeGi8drUAM4YTKPJvM/Oy1jq9ckwl34x+LXw
	X8UE1gg3IPcaqtJE4P7i+VBxLBFV4jBc=
X-Received: by 2002:a05:600c:c3cf:10b0:49b:8f18:714a with SMTP id
 5b1f17b1804b1-49b91c47b76mr56390145e9.12.1787906970884; Fri, 28 Aug 2026
 01:49:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260828070747.4009519-1-zong.li@sifive.com>
In-Reply-To: <20260828070747.4009519-1-zong.li@sifive.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 28 Aug 2026 16:49:17 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ-1pKoBvnRSLkDGqwKDzon_yfyT74haifeGD=VRBanYg@mail.gmail.com>
X-Gm-Features: AcwNN1VMCHhJ9U1VulIu65DXTUxtzDFoDLDzisWOEQmJfMR_Ji-KYifhbSJdPrk
Message-ID: <CAJF2gTQ-1pKoBvnRSLkDGqwKDzon_yfyT74haifeGD=VRBanYg@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] RISC-V IOMMU HPM support
To: Zong Li <zong.li@sifive.com>
Cc: tomasz.jeznach@linux.dev, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, mark.rutland@arm.com, 
	andrew.jones@oss.qualcomm.com, david.laight.linux@gmail.com, 
	zhangzhanpeng.jasper@bytedance.com, yang.yicong@picoheart.com, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Li Zong,

Just two patches? Where did the riscv-iommu PMU driver patch go?

--
Best Regards
 GUO Ren

On Fri, Aug 28, 2026 at 3:07=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote:
>
> This series implements support for the RISC-V IOMMU hardware performance
> monitor.
>
> The RISC-V IOMMU PMU driver is implemented as an auxiliary device driver
> created by the parent RISC-V IOMMU driver. Therefore, the child driver
> can obtain resources and information from the parent device, such as
> the MMIO base address and IRQ number.
>
> The thrid commit adds raw spinlock for race condition when PCI MSI/MSI-X
> on IMSIC. As the commit message mentioned:
> Events are bound to one CPU and the interrupt is affine to it, so the
> perf callbacks running with interrupts disabled would be enough to
> exclude the handler. But PCI MSI/MSI-X on IMSIC breaks that:
> The irqchip sets IRQCHIP_MOVE_DEFERRED, so irq_set_affinity() reports
> success while only recording the request, and the move is applied in
> interrupt context upon the next device interrupt. Until then the
> interrupt is still routed to the CPU IMSIC picked initially, so the
> first overflow interrupt can run concurrently with the perf callbacks
> on the CPU the events are bound to.
>
> I noticed that xgene_pmu and arm-cci have similar implementation, so add
> it in riscv_iommu_pmu should be accepted.
>
> Changed in v6:
> - Rebased onto the latest v7.3-rc
> - Use sysfs_emit instead of cpumap_print_to_pagebuf
> - Set up on_cpu and irq affinity by cpuhp callbacks
> - Change type of on_cpu from unsigned int to int
> - Reject filter operands of cycle event in event_init
> - Check return value of counter number and  masks in probe
> - Add raw spinlock for race condition (third commit)
>
> Changed in v5:
> - Pick up suggestions from sashiko-bot as follows
> - Fix event group validation for sw event
> - Bind IRQ to aux PMU dev instead of parent IOMMU dev
> - Clear OF bit when event is NULL
> - Improve hi-lo-hi patten
> - Add back IRQF_SHARED flag due to mismatch
> - Manage cpuhp and pmu register by devre
>
> Changed in v4:
> - Rebased onto v7.3-rc
> - Use is_sampling_event() instead of accessing vairable directly
> - Rename the matching name from "iommu.pmu" to "riscv-iommu.pmu"
> - Change the naming of PMU device for avoid ":" in PCIe case
> - Add suppress_bind_attrs attribute
> - Remove IRQF_SHARED flag
> - Set irq affinity to local CPU of IOMMU
> - Allocate ID by IDA for auxiliary device
> - Pick up suggestions from sashiko-bot
>
> Changed in v3:
> - Rebased onto v7.2-rc3
> - Use hi_lo_writeq/readq to access register
> - Pick comments from sashiko-bot as follows
> - Set IRQ CPU affinity
> - Remove IRQF_ONESHOT flag when request irq
> - Adjust cycle event check by checking event_id field only
> - Fix bug for group events verificaiton
> - Fix KASAN issue about casting 32-bit variable to unsigned long pointer
> - Clear IPSR pending bit before starting counter
> - Clear OF bit in event selector register in irq handler
> - Release irq by devm instead of explicit free_irq
>
> Changed in v2:
> - Rebased onto v7.2-rc1
> - Use hi-lo-hi mechanism to read counter.
>   Suggested by Guo Ren and David Laight
>
> Changed in v1:
> - Rebased onto v6.19-rc8
> - Pick all suggestions and feedbacks from v1 series
> - Add cpu hotplug implementation to avoid race enablement
> - Move PMU-related definition from header to c file
> - Change PMU driver to auxiliary device driver
>
> Changed in RFC:
> - Rebase onto v6.13-rc7
> - Clear interrupt pending before handling interrupt
> - Fix the counter value issue caused by OF bit in the cycle counter.
> - Invoke riscv_iommu_hpm_disable() instead of riscv_iommu_pmu_uninit()
>   in riscv_iommu_remove()
>
> Zong Li (2):
>   iommu/riscv: create a auxiliary device for HPM
>   drivers/perf: riscv-iommu: protect shared state with a raw spinlock
>
>  drivers/iommu/riscv/Kconfig    |  1 +
>  drivers/iommu/riscv/iommu.c    | 37 +++++++++++++++++++
>  drivers/perf/riscv_iommu_pmu.c | 66 ++++++++++++++++++++++++++++++----
>  3 files changed, 98 insertions(+), 6 deletions(-)
>
> --
> 2.43.7
>
