Received: from sg-3-27.ptr.tlmpb.com (sg-3-27.ptr.tlmpb.com [101.45.255.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29274CCDF0
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788336492; cv=none; b=l2MvwXeTOv0/2G8YMHTmzgdL1hkp6MeQ/FWD8BrwXSN21v21TTSYPZDL3ehYSTVRjt5UQV1Xgyp1sJwpGWJuJ63YFkb/CnFn3+osf04fh13ZiJzFfVXa9oWkAdpuR2WGmE0/4uSIstAo7ivkiWfGHQwo5JVshV8IXGPSigIcqZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788336492; c=relaxed/simple;
	bh=Q83DtHeGnaSXKynOURw9BcEve26kEwOps/1w432YEXc=;
	h=Subject:Date:Message-Id:Content-Type:In-Reply-To:Cc:From:
	 Mime-Version:References:To; b=gFVKeFrvZBsyJqBKlscGInwPs6w8GFZ6O6XyLi8Sbe6g9sK2LKhwz9sFWFaWXDKV0VEPWPC/Zv2z5iRoDHXFaPa2PSpMe80Xn0ikUjRJ/LdACd7kSadqdonouSWdSWniBMJFUIbrLYLnAYAuLBiK5Pph8rTJ4QlKNx94lxB0pDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=PZCbv27G; arc=none smtp.client-ip=101.45.255.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="PZCbv27G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1788336442; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=JtUcpfCIQENx/RAqzn2XCRp4WPXE5eT3JQCOCuuv+HE=;
 b=PZCbv27GGJClC4UJJrXdSQdMd3+b6n9EO7mhXltb2MM9F2JtM3mmS+kRbELDodn1uI6dgW
 DfPj/ws1x23RssEXBcC+JEEx9a73vudtkkHQLXnXzsHGlSGaF9S5bn2oRPa2tpBUtHMXxo
 3NmVYQX+/ns8ZrKOKurlW/jvmW5p5a352eHacJOMGkjDapBUaoVrXySY7VV5Ret4rafa3N
 GMktlVKpoZELn4SBuae84/o3rmAWBNBBRBNHQuS6Yz9DJ5NJ9EeJQGHwIzBEbNgXcRqaDw
 GXDM9xiVB3d3+DXd8xRjFdTdSUQMC+tMlN6z1OYoW1WV/1jKFey1nU/NS7D9mA==
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
Subject: Re: [PATCH RESEND v7 3/3] drivers/perf: riscv-iommu: protect shared state with a raw spinlock
Date: Wed, 2 Sep 2026 16:07:16 +0800
Message-Id: <8267ee7a-98b7-42a5-b479-648d2bec8ade@picoheart.com>
X-Lms-Return-Path: <lba+26a97d938+2019d2+lists.linux.dev+yang.yicong@picoheart.com>
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20260828085819.4076449-4-zong.li@sifive.com>
Cc: <tomasz.jeznach@linux.dev>, <joro@8bytes.org>, <will@kernel.org>, 
	<robin.murphy@arm.com>, <pjw@kernel.org>, <palmer@dabbelt.com>, 
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <mark.rutland@arm.com>, 
	<andrew.jones@oss.qualcomm.com>, <guoren@kernel.org>, 
	<david.laight.linux@gmail.com>, <zhangzhanpeng.jasper@bytedance.com>, 
	<iommu@lists.linux.dev>, <linux-riscv@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, 
	<yang.yicong@picoheart.com>
From: "Yicong Yang" <yang.yicong@picoheart.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Received: from [100.86.218.63] ([61.141.241.110]) by smtp.feishu.cn with ESMTPS; Wed, 02 Sep 2026 16:07:19 +0800
Content-Language: en-US
References: <20260828085819.4076449-1-zong.li@sifive.com> <20260828085819.4076449-4-zong.li@sifive.com>
To: "Zong Li" <zong.li@sifive.com>

On 8/28/26 4:58 PM, Zong Li wrote:
> Events are bound to one CPU and the interrupt is affine to it, so the
> perf callbacks running with interrupts disabled would be enough to
> exclude the handler.
> 
> PCI MSI/MSI-X on IMSIC breaks that: the irqchip sets
> IRQCHIP_MOVE_DEFERRED, so irq_set_affinity() reports success while only
> recording the request, and the move is applied in interrupt context upon
> the next device interrupt. Until then the interrupt is still routed to
> the CPU IMSIC picked initially, so the first overflow interrupt can run
> concurrently with the perf callbacks on the CPU the events are bound to.
> 
> Take a raw spinlock, with interrupts disabled so that the handler can
> never interrupt a holder on the same CPU, rather than depending on that
> irqchip behaviour. It covers the state which is reachable from both
> sides:
> 
>  - IOCOUNTINH is read-modify-written by ->start()/->stop() and is saved
>    and restored around the whole handler.
>  - pmu->events[] is written by ->del() and read by the handler.
>  - hw_perf_event::prev_count is updated by both.
> 
> ->add() and ->del() call the unlocked __riscv_iommu_pmu_start() and
> __riscv_iommu_pmu_stop() so the lock is taken once per callback.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  drivers/perf/riscv_iommu_pmu.c | 66 ++++++++++++++++++++++++++++++----
>  1 file changed, 60 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/perf/riscv_iommu_pmu.c b/drivers/perf/riscv_iommu_pmu.c
> index f6acd56f2f61..ee2f6d1fbece 100644
> --- a/drivers/perf/riscv_iommu_pmu.c
> +++ b/drivers/perf/riscv_iommu_pmu.c
> @@ -101,6 +101,7 @@ struct riscv_iommu_pmu {
>  	u64 event_cntr_mask;
>  	struct perf_event *events[RISCV_IOMMU_HPM_COUNTER_NUM];
>  	DECLARE_BITMAP(used_counters, RISCV_IOMMU_HPM_COUNTER_NUM);
> +	raw_spinlock_t lock;
>  };
>  
>  #define to_riscv_iommu_pmu(p) (container_of(p, struct riscv_iommu_pmu, pmu))
> @@ -485,7 +486,8 @@ static void riscv_iommu_pmu_update(struct perf_event *event)
>  	local64_add(delta, &event->count);
>  }
>  
> -static void riscv_iommu_pmu_start(struct perf_event *event, int flags)
> +/* Called with pmu->lock held */
> +static void __riscv_iommu_pmu_start(struct perf_event *event, int flags)
>  {
>  	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
>  	struct hw_perf_event *hwc = &event->hw;
> @@ -500,11 +502,22 @@ static void riscv_iommu_pmu_start(struct perf_event *event, int flags)
>  	riscv_iommu_pmu_set_period(event);
>  	riscv_iommu_pmu_set_event(pmu, hwc->idx, hwc->config);
>  	riscv_iommu_pmu_enable_counter(pmu, hwc->idx);
> +}
> +
> +static void riscv_iommu_pmu_start(struct perf_event *event, int flags)
> +{
> +	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
> +	unsigned long irqflags;
> +
> +	raw_spin_lock_irqsave(&pmu->lock, irqflags);
> +	__riscv_iommu_pmu_start(event, flags);
> +	raw_spin_unlock_irqrestore(&pmu->lock, irqflags);

could use guard(raw_spinlock_irqsave)() to help handle the lock release.

I'm considering if it'll better to use irq_work or function call to handle the
counts update from the interrupt handler, e.g. in the irq handler first check
if current cpu is the pmu->on_cpu, if so update the counts, otherwise queue
the update work to pmu->on_cpu by irq work or smp_call_function_single_async.
In this way we can use pmu's original synchronization mechanism without
extra spin locks since the callbacks will always run and synchronized by
the same cpu, and the shared interrupt doesn't matter at all.

any thoughts on this?

thanks.

>  
>  	perf_event_update_userpage(event);
>  }
>  
> -static void riscv_iommu_pmu_stop(struct perf_event *event, int flags)
> +/* Called with pmu->lock held */
> +static void __riscv_iommu_pmu_stop(struct perf_event *event, int flags)
>  {
>  	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
>  	struct hw_perf_event *hwc = &event->hw;
> @@ -521,13 +534,26 @@ static void riscv_iommu_pmu_stop(struct perf_event *event, int flags)
>  	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
>  }
>  
> +static void riscv_iommu_pmu_stop(struct perf_event *event, int flags)
> +{
> +	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
> +	unsigned long irqflags;
> +
> +	raw_spin_lock_irqsave(&pmu->lock, irqflags);
> +	__riscv_iommu_pmu_stop(event, flags);
> +	raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> +}
> +
>  static int riscv_iommu_pmu_add(struct perf_event *event, int flags)
>  {
>  	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
>  	struct hw_perf_event *hwc = &event->hw;
>  	unsigned int num_counters = pmu->num_counters;
> +	unsigned long irqflags;
>  	unsigned int idx;
>  
> +	raw_spin_lock_irqsave(&pmu->lock, irqflags);
> +
>  	/* Reserve index zero for iohpmcycles */
>  	if (is_cycle_event(event->attr.config))
>  		idx = RISCV_IOMMU_HPM_CYCLE_IDX;
> @@ -535,8 +561,10 @@ static int riscv_iommu_pmu_add(struct perf_event *event, int flags)
>  		idx = find_next_zero_bit(pmu->used_counters, num_counters, 1);
>  
>  	/* All event counters or cycle counter are in use */
> -	if (idx == num_counters || pmu->events[idx])
> +	if (idx == num_counters || pmu->events[idx]) {
> +		raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
>  		return -EAGAIN;
> +	}
>  
>  	set_bit(idx, pmu->used_counters);
>  
> @@ -546,7 +574,9 @@ static int riscv_iommu_pmu_add(struct perf_event *event, int flags)
>  	local64_set(&hwc->prev_count, 0);
>  
>  	if (flags & PERF_EF_START)
> -		riscv_iommu_pmu_start(event, flags);
> +		__riscv_iommu_pmu_start(event, flags);
> +
> +	raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
>  
>  	/* Propagate changes to the userspace mapping. */
>  	perf_event_update_userpage(event);
> @@ -556,18 +586,26 @@ static int riscv_iommu_pmu_add(struct perf_event *event, int flags)
>  
>  static void riscv_iommu_pmu_read(struct perf_event *event)
>  {
> +	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
> +	unsigned long irqflags;
> +
> +	raw_spin_lock_irqsave(&pmu->lock, irqflags);
>  	riscv_iommu_pmu_update(event);
> +	raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
>  }
>  
>  static void riscv_iommu_pmu_del(struct perf_event *event, int flags)
>  {
>  	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
>  	struct hw_perf_event *hwc = &event->hw;
> +	unsigned long irqflags;
>  	int idx = hwc->idx;
>  
> -	riscv_iommu_pmu_stop(event, PERF_EF_UPDATE);
> +	raw_spin_lock_irqsave(&pmu->lock, irqflags);
> +	__riscv_iommu_pmu_stop(event, PERF_EF_UPDATE);
>  	pmu->events[idx] = NULL;
>  	clear_bit(idx, pmu->used_counters);
> +	raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
>  
>  	perf_event_update_userpage(event);
>  }
> @@ -635,12 +673,24 @@ static irqreturn_t riscv_iommu_pmu_irq_handler(int irq, void *dev_id)
>  {
>  	struct riscv_iommu_pmu *pmu = (struct riscv_iommu_pmu *)dev_id;
>  	DECLARE_BITMAP(ovf_bitmap, BITS_PER_TYPE(u64));
> +	unsigned long irqflags;
>  	u32 ovf, idx, inhibit;
>  
> -	/* Check whether this interrupt is for PMU */
> +	/*
> +	 * Check whether this interrupt is for PMU. Done outside the lock so
> +	 * that a shared interrupt line is left alone as cheaply as possible.
> +	 */
>  	if (!(readl_relaxed(pmu->reg + RISCV_IOMMU_REG_IPSR) & RISCV_IOMMU_IPSR_PMIP))
>  		return IRQ_NONE;
>  
> +	/*
> +	 * Hold the lock across the whole sequence below. Stopping the
> +	 * counters, processing them and restoring the previous inhibit state
> +	 * has to be atomic against ->start()/->stop(), otherwise a counter
> +	 * enabled in between would be inhibited again by the restore.
> +	 */
> +	raw_spin_lock_irqsave(&pmu->lock, irqflags);
> +
>  	/* Process PMU IRQ */
>  	inhibit = riscv_iommu_pmu_stop_all(pmu);
>  
> @@ -672,6 +722,8 @@ static irqreturn_t riscv_iommu_pmu_irq_handler(int irq, void *dev_id)
>  
>  	riscv_iommu_pmu_start_all(pmu, inhibit);
>  
> +	raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> +
>  	return IRQ_HANDLED;
>  }
>  
> @@ -735,6 +787,8 @@ static int riscv_iommu_pmu_probe(struct auxiliary_device *auxdev,
>  
>  	iommu_pmu->reg = iommu_dev->reg;
>  
> +	raw_spin_lock_init(&iommu_pmu->lock);
> +
>  	/*
>  	 * Counter number and width are hardware-implemented, detect them by
>  	 * writing 1s and reading back which bits stuck.
