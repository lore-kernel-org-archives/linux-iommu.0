Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C3E321445
	for <iommu@lists.linux.dev>; Sun,  8 Mar 2026 21:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773004997; cv=pass; b=jm38vGePJa4AYxBkaRuVVp0Y+RYdYIN64dF+S9oyXEsuTuleEI06mk896y25zSh2AtfLXAq47Db7+gL+X/4L4wR8PBcvtia3lAMOTQrXFJpKRLIJ2pp3z5r8RODbK3keO8zaI0iJyOF7ctunDc15ehIQco1K/2uqldEFVtGOl0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773004997; c=relaxed/simple;
	bh=+gmK1RHreyPnC5Wj/huNh/Yd1F9ZC5bCPIkEgz+fvas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+AoauYjb2B58mkKaglzQ1XPeiaLTRPxs/VkpWTajhb5VPauZH2wXuP/uN7BQ1huvDpDzs4zCP+cEEclJc6Lmo7603tVg6m7IegcgOPWiy0KZEnAfcAhpO2x69ZGGk5X405jS+rSbGRmfb98YmIZ1wKYWjdnx/ZHg5qdlPWMxv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E/F+iV3X; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E/F+iV3X"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50906a98ffeso531201cf.0
        for <iommu@lists.linux.dev>; Sun, 08 Mar 2026 14:23:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773004994; cv=none;
        d=google.com; s=arc-20240605;
        b=L6kMF6EhqQKD/D+3XudR3Ur3rgSiVBm/oS3oGRSnfK1SeLuSkFbpJNoveWWMegGQiz
         Topbyk0rtFXA8Lw6BPKrESYzCEzEyPT8eVpP7tvv0Mc8DJ1RAO8D0wFTkNg4GL7r8axC
         709OkvODndpoqxBdmgEKxYi2BFc6SVTRuZ2an1F2T1kcqi0Ofv3BDkB/pFMQEe3cATXU
         334wyVplXtRfrOxYFoS81Zqvqpgjgd/+MtofjnDgrz0LLfnm0zj9+6jjRMWUbqXE07ji
         wjPQ7v8CdfupL4tmsh/RCD+TfUfTors5vbQO4AlJIEgkIcol0IC2WWGZrZmqlLszXHEl
         h4pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RRrMk2uGdvPoJJ9zAyHNkeP9uYA/6EODOGDOAZl+U1Y=;
        fh=Cr9Gz+4KxVp4Ci1moPY7g4WpWFGCr0a9bcVWr63STi0=;
        b=OeyT0EiNHrGpJzEqZdlAy1Vzzm4Uwg99G8kZ648kCmj62D/iPi2oeMQ1tqkoyyIro0
         vODWysHNSxyHTwWMI7zb0VTdAPeZFjI71uBvlLDVwYNkozZmRSoTexqKMTewF/QgXohu
         0dDLijqyGxRBxjaTgNAsVuIhb2qYDGw8Japiz0+0gKriEcA340W1dEiwS6f79U+r3SPd
         /9bjqc9Yysi0eQGTK5xrDdqD2dwac+pj8iaG6k+KcOBgzFMO9CDB6Sq/GAqc9628cswd
         tRZJzbuqGD8L8xsH7V/ZwfJCCUcp5hhHHS5eGApLnoBEbtfKSHgfwebDSN/2VEz4Lhjs
         wH3g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773004994; x=1773609794; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRrMk2uGdvPoJJ9zAyHNkeP9uYA/6EODOGDOAZl+U1Y=;
        b=E/F+iV3XgHSOt8S/iRv25HMvuObhS7M95PH3JQ7fnxA0sEAVPhBnfOpUOR24CtANAo
         3+rCwm/EwnSbhd1Wtt3HWUFqsEi5nItAL1c+R3OBoSVC2ObZW/plHrv2cWSxekUq32Go
         H5w6JDLQXPDJgEsem+5psTlQGjraoZhp5EQvls0yzqMq/J8W0Wrk0f6mvqwvkYADD9+Z
         6iXPOLtIi6RRjVmWrLUFX+YwVBjT8j2XlCj0Z+v3LmuSiakB/UQB7ZPuWXgdPyfoDU5e
         BNxO70WKi5WUp5oHdrg9GxnGf7KwIzRffxKNh+yHANl+7ubCw40ktLF8K8DujpHfb6Ys
         OYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773004994; x=1773609794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RRrMk2uGdvPoJJ9zAyHNkeP9uYA/6EODOGDOAZl+U1Y=;
        b=L/Yx4JOykUf+lixE9/aSdTDPORpQ2wVZ8Sj7LQE7tVhbdkHP3vCiY+PR1vRG1Kk77z
         /W2HdUlAvxP3hBBmSgQevVMVyaqVw9bGjM9XnecySheZIjgS7Oq0oCz3JgZf1W0sO8k3
         Mma/GUj/PkfN5n6t6jpWHtfGWenVm4NZgtFPHMUdxaVfy+j0NTGt/NsMIUugqP2n0fi+
         9F/bsvJ5Oy8n98Uh6ocVve9qsfkDjhmIRXkACcoOr/QMt5xq8vSoWgB0In3tmoEhu7bh
         2HwoToyfEyP8nnkJWkzQdqhJe2UnSlbvhNV6fhoU6Qxfb1p4Dka2P2qaWLm7TXLmOHZ5
         tB2Q==
X-Gm-Message-State: AOJu0YzvOpcWEGOWqdRu8SbDE6IX7+6xXmZiO4SsKslsEm/VvPkm0HiS
	gEAICAaxxog+s1kz2gTPBd42sdVsA6gVUb4Oc9SCa9j9rU/Te/mS3wv9/bi0hepY3QRxO9ffJIv
	/aBUZHXU8BPRXsMJtu3o33LEcMOe5c+XrcaRTtvD1
X-Gm-Gg: ATEYQzxICnTB90RmBQGmb0cS7ZEP3ltIjKOwOHrQ916N8oD5Ek2hVZ6JPenZjNxoutg
	jInNbsrxEMKIa5028aJu8rkGeieQxh/CtqWvGvPB8TNMaExLOBproEjOBbtscp0vfzfUhuQFDtJ
	NIhCphSWxglMgXymauixUHS2GR94e77AThNkbCrNj+v0GFH+GgnODnTZtp5gauUzfoByUTWYRNR
	05NIdG8eOKzJj5r8Uuchm6T3onphmXbKljr9unnims0OU4pnjYSYtjyVXhrzWJhE+ByDZnopxk0
	d4EJ
X-Received: by 2002:a05:622a:1915:b0:506:a3c8:d44d with SMTP id
 d75a77b69052e-50902b99912mr14868301cf.9.1773004994063; Sun, 08 Mar 2026
 14:23:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260126151157.3418145-1-praan@google.com> <20260126151157.3418145-7-praan@google.com>
In-Reply-To: <20260126151157.3418145-7-praan@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Sun, 8 Mar 2026 14:23:03 -0700
X-Gm-Features: AaiRm53CvmSMwN51gw08zMTIs5bVLwZOm58RWeTwUF--hfOJ8wl1gSs6h4igamk
Message-ID: <CAE2F3rD0aoTXJBnS4SPHLEEst6cTvoUxNywRZ1RhdgwNA_0JTA@mail.gmail.com>
Subject: Re: [PATCH v5 06/10] iommu/arm-smmu-v3: Add a usage counter for cmdq
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>, 
	Sairaj Kodilkar <sarunkod@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 7:12=E2=80=AFAM Pranjal Shrivastava <praan@google.c=
om> wrote:
>
> Introduce a biased counter to track the number of active cmdq owners as
> a preparatory step for the runtime PM implementation.

Non-owners waiting for their CMD_SYNC to be consumed also appear to
increase this counter.

>
> The counter will be used to gate command submission, preventing the
> submission of new commands while the device is suspended and deferring
> suspend while the command submissions are in-flight.

What does command submission mean in this context? I understand that
commands are still added to the queue (until the queue is full). It's
only the producer index that is not advanced.

>
> The counter is biased to a value of 1 during device reset. A cmdq owner
> or a thread issuing cmds with sync, increment it before accessing HW
> registers and decrements it with release semantics afterwards.
>
> A value of 1 represents an idle (but active) state. A suspend operation
> will set it to from 1 -> 0 representing the suspended state.
>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 65 +++++++++++++++++----
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 +
>  2 files changed, 57 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 91edcd8922a7..3a8d3c2a8d69 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -805,7 +805,7 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_devic=
e *smmu,
>         u64 cmd_sync[CMDQ_ENT_DWORDS];
>         u32 prod;
>         unsigned long flags;
> -       bool owner;
> +       bool owner, has_ref =3D false;
>         struct arm_smmu_ll_queue llq, head;
>         int ret =3D 0;
>
> @@ -819,8 +819,15 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_devi=
ce *smmu,
>
>                 while (!queue_has_space(&llq, n + sync)) {
>                         local_irq_restore(flags);
> +
> +                       if (!atomic_inc_not_zero(&smmu->nr_cmdq_users))
> +                               /* Device is suspended, don't wait for sp=
ace */
> +                               return 0;
> +

Does this mean that we still accumulate commands until the queue is
full while in the suspended state and then have SMMU excecute all of
these (now irrelevant) commands when the command queue is re-enabled?
One might argue that this is wasteful, but I guess it might be
technically correct, because it doesn't hurt either.

>                         if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq,=
 &llq))
>                                 dev_err_ratelimited(smmu->dev, "CMDQ time=
out\n");
> +
> +                       atomic_dec_return_release(&smmu->nr_cmdq_users);
>                         local_irq_save(flags);
>                 }
>
> @@ -879,10 +886,35 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_dev=
ice *smmu,
>                 arm_smmu_cmdq_poll_valid_map(cmdq, llq.prod, prod);
>
>                 /*
> -                * d. Advance the hardware prod pointer
> +                * d. Advance the hardware prod pointer (if smmu is still=
 active)

Consider "(if command queue is still enabled)". Otherwise, what does
"active" mean? SMMU and/or command queue enabled?

>                  * Control dependency ordering from the entries becoming =
valid.
>                  */
> -               writel_relaxed(prod, cmdq->q.prod_reg);
> +               if (atomic_inc_not_zero(&smmu->nr_cmdq_users)) {
> +                       writel_relaxed(prod, cmdq->q.prod_reg);
> +
> +                       if (sync) {
> +                               has_ref =3D true;
> +                       } else {
> +                               /*
> +                                * Use release semantics to enforce order=
ing without a full barrier.
> +                                * This ensures the prior writel_relaxed(=
) is ordered/visible
> +                                * before the refcount decrement, avoidin=
g the heavy pipeline
> +                                * stall of a full wmb().
> +                                *
> +                                * We need the atomic_dec_return_release(=
) below and the
> +                                * atomic_set_release() in step (e) below=
 doesn't suffice.
> +                                *
> +                                * Specifically, without release semantic=
s on the decrement,
> +                                * the CPU is free to reorder the indepen=
dent atomic_dec_relaxed()
> +                                * before the writel_relaxed().
> +                                *
> +                                * If this happens, the refcount could dr=
op to zero, allowing the PM
> +                                * suspend path (running on another CPU) =
to disable the SMMU before
> +                                * the register write completes, resultin=
g in a bus fault.
> +                                */
> +                               atomic_dec_return_release(&smmu->nr_cmdq_=
users);
> +                       }
> +               }
>
>                 /*
>                  * e. Tell the next owner we're done
> @@ -894,14 +926,19 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_dev=
ice *smmu,
>
>         /* 5. If we are inserting a CMD_SYNC, we must wait for it to comp=
lete */
>         if (sync) {
> -               llq.prod =3D queue_inc_prod_n(&llq, n);
> -               ret =3D arm_smmu_cmdq_poll_until_sync(smmu, cmdq, &llq);
> -               if (ret) {
> -                       dev_err_ratelimited(smmu->dev,
> -                                           "CMD_SYNC timeout at 0x%08x [=
hwprod 0x%08x, hwcons 0x%08x]\n",
> -                                           llq.prod,
> -                                           readl_relaxed(cmdq->q.prod_re=
g),
> -                                           readl_relaxed(cmdq->q.cons_re=
g));
> +
> +               /* If we are not the owner, check if we're suspended */
> +               if (has_ref || atomic_inc_not_zero(&smmu->nr_cmdq_users))=
 {

Can there be a situation, where we execute this branch and the
hardware prod pointer has not been updated, in which case
arm_smmu_cmdq_poll_until_sync will wait forever (well, actually, until
it times out). Imagine the following series of events:
 * nr_cmdq_users=3D=3D0
 * hardware prod pointer update is skipped
 * nr_cmdq_users becomes 1
 * arm_smmu_cmdq_poll_until_sync waits but commands are not executed
by SMMU because hardware prod pointer update wasn't updated
 * arm_smmu_device_reset() tries to submit CMDQ_OP_CFGI_ALL, but gets
stuck because the queue is full.
 * cmdq->q.llq.cons is never updated because the shared lock is held.
queue_has_space() returns false, and
arm_smmu_cmdq_poll_until_not_full() can't get the exclusive lock

> +                       has_ref =3D true;
> +                       llq.prod =3D queue_inc_prod_n(&llq, n);
> +                       ret =3D arm_smmu_cmdq_poll_until_sync(smmu, cmdq,=
 &llq);

If you skip arm_smmu_cmdq_poll_until_sync() in the nr_cmdq_users=3D=3D0
case, I'm thinking that llq.cons is not updated. If this is the case,
is the subsequent WRITE_ONCE(cmdq->q.llq.cons, llq.cons); potentially
incorrect?

I'm still trying to get my head around this algorithm, but accorrding
to my current understanding, the following rule applies:

Only the cmdq owner may update the hardware prod pointer, and only
after arm_smmu_cmdq_poll_valid_map() returned for the relevant range.
Does the following instruction in arm_smmu_device_reset() violate this
rule?

writel_relaxed(smmu->cmdq.q.llq.prod, smmu->base + ARM_SMMU_CMDQ_PROD);

I'm wondering if we should just set ARM_SMMU_CMDQ_PROD to
smmu->cmdq.q.llq.cons and then have the next owner update the hardware
prod pointer.
