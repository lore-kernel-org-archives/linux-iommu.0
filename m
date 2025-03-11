Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715F5265CA4
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 22:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741732612; cv=none; b=fkQ07SkIbwlJmRHQUtvgW5I5aSq4gBEXO/eAdx2u36dDviwLMYBHloiZrLv3DqzTyveYUVIZra2jOQvRIK3MLMZq7DXEijYLyyuYud9E5R9hwIuuEQiOLjVdxCHkp/uMa7/8X0sb9tNP2QjRB9VsQ8qUfxrDTm4O5kW8k2TUA1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741732612; c=relaxed/simple;
	bh=stGKqEUr4q8JKAOwejt7cWzSSykKFgW9stzYakf8cZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QeOcmURZaTpylJqTRqeP48qpo8rrVOfN7r3NVkA7buqF2ux4xzF482wD0iPyRrrUxCj48tdowDwXOcwmYYfQZGGHzB/5+y1gTyPGQ2ujmyuocHhEneGcNqAFrx4rD9kEiAaCaBrZRGqS0Sp01w6f3gzMEwy36TM9xz2lBv2do2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXlxEsY2; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXlxEsY2"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f9b8ef4261so1577769a91.1
        for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 15:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741732610; x=1742337410; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75JlrEnI8tdqw5rkhyab++osfwTd4EpAvf26QJsRa+Q=;
        b=MXlxEsY2AY3K5KFHHrIY8eB+4isYm0Rq2lzK2KFpv2p1GqM6JkSWUI3FMJzTmIO54q
         jT8gn+fXklfOw5/ciSkyXQamtdbUe2bN51XeiQJ0Hm+27PGUEvOt4fIZmw9wyZq0xHP/
         FKx7+y7rOyPdvYm5SVE1A2+uHf0uMbXBWXgCn/Hkb0VecTVCNN3M0of2aOuHfDexAqwA
         u7X+gCpLq205o7miJaqvDvKxLMnH6P3SLq2HZRsAQCACiXhL7qhIJtcvuJnxr8YBsm2j
         8Py37+wLaa0CljyUxK4ZjETpOSi3ZVsHMWcpgRaU2NoEf1B9400z/DuIlKdDLARNJeO5
         Ufdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741732610; x=1742337410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75JlrEnI8tdqw5rkhyab++osfwTd4EpAvf26QJsRa+Q=;
        b=W7DThwX5cUsXs9lN6trI9DyEwUUQvS7AMdBsouFyXCp5E31O11Rpj2jduMmSWETM9G
         hVYdSaA3dSoFzG3zQviCMSxWSxACkrsk6BWVxTM9mFW4p58d3HcNMQnM0xS3udZEpupv
         4F5C6+sgJ59qxvBEbFqYTM7zlGCHuN1zVKVtMEKPTxg6cftH6w0moEpFx6vzFftgkfp5
         hP0V38UoAqhMZBwDUbEzIASVAlTzCZDkoPgg3VbuRZdxaHBT2ns7Uj4QuXFMDEXDpiTV
         ZDqL1dPtAjSCtw9ZA6GJTq7rTl/UghVTCkjXwVTzwiDPQ+QuRJeZkDLTgt3gzXDSEEih
         XJBw==
X-Forwarded-Encrypted: i=1; AJvYcCWOUi5UU8C1GBZh6LAwSyuZinO1tSWDY0qEO75B2ynoWGlIKTEL/dtUTC/kotMvv++VxHz8pg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzuudfuJCpToDejA5q+JmwJvIuk+0NZuw9bVbAoWtgpRYB4zKvl
	Z7QusHbbP6M77xvDFy44miita35JFUnXk3Lw/IEyZk2q+38X5smf1T1I4isyQKsKhlyniB7+rUh
	yBCSjt3lVI5ggVWWLHYMI/KS7NR0=
X-Gm-Gg: ASbGncv3Nh3ufyncV7WGPjosshOrMvS4v+WktZ1NvSqD8a8XbD8W1wjd9BPz8nnLUSR
	wEQm1kMpCKr37GA3MKXL18cwPglNXIGV6+nOKkt7HifrwK4+eqyeJMVkB81nRbylLkTcEsKe/7f
	LftbOh1a8/7d+BDX1O69BLU9Slbw==
X-Google-Smtp-Source: AGHT+IE2yP0Oqp5icApOYEeT5S9ryMzCphdSruIQb+pyZ1tL48mZ6lOK0AKajCd16hcESy+fMFtcVCe/Z6YypMdt4rI=
X-Received: by 2002:a17:90b:4a81:b0:2ee:f59a:94d3 with SMTP id
 98e67ed59e1d1-300a2891c23mr8155406a91.0.1741732609220; Tue, 11 Mar 2025
 15:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250304-msm-gpu-fault-fixes-next-v4-0-be14be37f4c3@gmail.com>
 <20250304-msm-gpu-fault-fixes-next-v4-1-be14be37f4c3@gmail.com> <20250311180553.GB5216@willie-the-truck>
In-Reply-To: <20250311180553.GB5216@willie-the-truck>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Tue, 11 Mar 2025 18:36:38 -0400
X-Gm-Features: AQ5f1Jpps08fowB20qui8teO0kCK3_0sMgX__rQse3av3tUA4enIqUvNjCSXypk
Message-ID: <CACu1E7GzCiO2b7AFJSDC+pN2VD9VaD2aYz_GGymM3-xAUqd__A@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] iommu/arm-smmu: Save additional information on
 context fault
To: Will Deacon <will@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 2:06=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
>
> On Tue, Mar 04, 2025 at 11:56:47AM -0500, Connor Abbott wrote:
> > This will be used by drm/msm for GPU page faults, replacing the manual
> > register reading it does.
> >
> > Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
> > ---
> >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c |  4 ++--
> >  drivers/iommu/arm/arm-smmu/arm-smmu.c            | 27 +++++++++++++---=
--------
> >  drivers/iommu/arm/arm-smmu/arm-smmu.h            |  5 ++++-
> >  3 files changed, 21 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c b/drivers=
/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
> > index 548783f3f8e89fd978367afa65c473002f66e2e7..ae4fdbbce6ba80440f53955=
7a39866a932360d4e 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
> > @@ -400,7 +400,7 @@ irqreturn_t qcom_smmu_context_fault(int irq, void *=
dev)
> >
> >       if (list_empty(&tbu_list)) {
> >               ret =3D report_iommu_fault(&smmu_domain->domain, NULL, cf=
i.iova,
> > -                                      cfi.fsynr & ARM_SMMU_CB_FSYNR0_W=
NR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
> > +                                      cfi.fsynr0 & ARM_SMMU_CB_FSYNR0_=
WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
> >
> >               if (ret =3D=3D -ENOSYS)
> >                       arm_smmu_print_context_fault_info(smmu, idx, &cfi=
);
> > @@ -412,7 +412,7 @@ irqreturn_t qcom_smmu_context_fault(int irq, void *=
dev)
> >       phys_soft =3D ops->iova_to_phys(ops, cfi.iova);
> >
> >       tmp =3D report_iommu_fault(&smmu_domain->domain, NULL, cfi.iova,
> > -                              cfi.fsynr & ARM_SMMU_CB_FSYNR0_WNR ? IOM=
MU_FAULT_WRITE : IOMMU_FAULT_READ);
> > +                              cfi.fsynr0 & ARM_SMMU_CB_FSYNR0_WNR ? IO=
MMU_FAULT_WRITE : IOMMU_FAULT_READ);
> >       if (!tmp || tmp =3D=3D -EBUSY) {
> >               ret =3D IRQ_HANDLED;
> >               resume =3D ARM_SMMU_RESUME_TERMINATE;
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/=
arm-smmu/arm-smmu.c
> > index ade4684c14c9b2724a71e2457288dbfaf7562c83..a9213e0f1579d1e3be0bfba=
75eea1d5de23117de 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > @@ -409,9 +409,12 @@ void arm_smmu_read_context_fault_info(struct arm_s=
mmu_device *smmu, int idx,
> >                                     struct arm_smmu_context_fault_info =
*cfi)
> >  {
> >       cfi->iova =3D arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_FAR);
> > +     cfi->ttbr0 =3D arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_TTBR0);
> >       cfi->fsr =3D arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
> > -     cfi->fsynr =3D arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSYNR0);
> > +     cfi->fsynr0 =3D arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSYNR0);
> > +     cfi->fsynr1 =3D arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSYNR1);
>
> We already have an implementation hook (->get_fault_info()) which the
> qcom SMMU driver can override with qcom_adreno_smmu_get_fault_info().
> That thing dumps these registers already so if we're moving that into
> the core SMMU driver, let's get rid of the hook and move everybody over
> rather than having it done in both places.

As you probably saw, the next commit moves over
qcom_adreno_smmu_get_fault_info() to use this. The current back door
used by drm/msm to access these functions is specific to adreno_smmu
and there isn't an equivalent interface to allow it to call a generic
SMMU function so it isn't possible to move it entirely to the core. At
least not without a bigger refactoring that isn't justified for this
series that is just trying to fix things.

>
> >       cfi->cbfrsynra =3D arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA=
(idx));
> > +     cfi->contextidr =3D arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_CONTE=
XTIDR);
>
> I think the CONTEXTIDR register is stage-1 only, so we shouldn't dump
> it for stage-2 domains.
>
> Will

Does it matter if we read the register though, as long as users are
aware of this and don't use its value for anything?

Connor
