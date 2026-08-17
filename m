Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28F83D952C
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 12:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786971086; cv=pass; b=T++cxbUwkSGqVFUUgptbHnHU9bnPY5ZAH+ludCEYnT/YZ1yjp2ej1rMmYc5zp0hX63fGIQdjHobCZ6BJK8yfKTC5VJgEMUQawkLRXwwt5tm3O+NsKNs9c6IQeyFvQaSMvhMOQGtoQgykRJNt+oUbG1hXKGRjsa2erD+9b+Qmuoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786971086; c=relaxed/simple;
	bh=tyz9EcqboelxA3psXnq/gGKah+H4IaeTuowTMl/uuqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KmAVg5cM2i//OX6a33BOsDCEzHitnxG4QhtenyGR4FJ6T2UnXzHrndFtfbt2QiGJ6xHy9cPwc1Rf+Bpae6s67ymEgBoB8qK3Kskf6CoPU/70w0RZMpcV37g5JnIcaI3yAEyqO6dDbsKwY6XM6q6cLv560281iCQb7anEiYNWMuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMGdDxmE; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMGdDxmE"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81e8c68c0cdso2061027b3.2
        for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 05:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786971084; cv=none;
        d=google.com; s=arc-20260327;
        b=bBZnYGeNSuwurY/dt3Yo0iHIBEbTTFq09IYPbsGCtbqQD4ZNVHgM3d/f5rSguBRiv8
         Wo1dsAMPTbXeHoMF8iqExBiyWLDSjw3FXDSKwXJ90ZR3vny8dhFdtBgd7kTslBqOTN57
         IU6H1bbcaNsggUr5QuIN5LE8kCozGBkTtNYTnkTY87SBZKSKa49ydRHeEqFBjP6N4kwR
         PjK+2oNj7HuSkVLyxlrTgCogcv+6K4aLwYehiFFagtgoh/0Uf8e/ib5QhYSQZSh6r5rO
         R+h5LEnqrCrNJ7pA1+u45WHzZPa/hnU8ui4+u2evAcWLm6+Z/5JRNtEdz2wdcarYFevm
         80Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IsoFeL55aXnoSLzM6IlQSU+HvX9Cmm12pl1T+E59Rcg=;
        fh=StQGl1FPUz0sVsNbWA+GwL/TA81rLoBrQxQjzjelPzk=;
        b=ccFOh0ue2qTAbdKglrYk9oroUmwrV+22UQFkJG+rCgwQAkcETG9v0mrSsIrZ3il58e
         FLCE51avAQ5/9yXWg3Vy4Ka0EwGJWkUVBZHyoHSLel+PKw4GxoD4USBsYCYkcWBSpOIv
         fB5bt710Bm9sLQKo4ZVPFb5GLGwljNaFtZpJG19bqN6U8T/XkMfMcYQJvoiGJVOjv9Bp
         RH9EL/LrZAox+SsSgVlq+qypaDQvFugZoZ1u5kwrQM4Jsf5tNDlmoGd6BhYAXGSLD4Qu
         YXV+kd+kBMNBQa+XKpVGp+GuFUm1y2DZOBRFlKm9n8MYDdNUJwIotudkJvoAV9fyzgeC
         99Qg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786971084; x=1787575884; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IsoFeL55aXnoSLzM6IlQSU+HvX9Cmm12pl1T+E59Rcg=;
        b=XMGdDxmE5pRTrAqEbWmeT/YKTdDEm98VALBLYDoAxdPCQ9ToTSgG9lt1WLGcl0dbHW
         JjA7iEN/ACW7ujAuEhaUnR2qxK1pREQGVWKXFlZgZaeAFjwNqdrz0KPl/gNUK3TrxTbo
         xydfc+OIIjaH0dghGDxKHSpeSCMKRC3MEGGd2U53WQB9HCp94hDjLAVrHbvWnWz34Wd+
         yK1S8npoMQzNqNPyl1X+ifev8DCAU39XZAPE9xwO6tugIiBKEIRoyEj3l6GUZ0UG7VBH
         2hm/RTVdecOUjGUJKOKZ+yppBmds0Knic3a5TrHmnOqWtn7lE1x0G0SVZ6Ode4TZSMA/
         jSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786971084; x=1787575884;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IsoFeL55aXnoSLzM6IlQSU+HvX9Cmm12pl1T+E59Rcg=;
        b=r1p/GzEDw4Ief2uPbToXC5PSjwRsWrLG1IOg9PoE+MiJsM5w3N+0sfT+vnefUhqrNs
         SohDp+1EfwD/PXNexssNSNduHfArk+zWABkRFKCqM2oNfObvGYG1yfQ84V5R1bm51ikM
         qKvLQLb0aGsHSqZ9zAH4N6fKJyYDTFnmX8mKfNW0kVo0yBXeQuURo+opiVK9sNaXVagL
         Bthmuzbu8PKmW97JktFe/FJET/7HUg0Q/UA5l6I6l0/pK7h/V0qLufJcdbze7oSlooeR
         ZLXxS6Utq71TLhAV+VMhhbbY5xhXYw66/JIYAZrlYqEccWtgK/1s/CvVh+J7LKqSDXhj
         Xc7g==
X-Forwarded-Encrypted: i=1; AHgh+RrXO0LZ09oV3m69lljz2U6mfMxGXMrcj6IsrO9Mgp8S1xMRTXRAjeSg+KH3+vXhxZfldjXtLA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRt4ApWKKpLP7YqBTD13eGFSP/JzRndDaave1EBHWxyPt44huf
	KSZExqaQ+/dv5xmo7JzVL6//vqi7PCRvmWGkA4fItPSI7DKINo1Te1qnZap/kc8Y4TYZW1NHQWc
	3CjvmzDAEbejXnpAwLVV/DI8pWyksStg=
X-Gm-Gg: AR+sD11MSxUO5UpxfyQICOMEf0IWW9mqFvliwywqFJvYNwKXmJ4RjiumQyTicSYUC2e
	IfroCLZjOz42f1jAHE0/zPerhtz/RlPjhKu9y7KeJ+hueCfGmBZev/hMn6N7o8lt928eXoUt9HN
	Sdl9VCUFcfmLwLr+vLwvHAdGttwgx1MUwGuiZTarj+WL+ZvYdjbxY9GZzyH4KkwMUMZpHHiZhku
	6OqQYNh799J8QaE0QaEdt8X9oRKDqqqhCECQv0uZLHf86g3tTzgLGEt2DfZhETcEWTBj+Zy2x2Q
	16O//nmRWGh/aLQi0YQMU4ZbGQzPb+wFVs/Xbf/e3C8npe75JhUzRkJyp48glKk751nVBoiZ4rn
	QbK4=
X-Received: by 2002:a05:690c:b0f:b0:80d:5c71:d08c with SMTP id
 00721157ae682-8371308c88amr90606897b3.3.1786971083604; Mon, 17 Aug 2026
 05:51:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260817113603.1436067-1-gahing@gahingwoo.com> <20260817113603.1436067-4-gahing@gahingwoo.com>
In-Reply-To: <20260817113603.1436067-4-gahing@gahingwoo.com>
From: Igor Paunovic <royalnet026@gmail.com>
Date: Mon, 17 Aug 2026 14:51:12 +0200
X-Gm-Features: AcwNN1W5X2wGC2Q1I1TaTBqzvN2kUY3psEQZvOBiX0NX6cHaLHwnhi2fG-mcjGs
Message-ID: <CAEWPSH4VAR5VTJUW4PdJczrtueQzPzzo6og8PzWaupwd-t=BFQ@mail.gmail.com>
Subject: Re: [PATCH v8 03/12] accel/rocket: factor the completion tail out of
 the IRQ handler
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

You asked for a look at this one, so I checked it as a no functional
change refactor rather than only reading it. It holds.

I reconstructed the three source states from the posted diffs and built
the before and after with the driver's own kernel flags for arm64.
rocket_job_handle_irq() is static and inlines into
rocket_job_irq_handler_thread(); at -O2 both states emit the same calls
and the same stack frame, and differ only in which side of the branch
the rocket_job_hw_submit() call is laid out on.

The load bearing sentence in your message is the early return, and that
checks out too. At -O1 the pre-3/12 code emits mutex_unlock twice, once
on the path straight after rocket_job_hw_submit() and once at the guard
exit. That is the scoped_guard cleanup firing on the early return. After
3/12 there is one, because the return leaves the helper and all three
paths converge on the guard exit. Both versions unlock exactly once on
every path.

"Nothing follows it" also holds through the rest of the series, not only
here. 10/12 is the only later patch that touches rocket_job.c, and its
two hunks are the defines at the top and the PC_TASK_CON write inside
rocket_job_hw_submit(). Nothing is added after the scoped_guard in the
handler anywhere in v8.

While reconstructing the base I checked where the series sits.
drivers/accel/rocket/rocket_job.c in next-20260814 hashes to 3141f210f,
which is exactly 1/12's pre-image, and applying 1, 2 and 3 in order
reproduces 5f0f9682e, d484a3a6f and 0bb11c718 byte for byte. So these
three apply to an unmodified linux-next rocket_job.c and need neither
the RK3576 patches nor my clocks-by-name patch. Tomeu, that is meant as
information in case you want to pick them up independently, not as a
request for a re-cut.

Reviewed-by: Igor Paunovic <royalnet026@gmail.com>

Regards,
Igor


On Mon, Aug 17, 2026 at 1:36=E2=80=AFPM Jiaxing Hu <gahing@gahingwoo.com> w=
rote:
>
> rocket_job_handle_irq() stops the block and then either starts the job's
> next task or retires the job. The second half is a step of its own and
> reads better with a name, now that taking the register writes under
> job_lock has moved it a level deeper inside the scoped guard.
>
> Move it to rocket_job_next_locked(). The early return that used to leave
> the handler now leaves the helper, which is the same thing here: the
> scoped guard drops job_lock either way and nothing follows it.
>
> Doing it as its own patch keeps the locking fix at the head of the
> series minimal, so a bisect that stops before this one gets that fix and
> nothing else. There is one caller, and no functional change.
>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>  drivers/accel/rocket/rocket_job.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index d484a3a6f..0bb11c718 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -341,6 +341,25 @@ static struct dma_fence *rocket_job_run(struct drm_s=
ched_job *sched_job)
>         return ERR_PTR(ret);
>  }
>
> +/* Start the job's next task, or retire it. Caller holds job_lock. */
> +static void rocket_job_next_locked(struct rocket_core *core)
> +{
> +       lockdep_assert_held(&core->job_lock);
> +
> +       if (!core->in_flight_job)
> +               return;
> +
> +       if (core->in_flight_job->next_task_idx < core->in_flight_job->tas=
k_count) {
> +               rocket_job_hw_submit(core, core->in_flight_job);
> +               return;
> +       }
> +
> +       iommu_detach_group(NULL, iommu_group_get(core->dev));
> +       dma_fence_signal(core->in_flight_job->done_fence);
> +       pm_runtime_put_autosuspend(core->dev);
> +       core->in_flight_job =3D NULL;
> +}
> +
>  static void rocket_job_handle_irq(struct rocket_core *core)
>  {
>         pm_runtime_mark_last_busy(core->dev);
> @@ -354,17 +373,7 @@ static void rocket_job_handle_irq(struct rocket_core=
 *core)
>                 rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
>                 rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
>
> -               if (core->in_flight_job) {
> -                       if (core->in_flight_job->next_task_idx < core->in=
_flight_job->task_count) {
> -                               rocket_job_hw_submit(core, core->in_fligh=
t_job);
> -                               return;
> -                       }
> -
> -                       iommu_detach_group(NULL, iommu_group_get(core->de=
v));
> -                       dma_fence_signal(core->in_flight_job->done_fence)=
;
> -                       pm_runtime_put_autosuspend(core->dev);
> -                       core->in_flight_job =3D NULL;
> -               }
> +               rocket_job_next_locked(core);
>         }
>  }
>
> --
> 2.43.0
>
