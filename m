Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB760280008
	for <iommu@lists.linux.dev>; Tue,  6 May 2025 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746548799; cv=none; b=Ad6w5xzqUgamVKlyZRMm379OhRtTOBAo7IIt/HzLXTUZ/Y7gL5dq3wRJQWx04NJ7/EGCycSQQtTv5yiPFCW5Yxev3Ip5w5unT9TohlFuOQZS2Hd/UrqKyadzmOt/7YZNHd3eM2uhk8GDETOZMeKYmQw5CekGYaSvysFBYewxrdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746548799; c=relaxed/simple;
	bh=OUAw5A6DAgqvZt7MHmztMx8kURQYzD8rXFUwAwEBkuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=db5Ssxpj2CveuZS/78grrL6TuyUVZGZzYDpPtQL8pB+ShYN1m151t4ttAUDnrrSjlcC2G5SKbRtD0XqPm8bbyJcc+3LW0I06LqnZtmEMfP7X1Is56bVkNN23pw/nYsaesToRQkWWWBJqzejuxRD1yw1oIDxHt8DUX3GJk5Wiy48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exQRuFJw; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exQRuFJw"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736b94d12b6so362881b3a.1
        for <iommu@lists.linux.dev>; Tue, 06 May 2025 09:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746548797; x=1747153597; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2iEPT31lWJmfZ711HkWVQ8QdQyTw1Ihj+viAfDs+a4=;
        b=exQRuFJwja/J2SZ05sHQ+xkIHyc7qw38tC2+CenPZ11Cc5G1YrY7rWbgi1s20Jt5l3
         69uBO4zFsTO2eU4kX2AGKetmTlW39wBrBFqDRUFGcFQNu4wEfN0URZjUUnuFyqLYrRos
         2T1eTfGMOo2iCBWqHFDHRwngY+gk7bd89BMSw/VjxJTFKSFFw4dPPt765vMXptHX7XBz
         fNWIKEMKngkCSh7w6cnZqYR7062EGY0uzWk/Jkwp9gI2ha/dfMTRIR+uDzDmmwi0+9x/
         75u+yYq3zA4Zfjw8i0js6gNo987JZNg+ocHwK1AFr15f+Wv4oY9EWWfjBX+Y0zPxPSfm
         /n9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746548797; x=1747153597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2iEPT31lWJmfZ711HkWVQ8QdQyTw1Ihj+viAfDs+a4=;
        b=BAbaOT3Y85qDIwMM3SuVJecJTCjN/+DgOR3li5cfG6h5Fm0oTyjJAaYzgTIZ86v2B0
         csg84qhCGHkD2aDt0ogJEKgYePELCLeEORz96WBWGrO1GFzpS/DGK4k9fEyBh6llsYFK
         Hh3Vg7tas/EPJ8gOP/tiktK/4l3vz6NduqnX8eJt+W+c5l50VGsoy3CcwL2IOOiBhD0E
         I3L3/3FYwKnzXzgPSoHeawhsB6mzU5pVuDGNTPAis/8XMF4SebvgNHybymwkFNM0QVlo
         nUF2un8eDexjmI69M/tSQ4SdiCi+OpOq6ANdHEW+NkdtbwYVr4tHcpRcw4+2PKdNg/L5
         K7fA==
X-Forwarded-Encrypted: i=1; AJvYcCX03I/62ovk2C2cCnJxg0zZgHhWgJNcRdRzhdHGa9ISiuXeell1PO3m1VVizhKi90chQP1jHg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOB61LBs3xEkV4AIEqzR2uIYKFGufCXJLt2t4ZVUZ6Lmdr9snf
	ZMCU5SwdU45K5XhBb8iywIGl+8lXIkfFfClw/mLhXmMNolZqAt5DUjFlDZurKq+Zw+VbPnBtGZr
	Fz1hidD/hS9FU1T8asJtJAs2A/00=
X-Gm-Gg: ASbGncsBTQyyWvt6u4hze2aikVbfOZvJ1/deC7M/6C2J7pde9eykqGAyg5oRhhyuT3v
	OVgaWRs/4X9PDdLmkYwb0nhNEzFuOuzgrzMDFCGM62JKFb8Kbc34HDx59zToKb+nD70KK9NaWNS
	YGD/bYppBP4WrfcP0J6AOl6w==
X-Google-Smtp-Source: AGHT+IFevbIXo6chZ46DVNlJBWVZ9S7rGrPtFFMLAbHqHbciNEKnYEm+KoSXMjS7AzymQV/ccrlzB9i7DV6tVCsE5Kc=
X-Received: by 2002:a05:6a00:4296:b0:730:87b2:e848 with SMTP id
 d2e1a72fcca58-7409ba60c50mr111599b3a.5.1746548797029; Tue, 06 May 2025
 09:26:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250319-msm-gpu-fault-fixes-next-v5-0-97561209dd8c@gmail.com>
 <20250319-msm-gpu-fault-fixes-next-v5-1-97561209dd8c@gmail.com> <20250506113246.GA723@willie-the-truck>
In-Reply-To: <20250506113246.GA723@willie-the-truck>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Tue, 6 May 2025 12:26:25 -0400
X-Gm-Features: ATxdqUGyVeePAC0AKGU6Pbw5gC5TE6nCefsVqalCzAGzu-h58HCMKVxLU73Zb-o
Message-ID: <CACu1E7HXd9bUWwPCa_XxkQYRwCg6aobr8snFzArE=D99Z+iRJQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] iommu/arm-smmu: Save additional information on
 context fault
To: Will Deacon <will@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 7:32=E2=80=AFAM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Mar 19, 2025 at 10:44:00AM -0400, Connor Abbott wrote:
> > This will be used by drm/msm for GPU page faults, replacing the manual
> > register reading it does.
> >
> > Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
> > Reviewed-by: Rob Clark <robdclark@gmail.com>
> > ---
> >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c |  6 ++--
> >  drivers/iommu/arm/arm-smmu/arm-smmu.c            | 35 ++++++++++++++--=
--------
> >  drivers/iommu/arm/arm-smmu/arm-smmu.h            |  7 +++--
> >  3 files changed, 29 insertions(+), 19 deletions(-)
>
> [...]
>
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/=
arm-smmu/arm-smmu.c
> > index ade4684c14c9b2724a71e2457288dbfaf7562c83..a02078eb968b81a35c1c086=
ed7007ea2a453ef94 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > @@ -405,13 +405,20 @@ static const struct iommu_flush_ops arm_smmu_s2_t=
lb_ops_v1 =3D {
> >  };
> >
> >
> > -void arm_smmu_read_context_fault_info(struct arm_smmu_device *smmu, in=
t idx,
> > +void arm_smmu_read_context_fault_info(struct arm_smmu_domain *smmu_dom=
ain,
> >                                     struct arm_smmu_context_fault_info =
*cfi)
> >  {
> > +     struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> > +     int idx =3D smmu_domain->cfg.cbndx;
> > +
> >       cfi->iova =3D arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_FAR);
> > +     cfi->ttbr0 =3D arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_TTBR0);
> >       cfi->fsr =3D arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
> > -     cfi->fsynr =3D arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSYNR0);
> > +     cfi->fsynr0 =3D arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSYNR0);
> > +     cfi->fsynr1 =3D arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSYNR1);
> >       cfi->cbfrsynra =3D arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA=
(idx));
> > +     if (smmu_domain->stage =3D=3D ARM_SMMU_DOMAIN_S1)
> > +             cfi->contextidr =3D arm_smmu_cb_read(smmu, idx, ARM_SMMU_=
CB_CONTEXTIDR);
>
> I think this leaves 'cfi->contextidr' uninitialised for stage-2 domains.
> We should probably either zero it here or just zero-initialise the whole
> 'cfi' struct in arm_smmu_context_fault() with a:
>
>         struct arm_smmu_context_fault_info cfi =3D {};
>
> line.
>
> Will

The next patch moves the context fault info into arm_smmu_domain which
is already zero-initialized.

Connor
