Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D630A38944D
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 22:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773096090; cv=pass; b=V5FuWfxLeWRtuKep3d84iciD/8ELfp8uzNOsGEolGq4gAV/foAB+wz/5S2sGKo/etW4BXdXfANzhMK/zZSi5hat2uIRCV7MeZIEMEvi5AV4EWT+rt1wvYUWDIqNx47k1QsnZWWhPxeROdL70Qd+RT3apefYOczAwMZm+95LLfuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773096090; c=relaxed/simple;
	bh=hd1UOE+n3zi/UIeVn5ZPOqWNZWqWMmK88OeMNIJYLNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGIOWHcyERucx8NRKCzL6x+uSAZEjlW3sfoZ0lrhiz7XkUSHcNCWh5LAFGs0Q0v6YqqJPDI6VFEKs8dMl2cAP8QzIzKxFOBaNkg24KNdT7193ic50/nqTALUlpKUQn9LAOhb5yya2ntQvCSifUA7d7Nt8P7Gweax9qb+xYGEqZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QD34gorl; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QD34gorl"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-509062d829dso105771cf.1
        for <iommu@lists.linux.dev>; Mon, 09 Mar 2026 15:41:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773096088; cv=none;
        d=google.com; s=arc-20240605;
        b=QanPzFXy0EDeHePiQYjdL0nxbdVicB/ilTLUvpEC64nT6v2owmgTQx9zqh9dwjCTaJ
         XSBgDchX5/Exo7oqCHC9jLrLXIS7S1wBh857F3zcQArY6luxdT9JDNKogDAub8PQvxwa
         ABuAQoxVVsJjGi5BKLlpMNiqa0/kCOMG4IRSvXBualkHiu2Xa4HLMZzuud00wraBtZjN
         XfhLBOyqNsUsdD9w3IYXzGPUWhCCSPhoXT8yHOdC7ti6gb9MpBh7yQNMTiwSYcuQpDns
         9XL6WgooyZVynWeJopP2fLKrlcGFlUV/4IsTSR/zXgz7PY+xYzzovw1UzEyN6sYx/5nJ
         b7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q+0U9LEzn7iEJIVaCTuDl1rKtdnmYwaunKbA/AKCHvI=;
        fh=Cr9Gz+4KxVp4Ci1moPY7g4WpWFGCr0a9bcVWr63STi0=;
        b=Ls5IbXmjeVl/FZGR3aM1r95eatxkFtpHGbHCEO633fgU5/FEde3HEdQCFwzeIDov3J
         v+2aS9b2ozMk5I59HMDHNlyMdxi57BAuC37GpKUFvWeJY0LFVmDT1yIP+LPxNaJh0uUH
         +UzjGioxA4R/mEEN6VwycEfsHiPHdoBFxZ5+WDcld5i2AcI518y3Aj6v+tgXIjWiXzm2
         2s8JVPLxm5EA9VBn0293Tzyt/ivtkiqzxlfWZzm74XSd19pNwSvZrluxfQDtHLWopzJ8
         siAOQWdCGaBqzLGpfQeig6LGs+MGqgKWq+k1lKrq8/sq8kniDLl2mRPFZQ0DtWmDcLpy
         CY4Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773096088; x=1773700888; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+0U9LEzn7iEJIVaCTuDl1rKtdnmYwaunKbA/AKCHvI=;
        b=QD34gorlRBa09VgEhNAXjj5BX+tzgxMeOqU3PMnHbgBqOtox6ryA9no2sxDS/xfZuU
         p2Lp3zgO5t6SDPXNLDSCDevMk2Al4tT5QyM0Mch0VQ/cBUiSL3C4NsuJkLl6VlViIrOy
         vj5iegtO2+CyHtKbgrNJn7NNnond+3JI46WO1dyDPy6xxcKjyDM4MvmjSeC3tvix5pqm
         6E7if8/g50dhlaPY8Atja1mYcRneLN20JdXdNNBap7Eh33+PQ+BfzuMQ6bJIlEAF0T5D
         IanvT+FerI1uTrL9fk8x5X/P4jaR7huf/JZ8vnLdT//TWAoJ0guA8Ya+Sk3IiYNxlqRr
         6s7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773096088; x=1773700888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q+0U9LEzn7iEJIVaCTuDl1rKtdnmYwaunKbA/AKCHvI=;
        b=rnrdSlrgiM7Zqj9i9lk7yIWZZCHhcWF7ALMhQMj9T21FWII6TF+4ZZ3shjh5PImUNg
         pblBPzgpXBGNm7CoxjiWlYnhlsdLUFalFbyKAZenORcbqDqIGmCZe2XoGrINsLVTriGc
         3U9AT8knPgBWnR9KlXayTGar41HJkftAoMKBZ+gApc3gmL7pJDToOM1cRIfzD87EgBzV
         F+wSKB+M7Naf1KjQTvw0KzSuMFDY83YcyBH/hVXKzflssw6o7tkp4V/MT7zpRXA40iGI
         U9Qz7exEaSbe2pS2SSQZZ9bSPFUvE8APx4xyiZypRd+BwjdMrb4gRlapNOFUl+bEMvIj
         5udw==
X-Gm-Message-State: AOJu0YxhNYzJvQ9ZeVg1stWyFTqCi6bDDxaTYbLxyERYzH4jtwTCqELv
	+Chv5TIvNQWsQKPAnP+yX4sHxTIVnGF8BdlmzM6jBqXxnMAIncXW8WG9w91mG8lqxJqx6r7DOSl
	ZLrTcIiKrKtneu0VBQEwp3m+AW+dIhYehPxR8vQyT
X-Gm-Gg: ATEYQzx3LLeoEJyCb2hVeSLh5eorG6yiV6XxnV9x2HeYALsh5CVs5SXUg6dyoAt/d4m
	rldf6fC++BJIsUAjDTZRg2WKvg2mDfHwC+xSsRtVQUSKZaaMaIujg2NpgS04O/ZmqGRPLCkL8Dj
	i81XWgXagFugpvFEsakiwYxthItO9Fh+ETC5qm6O1Bl3NxHYEsHFJJKvaPvG0vziKEJ5ep6Zdo0
	08riPmCP2fQ7RM9ExU6XKP7ZjH3H96TBDGGu0JxAK/T1WBSSz5YNhNzBK1lJHM95EgrN+WZ4Rse
	eHKP
X-Received: by 2002:a05:622a:1315:b0:501:19b9:42e9 with SMTP id
 d75a77b69052e-50926d651d2mr4109031cf.4.1773096087070; Mon, 09 Mar 2026
 15:41:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260126151157.3418145-1-praan@google.com> <20260126151157.3418145-7-praan@google.com>
 <CAE2F3rD0aoTXJBnS4SPHLEEst6cTvoUxNywRZ1RhdgwNA_0JTA@mail.gmail.com> <aa8jkLD0l2WqMnyG@google.com>
In-Reply-To: <aa8jkLD0l2WqMnyG@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Mon, 9 Mar 2026 15:41:16 -0700
X-Gm-Features: AaiRm53D3J3nARYrmF_0OeGWH8dj9BmAGZl65prHRAwxTZfcmww0GA2bPjqUeFs
Message-ID: <CAE2F3rBFRSTC7bFCYTCit1-OKrT3jB-fwYGu_UJbwX+7aE65eA@mail.gmail.com>
Subject: Re: [PATCH v5 06/10] iommu/arm-smmu-v3: Add a usage counter for cmdq
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>, 
	Sairaj Kodilkar <sarunkod@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 12:46=E2=80=AFPM Pranjal Shrivastava <praan@google.c=
om> wrote:
> > > @@ -819,8 +819,15 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_=
device *smmu,
> > >
> > >                 while (!queue_has_space(&llq, n + sync)) {
> > >                         local_irq_restore(flags);
> > > +
> > > +                       if (!atomic_inc_not_zero(&smmu->nr_cmdq_users=
))
> > > +                               /* Device is suspended, don't wait fo=
r space */
> > > +                               return 0;
> > > +
> >
> > Does this mean that we still accumulate commands until the queue is
> > full while in the suspended state and then have SMMU excecute all of
> > these (now irrelevant) commands when the command queue is re-enabled?
> > One might argue that this is wasteful, but I guess it might be
> > technically correct, because it doesn't hurt either.
> >
>
> No, we drop any commands that are issued if the command queue doesn't
> have space while it is suspended. There are two reasons for this:
>
> 1. The arm_smmu_cmdq_poll_until_not_full below would try to perform an
> MMIO access (read_relaxed(cmdq->q.cons_reg) which shouldn't be allowed
> when the SMMU is suspended.
>
> 2. We usually have 3 types of commands in the SMMUv3:
>
>  a) Invalidation commands: We clear the entire TLB during resume, so we
>  don't really need to batch these.
>
>  b) Prefetch commands: Any prefetches are effectively no-ops as when the
>  SMMU is suspended, the resume would effectively read the latest config
>
>  c) Page responses: These are NOT expected to occur while the SMMU is
>  suspended and we shouldn't be batching them anyway. (The page resp
>  handlers handle such situations and avoid queueing-in commands anyway
>  with this series)
>
> Thus, any dropped invalidation / prefetch commands don't harm us if the
> SMMU was suspended.

Understood. My point is that we start dropping commands only when the
command queue fills up, even though we could potentially drop commands
even earlier.

> > >                  * Control dependency ordering from the entries becom=
ing valid.
> > >                  */
> > > -               writel_relaxed(prod, cmdq->q.prod_reg);
> > > +               if (atomic_inc_not_zero(&smmu->nr_cmdq_users)) {
> > > +                       writel_relaxed(prod, cmdq->q.prod_reg);
> > > +
> > > +                       if (sync) {
> > > +                               has_ref =3D true;
> > > +                       } else {
> > > +                               /*
> > > +                                * Use release semantics to enforce o=
rdering without a full barrier.
> > > +                                * This ensures the prior writel_rela=
xed() is ordered/visible
> > > +                                * before the refcount decrement, avo=
iding the heavy pipeline
> > > +                                * stall of a full wmb().
> > > +                                *
> > > +                                * We need the atomic_dec_return_rele=
ase() below and the
> > > +                                * atomic_set_release() in step (e) b=
elow doesn't suffice.
> > > +                                *
> > > +                                * Specifically, without release sema=
ntics on the decrement,
> > > +                                * the CPU is free to reorder the ind=
ependent atomic_dec_relaxed()
> > > +                                * before the writel_relaxed().
> > > +                                *
> > > +                                * If this happens, the refcount coul=
d drop to zero, allowing the PM
> > > +                                * suspend path (running on another C=
PU) to disable the SMMU before
> > > +                                * the register write completes, resu=
lting in a bus fault.
> > > +                                */
> > > +                               atomic_dec_return_release(&smmu->nr_c=
mdq_users);
> > > +                       }
> > > +               }
> > >
> > >                 /*
> > >                  * e. Tell the next owner we're done
> > > @@ -894,14 +926,19 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu=
_device *smmu,
> > >
> > >         /* 5. If we are inserting a CMD_SYNC, we must wait for it to =
complete */
> > >         if (sync) {
> > > -               llq.prod =3D queue_inc_prod_n(&llq, n);
> > > -               ret =3D arm_smmu_cmdq_poll_until_sync(smmu, cmdq, &ll=
q);
> > > -               if (ret) {
> > > -                       dev_err_ratelimited(smmu->dev,
> > > -                                           "CMD_SYNC timeout at 0x%0=
8x [hwprod 0x%08x, hwcons 0x%08x]\n",
> > > -                                           llq.prod,
> > > -                                           readl_relaxed(cmdq->q.pro=
d_reg),
> > > -                                           readl_relaxed(cmdq->q.con=
s_reg));
> > > +
> > > +               /* If we are not the owner, check if we're suspended =
*/
> > > +               if (has_ref || atomic_inc_not_zero(&smmu->nr_cmdq_use=
rs)) {
> >
> > Can there be a situation, where we execute this branch and the
> > hardware prod pointer has not been updated, in which case
> > arm_smmu_cmdq_poll_until_sync will wait forever (well, actually, until
> > it times out). Imagine the following series of events:
> >  * nr_cmdq_users=3D=3D0
> >  * hardware prod pointer update is skipped
> >  * nr_cmdq_users becomes 1
> >  * arm_smmu_cmdq_poll_until_sync waits but commands are not executed
> > by SMMU because hardware prod pointer update wasn't updated
> >  * arm_smmu_device_reset() tries to submit CMDQ_OP_CFGI_ALL, but gets
> > stuck because the queue is full.
> >  * cmdq->q.llq.cons is never updated because the shared lock is held.
> > queue_has_space() returns false, and
> > arm_smmu_cmdq_poll_until_not_full() can't get the exclusive lock
> >
>
> Thanks for catching this! IIUC, you mean a race between the resume and
> this code block can cause a deadlock? Something like the following:
>
> CPU 0                                   CPU 1
> nr_cmdq_users =3D=3D 0
> skip hw_prod++
>                                         ->resume cb
>                                         nr_cmdq_user =3D=3D 1
> nr_cmdq_users =3D=3D 1
> in the if (sync) part
> arm_smmu_cmdq_poll_until_sync()
>                                         CMDQ_OP_CFGI_ALL stuck for space
>
> I guess we could add a check here if (has_ref =3D=3D false) but
> nr_cmdq_users > 0, then we could write the prod_reg again.. maybe we'd
> need to factor out a helper function here.. I'll think more about this..
>
> I guess the simplest thing would be to bail out much before, something
> like if (nr_cmdq_users =3D=3D 0 && sync) return;

On a related note: Can you guarantee that with your current approach,
nr_cmdq_users drops to 1 even with a high rate of calls to
arm_smmu_cmdq_issue_cmdlist() from multiple CPUs or will your "/* Try
to suspend the device, wait for in-flight submissions */" eventually
time out?

Have you considered an alternative approach where you put

if (!atomic_inc_not_zero(&smmu->nr_cmdq_users))
return 0;

at the beginning of arm_smmu_cmdq_issue_cmdlist() and an unconditional
atomic_dec_return_release(&smmu->nr_cmdq_users); at the end? I think
that would avoid this potential deadlock situation.

>
> > I'm still trying to get my head around this algorithm, but accorrding
> > to my current understanding, the following rule applies:
> >
> > Only the cmdq owner may update the hardware prod pointer, and only
> > after arm_smmu_cmdq_poll_valid_map() returned for the relevant range.
> > Does the following instruction in arm_smmu_device_reset() violate this
> > rule?
> >
> > writel_relaxed(smmu->cmdq.q.llq.prod, smmu->base + ARM_SMMU_CMDQ_PROD);
> >
>
> Not really as we don't enable the command queue by that point.
> (but it's still racy as you've mentioned in the queue_full scenario
> above)

You're enabling the command queue right after writing to ARM_SMMU_CMDQ_PROD

/* Command queue */
writeq_relaxed(smmu->cmdq.q.q_base, smmu->base + ARM_SMMU_CMDQ_BASE);
writel_relaxed(smmu->cmdq.q.llq.prod, smmu->base + ARM_SMMU_CMDQ_PROD);
writel_relaxed(smmu->cmdq.q.llq.cons, smmu->base + ARM_SMMU_CMDQ_CONS);

enables =3D CR0_CMDQEN;
ret =3D arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
      ARM_SMMU_CR0ACK);

My point is that writing smmu->cmdq.q.llq.prod to ARM_SMMU_CMDQ_PROD
is premature. This might lead to the SMMU reading from command slots
that haven't been fully populated.

Daniel
