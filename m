Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CB33C00
	for <iommu@lists.linux.dev>; Thu, 20 Jun 2024 03:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718854365; cv=none; b=rEsY+8dJixrrFst1NcZagdg5O2uvVXOQ5SKv41u159hacLI2Wrb2uVV4Q3vQE6BcRv/bjxZ02t+Jn+cb9vlaJOdvcugMPKZGi8w2pKsFLqb8XaK1okHwaP0udO5O1WUe0pr61nWtAPiKicWYKDDIQ3XoQpedo+syO9W4vYxHHWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718854365; c=relaxed/simple;
	bh=uVUGA8tRzs0/e3loZzge4jGZVqc2SJ6qNIM7xjavFnI=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CvzjQbIImOzh+gyAxam/xJzp6609b29mrDX3oqPYkUTQq48TKgTYVwsL4ce3R/rju+IeYyy4Jzv/tDJsmMS8XQQBwvPqkQR9Z/PDfE83AsyHe1XpIS+H7syaxU74cnyEZXYpzjXk79o4dWIAgYKrqbxDZvS1c+8K+wvNA2reNPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W4QXG1fM0zxSYL;
	Thu, 20 Jun 2024 11:12:30 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 183BB180087;
	Thu, 20 Jun 2024 11:16:43 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 11:16:42 +0800
CC: <yangyicong@hisilicon.com>, <chenxiang66@hisilicon.com>, <hch@lst.de>,
	<iommu@lists.linux.dev>, <jonathan.cameron@huawei.com>,
	<prime.zeng@huawei.com>
Subject: Re: [PATCH] dma-mapping: benchmark: Don't starve others when doing
 the test
To: Barry Song <baohua@kernel.org>
References: <20240619092133.37411-1-yangyicong@huawei.com>
 <CAGsJ_4yrK=Zx2MR4OxjJLTHsKYWdM7SFhfAcFUSkS9dWgbnLtA@mail.gmail.com>
 <eb48b812-587b-080a-2e5a-a2943f51589f@huawei.com>
 <CAGsJ_4yvu+VaRUzKr58ZCbB_17qwkhaiNx8+G2GBNpnHyuGzCQ@mail.gmail.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <f254860e-1f73-e565-3f24-45451f6f87a0@huawei.com>
Date: Thu, 20 Jun 2024 11:16:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAGsJ_4yvu+VaRUzKr58ZCbB_17qwkhaiNx8+G2GBNpnHyuGzCQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2024/6/19 18:28, Barry Song wrote:
> On Wed, Jun 19, 2024 at 10:03 PM Yicong Yang <yangyicong@huawei.com> wrote:
>>
>> On 2024/6/19 17:33, Barry Song wrote:
>>> On Wed, Jun 19, 2024 at 9:27 PM Yicong Yang <yangyicong@huawei.com> wrote:
>>>>
>>>> From: Yicong Yang <yangyicong@hisilicon.com>
>>>>
>>>> The test thread will start N benchmark kthreads and then schedule out
>>>> until the test time finished and notify the benchmark kthreads to stop.
>>>> The benchmark kthreads will keep running until notified to stop.
>>>> There's a problem with current implementation when the benchmark
>>>> kthreads number is equal to the CPUs on a non-preemptible kernel:
>>>> since the scheduler will balance the kthreads across the CPUs and
>>>> when the test time's out the test thread won't get a chance to be
>>>> scheduled on any CPU then cannot notify the benchmark kthreads to stop.
>>>>
>>>> This can be easily reproduced on a VM (simulated with 16 CPUs) with
>>>> PREEMPT_VOLUNTARY:
>>>> estuary:/mnt$ ./dma_map_benchmark -t 16 -s 1
>>>>  rcu: INFO: rcu_sched self-detected stall on CPU
>>>>  rcu:     10-...!: (5221 ticks this GP) idle=ed24/1/0x4000000000000000 softirq=142/142 fqs=0
>>>>  rcu:     (t=5254 jiffies g=-559 q=45 ncpus=16)
>>>>  rcu: rcu_sched kthread starved for 5255 jiffies! g-559 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=12
>>>>  rcu:     Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.
>>>>  rcu: RCU grace-period kthread stack dump:
>>>>  task:rcu_sched       state:R  running task     stack:0     pid:16    tgid:16    ppid:2      flags:0x00000008
>>>>  Call trace
>>>>   __switch_to+0xec/0x138
>>>>   __schedule+0x2f8/0x1080
>>>>   schedule+0x30/0x130
>>>>   schedule_timeout+0xa0/0x188
>>>>   rcu_gp_fqs_loop+0x128/0x528
>>>>   rcu_gp_kthread+0x1c8/0x208
>>>>   kthread+0xec/0xf8
>>>>   ret_from_fork+0x10/0x20
>>>>  Sending NMI from CPU 10 to CPUs 0:
>>>>  NMI backtrace for cpu 0
>>>>  CPU: 0 PID: 332 Comm: dma-map-benchma Not tainted 6.10.0-rc1-vanilla-LSE #8
>>>>  Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>>>>  pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>>  pc : arm_smmu_cmdq_issue_cmdlist+0x218/0x730
>>>>  lr : arm_smmu_cmdq_issue_cmdlist+0x488/0x730
>>>>  sp : ffff80008748b630
>>>>  x29: ffff80008748b630 x28: 0000000000000000 x27: ffff80008748b780
>>>>  x26: 0000000000000000 x25: 000000000000bc70 x24: 000000000001bc70
>>>>  x23: ffff0000c12af080 x22: 0000000000010000 x21: 000000000000ffff
>>>>  x20: ffff80008748b700 x19: ffff0000c12af0c0 x18: 0000000000010000
>>>>  x17: 0000000000000001 x16: 0000000000000040 x15: ffffffffffffffff
>>>>  x14: 0001ffffffffffff x13: 000000000000ffff x12: 00000000000002f1
>>>>  x11: 000000000001ffff x10: 0000000000000031 x9 : ffff800080b6b0b8
>>>>  x8 : ffff0000c2a48000 x7 : 000000000001bc71 x6 : 0001800000000000
>>>>  x5 : 00000000000002f1 x4 : 01ffffffffffffff x3 : 000000000009aaf1
>>>>  x2 : 0000000000000018 x1 : 000000000000000f x0 : ffff0000c12af18c
>>>>  Call trace:
>>>>   arm_smmu_cmdq_issue_cmdlist+0x218/0x730
>>>>   __arm_smmu_tlb_inv_range+0xe0/0x1a8
>>>>   arm_smmu_iotlb_sync+0xc0/0x128
>>>>   __iommu_dma_unmap+0x248/0x320
>>>>   iommu_dma_unmap_page+0x5c/0xe8
>>>>   dma_unmap_page_attrs+0x38/0x1d0
>>>>   map_benchmark_thread+0x118/0x2c0
>>>>   kthread+0xec/0xf8
>>>>   ret_from_fork+0x10/0x20
>>>>
>>>> Solve this by adding scheduling point in the kthread loop to
>>>> avoid starving others. This won't affect the test results
>>>> since we only care about the time consumed by the
>>>> dma_{map, unmap}_single().
>>>>
>>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>>>> ---
>>>>  kernel/dma/map_benchmark.c | 9 +++++++++
>>>>  1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
>>>> index 02205ab53b7e..2da9326c094c 100644
>>>> --- a/kernel/dma/map_benchmark.c
>>>> +++ b/kernel/dma/map_benchmark.c
>>>> @@ -89,6 +89,15 @@ static int map_benchmark_thread(void *data)
>>>>                 atomic64_add(map_sq, &map->sum_sq_map);
>>>>                 atomic64_add(unmap_sq, &map->sum_sq_unmap);
>>>>                 atomic64_inc(&map->loops);
>>>> +
>>>> +               /*
>>>> +                * We may test for a long time so periodically yield the
>>>> +                * CPU to avoid starve the others, especially on the
>>>> +                * non-preemptible kernel. This won't affect the test
>>>> +                * results since we only care about the time consumed by
>>>> +                * the dma_{map, unmap}_single().
>>>> +                */
>>>> +               cond_resched();
>>>
>>> We don't care about the time outside of dma_{map, unmap}_single(). However,
>>> we do care about the concurrency. We use ndelay(map->bparam.dma_trans_ns);
>>> to simulate DMA transmission. Your code entirely changes the concurrency.
>>>
>>
>> I imagine 2 cases here:
>> 1) If only us running on the CPU, cond_resched() will not make us schedule out.
>> 2) Otherwise we'll be managed by the scheduler with other tasks. This will be more realistic
>>    in a system.
>>
>> For testing SMMU the case 1) is more general for us. But I don't think in both case
>> the cocurrency will be broke, the test kthreads still running concurrenctly. But they
>> need to share the cpu time with other threads if we have some other loads in the system.
>>
>> The initial idea of this patch is to fix the hangup in the case that the test kthreads
>> number is greater or equal to the CPU numaber. In such case the test kthreads will be
>> running infinitely since the thread responsible to notify the end of the test cannot
>> be scheduled in a non-preemptible kernel. This is described in the commit message.
> 
> I guess you mean this,
> 
>         for (i = 0; i < threads; i++) {
>                 ret = kthread_stop(tsk[i]);
>                 if (ret)
>                         goto out;
>         }
> 
> That's what I missed. Sorry about that.
> 
yes problem takes here. In the issue case this won't be executed.

> My point is that this is just a test program, not a real workload.
> Therefore, we don't want it to be
> too complex. Allowing others to preempt it changes the degree of
> concurrency, as we are
> intentionally slowing down the DMA map/unmap requests.
> 
> However, I agree with your point that we need to ensure the program
> functions correctly
> and does not crash.
> As long as we run the benchmark on an idle system, it should be fine.
> 
> Please correct the comment "This won't affect the test results since
> we only care about
> the time consumed by the dma_{map, unmap}_single()"which is actually misleading.
> Alternatively, explain the real problem and note that this benchmark
> is intended to run
> on an idle system.
> 

Will update the comments here to get this fixed and mention the restriction.

> And w/ that,
> 
> Acked-by: Barry Song <baohua@kernel.org>
> 

Thanks.

