Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411BB79DDB
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718789608; cv=none; b=HgejnxyIGHrITCMVb3xzFtJXra7caFywHnXnVNbc+n5jYzSEuLbMemoo+aRJ7KA+3uxnJwxITz8bY4m/as/Q/1TuqE5Ul5/pNBtsuJiPMNFbbrZUwzAVRd4/rmiP/FUyPVc/TnemussiyVfHVgyf5gzF4yEVuaNaYZP0M4muUyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718789608; c=relaxed/simple;
	bh=FFIaWc0A9F8h8RKW1SFHyXQ00lWXXlgI0sFkaQmSwXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5/SuGIiwtGqdVEKwhVPnao1JW2U4V+CnKXhP6H3G3t8QUIopNr4Hi8jQEns/rtEaYFLWQL2A6h0AeD7Lb6VvA+KwBbV9I0/d/SKG7fvrgoLBBHCqKRkDa+nqefSGwrYHBwZspHfAXHFgZhgR8nonmNa+HhGxfHXCk+xbKs5fbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4ecf1013d73so1899601e0c.2
        for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 02:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718789606; x=1719394406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylDz14lSOjbKuZVwpK1ABbk+/Nwu5W6FcLF+SwegSgI=;
        b=QgAyW9E2cUwcFxSR+CY1T0Cafv0E0hmLEZ0QNpKMhtcCe1aLWw791Q1Wax/YBCXjK5
         ROrEqwDVF196SOnorfOpvOi3cpgxfMi3skuybEtBbXfCFwZp1Ol4EYmfaTH+QIrRfxXn
         5uZaEWFi4T+sQ7Kw9Id0uShUDxZuHAPpqu910ynpM8nQf3NXEk7kDrmZfUrYlienwyJ4
         y/1fux8dWWTCEPcLsmrAjmA/xu4407baDbJMF7iyzRbspFVUiujfp/WXgpnvX8XpWT8X
         KUpfupIa/juVhV3s+hacScV5ZpO2HphBlKwjc8s3HopONTv7OYrzlBaXDZpi4TPEMs7L
         /xsg==
X-Forwarded-Encrypted: i=1; AJvYcCXoZkH7sOPgYqo4VbjjQfvd35KSwTVLeP6/qVoac572jNSyxis+Dmq386DlcwPJOOuXJlhmQtS76EOhJbjo0YNOdEgr52E=
X-Gm-Message-State: AOJu0YwiU56WzIMQnl2MugMbvrs0lNEmLxlUtSHSg3SCDclh2jB7/D3u
	NAy7dkJsHen2u/x9eK7g0iXtaqIn8fcN1b4zzB/GUxJ0XNCKNOs89zfQE5+dx7FP0s4ok41nBb1
	eZhOF93MBRXxm3YN24CrxDzMypr8=
X-Google-Smtp-Source: AGHT+IEhl3fxIyD+Vnn2+mk0Z4UcRl0qgybsY+JSw6Z9WTgrQzcoNxzlUjTdLt5z3IQbTtmOu9p9xun8TYymSKy2m08=
X-Received: by 2002:a05:6122:17a0:b0:4ec:fa1c:decf with SMTP id
 71dfb90a1353d-4ef276a8ab6mr2299422e0c.5.1718789605992; Wed, 19 Jun 2024
 02:33:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240619092133.37411-1-yangyicong@huawei.com>
In-Reply-To: <20240619092133.37411-1-yangyicong@huawei.com>
From: Barry Song <baohua@kernel.org>
Date: Wed, 19 Jun 2024 21:33:14 +1200
Message-ID: <CAGsJ_4yrK=Zx2MR4OxjJLTHsKYWdM7SFhfAcFUSkS9dWgbnLtA@mail.gmail.com>
Subject: Re: [PATCH] dma-mapping: benchmark: Don't starve others when doing
 the test
To: Yicong Yang <yangyicong@huawei.com>
Cc: chenxiang66@hisilicon.com, hch@lst.de, iommu@lists.linux.dev, 
	jonathan.cameron@huawei.com, prime.zeng@huawei.com, linuxarm@huawei.com, 
	yangyicong@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 9:27=E2=80=AFPM Yicong Yang <yangyicong@huawei.com>=
 wrote:
>
> From: Yicong Yang <yangyicong@hisilicon.com>
>
> The test thread will start N benchmark kthreads and then schedule out
> until the test time finished and notify the benchmark kthreads to stop.
> The benchmark kthreads will keep running until notified to stop.
> There's a problem with current implementation when the benchmark
> kthreads number is equal to the CPUs on a non-preemptible kernel:
> since the scheduler will balance the kthreads across the CPUs and
> when the test time's out the test thread won't get a chance to be
> scheduled on any CPU then cannot notify the benchmark kthreads to stop.
>
> This can be easily reproduced on a VM (simulated with 16 CPUs) with
> PREEMPT_VOLUNTARY:
> estuary:/mnt$ ./dma_map_benchmark -t 16 -s 1
>  rcu: INFO: rcu_sched self-detected stall on CPU
>  rcu:     10-...!: (5221 ticks this GP) idle=3Ded24/1/0x4000000000000000 =
softirq=3D142/142 fqs=3D0
>  rcu:     (t=3D5254 jiffies g=3D-559 q=3D45 ncpus=3D16)
>  rcu: rcu_sched kthread starved for 5255 jiffies! g-559 f0x0 RCU_GP_WAIT_=
FQS(5) ->state=3D0x0 ->cpu=3D12
>  rcu:     Unless rcu_sched kthread gets sufficient CPU time, OOM is now e=
xpected behavior.
>  rcu: RCU grace-period kthread stack dump:
>  task:rcu_sched       state:R  running task     stack:0     pid:16    tgi=
d:16    ppid:2      flags:0x00000008
>  Call trace
>   __switch_to+0xec/0x138
>   __schedule+0x2f8/0x1080
>   schedule+0x30/0x130
>   schedule_timeout+0xa0/0x188
>   rcu_gp_fqs_loop+0x128/0x528
>   rcu_gp_kthread+0x1c8/0x208
>   kthread+0xec/0xf8
>   ret_from_fork+0x10/0x20
>  Sending NMI from CPU 10 to CPUs 0:
>  NMI backtrace for cpu 0
>  CPU: 0 PID: 332 Comm: dma-map-benchma Not tainted 6.10.0-rc1-vanilla-LSE=
 #8
>  Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>  pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>  pc : arm_smmu_cmdq_issue_cmdlist+0x218/0x730
>  lr : arm_smmu_cmdq_issue_cmdlist+0x488/0x730
>  sp : ffff80008748b630
>  x29: ffff80008748b630 x28: 0000000000000000 x27: ffff80008748b780
>  x26: 0000000000000000 x25: 000000000000bc70 x24: 000000000001bc70
>  x23: ffff0000c12af080 x22: 0000000000010000 x21: 000000000000ffff
>  x20: ffff80008748b700 x19: ffff0000c12af0c0 x18: 0000000000010000
>  x17: 0000000000000001 x16: 0000000000000040 x15: ffffffffffffffff
>  x14: 0001ffffffffffff x13: 000000000000ffff x12: 00000000000002f1
>  x11: 000000000001ffff x10: 0000000000000031 x9 : ffff800080b6b0b8
>  x8 : ffff0000c2a48000 x7 : 000000000001bc71 x6 : 0001800000000000
>  x5 : 00000000000002f1 x4 : 01ffffffffffffff x3 : 000000000009aaf1
>  x2 : 0000000000000018 x1 : 000000000000000f x0 : ffff0000c12af18c
>  Call trace:
>   arm_smmu_cmdq_issue_cmdlist+0x218/0x730
>   __arm_smmu_tlb_inv_range+0xe0/0x1a8
>   arm_smmu_iotlb_sync+0xc0/0x128
>   __iommu_dma_unmap+0x248/0x320
>   iommu_dma_unmap_page+0x5c/0xe8
>   dma_unmap_page_attrs+0x38/0x1d0
>   map_benchmark_thread+0x118/0x2c0
>   kthread+0xec/0xf8
>   ret_from_fork+0x10/0x20
>
> Solve this by adding scheduling point in the kthread loop to
> avoid starving others. This won't affect the test results
> since we only care about the time consumed by the
> dma_{map, unmap}_single().
>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  kernel/dma/map_benchmark.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index 02205ab53b7e..2da9326c094c 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -89,6 +89,15 @@ static int map_benchmark_thread(void *data)
>                 atomic64_add(map_sq, &map->sum_sq_map);
>                 atomic64_add(unmap_sq, &map->sum_sq_unmap);
>                 atomic64_inc(&map->loops);
> +
> +               /*
> +                * We may test for a long time so periodically yield the
> +                * CPU to avoid starve the others, especially on the
> +                * non-preemptible kernel. This won't affect the test
> +                * results since we only care about the time consumed by
> +                * the dma_{map, unmap}_single().
> +                */
> +               cond_resched();

We don't care about the time outside of dma_{map, unmap}_single(). However,
we do care about the concurrency. We use ndelay(map->bparam.dma_trans_ns);
to simulate DMA transmission. Your code entirely changes the concurrency.

>         }
>
>  out:
> --
> 2.24.0
>

Thanks
Barry
