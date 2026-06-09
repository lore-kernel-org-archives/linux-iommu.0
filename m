Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7ED1A9F90
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 04:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780978857; cv=pass; b=G3v7QYGt/OiBnmx2mOJM9aLeO9UF6dUoGrXu4u7djIsKRHNAvx2InS/GrAiVvsabS2BK83c3hGcgAE6ccJV5CH9VPQSyRvJsZKImHdnsNnwx1ELmhOD9qKVAlm/VEoddNftKyR38uPIXV3nlLDVBXt5d0TtcUQMBN41+DMVqd8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780978857; c=relaxed/simple;
	bh=bhly8xTqAQfTTI2//G7TVMHFWFEHMrcltsnfPQj5kgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQZdCXF1XsxMsFOWRtk2NBdCJx8OxGyhrqipQURVP8v4Rkc6PhoBw6UyyDt7+v1VszohiQp3H9Znza8HKHq3ee1KG13lhbeseT70jRs1YwdmSwygWM9CN/IlwozkYD9fSLrLWIP74eyD62Eez6eed5Aw6hzH1bcGeSLms/yIOWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F/9r+1Ng; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F/9r+1Ng"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5177d1ff061so1983461cf.1
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 21:20:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780978855; cv=none;
        d=google.com; s=arc-20240605;
        b=Oq3hvUrCRJwj6oLdif2DDj86Cc7j4uRwXtNYLN+K4+RwucelrX91FBIvW9TnHcIxH8
         4ge0J2EaBmyaczzhfH4m77eeMngTyAXvuzaQyCtvZ//kbJSDE5jtVZoOrfyTUwPvt+07
         sKK24sRTPV1Fe66S0RphJGYTDSuykexUel3DVUOIcP5bbXbtWAYlf3j3DxqVdWrnOmUg
         HWJU+oNUBO2mgmO95tTarEnEAnoVkme3kbvor5FH0CdhYTFkrRBi6s3cHX9TyQdaOzfC
         8pewt+A9kejvryw6saTMs/5srY0vHwnEbCtLxUaecvqDKVMLACQFYY91Wr2E8gUIJkSx
         8n6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7I5kMFjUfQLKS3kOHOooOjgfOrWOEd0p39OkS4SVB1k=;
        fh=0u6trxL0zZwA0/1Sge/7uQQnOlSSVTu7AIo0GAZRpig=;
        b=Pb8SCspoa4+N9iTp66CrIPPGyGKHeRXMRekEpHMiQpNt+af8Y4IZ+8e9Oct5jybo0k
         WCGNJlVTS8Bbt5ivwBiA2aYXmnj4Uez/Wmw65KVJ475+/YeJCHO1hnU3aQZoCxvYm+zq
         0j9KrbbzVnHfKbTQ3Z9v+tXjRU/+Yu/ACByHZEU3B+vk4bBFMIYIhYTfR6tZ614Iz0HW
         Ur8pr2f72yBir2svjSvZtPRtC6wpfZ7JBoqk5AvduoxL35aZV4zwz9SO1XHgyXXRnOge
         jYJo5t76CoWg9eIXUSWhTP17Cb1CMZ0gtQ6OkCU6sQ3QfMc+UTiZcYW/trpLxtbozF2l
         A6Yw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780978855; x=1781583655; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7I5kMFjUfQLKS3kOHOooOjgfOrWOEd0p39OkS4SVB1k=;
        b=F/9r+1Ngcgwzk5034SX66shOn1XSDCiGzAE2J80xEh0NzxdI5P75ETEz+5Kg3BP7fr
         p63l4MDe1/vcHFpCX+ulIz19D5I9VvNE7er3ykz2tXV+OQPJmqu91v600IM4DHc95aJ+
         xcgqpiojsMVPFMckWgaWVUx6jkiAMt9of8bBqDVi6Ealeh6dU+WvLaXHuUD4NiIM7Rai
         a/hfqqktEpN130roTKzkhUFaIbxTCeqWh7SUwF1jiVHRGO7A6TRMl9XywpFAuWOs6/on
         PEMNNEJXJWTDIWhO2032/lN1coldBrYSffGhE7sqrSntuNj28JZI16R31q7rZw/PLhpq
         dylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780978855; x=1781583655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7I5kMFjUfQLKS3kOHOooOjgfOrWOEd0p39OkS4SVB1k=;
        b=dnwx4penpB5mMCF1CCW5++VVnf8QasQarDAcTsr286SxIyVjwzbYYja2Gj+Y526eM8
         cSfnVWEwXhdG0y6VbNOlVo6Wd92ThvuKiCbPm7h9FmzF8AQt+one/rRcajttwcmmj5FT
         BHtIjt/0BkCNMYqHsbDrWW97BClZIXaXro2PkLJyUTp5rY0Kwug65kM+7HBBVOl+WRYO
         vs8htzovyzs654S6vL1ldB/CB4lo8FjRk9jEp8GiG57nsqwZLk7D0m5pj/0sllzwrAk3
         3POGDJ0X8yGASs+AfaFS7kZEdVXfiLVXI64maqrZE9h9WRnImaMtkAMNpRwU0tvirF/3
         h/iw==
X-Gm-Message-State: AOJu0YzFLQMjYqL8zkZml4eHlljkSuSNeUf0ktJP8jNsRAJUEiml0foK
	3d4d03nKMtpxjupsG2YIEqMaZd+yortoHfUpaxiTPYh+Tb3l0qTLttRrIAdnutvpMycGaL25Lxs
	hw8S6p9GE9/k0xrNvpW+FykCbj3yitQ9xT9t+6ODy
X-Gm-Gg: Acq92OG0jw20nR4TUElybJog1au5nuxWyYH5RIrpL5F49uS3fazDCcErHt0j5sV5kDE
	bOASh+p6o7BrJSeYTvCKdXc9UUNvWJFAZL3HbpSSYQry8smpdTuOGad66exk/guCBVrYYOjGtqK
	G7gHFSrbYQB/KZxBg5F2kVvMlLNZRATPqABm50hXXqQG8SFpNjP5HsAk+4xAzCz4GawfvIybH3U
	owJ4J3OMdk5H0D4mKSZ74K5EeRG/IRFAMGVREXNkfTUXGTs+2KecOlHGx12HxhzlgIVZ9J4Rql9
	jBbQYSqtQQRvoUN/syJ1/5qLFw==
X-Received: by 2002:a05:622a:2cb:b0:517:5ac7:332e with SMTP id
 d75a77b69052e-51798069433mr36450171cf.6.1780978854584; Mon, 08 Jun 2026
 21:20:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260601215909.3958732-1-praan@google.com> <20260601215909.3958732-8-praan@google.com>
 <CAE2F3rDF5dVJip2gc+vaxtM-FRttnUEnAetUYz6qDCXRM=fNYg@mail.gmail.com> <aiZe97OkmvcUwCzS@google.com>
In-Reply-To: <aiZe97OkmvcUwCzS@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Mon, 8 Jun 2026 21:20:42 -0700
X-Gm-Features: AVVi8CdrHIiMqoDE8c7fuS7HvynOrR6RKi0d9Z9EqIwtonGtr0ODV-o_ZMQl_cU
Message-ID: <CAE2F3rDZupDgq5tQrvpuixGi-kVs+oi-Tacqa=Rxtri03LBPHQ@mail.gmail.com>
Subject: Re: [PATCH v8 07/12] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 7, 2026 at 11:19=E2=80=AFPM Pranjal Shrivastava <praan@google.c=
om> wrote:
> > >
> > >  static void queue_poll_init(struct arm_smmu_device *smmu,
> > > @@ -718,8 +719,25 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_=
device *smmu,
> > >         do {
> > >                 u64 old;
> > >
> > > +               /*
> > > +                * If the SMMU is suspended/suspending, any new CMDs =
are elided.
> > > +                * This loop is the Point of Commitment. If we haven'=
t cmpxchg'd
> > > +                * our new indices yet, we can safely bail. Once the =
indices are
> > > +                * committed, we MUST write valid commands to those s=
lots to
> > > +                * avoid indefinite polling in the drain function.
> > > +                */
> > > +               if (Q_STOP(llq.prod)) {
> > > +                       local_irq_restore(flags);
> > > +                       return 0;
> >
> > On second thought, I no longer believe that this is safe. I understand
> > that READ_ONCE(cmdq->q.llq.val) implies no ordering guarantees with
> > respect to any writes to translation tables. In the non-stopped case,
> > we can rely on the call to dma_wmb() further down in this function.
> > However, for the stopped case, I can't identify any barriers that
> > would ensure that the STOP flag is checked only after the writes are
> > visible to SMMU. Here is an example: Let's assume the following
> > program order:
> >
> >  * Write to invalidate PTE
> >  * Read from cmdq->q.llq.val, determine STOP flag is set, elide TLBI
> >
> > What prevents the CPU from reordering these operations as follows?
> >
> >  * Read from cmdq->q.llq.val, determine STOP flag is set, elide TLBI
> >  * Write to invalidate PTE

Now, I believe that the smp_mb() call in arm_smmu_domain_inv_range()
actually prevents this (if we remove arm_smmu_cmdq_can_elide or move
it to after the smp_mb() call)

> >
> > Can the following situation occur?
>
> Not really because:
>
> >
> >  * Read from cmdq->q.llq.val, determine STOP flag is set, elide TLBI
> >  * (Different CPU resumes SMMU)
>
> We do a full smp_mb() here to ensure all writes are seen before SMMUEN=3D=
1
> (note that the STOP_FLAG is already unset at that point, so we stop
> eliding commands much before the SMMU is physically able to access any
> config/xlation structures, I've explained everything below).
>
> >  * SMMU loads old PTE value into TLB
> >  * Write to invalidate PTE
> >  * (stale PTE remains in TLB)
> >
> > I propose the following: If you find the STOP flag set, run dma_mb()
> > and check again. I'm afraid that running dma_mb() unconditionally
> > might incur too much of a performance penalty.
>
> IMHO, I think this might be overcomplicating things here..
> Here's why the current version works according to me:
>
> Till SMMUEN=3D0, the SMMU is spec-guaranteed to never access translation
> or configuration structures (Section 6.3.9.6).
>
> Our runtime_suspend callback sets SMMUEN=3D0 before setting the STOP_FLAG=
.

Does "before" refer to program order or the order in which other
agents can observe the STOP_FLAG relative to when SMMUEN=3D0 is set?
Your program might read "Set SMMUEN=3D0 then set STOP_FLAG". However, my
question is whether other observers might see the STOP_FLAG before
SMMUEN is cleared. I couldn't identify any barriers in
arm_smmu_runtime_suspend() that would prevent this type of
re-ordering.

> Even if the worker CPU reorders the PTE write after the STOP_FLAG check,
> it is benign because the SMMU is incapable of fetching that (or any) PTE
> while the gate is closed. Because GATE_CLOSED =3D=3D SMMUEN =3D 0, implyi=
ng no
> access to any HW structures whatsoever.
>
> The real synchronization happens in the Resume Path:
>
> 1. arm_smmu_device_reset() clears all caches / TLBs.
>    (None of these can have entries before SMMUEN=3D1)
>
> 2. We execute a full smp_mb() before setting SMMUEN=3D1. (that's why we
>    need smp_mb before SMMUEN=3D1). This barrier ensures that any PTE
>    writes made by any thread=E2=80=94including those that were elided whi=
le the
>    gate was closed, are globally visible before the SMMU hardware starts
>    fetching into TLBs again. (This is why Jason suggested this in v6 [1])

A barrier on one CPU has no bearing on whether writes by any other CPU
can be observed by any particular agent in the system.

Let's compare this with the long comment in
arm_smmu_domain_inv_range() which is what I believe Jason was
referring to. In that example, you see smp_mb() in the code path on
CPU0 and dma_wmb() in the code path on CPU1. Hence, barriers exist on
both sides. If you compare the runtime PM design with
arm_smmu_domain_inv_range(), then smp_mb() belongs in the CPU thread
that performs the translation table updates not the one that performs
the suspend/resume operation.

Actually, now that I think of it: We could just piggy pack on the
existing smp_mb() in arm_smmu_domain_inv_range(). For your
arm_smmu_cmdq_can_elide() to work correctly, though, you would need to
move it to *after* the smp_mb() call. This being said, I would prefer
to remove arm_smmu_cmdq_can_elide() as I wrote on the other thread.
If we do take advantage of the existing smp_mb() in
arm_smmu_domain_inv_range(), then we should probably update that
comment to state that the runtime PM implementation now also depends
on it.

>
> Adding a dma_mb() to the elision path would be redundant given the
> SMMU can't access any structures and the resume barrier. We'd be
> needlessly injecting dma_mbs when no entity is actually accessing those
> structures while the STOP_FLAG is set.
> >
> > I have the same concerns with arm_smmu_cmdq_can_elide(): That
> > READ_ONCE in arm_smmu_cmdq_can_elide() provides no guarantees in
> > regards to ordering relative to PTE writes.
> >
>
> The same as above, No structures are accessed during SMMUEN=3D0 (spec) an=
d
> during resume before setting SMMUEN=3D1, we do a full smp_mb() to ensure
> all concurrent PTE writes are acquired in our resume thread before we
> enable SMMUEN=3D1

I think the definition of "all concurrent PTE writes" is a bit vague.
I don't think the architecture allows you to wait for writes performed
by other CPUs to be observable by all other agents. The only thing you
can do is to ensure that other agents can observe that the STOP_FLAG
has been cleared *before* SMMUEN is set. However, this is already
achieved by the existing dma_wmb() in arm_smmu_cmdq_issue_cmdlist().
Hence, the extra smp_mb() is not required.

>
> Thanks,
> Praan
>
> [1] https://lore.kernel.org/all/20260424151639.GE3611611@ziepe.ca/
