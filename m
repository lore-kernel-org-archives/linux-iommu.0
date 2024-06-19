Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D798763FD
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 10:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718792911; cv=none; b=RA42hATpyDXLCss3vgO3v1CxD7u0/Fxz6sg+FcfwZXBePyDG76NmK3rNuyNd5V9Gn4jL7xlvz38XDzWeampPgnJemxhQ4Vuyz/fIiu+5EhttNiaLCWV7LbgVdrWwcns+nhYW3zBb3Df3xeI1hAx3UW6SYj9CLOfY5S5NuE92d14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718792911; c=relaxed/simple;
	bh=xerdFqPJeVz5RfrT2OmtpZ7S/Y8Ds0xSagglsBbNfHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBbiIrE24WrlgLG47WxtAQVOsUbR4JJxyLj1wgr2KHsL1+1q2+PMzDQagjZRhRBYRS+Luzp4sZAn0+d1GiuKwSodHUolHyxLMPpG4NLmizsuAsm0NComs/c8VbpX3vt4CDWj1E2j5dINVXJqgHuck3jUqHVlR/rQHhDfRPXBt94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4ef267f2912so334058e0c.0
        for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 03:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718792908; x=1719397708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsV/PS7CwLrNz7YnyMvaeNBIzbUQwqZIDKo5iSbVpkE=;
        b=q5eh7Xd0W9vC3uhGLh+mOV52yM1T8v/W/XqDOuN9HrLV8MdtJi8DtkxwziGBtphLhm
         N7rS1LpJdiuQjSLuaWEunNstQLH8+T4q4DthhyzakuDryXo0a79nd64eGbTAJkeuQqBi
         J5kOtuXMUXR4v4C78m4EnNT0ptl+5QVp8GviG2MP8gTUcuUuu+cedT//1DiXF/xYxuAQ
         G6wcuyIFy4/Wfms+/c90qPWxBsIVT3w/MlRlSdY2X1qHYVJ+Y6S5Hsr16zAazRlt3Vkr
         D9nVExrxTCJbfKAfCd6v28GglHG5ieiOoPTsigztAs/WEdOHamcLQFCVEZl+oiabvvKI
         ymtw==
X-Forwarded-Encrypted: i=1; AJvYcCVBQKOCeHlABd9wYPIsGEhPytliSGtDZQ8opdY0dTvLZw64YAU9YJhut0L0rRLJV13AZqpahcHDVIXlO+WNZFXOcls/yvk=
X-Gm-Message-State: AOJu0YyPZqyg+GZ2z+cfYsZLVrJue6SPOz4mi/zz/p01h6ZWA2x8WOav
	lkR+ZboVNHPa/0bg/nqSVXNRhyIp1SZS0Ce9rBWgKtz8W8YI/AMyu5rHo7PyYmgnjAVfg7SqbRp
	P7IYpmu7gBL644Zb3BgXjaYGUwcw=
X-Google-Smtp-Source: AGHT+IEXlhpbcDeQz8RM1VvfQNGl2XpRsfgdP2sFufz52/DPQmUKe/NfJFej6Z9vZmjfrEUrxA+u3WaDankQndRWlNc=
X-Received: by 2002:a05:6122:46a6:b0:4ec:fc6b:b473 with SMTP id
 71dfb90a1353d-4ef1ab2f8famr4777032e0c.8.1718792908156; Wed, 19 Jun 2024
 03:28:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240619092133.37411-1-yangyicong@huawei.com> <CAGsJ_4yrK=Zx2MR4OxjJLTHsKYWdM7SFhfAcFUSkS9dWgbnLtA@mail.gmail.com>
 <eb48b812-587b-080a-2e5a-a2943f51589f@huawei.com>
In-Reply-To: <eb48b812-587b-080a-2e5a-a2943f51589f@huawei.com>
From: Barry Song <baohua@kernel.org>
Date: Wed, 19 Jun 2024 22:28:17 +1200
Message-ID: <CAGsJ_4yvu+VaRUzKr58ZCbB_17qwkhaiNx8+G2GBNpnHyuGzCQ@mail.gmail.com>
Subject: Re: [PATCH] dma-mapping: benchmark: Don't starve others when doing
 the test
To: Yicong Yang <yangyicong@huawei.com>
Cc: chenxiang66@hisilicon.com, hch@lst.de, iommu@lists.linux.dev, 
	jonathan.cameron@huawei.com, prime.zeng@huawei.com, yangyicong@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 10:03=E2=80=AFPM Yicong Yang <yangyicong@huawei.com=
> wrote:
>
> On 2024/6/19 17:33, Barry Song wrote:
> > On Wed, Jun 19, 2024 at 9:27=E2=80=AFPM Yicong Yang <yangyicong@huawei.=
com> wrote:
> >>
> >> From: Yicong Yang <yangyicong@hisilicon.com>
> >>
> >> The test thread will start N benchmark kthreads and then schedule out
> >> until the test time finished and notify the benchmark kthreads to stop=
.
> >> The benchmark kthreads will keep running until notified to stop.
> >> There's a problem with current implementation when the benchmark
> >> kthreads number is equal to the CPUs on a non-preemptible kernel:
> >> since the scheduler will balance the kthreads across the CPUs and
> >> when the test time's out the test thread won't get a chance to be
> >> scheduled on any CPU then cannot notify the benchmark kthreads to stop=
.
> >>
> >> This can be easily reproduced on a VM (simulated with 16 CPUs) with
> >> PREEMPT_VOLUNTARY:
> >> estuary:/mnt$ ./dma_map_benchmark -t 16 -s 1
> >>  rcu: INFO: rcu_sched self-detected stall on CPU
> >>  rcu:     10-...!: (5221 ticks this GP) idle=3Ded24/1/0x40000000000000=
00 softirq=3D142/142 fqs=3D0
> >>  rcu:     (t=3D5254 jiffies g=3D-559 q=3D45 ncpus=3D16)
> >>  rcu: rcu_sched kthread starved for 5255 jiffies! g-559 f0x0 RCU_GP_WA=
IT_FQS(5) ->state=3D0x0 ->cpu=3D12
> >>  rcu:     Unless rcu_sched kthread gets sufficient CPU time, OOM is no=
w expected behavior.
> >>  rcu: RCU grace-period kthread stack dump:
> >>  task:rcu_sched       state:R  running task     stack:0     pid:16    =
tgid:16    ppid:2      flags:0x00000008
> >>  Call trace
> >>   __switch_to+0xec/0x138
> >>   __schedule+0x2f8/0x1080
> >>   schedule+0x30/0x130
> >>   schedule_timeout+0xa0/0x188
> >>   rcu_gp_fqs_loop+0x128/0x528
> >>   rcu_gp_kthread+0x1c8/0x208
> >>   kthread+0xec/0xf8
> >>   ret_from_fork+0x10/0x20
> >>  Sending NMI from CPU 10 to CPUs 0:
> >>  NMI backtrace for cpu 0
> >>  CPU: 0 PID: 332 Comm: dma-map-benchma Not tainted 6.10.0-rc1-vanilla-=
LSE #8
> >>  Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
> >>  pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> >>  pc : arm_smmu_cmdq_issue_cmdlist+0x218/0x730
> >>  lr : arm_smmu_cmdq_issue_cmdlist+0x488/0x730
> >>  sp : ffff80008748b630
> >>  x29: ffff80008748b630 x28: 0000000000000000 x27: ffff80008748b780
> >>  x26: 0000000000000000 x25: 000000000000bc70 x24: 000000000001bc70
> >>  x23: ffff0000c12af080 x22: 0000000000010000 x21: 000000000000ffff
> >>  x20: ffff80008748b700 x19: ffff0000c12af0c0 x18: 0000000000010000
> >>  x17: 0000000000000001 x16: 0000000000000040 x15: ffffffffffffffff
> >>  x14: 0001ffffffffffff x13: 000000000000ffff x12: 00000000000002f1
> >>  x11: 000000000001ffff x10: 0000000000000031 x9 : ffff800080b6b0b8
> >>  x8 : ffff0000c2a48000 x7 : 000000000001bc71 x6 : 0001800000000000
> >>  x5 : 00000000000002f1 x4 : 01ffffffffffffff x3 : 000000000009aaf1
> >>  x2 : 0000000000000018 x1 : 000000000000000f x0 : ffff0000c12af18c
> >>  Call trace:
> >>   arm_smmu_cmdq_issue_cmdlist+0x218/0x730
> >>   __arm_smmu_tlb_inv_range+0xe0/0x1a8
> >>   arm_smmu_iotlb_sync+0xc0/0x128
> >>   __iommu_dma_unmap+0x248/0x320
> >>   iommu_dma_unmap_page+0x5c/0xe8
> >>   dma_unmap_page_attrs+0x38/0x1d0
> >>   map_benchmark_thread+0x118/0x2c0
> >>   kthread+0xec/0xf8
> >>   ret_from_fork+0x10/0x20
> >>
> >> Solve this by adding scheduling point in the kthread loop to
> >> avoid starving others. This won't affect the test results
> >> since we only care about the time consumed by the
> >> dma_{map, unmap}_single().
> >>
> >> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> >> ---
> >>  kernel/dma/map_benchmark.c | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >>
> >> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> >> index 02205ab53b7e..2da9326c094c 100644
> >> --- a/kernel/dma/map_benchmark.c
> >> +++ b/kernel/dma/map_benchmark.c
> >> @@ -89,6 +89,15 @@ static int map_benchmark_thread(void *data)
> >>                 atomic64_add(map_sq, &map->sum_sq_map);
> >>                 atomic64_add(unmap_sq, &map->sum_sq_unmap);
> >>                 atomic64_inc(&map->loops);
> >> +
> >> +               /*
> >> +                * We may test for a long time so periodically yield t=
he
> >> +                * CPU to avoid starve the others, especially on the
> >> +                * non-preemptible kernel. This won't affect the test
> >> +                * results since we only care about the time consumed =
by
> >> +                * the dma_{map, unmap}_single().
> >> +                */
> >> +               cond_resched();
> >
> > We don't care about the time outside of dma_{map, unmap}_single(). Howe=
ver,
> > we do care about the concurrency. We use ndelay(map->bparam.dma_trans_n=
s);
> > to simulate DMA transmission. Your code entirely changes the concurrenc=
y.
> >
>
> I imagine 2 cases here:
> 1) If only us running on the CPU, cond_resched() will not make us schedul=
e out.
> 2) Otherwise we'll be managed by the scheduler with other tasks. This wil=
l be more realistic
>    in a system.
>
> For testing SMMU the case 1) is more general for us. But I don't think in=
 both case
> the cocurrency will be broke, the test kthreads still running concurrenct=
ly. But they
> need to share the cpu time with other threads if we have some other loads=
 in the system.
>
> The initial idea of this patch is to fix the hangup in the case that the =
test kthreads
> number is greater or equal to the CPU numaber. In such case the test kthr=
eads will be
> running infinitely since the thread responsible to notify the end of the =
test cannot
> be scheduled in a non-preemptible kernel. This is described in the commit=
 message.

I guess you mean this,

        for (i =3D 0; i < threads; i++) {
                ret =3D kthread_stop(tsk[i]);
                if (ret)
                        goto out;
        }

That's what I missed. Sorry about that.

My point is that this is just a test program, not a real workload.
Therefore, we don't want it to be
too complex. Allowing others to preempt it changes the degree of
concurrency, as we are
intentionally slowing down the DMA map/unmap requests.

However, I agree with your point that we need to ensure the program
functions correctly
and does not crash.
As long as we run the benchmark on an idle system, it should be fine.

Please correct the comment "This won't affect the test results since
we only care about
the time consumed by the dma_{map, unmap}_single()"which is actually mislea=
ding.
Alternatively, explain the real problem and note that this benchmark
is intended to run
on an idle system.

And w/ that,

Acked-by: Barry Song <baohua@kernel.org>

>

Thanks
Barry
