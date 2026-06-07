Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0A327A123
	for <iommu@lists.linux.dev>; Sun,  7 Jun 2026 21:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780868571; cv=pass; b=Yiumhyb61VYgBa3xYCo80xWeV4gaEgKdSS3ADdO7PHHtdbJFuSfzr4cxk5Dsx37xaAV9HDwzx4LAPNvSzceZOj/3gpvPORFf4owIWg7515GS6e9Mlrzjxet9M5BAt1Hp3Vf+o3cGNL17Ib6qdY4iEhZq81D7fQy+pN/jHbt3zVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780868571; c=relaxed/simple;
	bh=JcXslbvH1I8goZHOmV6zrmSyQrWDxpEMx44DBzaANDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1p2CbnI3OClGd+IXfD6Uu5PJQ92Gbzg0vNDEqM1yGQYmD8hPp5yrHVvTjmIVwQ6K7y/UGGM49kkZX9Na+4jM2ZAL2wFkK2yV+7E76IvN6pPLmm68rGRttOQ4H4w/UAZlLkZrGzazFqOKnp1r7J9V9EQ4ux0dxO1rpL6xLRV/nE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nxAQtzD8; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nxAQtzD8"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5177d1ff061so1234271cf.1
        for <iommu@lists.linux.dev>; Sun, 07 Jun 2026 14:42:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780868569; cv=none;
        d=google.com; s=arc-20240605;
        b=NO0/BSSNkIWheI0YUY0EWOwwv+i3XHnAkTSXn8YRsejC2EJWiZy2O3KioK+pPHRWRG
         vy1uPc5S0K1RdE2ZR2nGrt/eNwJ6oVgsSt6z4IjfFzLlzg89g48hT3YwfpWi/6MvnGZg
         dv2fzJOjBTk7Zir4ls5Q++7x8Xtf1386Xmn8LjDMu4y4LFDiU0IZrtmaDE6Hf8xQ+It0
         UmXfE3M9yj4ulMtC1Wym/8TAdSBKu8xibw5NOX4ngpVpxnyoSQXx+zLVGJ6elou9/Gsj
         yXf+KklFhHuZWH/dh3saiO6rPyQha4i3p3/s/R07Exa7UOye4SizQItWhg+DCInY35L4
         mh0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vyqe1/V8LOLZRRB2tkc6YkttN2Ie/2+WN0mY7kcvXhU=;
        fh=0u6trxL0zZwA0/1Sge/7uQQnOlSSVTu7AIo0GAZRpig=;
        b=Uf4c8kDnYwSHCvHv5GOesb1jlHdrZCZR5x+dClQuDP09OkfGZLBgu/1BrFSR3Ksdaf
         4UzckQIMLYJtIGPmUXlCY+QGvF4zdvL2Gv+LgUPNVUtnF6OcUZDb1TBvKbM7yTYDTbde
         FYtaY7hCUYmgUXSYsjtp0/LiPrcpXVUkmXa9v1gaO2q4pHCgSYTT3p88jcUcGHBL1Whf
         R5ZvmWBOhy6ICyfnH0+iJxpiAZ3Dm+7CZ2jA9g2537UvayqdxeeXPDl6zQSHpatmohaR
         L2qeUbmBSTQE+fy8kDZKcbhZYDRXUdsp+E4vEJI8N7XcAH7tiNcHiCOYdogpNEC9BxqF
         IB7w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780868569; x=1781473369; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vyqe1/V8LOLZRRB2tkc6YkttN2Ie/2+WN0mY7kcvXhU=;
        b=nxAQtzD8XDxii2AvVitEc/g5OgZOsoPPwSS6o9CR0MhpJ9hrSaFa7IIrLPx+7+5UP8
         3PXm2K/0sjN3RVeAL22OJeQ4UlBl1DIfeaoC1ZgfEPP7xEd8Rw588H6/G3pNif0Scm9/
         US5vqBUAHhfrSsLlx9HfNquSlms62Fe1teidYVoaG5UoSgOHlESXLgN184TTz0xT6MG6
         5zyCeuiOALveknVN58isp3QK5U4ef8e2sZrULx2jHZ/VzMFl7UHJjZKl9OyWsgDn4gbn
         OZb+KXDBJwNQxjI8uwoCUyT/blFGSUwVlK6CAn2Oug2Rg3dWjyIn0Hih4PMFADGA3BJ3
         v/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780868569; x=1781473369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vyqe1/V8LOLZRRB2tkc6YkttN2Ie/2+WN0mY7kcvXhU=;
        b=sYTbwodhcBjZMU+uZ2SKA++cWtBqFpv6R9HqJxU4SOb6DAMp+HbC9OR2FgfwdJCUtj
         KHuxZIxA30hmqI3qqfxfzEaTu8eH+PEZebbzR1YPHMR309r4iwul/dp92sMTaLDu7miZ
         LlZRgEiFFsd166+4OXuhuy1gyRjCZnNWZnh06YMpP8DqSPfKA6MW0GzReNk1ytASOKGs
         vBHnZFal8ezro1w73Q4Cwek9ISOTFYJVpBkcyoCV3XB5CZ79gdkFNNZqFt9MXwImqpHA
         j11BzDWTuOQ4b7wibn6o3iUD+fAAZt6yhJhRPd+A/dBJMI+ZXCtanUwpfRmn6xsHG0sr
         5MFA==
X-Gm-Message-State: AOJu0Yw6NgDMaEkKRYFYMdfFeoV4bGYDh7cyRYDZ6WBG/1TPR1+rNomQ
	PTrbZ6SZS9fbXiauG8THIuOuXD03j2EsbcZoJM4qJqdXFWQa3OpTDoAh+XzxmWXTbf/FBXEHWav
	GSsJdCcqOI/0MhAjGKjBPXqwTfIVlmQVbaT4Ym3NR
X-Gm-Gg: Acq92OEmqhw71y7TkvoVvU/gTOGjPlJa1ApYbFATxA71R5RlSqpaKXkEKeOU5Kg03Pc
	ZFgcoCpsxZKlDm7Am+y+dxtv7rN9OJz39QaxBuvup3Y0bGKUhP6mAlEJeRIbZysU53cnjMY0aKx
	jFDazRY5NuhxZJyHJ1EOBUmZfQNplnCE4I4RMSOxpslhokw9fyglum8w21BZLcxlIvCt3nuYCeo
	JpA50b2sZriCtvRyiRDM75GMLFqbx+/yMd8VT/NymaNB+7sxAUX5RtrEC8P+UCziJm9HeOKLsYa
	noeNyWYdeqZVqO0=
X-Received: by 2002:a05:622a:178a:b0:517:99ea:ab7c with SMTP id
 d75a77b69052e-51799eabedcmr13790861cf.28.1780868568251; Sun, 07 Jun 2026
 14:42:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260601215909.3958732-1-praan@google.com> <20260601215909.3958732-8-praan@google.com>
In-Reply-To: <20260601215909.3958732-8-praan@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Sun, 7 Jun 2026 14:42:37 -0700
X-Gm-Features: AVVi8Cc7vDwsTYlZ7xArJ-OaI4SeEU2xRhvF0rVcM1tRP9imeosdVyxxnu47IE0
Message-ID: <CAE2F3rDF5dVJip2gc+vaxtM-FRttnUEnAetUYz6qDCXRM=fNYg@mail.gmail.com>
Subject: Re: [PATCH v8 07/12] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 2:59=E2=80=AFPM Pranjal Shrivastava <praan@google.co=
m> wrote:
>
> Introduce a new bit flag, CMDQ_PROD_STOP_FLAG (bit 30), in the command
> queue's producer index to safely gate command submissions during device
> suspension.
>
> The flag embeds the suspend state directly into the existing global state
> The flag checked in the cmpxchg loop in arm_smmu_cmdq_issue_cmdlist(),
> which acts as a Point of Commitment, ensuring that no indices are
> reserved or committed once the SMMU begins suspending.
>
> This prevents a situation of "abandoned batches" where indices are
> incremented but commands are never written, which would otherwise
> lead to timeout during the drain poll.
>
> Update queue_inc_prod_n() to preserve this flag during index
> calculations, ensuring that any in-flight commands that successfully
> passed the point of commitment can proceed to completion while the
> flag remains set.
>
> Suggested-by: Daniel Mentz <danielmentz@google.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 20 +++++++++++++++++++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
>  2 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 6c8631e2f153..c4315bdde7d5 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -210,7 +210,8 @@ static int queue_sync_prod_in(struct arm_smmu_queue *=
q)
>  static u32 queue_inc_prod_n(struct arm_smmu_ll_queue *q, int n)
>  {
>         u32 prod =3D (Q_WRP(q, q->prod) | Q_IDX(q, q->prod)) + n;
> -       return Q_OVF(q->prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
> +
> +       return Q_OVF(q->prod) | Q_STOP(q->prod) | Q_WRP(q, prod) | Q_IDX(=
q, prod);
>  }
>
>  static void queue_poll_init(struct arm_smmu_device *smmu,
> @@ -718,8 +719,25 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_devi=
ce *smmu,
>         do {
>                 u64 old;
>
> +               /*
> +                * If the SMMU is suspended/suspending, any new CMDs are =
elided.
> +                * This loop is the Point of Commitment. If we haven't cm=
pxchg'd
> +                * our new indices yet, we can safely bail. Once the indi=
ces are
> +                * committed, we MUST write valid commands to those slots=
 to
> +                * avoid indefinite polling in the drain function.
> +                */
> +               if (Q_STOP(llq.prod)) {
> +                       local_irq_restore(flags);
> +                       return 0;

On second thought, I no longer believe that this is safe. I understand
that READ_ONCE(cmdq->q.llq.val) implies no ordering guarantees with
respect to any writes to translation tables. In the non-stopped case,
we can rely on the call to dma_wmb() further down in this function.
However, for the stopped case, I can't identify any barriers that
would ensure that the STOP flag is checked only after the writes are
visible to SMMU. Here is an example: Let's assume the following
program order:

 * Write to invalidate PTE
 * Read from cmdq->q.llq.val, determine STOP flag is set, elide TLBI

What prevents the CPU from reordering these operations as follows?

 * Read from cmdq->q.llq.val, determine STOP flag is set, elide TLBI
 * Write to invalidate PTE

Can the following situation occur?

 * Read from cmdq->q.llq.val, determine STOP flag is set, elide TLBI
 * (Different CPU resumes SMMU)
 * SMMU loads old PTE value into TLB
 * Write to invalidate PTE
 * (stale PTE remains in TLB)

I propose the following: If you find the STOP flag set, run dma_mb()
and check again. I'm afraid that running dma_mb() unconditionally
might incur too much of a performance penalty.

I have the same concerns with arm_smmu_cmdq_can_elide(): That
READ_ONCE in arm_smmu_cmdq_can_elide() provides no guarantees in
regards to ordering relative to PTE writes.

>
> +               }
> +
>                 while (!queue_has_space(&llq, n + sync)) {
>                         local_irq_restore(flags);
> +
> +                       /* Avoid waiting for space if the SMMU is suspend=
ing */
> +                       if (Q_STOP(READ_ONCE(cmdq->q.llq.prod)))
> +                               return 0;
> +
>                         if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq,=
 &llq))
>                                 dev_err_ratelimited(smmu->dev, "CMDQ time=
out\n");
>                         local_irq_save(flags);
