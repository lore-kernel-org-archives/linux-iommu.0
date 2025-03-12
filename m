Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27AD22ACD1
	for <iommu@lists.linux.dev>; Wed, 12 Mar 2025 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786221; cv=none; b=Lkxa0LGkAyINNWeWzVv6t3IQ9hXydHnZGb+NAKL1g+xDMGdWWelCCGESfwtduPiym/arGbt9hWs+siXtDZluvkcv3OHU2idQrfygjFE/DYiSSVOg+X/0pfzS/D5PdRINbYapbmrtTIh6F0bTO71bHR/KLq7Jo73gyNkg6W1O7Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786221; c=relaxed/simple;
	bh=dUkhfbQ1pEJvrtOfEPaUFyyEtMdnqKdonMPgNHzBEJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctY2khW45iGxZYcrp37XYDeQVH2bNIxIOMriV6q59wfotB2kQvrEleLz4kYB4TSsxYWdERegZPI1sjZxxtaWpxMwyODEoCRi8zv6Bh50Af005bRiQpMtwoVgFz8r5iqFV2ROk3xBLUOoteRYrzkaKoOimer1AAiimT4Wmblbpio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjLaYRlf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjLaYRlf"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2240ff0bd6eso13941095ad.0
        for <iommu@lists.linux.dev>; Wed, 12 Mar 2025 06:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741786219; x=1742391019; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBctFsjmeN6VVslMSX3ZvqdK0/Rk8ae8uumPF0NJ1/s=;
        b=LjLaYRlf25r1YzZoNLOoTpzMf2J5flbU0mS2s9Ty0cm10F9X6pybLLOTqzJtlIYIy8
         0nQasrcRo7h1K/sjJD8MlS8Up51M7ltDP2PmyiaX6P/xzCRzSVOWc9Va8u2M1eXamQBa
         pMJEndz/Aovt3/fQZJoHi67rCiTE8f//aqRVPc75C5Z93r1EvZEvrskvJ0eKkGy0Kl6i
         Nz5tVsXuhCvXpKbr5SEJ2ay8y3nE0GLGqEbI5O47N2j3gBuaarkXmqq/0rpUEBX+X3zF
         QmrtIoXkYZ95HHdY6iP7Osrlh6DeJU2CVMQiML/yJ6u26FDZwEcSiWow4p3RHAebgSn1
         edYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741786219; x=1742391019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBctFsjmeN6VVslMSX3ZvqdK0/Rk8ae8uumPF0NJ1/s=;
        b=GZtO9p5xXIezQQh0rHliXxoqyniPEGEtNW17IN4IcXXAEdfhHzob+i2xD5jpZ+O95p
         xuUtU9M0W3u/2SPQZVbTaZxyDtypmYz1/xkM1nRT0eAR64kxUFuCQIY3IFdlHgxuWEfl
         avYGMltFmDucfr13JpTkHkKm8HkbZ5DdJPCaEaeGY6UD6dHVJRzHXpv8/a49BprugjD+
         WlPeRHYsU2yeoyqLHtjEXXEJv8bn9iNPk+G7nMGop9KKe5KyqmHlTrFHxHiAYNAiGYQT
         DC91ZiIlJ7koIuEVrP5PBemobLNR8/Wpj+QUYxQ1xdWIeMD2p0/YN1FfMdnlS3k24AHK
         YLDg==
X-Forwarded-Encrypted: i=1; AJvYcCVHkGNcWdEp1YPLUCgGVMW790Ij93zTOLc7Dqk/sLyIjz81eL6GbwWDJUYpxMiMfMtcXL9JBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZgynF3C4PRFruQ0TNoD/zuZ2/rHVIsortydjPm2yjIBQIN9xF
	Q7Mp+0/FiAwkv0ZgXWWgp2EDNQhKIDIDc36iaKpicOr+6OQbDE2pOOd8MU4omrKDUN1ibS2u+hU
	dFyVwVJ8i4Zyc9pqT4fDMql3Ao2s=
X-Gm-Gg: ASbGncvVFifQjpuXQBs6GFszXdPmOVfX9Odf00HSQImJg17MQqvSAgBw7Vzv42Rkwp7
	Am4sWZ68MmfFIkzvhaEnGfC/YBwmVga49Dj04An2pUyv5YLDkTB+GU/ca78MrJ7tCl91X33NCK8
	0oaUXb2+cq1CuLMC2NDtCifpi8rg==
X-Google-Smtp-Source: AGHT+IHNI8mdn86Q0gIcolu7qp1NQiSCr9Mpiw/QLXiMzo4X0s/wK63ODT6l7NpH3nsyJT/iynSTv/X8C6Q/+ji18QU=
X-Received: by 2002:a05:6a00:2d9f:b0:730:9467:b4b8 with SMTP id
 d2e1a72fcca58-736eba6ca4cmr3642332b3a.4.1741786218878; Wed, 12 Mar 2025
 06:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250304-msm-gpu-fault-fixes-next-v4-0-be14be37f4c3@gmail.com>
 <20250304-msm-gpu-fault-fixes-next-v4-4-be14be37f4c3@gmail.com>
 <20250311181151.GD5216@willie-the-truck> <CACu1E7Gg3WpQASADAdediRzFz2wEXAnfD7tg05XkiXZQp=X8fQ@mail.gmail.com>
 <20250312124907.GB6181@willie-the-truck>
In-Reply-To: <20250312124907.GB6181@willie-the-truck>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Wed, 12 Mar 2025 09:30:07 -0400
X-Gm-Features: AQ5f1JqWM8ID_E8sPNheprXCY9CSTKUwdJFoTdyL5levhUnxGmDxSGFVnmiAz6I
Message-ID: <CACu1E7Hm=DWDC2aFdBRkT8f=8gKXJPpif_uEOA9iFZcyT-uCfQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] iommu/arm-smmu-qcom: Make set_stall work when the
 device is on
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

On Wed, Mar 12, 2025 at 8:49=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Tue, Mar 11, 2025 at 04:01:00PM -0400, Connor Abbott wrote:
> > On Tue, Mar 11, 2025 at 2:11=E2=80=AFPM Will Deacon <will@kernel.org> w=
rote:
> > >
> > > On Tue, Mar 04, 2025 at 11:56:50AM -0500, Connor Abbott wrote:
> > > > Up until now we have only called the set_stall callback during
> > > > initialization when the device is off. But we will soon start calli=
ng it
> > > > to temporarily disable stall-on-fault when the device is on, so han=
dle
> > > > that by checking if the device is on and writing SCTLR.
> > > >
> > > > Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
> > > > ---
> > > >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 30 ++++++++++++++++++=
+++++++++---
> > > >  1 file changed, 27 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/i=
ommu/arm/arm-smmu/arm-smmu-qcom.c
> > > > index a428e53add08d451fb2152e3ab80e0fba936e214..d34a0d917013bb3d5a2=
4b3ce72f48e3b38474da2 100644
> > > > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > > @@ -77,12 +77,36 @@ static void qcom_adreno_smmu_set_stall(const vo=
id *cookie, bool enabled)
> > > >  {
> > > >       struct arm_smmu_domain *smmu_domain =3D (void *)cookie;
> > > >       struct arm_smmu_cfg *cfg =3D &smmu_domain->cfg;
> > > > -     struct qcom_smmu *qsmmu =3D to_qcom_smmu(smmu_domain->smmu);
> > > > +     struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> > > > +     struct qcom_smmu *qsmmu =3D to_qcom_smmu(smmu);
> > > > +     u32 mask =3D BIT(cfg->cbndx);
> > > > +     bool stall_changed =3D !!(qsmmu->stall_enabled & mask) !=3D e=
nabled;
> > > > +     unsigned long flags;
> > > >
> > > >       if (enabled)
> > > > -             qsmmu->stall_enabled |=3D BIT(cfg->cbndx);
> > > > +             qsmmu->stall_enabled |=3D mask;
> > > >       else
> > > > -             qsmmu->stall_enabled &=3D ~BIT(cfg->cbndx);
> > > > +             qsmmu->stall_enabled &=3D ~mask;
> > > > +
> > > > +     /*
> > > > +      * If the device is on and we changed the setting, update the=
 register.
> > > > +      */
> > > > +     if (stall_changed && pm_runtime_get_if_active(smmu->dev) > 0)=
 {
> > > > +             spin_lock_irqsave(&smmu_domain->cb_lock, flags);
> > > > +
> > > > +             u32 reg =3D arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SM=
MU_CB_SCTLR);
> > > > +
> > > > +             if (enabled)
> > > > +                     reg |=3D ARM_SMMU_SCTLR_CFCFG;
> > > > +             else
> > > > +                     reg &=3D ~ARM_SMMU_SCTLR_CFCFG;
> > > > +
> > > > +             arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_SCTLR=
, reg);
> > >
> > > Are you sure you don't need TLB invalidation for this to take effect?=
 I
> > > think some fields in the SCTLR can be cached in the TLB but you'll ne=
ed
> > > to check whether or not that applies to CFCFG.
> > >
> >
> > I think it should be fine because CFCFG only controls behavior when
> > there's a context fault and there can't be TLB entries for entries
> > that cause a context fault: "The architecture permits the caching of
> > any translation table entry that has been returned from memory without
> > a fault and that does not, as a result of that entry, cause a
> > Translation Fault or an Access Flag fault."
>
> Ok, but what about other types of fault? For example, a permission fault
> or an address size fault?
>
> Will

I'm not sure, but the pseudocode for context faults mentions
resampling CFCFG after a fault happens ("We have a fault and must
resample FSR, CFCFG and HUPCF") so I don't think it would be legal to
cache it. Also in practice this does seem to work. Does that answer
it?

Connor
