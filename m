Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792769347;
	b=gVXMOIRoNuNofTlrc5Ka6vSNF1No9kCs+jmvdlquAhcIM00ejv7vTO7lI5oV/AD/6+NK
	 cuLRGj9CY56xLxLMc3f3RuwbpBJBjZxOpxeQ1c/96uLtDfFEmtIl6LlZ7cgU7OB8Qsb6d
	 JmEx+7woL2zjzUNHs5Olr8o60acz7yI4LhciAF6IRso9EpcNWMVhdnnorjTZ8KomtWapR
	 1rU6JV2veRoGg7FH885ZvFVILMYoAz+i5IXw++7qUynBU7XKYgO+RnKRmqqPgHyWt+uyH
	 3IiGfW+UEcP2miloDLl0WYDfxSaz/nqJ0CUKKcKNta7OEmA5cLOy6Vsn4xF3ouaLlBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792769347;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=WuI4eN17B4C+OLPySzEF18wjfbpCjU6xL2dwOt9LOIM=;
	b=vj8rG6HrNuupjy6bsZATCPZ5bQR71XUca8GMBstXGSvDjaLTz15PSHbt/dResII8m+Uk
	 NFV/CUCsidRi5ennFNe0yTNKCXMHitXSjYbEuZTUqbFNMUW6DzY8aL7N6khM2MD8emP67
	 vZN3yjt5RwjzJ6BGVBKiUtCgSbslbrA8htf6/PX04J48FJzdsht8inlom/qksNDVdKsVP
	 jWqNb+ycMo5FZgPTZN11l8XdJ000ocstVYLdSP0JHLaaZKYlrgBzHuSShEozlPohG8flL
	 UOBnhl2bpqZOLhef4eNkc1WFYYXnrpwhv58bUvhVqoMFnYMMhJsBnn1cTvM4eiGkDow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB98606A327
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 15:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BB98606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 991761C14;
	Fri, 23 Oct 2026 08:29:02 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E965F3F673;
	Fri, 23 Oct 2026 08:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792769345; bh=rpTZxMbDyCTwm1qN1rvzPWmDGskbXmAYWwCB18O1Agk=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=LxObpB0rNBboXyuEi/cHdpT/+mZDjDJ2kGqkiRfugUNbWUpN+VT1nEZKUlLIg7NfS
	 4KvWNgzODO2LNZuP1H6beXfb79SByyja8amUgfEc03A1gY2rduy/gTXmj7idtn6Zni
	 /VD7Brn4g4b51dsdwNYroipbn+UmzbD95jDoPOLM=
Message-ID: <70ce461e-3c7e-40a5-9a23-082a0ad2f8f1@arm.com>
Date: Fri, 23 Oct 2026 16:29:00 +0100
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
From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: iommu: iommu_device_unregister() traversal racing concurrent
 client removal -> group use-after-free / refcount underflow (unconditional
 iommu_group_put, unlocked TOCTOU reads)
To: =?UTF-8?B?5b6Q5pmX57+U?= <xuhx@hust.edu.cn>, joro@8bytes.org,
 will@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <4eed6353.14843.1a162dc1a8f.Coremail.xuhx@hust.edu.cn>
Content-Language: en-GB
In-Reply-To: <4eed6353.14843.1a162dc1a8f.Coremail.xuhx@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/10/2026 10:05 am, 徐晗翔 wrote:
> When iommu_device_unregister()'s bus traversal releases a client
> device, nothing prevents iommu_release_device() from running on the
> same device a second time from the device_del() bus notifier -- and
> the release path's unlocked double-read of dev->iommu_group plus its
> unconditional iommu_group_put() (outside the "device actually found"
> branch) turn that double execution into a use-after-free of the group
> and its devices kobject, or a refcount underflow that frees the group
> early while other members still point at it.  Confirmed with KASAN on
> mainline 7.3: in a 3000-round race, 7 slab-use-after-free reports in
> kobject_put/refcount_warn_saturate with a closed three-stack witness
> (group allocated by the probe side, freed by the unregister traversal,
> touched again by the removal side), plus a NULL deref in
> __iommu_probe_device.
> 
> The two kernel paths involved have no lock in common: the traversal
> (remove_iommu_group(), drivers/iommu/iommu.c:273) and the bus notifier
> (device_del -> BUS_NOTIFY_REMOVED_DEVICE -> iommu_bus_notifier,
> iommu.c:1815) both funnel into iommu_release_device() (iommu.c:778),
> which takes neither iommu_probe_device_lock nor the group lock before
> its first read.  The kernel itself documents the hazard in the PCI
> reset helpers ("callers must ensure there will be no racy
> iommu_release_device() call, which otherwise would UAF the
> dev->iommu_group pointer", iommu.c:4029-4031) -- that contract is a
> caller-side convention with no mechanism behind it, and the traversal
> and the notifier are exactly the callers that were never made to
> ensure it.  Triggering needs a runtime-unregistrable IOMMU instance
> (virtio-iommu sysfs unbind, several platform IOMMUs) plus a concurrent
> client device removal (PCI remove/rescan, hotplug) -- both
> administrator actions, but each entirely legitimate on its own.

Drivers really shouldn't allow unbinding - if we can pull an IOMMU out 
from underneath client devices with active DMA (especially to translated 
addresses), a theoretical race against device hot-remove is hardly the 
biggest problem facing the system in that case...

Properly-implemented modular drivers can only be removed if and when 
they have no client devices - which in practice means they're usually 
non-removable - so one way or another this race would not exist.

That does still leave the case of unwinding from iommu_device_register() 
failure, but again that's already a sufficiently unexpected and serious 
condition that we can't necessarily expect the system to continue in a 
usable state at all, and if you want to start worrying about hot-remove 
during IOMMU registration that's probably a much bigger can of worms anyway.

Thanks,
Robin.

> 
> The detailed description:
> 
> * Test environment / affected version
> 
>    Linux version 7.3.0 (gcc 13.3.0, GNU ld 2.42) #1 SMP PREEMPT_DYNAMIC
>    -- vanilla mainline 7.3 release tarball (kernel.org, unmodified),
>    rebuilt with CONFIG_KASAN_GENERIC=y, CONFIG_IOMMU_SUPPORT=y,
>    CONFIG_IOMMU_API=y, QEMU/KVM x86_64 guest.  All functions cited
>    below are byte-identical in 7.1.5 and 7.3 (function-level diff);
>    line numbers are from 7.3.
> 
> * The two racing entries into the same release path
> 
>    A (instance unregister traversal):
>        iommu_device_unregister() (iommu.c:316)
>          -> bus_for_each_dev(..., remove_iommu_group)   /* :319 */
>          -> remove_iommu_group()                        /* :273 */
>               if (dev->iommu && dev->iommu->iommu_dev == data)   /* :275 */
>                       iommu_release_device(dev);
> 
>    B (client removal notification):
>        device_del() -> BUS_NOTIFY_REMOVED_DEVICE (fired without the
>        device_lock held) -> iommu_bus_notifier() (iommu.c:1815)
>          -> iommu_release_device(dev)
> 
>    Neither path takes iommu_probe_device_lock (which the probe side
>    uses to make dev->iommu stable, iommu.c:626/715); the group lock is
>    only acquired deep inside, after the unlocked reads.  The device
>    model does not serialize them: klist_del() only marks the node dead
>    and drops one reference, and the traversal's iterator pins the node
>    with kref_get -- so A's callback and B's notifier run concurrently
>    for the same device.
> 
> * What breaks inside iommu_release_device() (iommu.c:778-789)
> 
>        group = dev->iommu_group;             /* :781, unlocked read #1 */
>        if (group)
>                __iommu_group_remove_device(dev);
>        if (dev->iommu)
>                dev_iommu_free(dev);          /* :788, unlocked free when
>                                                  the group is gone */
> 
>    __iommu_group_remove_device() (iommu.c:751) then re-reads
>    dev->iommu_group (read #2 at :753) and locks it (:755) -- between
>    the two reads the other side can complete the whole removal inside
>    the group lock (iommu_deinit_device() clears dev->iommu_group at
>    :611 and frees the param at :613), so:
> 
>    - read #2 yields NULL -> mutex_lock(NULL) -> oops; or
>    - read #2 yields the same group, the find loop finds nothing (the
>      other side already list_del'ed it) and the code falls through to
>      the UNCONDITIONAL iommu_group_put(group) at :775 -- a put with no
>      matching get, because the only get paired with :775 is the group
>      membership reference (iommu_group_add_device(), iommu.c:1338),
>      which the winner already consumed.
> 
>    The group's reference sits on its devices kobject
>    (kobject_get/put(group->devices_kobj), iommu.c:1448/1462), so the
>    extra put either frees the group immediately (single-member,
>    no-external-ref topology -> every later access, including the
>    loser's own mutex_unlock and kobject_put, is a UAF) or drops the
>    kref early (refcount underflow -> premature kfree while other
>    members / the singleton pointer still reference it).
> 
>    Two more crossings of the same root, for completeness:
>    - remove_iommu_group()'s second dereference at :275
>      (dev->iommu->iommu_dev) races the param free (dev_iommu_free()
>      clears dev->iommu and kfrees the param), including the
>      probe-failure cleanup inside iommu_init_device() (iommu.c:544),
>      which holds the probe lock that the traversal does not take:
>      UAF read of the param.
>    - the "group == NULL but param != NULL" branch free at :788 races
>      the locked free at :613: double free of param/fwspec, or a
>      NULL+0x28 read in the loser's path.
> 
> * Evidence (7.3, KASAN)
> 
>    Reproducer attached (iommurace.c): registers a fake IOMMU instance
>    through the real exported core API and drives both entries with
>    real platform-bus devices -- kthread A loops
>    iommu_device_register/unregister, kthread B loops client
>    platform_device_add/del.  Usage:
> 
>      insmod iommurace.ko
>      echo setup > /sys/module/iommurace/parameters/action
>      echo "ab 3000" > /sys/module/iommurace/parameters/action
>      echo status > /sys/module/iommurace/parameters/action
> 
>    One 3000-round run (4 vCPU): 7 slab-use-after-free reports
>    (kobject_put x4, refcount_warn_saturate x3 -- the refcount
>    underflow family) plus one NULL deref at
>    __iommu_probe_device+0x2ad (address 0x28) as B's probe walked state
>    the concurrent unregister had already torn down; the module
>    reference count stays pinned at 1 afterwards (the poisoned state
>    skips the deinit that would module_put).  First report, closed
>    three-stack witness:
> 
>      access:  slab-use-after-free in kobject_put
>               by task iommurace_b (client removal side)
>      allocated: kobject_create_and_add <- iommu_group_alloc
>                 <- __iommu_probe_device <- iommu_probe_device
>                 <- iommu_bus_notifier        (removal side's earlier probe)
>      freed:     kfree <- kobject_put <- remove_iommu_group+0x67
>                 <- bus_for_each_dev
>                 <- iommu_device_unregister  (traversal side)
> 
>    This is exactly the "extra put frees the group / underflows the
>    kref" interleaving described above.  (Sequential baselines --
>    register/unregister loops and client add/del without the race --
>    produce zero reports during the test phases.  Note for running the
>    module: leave it loaded after the race actions; the poisoned state
>    intentionally pins its refcount, and the module's own rmmod path
>    has an unrelated software-node teardown ordering splat on 7.3.)
> 
> * Trigger model / affected configurations
> 
>    Any build where an IOMMU instance can be unregistered at runtime:
>    virtio-iommu (sysfs unbind), several platform IOMMU drivers (some
>    set suppress_bind_attrs; PCI hot-unplug paths remain), plus any
>    concurrent client removal the platform produces (PCI remove/rescan,
>    device_del on hotpluggable buses).  Both sides are administrator
>    actions; the consequence is kernel memory corruption (UAF
>    read/write, double free, premature group release leaving dangling
>    dev->iommu_group / singleton pointers for later users).
> 
> Thanks for taking a look.
> 
> Regards,
> Hanxiang Xu
> xuhx@hust.edu.cn
> 
> 

