Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C1741DED5
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786971415; cv=pass; b=L4EkNmmfz8t7yhLuc5S/SfsdCfBX01MmDn4vUbCrr77+H+J6Rp2PHsc9GtM0hMvCww9VmKNyy7lAAMwJ+nLsH7ROceSsPO/p9sDa2txxGaaWENRV+DTguRxIYQrFG0bNi5sS38SVBhwLnJUmnJsxIzK7dlLISwbGmtIamDVp0Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786971415; c=relaxed/simple;
	bh=rdWjFo8SxHgUJL7l2Ksyu9UqQR1+bU8OTWc0M3vDGyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JgoGWMTbIHJQj/6OpwJ1xNAWnfowHaKFO8b3yJLFNoayn74GT6vIErMf6D5fhBg/ylj4vA2hekjQnSnK+MWFu92/CPF1UbsZd7MJoCdQi1iOn9IEAEW5v7zpESoP8bYMnVY0uE5e+KNDfSClo0Bu3ttxQdAlzO3hfBcrNDZyhmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDayuwRi; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDayuwRi"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-81ce92c1b05so2036387b3.3
        for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 05:56:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786971413; cv=none;
        d=google.com; s=arc-20260327;
        b=L6sBDnfnAXm6zTLUPli5jo1AOqs69qK/R2mNOd07Y23D3H3TnLxwb3o3RpPM0/IpA9
         wt7aUS+WBlI0sc5ok+fo8RxQS2cHoM45zIK2KXoOqyutJ/tgEZxyZ8fFbjag8mu/ZZCX
         dDcjuP/RXayPfAFbyRPqm0//IACOSrb7rxXsb+jHHDNdMu63UITpiZ4ZhU12nB/gInTW
         YW3WQv9b4wf9IUdSisK2AF7EHsOfpg+UKuVuYjGqUXBE66pDXqCU4GRwgAu2CQEPE4dv
         JCNbzHjMH1PJLv/t+Kp/GidPHyLP/FkeGzrgclIadvgBvb1n77cg7xfb0exrf0A4eQSh
         RvEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+sWYGz5XT9OAhWSz7+RnTv94A8j0P9pbFdVtTXC675o=;
        fh=/j5Z3kc+ODdEeoXFKlLFyDeiUsRYdtRlhbUsWfp8XUw=;
        b=iZ01+knniQo2oBDAOwqq08hxGW/PgJDN2TebIqeu/LO+sHuSRyTGh0HXSqmaDqSNx4
         ZEXSCb/9hv1IO1lhYsgavAIlBV2JqCnSHOQqppRm7VuTwojYUw+y2fCvPsnM1cA+Tspa
         i8Pi+/haJ9EhEb2GRD87B9ZO3NmnTW1euUBM0VecECqqt+KhpCXhGYj/LGnFl79x0Fkm
         mI/MzhOmCYYQTDKpiptA9P2CgbGFlsZRCo7wQ/+g+fWPt2oPX4bvv9USvMSmqU/nqx75
         R5Mx2Z1SwRpKtfQhx43ea/O9L5LA2CTzsAfElMjsTlt6n76zB97G90YHuTALbyHr4fA+
         u7Yg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786971413; x=1787576213; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+sWYGz5XT9OAhWSz7+RnTv94A8j0P9pbFdVtTXC675o=;
        b=SDayuwRiKAMnpYX6tDdIBtnqvIogHWiBcu5sfyaVW9Vh9WT27VhllsMrCRzCzy3BTp
         CogO2In+Er9rP3/GHx3De3+75eQUUNG3ZBIcEKehA7Ps7k7+9gjyaKqOvxbts9xkg2gk
         Fc3dbaAGE6oahBAPpJQOsQbCA6RlAqd76QkmKf6r+8ru6RSQtSI2T8bzWsZH1m0chhaC
         iSTNI/dH8ZiyxrtLVPHvb7BAGYq25AthQ2motFzRANR63ELP3oqW6yKUdJ8E3tLPRatj
         2Hv+UsVKLPqll1p8tyyY1CxX2ifzCI5hWugx78SqKB0My5fn4gBK5pM67MCbJY9JSt/G
         o27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786971413; x=1787576213;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+sWYGz5XT9OAhWSz7+RnTv94A8j0P9pbFdVtTXC675o=;
        b=n4v3U5jLVXn47YgBgggX3+rPbhVIEN0c6oGh8pZTw0lsSYxJbDMHSX/oIYf+VPXQxK
         Aijr54r+vUybucL/u+COPHpflNrs2Q9NDTnH+ln9gSQxbDm/Cdf3z0Ofig8YvDH5qQCE
         1BBvPJWiHF+C3OlmKGYnguraBtGONsXPha19vAJgF2olWsqdDvMZZ3aAj2RVWxozidWQ
         ev4vX3mKXvGehwS8vMqztfsZzbCYwpI0Y0Bg2wM7h7CemaaiOud9XN9vDGQbutU+P0Ke
         XoE/hUnzOCk5VD/JgSXc/H0C1PYjtN9FjvcWmza+Dqh0TKCFvgCLadmz/s6n/k60k7NV
         5Tyg==
X-Forwarded-Encrypted: i=1; AHgh+RrgWrVtDDDW/v6Tv3H09GFVgCc3vG1ZpnNJbXpY/aQCaABEqoABX7zawrozGlaNsEVvS9x3YQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw14CyT7ehr+2e+aw7AuRCvQa6KftdmLpi1EsL+1clLAYyY4+5l
	0LI5RF++zhGDUt34eehmMTjTZtY+XgsINc9d9EXIHbMEYWw3wDdVrpsWvYwBb0JWsQn15iTG8aA
	0lV7dlfWjSNedwigujt8zdWyP2puyreI=
X-Gm-Gg: AR+sD12juRxz55i08yP9LyjoEvoac5GWPD4q1z6jBpxWaEtn6dbyFwZluOGkiQMSqah
	eGZct6YpLn+b8Zi5uJ7IarM1d8qYmNEjEPKpPQI+GJNQqRj5iuSdEO/1BZq9loWClxBmV2RtcwJ
	XcyNO7AEc8hEnV1fHE/JJ6tDG/MAgFZpdEGcez0W7TkQbOkC/KRJGEf0pbtjnwplT5XyiLO8wvH
	G/HF20JsX9QFNYQGkA4hCd5CtU+FTWql5JxOiE6bLuC+DYeKrtPV9uaachAlO59B7qRWRCuamhV
	9lfEWNcLqsNb4j+8+R7RNxNeXt8cvOwtPT4p0dnebS0zX2lX8X0RT3BD7n0PBOoHnL64Jrva1Bk
	m+L8=
X-Received: by 2002:a05:690c:4c07:b0:7f0:9099:daed with SMTP id
 00721157ae682-837081dbb86mr86189087b3.0.1786971412607; Mon, 17 Aug 2026
 05:56:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260817113603.1436067-1-gahing@gahingwoo.com> <20260817113603.1436067-3-gahing@gahingwoo.com>
In-Reply-To: <20260817113603.1436067-3-gahing@gahingwoo.com>
From: Igor Paunovic <royalnet026@gmail.com>
Date: Mon, 17 Aug 2026 14:56:40 +0200
X-Gm-Features: AcwNN1V-5NLT5_FLJWlZREIascUsv5ajt7d1tsDmiA1E2hxh05iV2LoVrZcqDUw
Message-ID: <CAEWPSH7tM9WQUJ0H13ghkiHGzDcdycC1syTuO5B8DpC6cUSnfg@mail.gmail.com>
Subject: Re: [PATCH v8 02/12] accel/rocket: wait for a running IRQ handler
 before resetting a core
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de, 
	ogabbay@kernel.org, zhangqing@rock-chips.com, chaoyi.chen@rock-chips.com, 
	diederik@cknow-tech.com, alchark@flipper.net, dri-devel@lists.freedesktop.org, 
	linux-rockchip@lists.infradead.org, iommu@lists.linux.dev, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiaxing,

I have not run v8 on hardware yet. Everything below is source review.
My Tested-by on 1/12 is from the v7 run and I am not extending it to
this patch yet; the last section says why, and what I will run instead.
Line numbers are next-20260814.

The patch is right and the reasoning in the message is right.
synchronize_irq() is the correct one of the pair: __synchronize_irq()
does the hardirq spin and then waits on desc->wait_for_threads
(kernel/irq/manage.c), so it fences the threaded handler, which is the
one that takes job_lock. synchronize_hardirq() would not have. Worth
adding to your placement argument: the deadlock you avoided would have
been a silent hang rather than a lockdep splat, because that wait is on
a waitqueue and not on a lock, so lockdep does not model it at all.
Nothing would have told you.

Two questions, both about what the reset path does not do.

1. Would you also mask the block before the sync?

rocket_reset() is descended from panfrost_reset(), and the comment this
patch replaces is inherited from it word for word. In panfrost that
comment is earned, because three things happen before it:

    job_write(pfdev, JOB_INT_MASK, 0);
    synchronize_irq(pfdev->js->irq);
    ... soft-stop ...
    panfrost_jm_handle_irqs(pfdev);

(panfrost_job.c:692-693 and :710, with the same sentence rocket carries
at :712-715). Rocket inherited the sentence and none of the three steps,
which is your point, and 2/12 restores one of them.

Without the device level mask a fresh completion interrupt can still
arrive after synchronize_irq() returns. INTERRUPT_MASK is armed on every
submit (rocket_job.c:142) and the only place it is cleared is the
hardirq (:446); rocket_reset() never touches it. In the ordinary
timeout, where no interrupt fired before the job hung, the mask is still
live. So: would you write

    rocket_pc_writel(core, INTERRUPT_MASK, 0x0);

immediately before the synchronize_irq()? It is safe to do, since
hw_submit() re-arms the mask on every submit, so nothing is lost.

I do not think this is a hole. The reset.pending check in hw_submit()
(:116, returning before next_task_idx++ at :123) already stops the
resubmit branch from firing here. It is about making the new comment
literally true. I have no TRM, so I am not claiming that a write landing
on a block under reset is harmful.

2. Should rocket_reset() hold a runtime PM reference?

This one surprised me. drm_sched_stop() zeroes the credit counter and it
is only restored in drm_sched_start(), the last line of rocket_reset().
That counter is the only thing gating suspend: rocket_job_is_idle() is
exactly atomic_read(&core->sched.credit_count) (rocket_job.c:540-543),
and rocket_device_runtime_suspend() returns -EBUSY iff that says busy,
then disables the clocks (rocket_drv.c). So for the whole body of
rocket_reset() the driver is telling runtime PM the core is idle while
holding no reference, and rocket_core_reset() is an assert, udelay(10),
deassert on top of that.

The part that touches this patch: the two puts are not equivalent.
pm_runtime_put_noidle() is a bare decrement with no idle request, so
nothing is armed. put_autosuspend() arms the 50 ms timer. Before 2/12 it
depended on who won the lock. After 2/12, if a completion interrupt was
in flight, the handler is guaranteed to finish its retire first, so
put_autosuspend() runs, the reset finds in_flight_job NULL and skips its
put_noidle, and rocket_core_reset() runs with a live timer. In the plain
hung-job case there is no handler and put_noidle still runs, so this is
only the racing case.

I have not seen it fire, and panfrost has the same
is_idle-on-credit_count shape, so this may be inherited and intended.
But would you bracket the reset with pm_runtime_get_sync() and
pm_runtime_put_autosuspend()? For contrast, panfrost_device_reset()
re-powers the block and re-initialises the MMU; rocket_core_reset()
toggles the reset lines and returns.

On the RK3576 non-recovery in your cover

You wrote that you have not worked out what sits between
rocket_core_reset() and rk_iommu re-enabling the MMU. Three things from
the source that may narrow it. I have no RK3576, so this is a direction,
not a diagnosis.

- That message is rk_iommu_force_reset(), reached only from
  rk_iommu_enable(), via attach or runtime_resume. Never from
  rocket_core_reset(). Since rocket attaches per job, the report is at
  the next job, so the damage precedes it. That matches your "a few
  seconds later".

- The check is a write-then-readback of RK_MMU_DTE_ADDR, and
  rk_iommu_enable_stall() returns 0 silently when paging is not enabled,
  which it decides by reading RK_MMU_STATUS. So a block whose registers
  read back zero produces exactly that message with nothing printed
  before it. It means the MMU is not responding at all, rather than
  being in a wrong state. Worth grepping the same run for "stall request
  timed out" and "paging request timed out"; if they are absent, that
  reading holds.

- Between the reset and the next job the core does not power cycle.
  put_noidle leaves usage_count at 0 with the device still active and no
  idle request pending. So the domain stays up, and on RK3576 the BIU
  reset your 9/12 cycles on power-on never gets cycled. If the MMU needs
  that to come back, it never gets it.

One build would settle it: put_autosuspend() instead of put_noidle() at
the end of rocket_reset(), or force a suspend and resume before the next
job, and see whether the block returns.

One question only you can answer: did MMU_DTE_ADDR appear on v7 too,
before the rail moved to domain-supply? If it did not, "existing
behaviour rather than something the series introduces" may want another
look.

What I will run, and why no tag yet

I am not putting Tested-by on this patch from an ordinary run, because
an ordinary run cannot reach the code it changes. rocket_reset()
early-returns unless reset.pending (:368), and
atomic_set(&core->reset.pending, 1) appears at exactly one site in the
driver, inside rocket_job_timedout() (:405). No debugfs knob, no sysfs
trigger, no error path. (Separately, rocket_reset_work() is never queued
anywhere, which does not affect your message but is a cleanup
candidate.) At 182 inf/s an RK3588 job is about 5.5 ms against a 500 ms
timeout, so I have never been near it.

So: a test build with JOB_TIMEOUT_MS lowered to 2, which makes healthy
jobs time out with a completion interrupt genuinely in flight, which is
the window 1/12 and 2/12 exist for. Twenty induced resets per core
across all three, with and without 1/12+2/12 for a differential, at
least one inference after each reset and one after an autosuspend and
resume, and PROVE_LOCKING plus DEBUG_ATOMIC_SLEEP on. On RK3588 core 0
sits in PD_NPUTOP, which is the parent of PD_NPU1 and PD_NPU2, so I will
do core 0 with the other two busy and core 1 on its own. Capturing
dmesg, the per-core lines in /proc/interrupts either side of each
timeout, runtime status, the genpd summary, and the output tensor
against my existing bit-exact baseline.

If all three cores come back clean, that says your non-recovery is
RK3576-specific, which is the useful answer. If RK3588 logs the same
MMU_DTE_ADDR, it is rocket-wide and pre-existing, wants its own patch,
and should not hold up v8. Either way I will report it with the lowered
timeout stated in the trailer.

Reviewed-by on 3/12 sent separately.

Regards,
Igor


On Mon, Aug 17, 2026 at 1:36=E2=80=AFPM Jiaxing Hu <gahing@gahingwoo.com> w=
rote:
>
> rocket_reset() calls drm_sched_stop(), which stops the scheduler and
> returns. It does not wait for a threaded handler that is already
> running, so the comment that follows, "Remaining interrupts have been
> handled", states an assumption rather than something the code arranges.
>
> Call synchronize_irq(core->irq) after drm_sched_stop() and reword the
> comment to say what holds afterwards.
>
> It has to go before the scoped_guard(mutex, &core->job_lock) rather than
> inside it. rocket_job_handle_irq() takes job_lock, so waiting for the
> handler while holding that lock would be waiting for a handler that is
> waiting for us. Nothing is held at that point, and both callers,
> rocket_job_timedout() and rocket_reset_work(), run in process context,
> so sleeping there is allowed.
>
> This does not stop a handler that has already read in_flight_job from
> finishing its work on the job the reset is about to drop. That window
> needs the check and the register writes to be one step under the lock,
> which is what the previous patch does; the two are complementary.
>
> Suggested-by: Igor Paunovic <royalnet026@gmail.com>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>  drivers/accel/rocket/rocket_job.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 5f0f9682e..d484a3a6f 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -377,9 +377,17 @@ rocket_reset(struct rocket_core *core, struct drm_sc=
hed_job *bad)
>         drm_sched_stop(&core->sched, bad);
>
>         /*
> -        * Remaining interrupts have been handled, but we might still hav=
e
> -        * stuck jobs. Let's make sure the PM counters stay balanced by
> -        * manually calling pm_runtime_put_noidle().
> +        * drm_sched_stop() returns without waiting for a threaded handle=
r that
> +        * is already running, so wait for one here. This has to stay out=
side
> +        * job_lock: the handler takes that lock, so waiting for it while
> +        * holding it would deadlock instead of fencing anything.
> +        */
> +       synchronize_irq(core->irq);
> +
> +       /*
> +        * No handler is running now, but we might still have stuck jobs.=
 Let's
> +        * make sure the PM counters stay balanced by manually calling
> +        * pm_runtime_put_noidle().
>          */
>         scoped_guard(mutex, &core->job_lock) {
>                 if (core->in_flight_job)
> --
> 2.43.0
>
