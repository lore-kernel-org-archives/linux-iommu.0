Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CED176AA9
	for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719338597; cv=none; b=B+F4qrvXpSKBZD+LQCu/9jEt8ZHhlcUirKY2/NmSYDII6d5NOm1RenzToc/yXMqkDKxiSC+Tkoby+NfzbywRf+1NZq7WbzsYvUvA/hjW1pzHnj3XoafYE32GrQtXjmaPvLTi1VjTdHreUvBbTYZP1o/Bf7OtTxPVIgTmiNBHT20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719338597; c=relaxed/simple;
	bh=L58SEVlBTVvhb4St1IdsBg30ubcoO3Uti+SfHoLJW2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SsZCciOrKxdFivEErx/m9iQR2vdw7DRCU2OlC4mCl+cyQDsTVJX/QKkF7wULnoyGvDPVxnh8Xzf3JZ00RozkJdSl474MbzY5wy4HhwNsSssoUVCWBwWBZEZoEaxCsHXPSR6Y8InmdDXoTGcG6PE/bSeYrSvpwmJWgoiuJsypQ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBA66339;
	Tue, 25 Jun 2024 11:03:38 -0700 (PDT)
Received: from [10.57.73.131] (unknown [10.57.73.131])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11A793F73B;
	Tue, 25 Jun 2024 11:03:12 -0700 (PDT)
Message-ID: <53b7ec9c-9542-4f7a-960e-8cecaf428b27@arm.com>
Date: Tue, 25 Jun 2024 19:03:11 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/iova: Bettering utilizing cpu_rcaches in no-strict
 mode
To: "zhangzekun (A)" <zhangzekun11@huawei.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 "joro@8bytes.org" <joro@8bytes.org>, will@kernel.org,
 John Garry <john.g.garry@oracle.com>
References: <20240624083952.52612-1-zhangzekun11@huawei.com>
 <5149c162-cf38-4aa4-9e96-27c6897cad36@arm.com>
 <0322849d-dc1f-4e1c-a47a-463f3c301bdc@huawei.com>
 <c4c44f66-fb9c-4d71-ac35-f3fef75832bd@arm.com>
 <c6ae28eb-69b6-4508-a516-1d419e950b37@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <c6ae28eb-69b6-4508-a516-1d419e950b37@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-06-25 2:29 am, zhangzekun (A) wrote:
> 
> 
> 在 2024/6/24 21:32, Robin Murphy 写道:
> 
>>> This patch is firstly intent to minimize the chance of softlock issue 
>>> in fq_flush_timeout(), which is already dicribed erarlier in [1], 
>>> which has beed applied in a commercial kernel[2] for years.
>>>
>>> However, the later tests show that this single patch is not enough to 
>>> fix the softlockup issue, since the root cause of softlockup is the 
>>> underlying iova_rbtree_lock. In our softlockup scenarios, the average
>>> time cost to get this spinlock is about 6ms.
>>
>> That should already be fixed, though. The only reason for 
>> fq_flush_timeout() to interact with the rbtree at all was due to the 
>> notion of a fixed-size depot which could become full. That no longer 
>> exists since 911aa1245da8 ("iommu/iova: Make the rcache depot scale 
>> better").
>>
>> Thanks,
>> Robin.
>>
> Hi, Robin,
> 
> The commit 911aa1245da8 ("iommu/iova: Make the rcache depot scale 
> better") can reduce the risks of softlockup, but can not fix it 
> entirely. We do solve a softlockup issue[1] with that patch, and that is
> why it has aleady been backported in our branch. The softlockup issue 
> which we met recently is a 5.10-based kernel with that patch already 
> backported, which can be found in [2].

Sorry, I was implying some context that I should have made clear - yes, 
the softlockup can still happen in general if the flush queues are full 
of IOVAs which are too large for the rcache mechanism at all, so are 
always freed directly to the rbtree, but then there's no way *this* 
patch could make any difference to that case either.

Thanks,
Robin.

> In 6.7-rc4, which has already applied patch  911aa1245da8 ("iommu/iova: 
> Make the rcache depot scale better"). We can also get the following
> call trace. It seems still existing the issue, and we fix this issue 
> using the patch in [3], when the call trace first came up.
> 
> rcu: INFO: rcu_preempt self-detected stall on CPU
> rcu:     85-....: (5249 ticks this GP) idle=4d04/1/0x4000000000000000 
> softirq=428240/428240 fqs=1882
> rcu:     (t=5253 jiffies g=2005741 q=19446136 ncpus=128)
> CPU: 85 PID: 2401130 Comm: kpktgend_85 Kdump: loaded Tainted: G  O       
> 6.7.0-rc4+ #1
> 
> pc : _raw_spin_unlock_irqrestore+0x14/0x78
> lr : fq_flush_timeout+0x94/0x118
> sp : ffff8000802abdf0
> x29: ffff8000802abdf0 x28: ffff20201142e480 x27: 0000000000000002
> x26: ffffdeeb67e82b20 x25: 0000000000000000 x24: ffffdeeb67e87400
> x23: ffffdeeb67e82ba0 x22: ffff202009db1c00 x21: ffffdeeb67e82f40
> x20: 0000000000000000 x19: ffffdbe06f0140a8 x18: 0000000000040000
> x17: 0000000000000001 x16: 0000000000000040 x15: ffffffffffffffff
> x14: 0000000000001fff x13: 000000000003ffff x12: 0000000000000259
> x11: 000000000007ffff x10: 000000000000000d x9 : ffffdeeb6549ec84
> x8 : ffff0020886e0000 x7 : 000000000000964d x6 : 000001afa2986acb
> x5 : 01ffffffffffffff x4 : 0000000000000000 x3 : ffff202006b57d70
> x2 : 0000000000000015 x1 : 0000000000000000 x0 : ffffdbe06f0140a8
> Call trace:
>   _raw_spin_unlock_irqrestore+0x14/0x78
>   call_timer_fn+0x3c/0x1d0
>   expire_timers+0xcc/0x190
>   run_timer_softirq+0xfc/0x268
>   __do_softirq+0x128/0x3dc
>   ____do_softirq+0x18/0x30
>   call_on_irq_stack+0x24/0x30
>   do_softirq_own_stack+0x24/0x38
>   irq_exit_rcu+0xc0/0xe8
>   el1_interrupt+0x48/0xc0
>   el1h_64_irq_handler+0x18/0x28
>   el1h_64_irq+0x78/0x80
>   __schedule+0xf28/0x12a0
>   schedule+0x3c/0x108
>   schedule_timeout+0xa0/0x1d0
>   pktgen_thread_worker+0x1180/0x15d0
>   kthread+0x120/0x130
>   ret_from_fork+0x10/0x20
> 
> [1] https://gitee.com/openeuler/kernel/issues/I8KS9A
> [2] https://gitee.com/openeuler/kernel/tree/OLK-5.10/
> [3] https://lkml.org/lkml/2023/2/16/124
> 
> Thanks,
> Zekun
