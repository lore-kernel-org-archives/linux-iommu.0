Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543026;
	b=5ANqvLNOUFW59IWvdehoFLz6jJuoT63HIIz+b/6VNR215oLLntqt4iBKb9r0wxv4J9I+
	 0BkIyCiSA+o6s+NyVWmgfs3m94OqMij4a5qHlWrFwH5oR1IV41JpXEBJf/B5Nbi59h8XO
	 Fl04zzwxVQAhB9diZvFS6etsUp5sqnesa28Bd5QKTJqxcnX7gBF0k+IhQaYzRwVb7wgHG
	 dg8il3mFWEv0jXedMHyI0PuSxTY36jSIpsmm1EdajzZyEnFngpjYXlihPSA9mfjbRLw7l
	 EyhuiCyLKzsrzA1EVCFH+E5K2JLCfInWDUbr70rTUu4tNfWs4odZg5fgAkXjddHlHsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543026;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=QAfn4/fyucj8w9tvIqm0t/BfQJuC1gSulyNyHXm2Fv8=;
	b=KxLVxVmm54dTroANhnuc6p5yxgzTxR7bGI3qUjJNESqllzd397ZVnJiFXVoJw8BwMFW1
	 KR/UrJWEq6eQZgqT0JvZQOi3HX1fTIyqq31vK/T2ap3NXyBJRS2NEXjQxdKK7nfSbN6pM
	 wFNEuUKKNLrdxLvuBlL7aOj993aelzBDKMorVv9EZDjXdH/GwxTXd4SN+wgEoKfy3S8kH
	 qbyFA36VzMbHGiYgT/M6Nj7ayvaE1Nyes1MdEl6katlFf5Azu4gXAfBUuaH0roJq+NSa/
	 5SX7VKdLGsENV4O3heL/RUmRDsw+U0XIWgpHt9TunPeFjGu9+dxjOZdSlodgnAgF1kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=c6lqprQY;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BAE606A31E
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 17:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87BAE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=c6lqprQY
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8752C339;
	Tue, 24 Nov 2026 09:57:01 -0800 (PST)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AE6F3F763;
	Tue, 24 Nov 2026 09:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795543024; bh=I6pw8uS8s5roJNHb7M2GM3OgWZOUcGnGgtSmOYmDpLA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c6lqprQYOctmM+/fQeuolrZ+/sAfDhBlYn6i0fniglNB+4MwNRaFwVhU0AWexLKDd
	 0dJaJktHsbqbhj5212vBrwIuPIFS42nLlbTpJMeJv0tuzeczJCMQ6LYG8UiGsa/0Nu
	 OJH2NEs+0VqstSHCG9YNw4T5EUmsHdco4iHEkoqc=
Message-ID: <d4f010f9-44b3-4f0e-9f84-f85ad9c82b3e@arm.com>
Date: Tue, 24 Nov 2026 17:57:01 +0000
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] iommu/rockchip: program the MMU even when the device
 is not in use
To: Anton Sovetov <anton.sovetov@gmail.com>, iommu@lists.linux.dev
Cc: heiko@sntech.de, joro@8bytes.org, will@kernel.org,
 linux-rockchip@lists.infradead.org
References: <CANLiQWrVGN00Hn8s3X7nyDZxh3x0wJ1YqTVzYsLUPM3s-Pkp1A@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CANLiQWrVGN00Hn8s3X7nyDZxh3x0wJ1YqTVzYsLUPM3s-Pkp1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/11/2026 8:07 pm, Anton Sovetov wrote:
> Hi,
> 
> I hit three related problems in drivers/iommu/rockchip-iommu.c on an RK3566
> (Radxa Zero 3W) with the out-of-tree NPU driver. All three have the same shape:
> the driver gates work on pm_runtime_get_if_in_use(), which is 0 unless somebody
> already holds a reference, and for a device that keeps its DMA domain for its
> whole lifetime that is the normal state.
> 
> 1. rk_iommu_irq(), line 583, gate at 592.
> 
>     A page fault raised while the device is running, outside a map or unmap
>     call, finds usage_count 0,

That sounds wrong - if "the device is running" then its RPM state should 
be logically active, which should in turn hold the IOMMU active via the 
device link. And if the client device is still doing DMA and able to 
cause page faults while logically suspended, that would seem like a bug 
in the client driver.

> so the handler returns IRQ_NONE without touching
>     the registers. The fault stays latched: INT_RAWSTAT bit 0 and INT_STATUS bit
>     0 remain set, PAGE_FAULT_ACTIVE stays set in STATUS, REPLAY_BUFFER_EMPTY
>     clears, and nothing is printed. The device then sits on a stalled
>     transaction and dmesg says nothing at all, which is the worst part for
>     anyone trying to debug it.
> 
>     Observed on the NPU: after a job that never completed, the MMU read back
>     dte 0x480000 status 0x2b rawstat 0x1 intstatus 0x1 fault 0xdc80, and the
>     handler had never run. A normal fault report would have printed "Page fault
>     at 0x0000dc80 of type read" plus the page table walk.
> 
> 2. rk_iommu_zap_iova(), line 680, gate at 694.
> 
>     The comment says "Only zap TLBs of IOMMUs that are powered on", but the test
>     is the usage count, not the power state. An unmap that happens while nothing
>     else is using the IOMMU skips the shootdown. A device that keeps its domain
>     but is idle at that moment, which is the usual case when the process that
>     owned the buffers has exited, keeps stale entries, and the next owner of the
>     same iova can still be translated to the previous physical page.
> 
>     I could not prove this one with a bus trace, so I am reporting it as a code
>     observation and not as a measured failure.

The physical power state shouldn't matter - as long as the IOMMU is 
logically suspended then we should have been through rk_iommu_suspend() 
-> rk_iommu_disable(), after which we're not going to touch it again 
until rk_iommu_resume() -> rk_iommu_enable() which inherently does an 
RK_MMU_CMD_ZAP_CACHE. Thus resuming a suspended IOMMU, invalidating all 
the TLBs in the process, just to issue a command to re-invalidate 
nothing, then disabling it until the client device next resumes it and 
invalidates all the TLBs yet again, clearly seems a bit silly.

> 3. rk_iommu_attach_device(), line 1008, gate at 1040.
> 
>     Detach plus attach is how a driver resets its IOMMU domain. On attach, when
>     the usage count is 0, the function returns 0 without calling
>     rk_iommu_enable(), so paging stays off, DTE_ADDR stays 0 and INT_MASK stays
>     0. The caller is told the attach succeeded.
> 
>     Observed on the NPU: its soft reset does iommu_detach_device() and then
>     iommu_attach_device() on the same domain. After the first reset the MMU read
>     dte 0x0 status 0x18 intmask 0x0, no translation at all, and every later DMA
>     ran on raw iovas. Before the reset it was dte 0x480000 status 0x19
>     intmask 0x3. Holding the MMU device with pm_runtime_resume_and_get() around
>     the detach/attach makes the same sequence end with dte 0x480000 status 0x19,
>     which is how I convinced myself the gate, and not the reset itself, was
>     responsible.

Again, that sounds very much like something is wrong with either the 
device link or how the out-of-tree client driver is managing its own 
RPM. And since the device link support has been upstream and apparently 
working fine with the upstream VOP/RGA/etc. client drivers for over 8 
years now...

Thanks,
Robin.

> The patch below resumes the device around the attach and the zap. Both run in
> process context, so pm_runtime_get_sync() is fine there. For the interrupt
> handler I only added a log line on the drop path, because I do not want to
> touch registers from hard irq context while the device may be suspended.
> 
> What it fixes: the MMU now stays programmed across a detach/attach cycle, and a
> fault that arrives while nothing is mapping gets reported instead of vanishing.
> 
> What it does not fix: the reason I went looking. Our NPU still stops executing
> jobs in IOMMU mode after a few separate processes, with a healthy MMU and no
> page fault at all. That is a different problem and I am not claiming this patch
> touches it. I am sending these three because each one is a real failure mode on
> its own.
> 
> Tested only on rk3566 with the v1 block. I have no rk3588 hardware and would
> rather not guess about the v2 path.
> 
> Questions:
> 
> - Is the usage count gate deliberate, in the sense that register access is
>    unsafe unless someone holds a reference? If so, is the right fix to keep the
>    MMU programmed for as long as the device is attached to a domain, instead of
>    tying it to the map/unmap window?
> - For the interrupt path, what is the intended behaviour when a fault arrives
>    while the IOMMU device is runtime suspended? Ignoring it leaves the device
>    stalled and the status latched, which is what we see today.
> 
> Signed-off-by: Anton Sovetov <anton.sovetov@gmail.com>
> 
> ---
>   drivers/iommu/rockchip-iommu.c | 42 ++++++++++++++++++++++------------
>   1 file changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 07e3517..a3da612 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -590,8 +590,11 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
>    int i, err;
> 
>    err = pm_runtime_get_if_in_use(iommu->dev);
> - if (!err || WARN_ON_ONCE(err < 0))
> + if (!err || WARN_ON_ONCE(err < 0)) {
> + dev_err(iommu->dev,
> + "interrupt while the mmu is not in use, ignored\n");
>    return ret;
> + }
> 
>    if (WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks)))
>    goto out;
> @@ -691,17 +694,19 @@ static void rk_iommu_zap_iova(struct
> rk_iommu_domain *rk_domain,
> 
>    iommu = list_entry(pos, struct rk_iommu, node);
> 
> - /* Only zap TLBs of IOMMUs that are powered on. */
> - ret = pm_runtime_get_if_in_use(iommu->dev);
> + /*
> + * The usage count says nothing about the power state, so an
> + * unmap that runs while the IOMMU is idle skipped the
> + * shootdown and left stale translations for the next owner of
> + * the same iova.
> + */
> + ret = pm_runtime_get_sync(iommu->dev);
>    if (WARN_ON_ONCE(ret < 0))
>    continue;
> - if (ret) {
> - WARN_ON(clk_bulk_enable(iommu->num_clocks,
> - iommu->clocks));
> - rk_iommu_zap_lines(iommu, iova, size);
> - clk_bulk_disable(iommu->num_clocks, iommu->clocks);
> - pm_runtime_put(iommu->dev);
> - }
> + WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
> + rk_iommu_zap_lines(iommu, iova, size);
> + clk_bulk_disable(iommu->num_clocks, iommu->clocks);
> + pm_runtime_put(iommu->dev);
>    }
>    spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
>   }
> @@ -1037,13 +1042,22 @@ static int rk_iommu_attach_device(struct
> iommu_domain *domain,
>    list_add_tail(&iommu->node, &rk_domain->iommus);
>    spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
> 
> - ret = pm_runtime_get_if_in_use(iommu->dev);
> - if (!ret || WARN_ON_ONCE(ret < 0))
> - return 0;
> + /*
> + * Detach plus attach is how drivers reset their domain, and the caller
> + * has no way to notice that the MMU was left unprogrammed. Resume the
> + * device and program it.
> + */
> + ret = pm_runtime_get_sync(iommu->dev);
> + if (ret < 0) {
> + dev_err(dev, "cannot resume the mmu, ret: %d\n", ret);
> + return ret;
> + }
> 
>    ret = rk_iommu_enable(iommu);
> - if (ret)
> + if (ret) {
> + dev_err(dev, "mmu enable failed, ret: %d\n", ret);
>    WARN_ON(rk_iommu_identity_attach(&rk_identity_domain, dev));
> + }
> 
>    pm_runtime_put(iommu->dev);
> 
> 

