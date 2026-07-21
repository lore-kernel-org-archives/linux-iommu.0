Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A82F33F5AA
	for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638974; cv=pass; b=d/eTtfNdwJNSZKh7K5wurVOBRL/wd7wZajMKtjE6nv+eDu9Hd7y8DtfZ6RFeM6eTwwn+811g2plyhcXsU31KGZLZe4DM2e094t64usS/1ceKnpt/Eqs2R1U8iZuN4hn+SQ22pC01fejKZnHOA6OcBDpir5Vt2LTe6DIXM+nr/gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638974; c=relaxed/simple;
	bh=/Oh0ypFHF/MeCKdDZKZv3m+0QRpoUmuQ3pwi6V0uN70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+DEUHGZT83I5WESoGZIABJZegScMdpJvT8dNMvsQh9k3otrZ2rsZVH1mZaYsK0QkkL50l4mOdoajHY9m8Picdh5R2AM6sbD/799gS0n/j1BUqUxk7a1kfMtCNlX5JzeXg+hyLReypD5MNGAI2vJMEgIEAc7rB2V0keA0hS3Hxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=Dr+jeev6; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="Dr+jeev6"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69c7c8accffso656406a12.2
        for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 06:02:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784638971; cv=none;
        d=google.com; s=arc-20260327;
        b=M/NL+EN0hqEDTV6F4CVRvtrqona8o5tCZadXTqET4EQM5pL3S9CxufwE1BC5PhwpqI
         80lKLHp26ZjUFkzyiD0bjffSVADtq1c0aJOD8Eziv9wMCt6yc+doa901r2IUc2xqW5Pc
         EceT9ofagLIA43Cv0mEXhJGdXpWDSleuYZP213nLgb/qo+4aVD3igRQtDrnPbevP012Y
         J26CldfCAtkvMj9qMdr8EwEycCGeSE66FTk9IL1vIRu63JHETof8tITwkDvnc6jk5nm9
         UarxyyrjqYsa93oESnMFqRg75SK6DdTyOZ1653Q38CNEPI3XfUhZsQ6aPXd0gkukOrY+
         RiZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PLoRxgeU4eLbTE5cBel+nzCrJ1tx2QkUTBvlydG2Zzg=;
        fh=C4y50BtaVf9cOxD4ZNP0UCKfBvxz7WMP9rOymuj+fKA=;
        b=fl9OycY5dk5fAgNbmeVqQ1gKl68p6x0OiOuEqcDHokBcSJcj0mJjbSZcd0rLnDPvay
         /Nf47ejayKn53isQoUUK+Y6fRmHFpe0uxwYU4Os5XQnuxQUwMzfp/Mi6VKFlDxAMvPtS
         o7LF6ax6eCIgWbRb8HorgPy4LSih8HBi6uThS2hVG3RVC4GVv2Gk5kh3kC7DrW23f+Dg
         +nj0BKMSZ2Xe62DhbWdreg9Kh5ctMZAXbbaJigqKUqaio+gf/DcCjUyg+uydoh4BIBqd
         cv0ycMumBhE6gENuZL8wGs2GtxWuD7jaRRtwJXLVq/1DXJ1kbGT/OZAcEJK67vwyEZ7d
         JWEw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1784638971; x=1785243771; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PLoRxgeU4eLbTE5cBel+nzCrJ1tx2QkUTBvlydG2Zzg=;
        b=Dr+jeev6QCoSr0xqwkThVzUsv09L5dy2XaJKB3GHQ7JYVf7CZJLFFS1FctzA8cIJDA
         lg64TXLpyGEQyeUjcZF/ufjxD9tGa0kF2ZaZYWIC4bbFLgiKpYKSdL5UOGYy6D8BJD/A
         vfcFTbG611aXxs6HrZaHeOgzOulb4WkxmaSdOYSwakrJ4L48d8NmsY8j6J2OGwNhYCQ+
         Jc7eTE4aP7GqWIzWYiwaLa1rlZT5t5IqUWV71Sk5HCD8rU2XJleXm/XzvQOkXOWc6IVG
         jio6Wxxa+0iB3v3nG3S8omZtE+mtmuYz7Vg9wzL7BbIXDB0gGqBiptCqBvau5URFvxOd
         l5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784638971; x=1785243771;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PLoRxgeU4eLbTE5cBel+nzCrJ1tx2QkUTBvlydG2Zzg=;
        b=shwdmE6tZyK2Xs2Xp963heTqy62IcscEIH37KI+jqIcUMSqiNF/3PL9NFBpHFO8rS4
         hPBTaiitS1Tz6Mgbg+zMTRusjjEvmOZwkqd4ILKpeNjB+2yzQvL6qL1i+20E284MSBzb
         Kg7mgTchhvQQccU8iF93vyMFe1QgsymX5M2HQVnYvAkhRwZfwnY4Xn8XC/8pVHc1q0gq
         WvU5PTJ4zvw8fKyNgqIlDnZXdrG/2D2149QFHUCHR6VEWfdbpqbspcIP3wBUqErCVfmd
         OUsMpQw+QA0XEM4gMvk7pb4Z9QgkgkqhqtZOgXIWuwNysFmBwli7mTo0RUfWw5XzP4E0
         xubg==
X-Forwarded-Encrypted: i=1; AHgh+Rrdlym9VEgXLEkNlkBMyl4J0fPX5yVadk/9Th8wJgK/Eh4IVTSSvNL205gsNapwqdi74Jstjw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzEPdMkFVzLYg/YElZ2iVmVlzJwkdOmZkNseNaf8/bEgRxMZUMR
	iY15tmW30FXnTvl7qd2wlRd1GY46KQ1DpOqw6mobSr+GUeZ4XtDoohWn6tcAB7djwLReCnDB2QH
	p92ah0Bo05xjAMYcixi8m+iqgOvcWvYZXND7CdKr6NQ==
X-Gm-Gg: AR+sD12oXs+3swOCha8c6bsEPPTElF4se4j/hS2e2RAFD7BczuBCYO0lhJOYMMfHl5a
	qBqeE9ex1KtoDOqAGla3NJe2wQX69+r0b099E4F/pdAl+6Ar1xfSEb81AD2MHRR+lG3SwwZfJVG
	pGMjsWF83wJpDriSw9aF2VaV2O9817GIm3R4vf22s5HgfmSq4vYG6aZuob9RkSFW6b8M2r2/J7g
	sHRzz+SV6MsddP49Qzk+GuKELi1o6emhQ+Y0xc5VUQNrY+8z6qUxvWonliYECFyDBKmVNcB/dWu
	5/dNf6733TK6iShwmg==
X-Received: by 2002:a17:906:ee81:b0:c12:34ed:e0fe with SMTP id
 a640c23a62f3a-c16b486b059mr764236766b.60.1784638970824; Tue, 21 Jul 2026
 06:02:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260718031146.3368811-1-gahing@gahingwoo.com> <20260718031146.3368811-7-gahing@gahingwoo.com>
In-Reply-To: <20260718031146.3368811-7-gahing@gahingwoo.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 21 Jul 2026 17:02:36 +0400
X-Gm-Features: AUfX_mybR4TJcD7UtKT7vkslJHd83avKACirSY-Al4DoJE_V_nYHHDDfXmU2CdM
Message-ID: <CAKTNdwHL2Z3h-FN7LLPshz5B0duiMw_pyfe=VG4UDhfm8igZ6Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 6/8] accel/rocket: add RK3576 NPU (RKNN) support
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de, 
	ogabbay@kernel.org, chaoyi.chen@rock-chips.com, 
	dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
	iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiaxing,

On Sat, Jul 18, 2026 at 7:11=E2=80=AFAM Jiaxing Hu <gahing@gahingwoo.com> w=
rote:
>
> Add RK3576 support to the rocket DRM accelerator driver (used with the
> Mesa Teflon TFLite delegate).  Per-SoC differences are selected by new
> of_device_id match data (struct rocket_soc_data) so the RK3588 path stays
> unchanged:
>
>   - match rockchip,rk3576-rknn-core; iterate its nodes at probe
>   - RK3576 takes six clocks (adds the CBUF domain ACLK/HCLK_RKNN_CBUF):
>     the CNA fills the CBUF and CORE reads from it, so the compute path
>     stalls without them.  RK3588 keeps its four clocks.
>   - RK3576 requests one reset (srst_a); its BIU reset (srst_h) is driven
>     from the power domain.  RK3588 keeps both.
>   - RK3576 spans two power domains (PD_NPU0 + PD_NPU1) and attaches the
>     list explicitly; RK3588 is single-domain and keeps the driver-core
>     auto-attach.
>   - RK3576 has no maskable completion interrupt (PC_DONE is read-only in
>     INTERRUPT_MASK), so it polls PC_DONE via an hrtimer; RK3588 keeps the
>     DPU completion IRQ.
>   - guard rocket_job_timedout() MMIO behind pm_runtime_active()
>
> Tested on a Radxa ROCK 4D: the NPU probes, powers on, brings up its
> IOMMUs and runs submitted jobs to completion.  Full multi-layer inference
> is not yet correct on this SoC (only the first operation per power sessio=
n
> produces valid output); see the cover letter.
>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>  drivers/accel/rocket/rocket_core.c   |  39 +++++++-
>  drivers/accel/rocket/rocket_core.h   |  22 ++++-
>  drivers/accel/rocket/rocket_device.c |   4 +
>  drivers/accel/rocket/rocket_drv.c    |  22 ++++-
>  drivers/accel/rocket/rocket_job.c    | 127 +++++++++++++++++++++++++--
>  5 files changed, 200 insertions(+), 14 deletions(-)

[...]

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 2f1861f96..ce3f7c92e 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -7,6 +7,7 @@
>  #include <drm/drm_file.h>
>  #include <drm/drm_gem.h>
>  #include <drm/rocket_accel.h>
> +#include <linux/hrtimer.h>
>  #include <linux/interrupt.h>
>  #include <linux/iommu.h>
>  #include <linux/platform_device.h>
> @@ -20,6 +21,16 @@
>
>  #define JOB_TIMEOUT_MS 500
>
> +/*
> + * RK3576: INTERRUPT_MASK bits 28-29 are read-only (hardware rejects the=
 write),
> + * so the PC_DONE completion signal cannot be routed to the GIC via the =
normal
> + * interrupt-mask path.  We poll OPERATION_ENABLE every RK3576_POLL_INTE=
RVAL_NS
> + * instead of waiting for a completion IRQ.
> + */
> +#define PC_INTERRUPT_MASK_RK3576_PC_DONE_0  0x10000000u
> +#define PC_INTERRUPT_MASK_RK3576_PC_DONE_1  0x20000000u
> +#define RK3576_POLL_INTERVAL_NS  1000000LL  /* 1 ms */
> +
>  static struct rocket_job *
>  to_rocket_job(struct drm_sched_job *sched_job)
>  {
> @@ -137,8 +148,24 @@ static void rocket_job_hw_submit(struct rocket_core =
*core, struct rocket_job *jo
>         rocket_pc_writel(core, REGISTER_AMOUNTS,
>                          PC_REGISTER_AMOUNTS_PC_DATA_AMOUNT((task->regcmd=
_count + 1) / 2 - 1));
>
> -       rocket_pc_writel(core, INTERRUPT_MASK, PC_INTERRUPT_MASK_DPU_0 | =
PC_INTERRUPT_MASK_DPU_1);
> -       rocket_pc_writel(core, INTERRUPT_CLEAR, PC_INTERRUPT_CLEAR_DPU_0 =
| PC_INTERRUPT_CLEAR_DPU_1);
> +       if (core->soc->poll_completion) {
> +               /*
> +                * RK3576: PC_DONE (bits 28-29) is read-only in INTERRUPT=
_MASK, so
> +                * it cannot be routed to the GIC; enable the DMA-error i=
nterrupts
> +                * and poll PC_DONE via the hrtimer started below.
> +                */
> +               rocket_pc_writel(core, INTERRUPT_MASK,
> +                                PC_INTERRUPT_MASK_DMA_READ_ERROR |
> +                                PC_INTERRUPT_MASK_DMA_WRITE_ERROR);
> +               rocket_pc_writel(core, INTERRUPT_CLEAR,
> +                                PC_INTERRUPT_MASK_RK3576_PC_DONE_0 |
> +                                PC_INTERRUPT_MASK_RK3576_PC_DONE_1);
> +       } else {
> +               rocket_pc_writel(core, INTERRUPT_MASK,
> +                                PC_INTERRUPT_MASK_DPU_0 | PC_INTERRUPT_M=
ASK_DPU_1);
> +               rocket_pc_writel(core, INTERRUPT_CLEAR,
> +                                PC_INTERRUPT_CLEAR_DPU_0 | PC_INTERRUPT_=
CLEAR_DPU_1);
> +       }

This whole polled-interrupt part looks very suspicious. Does the
vendor stack do the same thing?

It's hard to believe Rockchip would release performance-critical and
hype-heavy silicon which can't properly raise the most often triggered
interrupt in its critical path, so there must be something else going
on here.

One theory could be that the interrupt bits are not "read-only" per
se, but rather gated inactive by some internal hardware state which
must be cleared before jobs are submitted (e.g. some buffers not
drained, or init sequence not completed, or voltages/frequencies not
set, or memory mappings not written out, ...). If so, this same
hardware state (or something related to it) may well be the cause of
your observed "first (forced) job completes, others don't".

Best regards,
Alexey
