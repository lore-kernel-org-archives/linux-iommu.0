Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623315;
	b=L9E/lfrsQVr2RqXkS06Z1/mn4e4NAfqgiKk3V7AcmnB5eOdVzbDJ4I/DkWK77VVLyVnr
	 4crbNxXJ3J3ayhGQV4OVv1kSXMqmtZ58nspVSdlFg/ff0Fa4an8sCjdefnILqEKr5Zq3x
	 s5Qdz3+i6WfNp5JTq/g8UsgozkB3jMa+0laCAV2ES6LwOerC7SJQyMdw54HX97ExzeZeu
	 miFRu5vaisCyrnZdN2lJLcy0M8Ovw6JCbKwtKIGtJff0fHgfI6I0iK8F06LO9gLEW8w6Y
	 8u3ZlZj0ZWUVl5y6n85RoKtqilwA+coAneESOm/tXMU5ZkXADZwb2z4KYvkOKEGsZZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623315;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=p95Hk+rcp6xhzC/W/iDDWgBxcMkWhCfXl3jnrC2DBaU=;
	b=kJozvBQsuuO/tTn7wyPpp+KYuzIhX0gjuS2BRBdHiMVn7z2Ed6wcuU4gu9dXSUDhKoy5
	 i103I0mLiRiituuGhFMLrZ80h02w+AkmAnR2GYkAL3y6bEiSWefGNbWYXrR/GtHcyJZVw
	 rZw3qYzbPY/DozQOV6cIyUhLVcUvVf19ErFgKM+4+2IL3p0fabr812JJSC3ENogb/web2
	 mU8FaO3knj/lOvJjRvxW1VpaDpqjoenkY0wxrf0expnhRQbGM1RlyZpjfDoGZurMfPqfA
	 keylQY2j9k/Rozw4bS4Di6suj+BgvyeDItXuyA7Hk0CGf8UgdCThvDjUmV6NK8Gzbjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cr03LFpM;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4599F606A334
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 16:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4599F606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cr03LFpM
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 670872F;
	Wed, 25 Nov 2026 08:15:11 -0800 (PST)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F6D33F632;
	Wed, 25 Nov 2026 08:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795623314; bh=LAwCGt3Lu+4z2+zSmAxPU6gkEEwNgUcLUPqKn1ssCLk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cr03LFpMqW2sJLMhyKgRtunzyYDYRJ6NYQhC3yk53b8i7LbBl/2+4VnRdMjXIWkbs
	 EOTUQHSo3NyZb832sZtIpSd1vlESx1X5NTm2PzRH8RyzeqveyEs4SCAGfRIe/pH6MC
	 fT6pYSs4VDN/D4X90LWs2o5753gLL+9w7vFk+JXc=
Message-ID: <390ebe97-876e-4fbc-a0ad-955484ce2009@arm.com>
Date: Wed, 25 Nov 2026 16:15:12 +0000
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
To: Anton Sovetov <anton.sovetov@gmail.com>
Cc: iommu@lists.linux.dev, heiko@sntech.de, joro@8bytes.org, will@kernel.org,
 linux-rockchip@lists.infradead.org
References: <CANLiQWrVGN00Hn8s3X7nyDZxh3x0wJ1YqTVzYsLUPM3s-Pkp1A@mail.gmail.com>
 <d4f010f9-44b3-4f0e-9f84-f85ad9c82b3e@arm.com>
 <CANLiQWo5qOUt4CS-nK+nHQk3aZHADb3hy=zfvLKoxi7N_jEmPw@mail.gmail.com_quarantine>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CANLiQWo5qOUt4CS-nK+nHQk3aZHADb3hy=zfvLKoxi7N_jEmPw@mail.gmail.com_quarantine>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/11/2026 12:23 pm, Anton Sovetov wrote:
> Hi Robin,
> 
> Thanks, that's a fair reading. I'll take 2 and 3 as answered: zapping a
> disabled MMU is pointless when resume re-enables it with ZAP_CACHE, and an
> attach that leaves paging off is fine because the client's next runtime
> resume turns it on anyway.
> 
> On 1 I'd like to check one thing before I drop it. pm_runtime_get_if_in_use()
> returns 0 not only when the device is suspended but also while it is still
> RPM_ACTIVE with the usage count already at zero, and during the suspending
> transition, since pm_runtime_put() defers the suspend to the workqueue. In
> that window the MMU is still paging and can latch a fault the handler then
> discards, which is how I ended up with dte 0x480000 status 0x2b fault 0xdc80
> latched and nothing in dmesg. Would pm_runtime_get_if_active() be acceptable
> there, or is that window too narrow to be worth the change?

Ah, good point - it is indeed possible for the client to cause a fault 
but then immediately suspend itself before we've managed to take the 
interrupt, so technically anything up to the point that we actually 
disable the IOMMU interrupt sources in rk_iommu_suspend() can still be 
considered legitimate. So yes, I think I'd agree that RPM_ACTIVE is a 
more accurate condition than usage_count here (strictly that still 
leaves a small window for "missed" interrupts during RPM_SUSPENDING 
itself but oh well).

That now also makes me wonder if autosuspend etc. could ever result in 
the IOMMU's usage_count going from 0 back to 1 without the full 
suspend/resume cycle - if so then we probably want the same change in 
the other 3 instances too.

Thanks,
Robin.
  > Either way I'm now looking at the client driver's RPM accounting as you
> suggest, and will report back what I find.
> 
> вт, 24 нояб. 2026 г. в 20:57, Robin Murphy <robin.murphy@arm.com>:
>>
>> On 23/11/2026 8:07 pm, Anton Sovetov wrote:
>>> Hi,
>>>
>>> I hit three related problems in drivers/iommu/rockchip-iommu.c on an RK3566
>>> (Radxa Zero 3W) with the out-of-tree NPU driver. All three have the same shape:
>>> the driver gates work on pm_runtime_get_if_in_use(), which is 0 unless somebody
>>> already holds a reference, and for a device that keeps its DMA domain for its
>>> whole lifetime that is the normal state.
>>>
>>> 1. rk_iommu_irq(), line 583, gate at 592.
>>>
>>>      A page fault raised while the device is running, outside a map or unmap
>>>      call, finds usage_count 0,
>>
>> That sounds wrong - if "the device is running" then its RPM state should
>> be logically active, which should in turn hold the IOMMU active via the
>> device link. And if the client device is still doing DMA and able to
>> cause page faults while logically suspended, that would seem like a bug
>> in the client driver.
>>
>>> so the handler returns IRQ_NONE without touching
>>>      the registers. The fault stays latched: INT_RAWSTAT bit 0 and INT_STATUS bit
>>>      0 remain set, PAGE_FAULT_ACTIVE stays set in STATUS, REPLAY_BUFFER_EMPTY
>>>      clears, and nothing is printed. The device then sits on a stalled
>>>      transaction and dmesg says nothing at all, which is the worst part for
>>>      anyone trying to debug it.
>>>
>>>      Observed on the NPU: after a job that never completed, the MMU read back
>>>      dte 0x480000 status 0x2b rawstat 0x1 intstatus 0x1 fault 0xdc80, and the
>>>      handler had never run. A normal fault report would have printed "Page fault
>>>      at 0x0000dc80 of type read" plus the page table walk.
>>>
>>> 2. rk_iommu_zap_iova(), line 680, gate at 694.
>>>
>>>      The comment says "Only zap TLBs of IOMMUs that are powered on", but the test
>>>      is the usage count, not the power state. An unmap that happens while nothing
>>>      else is using the IOMMU skips the shootdown. A device that keeps its domain
>>>      but is idle at that moment, which is the usual case when the process that
>>>      owned the buffers has exited, keeps stale entries, and the next owner of the
>>>      same iova can still be translated to the previous physical page.
>>>
>>>      I could not prove this one with a bus trace, so I am reporting it as a code
>>>      observation and not as a measured failure.
>>
>> The physical power state shouldn't matter - as long as the IOMMU is
>> logically suspended then we should have been through rk_iommu_suspend()
>> -> rk_iommu_disable(), after which we're not going to touch it again
>> until rk_iommu_resume() -> rk_iommu_enable() which inherently does an
>> RK_MMU_CMD_ZAP_CACHE. Thus resuming a suspended IOMMU, invalidating all
>> the TLBs in the process, just to issue a command to re-invalidate
>> nothing, then disabling it until the client device next resumes it and
>> invalidates all the TLBs yet again, clearly seems a bit silly.
>>
>>> 3. rk_iommu_attach_device(), line 1008, gate at 1040.
>>>
>>>      Detach plus attach is how a driver resets its IOMMU domain. On attach, when
>>>      the usage count is 0, the function returns 0 without calling
>>>      rk_iommu_enable(), so paging stays off, DTE_ADDR stays 0 and INT_MASK stays
>>>      0. The caller is told the attach succeeded.
>>>
>>>      Observed on the NPU: its soft reset does iommu_detach_device() and then
>>>      iommu_attach_device() on the same domain. After the first reset the MMU read
>>>      dte 0x0 status 0x18 intmask 0x0, no translation at all, and every later DMA
>>>      ran on raw iovas. Before the reset it was dte 0x480000 status 0x19
>>>      intmask 0x3. Holding the MMU device with pm_runtime_resume_and_get() around
>>>      the detach/attach makes the same sequence end with dte 0x480000 status 0x19,
>>>      which is how I convinced myself the gate, and not the reset itself, was
>>>      responsible.
>>
>> Again, that sounds very much like something is wrong with either the
>> device link or how the out-of-tree client driver is managing its own
>> RPM. And since the device link support has been upstream and apparently
>> working fine with the upstream VOP/RGA/etc. client drivers for over 8
>> years now...
>>
>> Thanks,
>> Robin.
>>
>>> The patch below resumes the device around the attach and the zap. Both run in
>>> process context, so pm_runtime_get_sync() is fine there. For the interrupt
>>> handler I only added a log line on the drop path, because I do not want to
>>> touch registers from hard irq context while the device may be suspended.
>>>
>>> What it fixes: the MMU now stays programmed across a detach/attach cycle, and a
>>> fault that arrives while nothing is mapping gets reported instead of vanishing.
>>>
>>> What it does not fix: the reason I went looking. Our NPU still stops executing
>>> jobs in IOMMU mode after a few separate processes, with a healthy MMU and no
>>> page fault at all. That is a different problem and I am not claiming this patch
>>> touches it. I am sending these three because each one is a real failure mode on
>>> its own.
>>>
>>> Tested only on rk3566 with the v1 block. I have no rk3588 hardware and would
>>> rather not guess about the v2 path.
>>>
>>> Questions:
>>>
>>> - Is the usage count gate deliberate, in the sense that register access is
>>>     unsafe unless someone holds a reference? If so, is the right fix to keep the
>>>     MMU programmed for as long as the device is attached to a domain, instead of
>>>     tying it to the map/unmap window?
>>> - For the interrupt path, what is the intended behaviour when a fault arrives
>>>     while the IOMMU device is runtime suspended? Ignoring it leaves the device
>>>     stalled and the status latched, which is what we see today.
>>>
>>> Signed-off-by: Anton Sovetov <anton.sovetov@gmail.com>
>>>
>>> ---
>>>    drivers/iommu/rockchip-iommu.c | 42 ++++++++++++++++++++++------------
>>>    1 file changed, 28 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
>>> index 07e3517..a3da612 100644
>>> --- a/drivers/iommu/rockchip-iommu.c
>>> +++ b/drivers/iommu/rockchip-iommu.c
>>> @@ -590,8 +590,11 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
>>>     int i, err;
>>>
>>>     err = pm_runtime_get_if_in_use(iommu->dev);
>>> - if (!err || WARN_ON_ONCE(err < 0))
>>> + if (!err || WARN_ON_ONCE(err < 0)) {
>>> + dev_err(iommu->dev,
>>> + "interrupt while the mmu is not in use, ignored\n");
>>>     return ret;
>>> + }
>>>
>>>     if (WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks)))
>>>     goto out;
>>> @@ -691,17 +694,19 @@ static void rk_iommu_zap_iova(struct
>>> rk_iommu_domain *rk_domain,
>>>
>>>     iommu = list_entry(pos, struct rk_iommu, node);
>>>
>>> - /* Only zap TLBs of IOMMUs that are powered on. */
>>> - ret = pm_runtime_get_if_in_use(iommu->dev);
>>> + /*
>>> + * The usage count says nothing about the power state, so an
>>> + * unmap that runs while the IOMMU is idle skipped the
>>> + * shootdown and left stale translations for the next owner of
>>> + * the same iova.
>>> + */
>>> + ret = pm_runtime_get_sync(iommu->dev);
>>>     if (WARN_ON_ONCE(ret < 0))
>>>     continue;
>>> - if (ret) {
>>> - WARN_ON(clk_bulk_enable(iommu->num_clocks,
>>> - iommu->clocks));
>>> - rk_iommu_zap_lines(iommu, iova, size);
>>> - clk_bulk_disable(iommu->num_clocks, iommu->clocks);
>>> - pm_runtime_put(iommu->dev);
>>> - }
>>> + WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
>>> + rk_iommu_zap_lines(iommu, iova, size);
>>> + clk_bulk_disable(iommu->num_clocks, iommu->clocks);
>>> + pm_runtime_put(iommu->dev);
>>>     }
>>>     spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
>>>    }
>>> @@ -1037,13 +1042,22 @@ static int rk_iommu_attach_device(struct
>>> iommu_domain *domain,
>>>     list_add_tail(&iommu->node, &rk_domain->iommus);
>>>     spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
>>>
>>> - ret = pm_runtime_get_if_in_use(iommu->dev);
>>> - if (!ret || WARN_ON_ONCE(ret < 0))
>>> - return 0;
>>> + /*
>>> + * Detach plus attach is how drivers reset their domain, and the caller
>>> + * has no way to notice that the MMU was left unprogrammed. Resume the
>>> + * device and program it.
>>> + */
>>> + ret = pm_runtime_get_sync(iommu->dev);
>>> + if (ret < 0) {
>>> + dev_err(dev, "cannot resume the mmu, ret: %d\n", ret);
>>> + return ret;
>>> + }
>>>
>>>     ret = rk_iommu_enable(iommu);
>>> - if (ret)
>>> + if (ret) {
>>> + dev_err(dev, "mmu enable failed, ret: %d\n", ret);
>>>     WARN_ON(rk_iommu_identity_attach(&rk_identity_domain, dev));
>>> + }
>>>
>>>     pm_runtime_put(iommu->dev);
>>>
>>>
>>
> 
> 

