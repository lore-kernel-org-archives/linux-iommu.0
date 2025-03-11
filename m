Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F131E8336
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 20:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723273; cv=none; b=BRSxECquMvEUqlwx+2ZwTfHKuI9aIzGmlddWkyGg9R1NLcGbpKsLjGtHGXFSdEHnpWgs/AjlBtKl9vkF3+FPU8GvqCHw15AZelfngf03BemDYquIlDW6O/Ny2b7FxD4B9sNxV30h9EHv35znoF7yp7YU4mWxUeLc+sdlltwkEmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723273; c=relaxed/simple;
	bh=xrKFuJ0SOVfh3Sa0BTqqoPTKaQUC9fHEUGC2Dq15QUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4j9ux6MfTOfTnaNV3oijjkAhSJfpp+kkcFnp+RWLffMpdZWTeeMlQU3EO6TNZfvGkP0H0kgjjAMBhrd6tjc4s3UgYsYhNmabJCf2kTEK0wmHsTz2IQAzWex1NVyQX2aG9lg4ojISBny0RXeVkZzXrdEyM4+x/z6i5nHfzGDkVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPK1Fd2r; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPK1Fd2r"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-216513f8104so10521865ad.2
        for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 13:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741723271; x=1742328071; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52OV000Ss02HywoZBmMaH6saPDX3ZD7R+9jkTkZmirw=;
        b=NPK1Fd2rjLXRD3J3xIE2rh/ZNMIt52ZVHAUGFv3ZGe+1zVXPP28laQW4Ug0tdzipK6
         dUWokiJNEDNIMJcMLhe9tCsYfcD3Y7RkO/IInrvx+FOlWw/7BzPv/AqBKhZNIGQgFjji
         TKltlngcqNTEnE32viYQtwx4BrXU/Aie8uIgIJms5UZ/9Z9rWltgE7dZPZhGO83hI6X/
         ow5uIYGFAFn5U1peUyHwU/0hsCZlS8Fq5uYG7UT30fGlf2KeCNKX3ZxfIwegg/8/9F5v
         m/PIk4nL12SEjMQ8lNOOuTEqILgpLIfFxe9RP/vP/y0jyIqEJPMeRdquns+41Z5chVtD
         T0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741723271; x=1742328071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52OV000Ss02HywoZBmMaH6saPDX3ZD7R+9jkTkZmirw=;
        b=rWsQ+lr/fqxawgMUEDd4QPaD3LSk8sF9J0H1+yuECFz7eCFXrJeZKPGGkmx6fOVj4n
         K1x02Fn5IhdA3xn4Bb4q34+DinPYQyE6IUp4Ee97BmILbU9A1ugujJDE0idqNc4+LLky
         0LZT081yHXLW5aRbr5S91TzFfTsV1ytgmNdFZjK6GHgw75QdgC/SL3cMA/x8fiTh5Xmf
         hdmCvdZwRn9ztub8gbmGv7A+GH7isH8uFUg/qmdKR2cARiF6Yt0LGWx4S/0ef22vDBdf
         Dvtb+s6Jhv2L9fmIlcpCPGqNC/Zo7iY4Yhdxe6NAyRYQwgMMU0HhfkXQorG63811Dx7z
         N8pw==
X-Forwarded-Encrypted: i=1; AJvYcCWFR5wZt9ZAK+llc2JyIB7n64/VG6mpEkuKrAfCSmqHQzDuvL4DlGVpytiuZP72CQE9XMm50Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlaeIHfrRZLGctR6rR14P1ljxZwxaabg+ixIK2kLQuUbfC62D9
	RyHpag9sAP9Dg8d7MC9YsRUbH2EeUsA6id0gT6ls+2n3MgWiXeQ4Xv9zkLG2Pv2MJjA33kodyol
	4Gq42s8Sg8AcDZig4m6+9fOU9U5g=
X-Gm-Gg: ASbGncvACS+RiocYf4Q2JO1e7Go/NGE4WBqRArYHeOLgBSYdicNlCu9Hh2OAYDsJIC2
	x6f0xAg9/u5oYdkCQCSf7T41XeDTSnfuCHk5tro7A+fQeiUKbHu5lwqBqyHMdy9V7Q2Tkkr4aJ+
	DoqCbP0s6ZGPPDpvZTTOZTKRz5sA==
X-Google-Smtp-Source: AGHT+IEZes+rPRA7sKIj+77k/pMBCMpcY3PJgbIkDYPW+Vp6cHzjHEMWL9jx7sEj0huuFiLemUSLs1dnWAE9qx1ILMs=
X-Received: by 2002:a05:6a00:3d01:b0:730:915c:b70 with SMTP id
 d2e1a72fcca58-736eb884cd6mr2575318b3a.0.1741723270852; Tue, 11 Mar 2025
 13:01:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250304-msm-gpu-fault-fixes-next-v4-0-be14be37f4c3@gmail.com>
 <20250304-msm-gpu-fault-fixes-next-v4-4-be14be37f4c3@gmail.com> <20250311181151.GD5216@willie-the-truck>
In-Reply-To: <20250311181151.GD5216@willie-the-truck>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Tue, 11 Mar 2025 16:01:00 -0400
X-Gm-Features: AQ5f1JoexqrwePJhk6DD8zjGJRAEALzPtqaGXwA5Wf6vdtHsWziKMQ-PaQeJdxI
Message-ID: <CACu1E7Gg3WpQASADAdediRzFz2wEXAnfD7tg05XkiXZQp=X8fQ@mail.gmail.com>
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

On Tue, Mar 11, 2025 at 2:11=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
>
> On Tue, Mar 04, 2025 at 11:56:50AM -0500, Connor Abbott wrote:
> > Up until now we have only called the set_stall callback during
> > initialization when the device is off. But we will soon start calling i=
t
> > to temporarily disable stall-on-fault when the device is on, so handle
> > that by checking if the device is on and writing SCTLR.
> >
> > Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
> > ---
> >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 30 ++++++++++++++++++++++=
+++++---
> >  1 file changed, 27 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu=
/arm/arm-smmu/arm-smmu-qcom.c
> > index a428e53add08d451fb2152e3ab80e0fba936e214..d34a0d917013bb3d5a24b3c=
e72f48e3b38474da2 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > @@ -77,12 +77,36 @@ static void qcom_adreno_smmu_set_stall(const void *=
cookie, bool enabled)
> >  {
> >       struct arm_smmu_domain *smmu_domain =3D (void *)cookie;
> >       struct arm_smmu_cfg *cfg =3D &smmu_domain->cfg;
> > -     struct qcom_smmu *qsmmu =3D to_qcom_smmu(smmu_domain->smmu);
> > +     struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> > +     struct qcom_smmu *qsmmu =3D to_qcom_smmu(smmu);
> > +     u32 mask =3D BIT(cfg->cbndx);
> > +     bool stall_changed =3D !!(qsmmu->stall_enabled & mask) !=3D enabl=
ed;
> > +     unsigned long flags;
> >
> >       if (enabled)
> > -             qsmmu->stall_enabled |=3D BIT(cfg->cbndx);
> > +             qsmmu->stall_enabled |=3D mask;
> >       else
> > -             qsmmu->stall_enabled &=3D ~BIT(cfg->cbndx);
> > +             qsmmu->stall_enabled &=3D ~mask;
> > +
> > +     /*
> > +      * If the device is on and we changed the setting, update the reg=
ister.
> > +      */
> > +     if (stall_changed && pm_runtime_get_if_active(smmu->dev) > 0) {
> > +             spin_lock_irqsave(&smmu_domain->cb_lock, flags);
> > +
> > +             u32 reg =3D arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_C=
B_SCTLR);
> > +
> > +             if (enabled)
> > +                     reg |=3D ARM_SMMU_SCTLR_CFCFG;
> > +             else
> > +                     reg &=3D ~ARM_SMMU_SCTLR_CFCFG;
> > +
> > +             arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_SCTLR, re=
g);
>
> Are you sure you don't need TLB invalidation for this to take effect? I
> think some fields in the SCTLR can be cached in the TLB but you'll need
> to check whether or not that applies to CFCFG.
>
> Will

I think it should be fine because CFCFG only controls behavior when
there's a context fault and there can't be TLB entries for entries
that cause a context fault: "The architecture permits the caching of
any translation table entry that has been returned from memory without
a fault and that does not, as a result of that entry, cause a
Translation Fault or an Access Flag fault."

Connor
