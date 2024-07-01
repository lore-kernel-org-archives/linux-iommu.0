Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FF71EB39
	for <iommu@lists.linux.dev>; Mon,  1 Jul 2024 20:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719865903; cv=none; b=Ug+FdjMryUKAI5nOViy7fTOXdaCkZZLqgg5KA1a9hUP289KphETq1SWGHUUssVsDYKgXOCKLfNit2I7y8Wsk0eok3sY/VPSyjcCmE0ROMgAnfDM++J9xt67Aqy9VLRzrTEQnAkmDnEubX7aYkZTrt7yRlaSpTp/3CnFA9ho8zCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719865903; c=relaxed/simple;
	bh=Xoug+Pf2H5s/IkOhc+YsXZkhlN6gdo4kVZVVtz2oYuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sxf8jO+ZZBaLq73x2J26lgL08LVM/THyDf2qHnRG2T5YWBgJnjrbwvvDHMsxGi1QF6rbehGT3EPt4Lw0WtF/LrhQi4CxiYupMiabo1FJ+c9rdeJPDKqxBGx4fhaeX4cNRU6Yo9WAvX3swVLWYVn6lYllcxKB1GDUg47lLFf04w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3d+22kr; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3d+22kr"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ec50d4e47bso33431641fa.2
        for <iommu@lists.linux.dev>; Mon, 01 Jul 2024 13:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719865900; x=1720470700; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Igo6mRmi4Wb8qhjbnltnAiTul1wcsE29u8pkuVZmfuw=;
        b=m3d+22krEdYHACwa68GK10WmYSZLTNmU8fXADLDLKlR2BUG5Qa1WIW1hn/tD0GqSVx
         T60cOsQBt6aEXzdfWsv3T+eUvZkXLZks+FMD9gj6QhH0C59/dRYvGs3mMqEt4xxHOSX9
         sGdYt6BlC1FM+PJIzsFjpOnfDKLxMhQH94j94QtJXvr35AHDypHBJaehgTu5nHxVtGPp
         mAZ4UnJchU64P7xxdd1+QENzaTbMhdf+o+9yKTOAGqx70HjCO98TVGn76DBMYptrNpBC
         aDIfc0117y1SOlGgBgUTsee3GcMEoFsUErT2vjq+9VFIdteJ74xK4jOY9uv8/grMbtM+
         Pp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719865900; x=1720470700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Igo6mRmi4Wb8qhjbnltnAiTul1wcsE29u8pkuVZmfuw=;
        b=LX9y3riXaWLMz4SKlgHiy80W+jpOVBbQ7ilEpA0ZL8wh5O91QtL+VN6nM/ZP2w34VZ
         NeKvGpVawY7ynj7ucsQk8X0KRJ6rX9dPww83ZW/9shqPhfBuKczNZgPXkdmd4fg4xRTy
         FNDmiqGK/C1aTPzFu2lFeUVPrCZG23OuqsQyDHQPrjbZBYt1ggjpULWEtqPROyrrOuQj
         IJr0W8UfMVgyFtCWQHJgk/nNT9SlTJb4H/+LjAhgzOub7t1kxgox0tXPBpnBVBhhd9jq
         2fapQhl7+4XKdXbxNW/RQRPQZ1kgaYuNjGf1kFJnDY/HSYHWjdVWawNOHB/mwLrPOha0
         A7Lg==
X-Forwarded-Encrypted: i=1; AJvYcCVGsfouFHmGF0SmKCehcusdEZeIE/hpu5U5qpqrV8L15Pvj4XW5gWYZf9d71szkCE1EDSgwzpFaXobKD3RH1cy7JH2RO90=
X-Gm-Message-State: AOJu0YwhCn9/5ws+02WNBnvcWBJVhVT4XItYEUf0ZCaFqtSbAQsejSv8
	bM6OFq8RL1I68KKk68mJ2H9HfENo6UCvdO+plIRgn5bemXf86/Wq6pPck6o32h4CIpzxFlPy3x4
	3NjaUAqQsXc15Xfn+UAZ6Atn/SzFnCA==
X-Google-Smtp-Source: AGHT+IFOIrXPT4bf9oS/jD9RNxfQRx/jOKo5gIFwN3zbBp2BUCaCY4nY72iPAZpqtW7pbCW/3tcVNRjGyb52d14AWDU=
X-Received: by 2002:a2e:7004:0:b0:2ec:556f:3474 with SMTP id
 38308e7fff4ca-2ee5e6d76e9mr38826921fa.52.1719865899468; Mon, 01 Jul 2024
 13:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240628140435.1652374-1-quic_bibekkum@quicinc.com>
 <20240628140435.1652374-7-quic_bibekkum@quicinc.com> <CAF6AEGvroi8rJimFv95tkWmRFa5_aTpBJ7GFcRAuZpLGdSyEYQ@mail.gmail.com>
 <0650ba0a-4453-4e2d-8a76-0f396ac1999c@quicinc.com> <CAF6AEGv_9e-TDW1r0N4-db6pY_aV_EZFqrpNbATVS5Vy6+fs1g@mail.gmail.com>
 <4a5f54c7-120e-427d-8a0a-9fb83e13a72e@quicinc.com>
In-Reply-To: <4a5f54c7-120e-427d-8a0a-9fb83e13a72e@quicinc.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 1 Jul 2024 13:31:27 -0700
Message-ID: <CAF6AEGtrtFNxDWtuADA4oOHhZJ=dJZcGaJ1XLFJt4fe4Xp=pTA@mail.gmail.com>
Subject: Re: [PATCH v13 6/6] iommu/arm-smmu: add support for PRR bit setup
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, 
	jsnitsel@redhat.com, robh@kernel.org, krzysztof.kozlowski@linaro.org, 
	quic_c_gdjako@quicinc.com, dmitry.baryshkov@linaro.org, 
	konrad.dybcio@linaro.org, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 4:01=E2=80=AFAM Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
>
>
> On 6/28/2024 9:14 PM, Rob Clark wrote:
> > On Fri, Jun 28, 2024 at 8:10=E2=80=AFAM Bibek Kumar Patro
> > <quic_bibekkum@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 6/28/2024 7:47 PM, Rob Clark wrote:
> >>> On Fri, Jun 28, 2024 at 7:05=E2=80=AFAM Bibek Kumar Patro
> >>> <quic_bibekkum@quicinc.com> wrote:
> >>>>
> >>>> Add an adreno-smmu-priv interface for drm/msm to call
> >>>> into arm-smmu-qcom and initiate the PRR bit setup or reset
> >>>> sequence as per request.
> >>>>
> >>>> This will be used by GPU to setup the PRR bit and related
> >>>> configuration registers through adreno-smmu private
> >>>> interface instead of directly poking the smmu hardware.
> >>>>
> >>>> Suggested-by: Rob Clark <robdclark@gmail.com>
> >>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> >>>> ---
> >>>>    drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 23 +++++++++++++++++=
+++++
> >>>>    drivers/iommu/arm/arm-smmu/arm-smmu.h      |  2 ++
> >>>>    include/linux/adreno-smmu-priv.h           |  6 +++++-
> >>>>    3 files changed, 30 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/io=
mmu/arm/arm-smmu/arm-smmu-qcom.c
> >>>> index bd101a161d04..64571a1c47b8 100644
> >>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>> @@ -28,6 +28,7 @@
> >>>>    #define PREFETCH_SHALLOW       (1 << PREFETCH_SHIFT)
> >>>>    #define PREFETCH_MODERATE      (2 << PREFETCH_SHIFT)
> >>>>    #define PREFETCH_DEEP          (3 << PREFETCH_SHIFT)
> >>>> +#define GFX_ACTLR_PRR          (1 << 5)
> >>>>
> >>>>    static const struct actlr_config sc7280_apps_actlr_cfg[] =3D {
> >>>>           { 0x0800, 0x04e0, PREFETCH_DEFAULT | CMTLB },
> >>>> @@ -235,6 +236,27 @@ static void qcom_adreno_smmu_resume_translation=
(const void *cookie, bool termina
> >>>>           arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_RESUME, re=
g);
> >>>>    }
> >>>>
> >>>> +static void qcom_adreno_smmu_set_prr(const void *cookie, phys_addr_=
t page_addr, bool set)
> >>>> +{
> >>>> +       struct arm_smmu_domain *smmu_domain =3D (void *)cookie;
> >>>> +       struct arm_smmu_cfg *cfg =3D &smmu_domain->cfg;
> >>>> +       struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> >>>> +       u32 reg =3D 0;
> >>>> +
> >>>> +       writel_relaxed(lower_32_bits(page_addr),
> >>>> +                               smmu->base + ARM_SMMU_GFX_PRR_CFG_LA=
DDR);
> >>>> +
> >>>> +       writel_relaxed(upper_32_bits(page_addr),
> >>>> +                               smmu->base + ARM_SMMU_GFX_PRR_CFG_UA=
DDR);
> >>>> +
> >>>> +       reg =3D  arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_ACTL=
R);
> >>>> +       reg &=3D ~GFX_ACTLR_PRR;
> >>>> +       if (set)
> >>>> +               reg |=3D FIELD_PREP(GFX_ACTLR_PRR, 1);
> >>>> +       arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_ACTLR, reg);
> >>>> +
> >>>
> >>> nit, extra line
> >>>
> >>
> >> Ack, will remove this. Thanks for pointing out.
> >>
> >>> Also, if you passed a `struct page *` instead, then you could drop th=
e
> >>> bool param, ie. passing NULL for the page would disable PRR.  But I
> >>> can go either way if others have a strong preference for phys_addr_t.
> >>>
> >>
> >> Oh okay, this looks simple to reset the prr bit.
> >> But since this page is allocated and is used inside gfx driver
> >> before being utilized for prr bit operation, would it be safe for
> >> drm/gfx driver to keep a reference to this page in smmu driver?
> >>
> >> Since we only need the page address for configuring the
> >> CFG_UADDR/CFG_LADDR registers so passed the phys_addr_t.
> >
> > I don't think the smmu driver needs to keep a reference to the page..
> > we can just say it is the responsibility of the drm driver to call
> > set_prr(NULL) before freeing the page
> >
>
> That makes sense. If we go by this NULL page method to disable the PRR,
> we would have to set the address registers to reset value as well.
>
> The sequence would be like the following as per my understaning:
> - Check if it's NULL page
> - Set the PRR_CFG_UADDR/PRR_CFG_LADDR to reset values i.e - 0x0 for
>    these registers
> - Reset the PRR bit in actlr register
>
> Similar to this snippet:
>
> #PRR_RESET_ADDR 0x0
>
> --------------
> reg =3D  arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_ACTLR);
> reg &=3D ~GFX_ACTLR_PRR;
> arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_ACTLR, reg);
>
> if (!prr_page) {
>         writel_relaxed(PRR_RESET_ADDR,
>                         smmu->base + ARM_SMMU_GFX_PRR_CFG_LADDR);
>         writel_relaxed(PRR_RESET_ADDR),
>                          smmu->base + ARM_SMMU_GFX_PRR_CFG_UADDR);
>         return;
> }
>
>
> writel_relaxed(lower_32_bits(page_to_phys(prr_page)),
>                 smmu->base + ARM_SMMU_GFX_PRR_CFG_LADDR);
>
> writel_relaxed(upper_32_bits(page_to_phys(prr_page)),
>                 smmu->base + ARM_SMMU_GFX_PRR_CFG_UADDR);
>
> reg |=3D FIELD_PREP(GFX_ACTLR_PRR, 1);
> arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_ACTLR, reg);
> -----------------
>
> If looks good, will implement the same in next version.

yeah, that looks like it could work..

you probably don't need to zero out the PRR_CFG_*ADDR when disabling,
and probably could avoid double writing ACTLR, but that is getting
into bikeshedding

BR,
-R

>
> Thanks & regards,
> Bibek
>
> > BR,
> > -R
> >
> >>> Otherwise, lgtm
> >>>
> >>> BR,
> >>> -R
> >>>
> >>
> >> Thanks & regards,
> >> Bibek
> >>
> >>>> +}
> >>>> +
> >>>>    #define QCOM_ADRENO_SMMU_GPU_SID 0
> >>>>
> >>>>    static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
> >>>> @@ -407,6 +429,7 @@ static int qcom_adreno_smmu_init_context(struct =
arm_smmu_domain *smmu_domain,
> >>>>           priv->get_fault_info =3D qcom_adreno_smmu_get_fault_info;
> >>>>           priv->set_stall =3D qcom_adreno_smmu_set_stall;
> >>>>           priv->resume_translation =3D qcom_adreno_smmu_resume_trans=
lation;
> >>>> +       priv->set_prr =3D qcom_adreno_smmu_set_prr;
> >>>>
> >>>>           actlrvar =3D qsmmu->data->actlrvar;
> >>>>           if (!actlrvar)
> >>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/a=
rm/arm-smmu/arm-smmu.h
> >>>> index d9c2ef8c1653..3076bef49e20 100644
> >>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> >>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> >>>> @@ -154,6 +154,8 @@ enum arm_smmu_cbar_type {
> >>>>    #define ARM_SMMU_SCTLR_M               BIT(0)
> >>>>
> >>>>    #define ARM_SMMU_CB_ACTLR              0x4
> >>>> +#define ARM_SMMU_GFX_PRR_CFG_LADDR     0x6008
> >>>> +#define ARM_SMMU_GFX_PRR_CFG_UADDR     0x600C
> >>>>
> >>>>    #define ARM_SMMU_CB_RESUME             0x8
> >>>>    #define ARM_SMMU_RESUME_TERMINATE      BIT(0)
> >>>> diff --git a/include/linux/adreno-smmu-priv.h b/include/linux/adreno=
-smmu-priv.h
> >>>> index c637e0997f6d..d6e2ca9f8d8c 100644
> >>>> --- a/include/linux/adreno-smmu-priv.h
> >>>> +++ b/include/linux/adreno-smmu-priv.h
> >>>> @@ -49,7 +49,10 @@ struct adreno_smmu_fault_info {
> >>>>     *                 before set_ttbr0_cfg().  If stalling on fault =
is enabled,
> >>>>     *                 the GPU driver must call resume_translation()
> >>>>     * @resume_translation: Resume translation after a fault
> >>>> - *
> >>>> + * @set_prr:      Extendible interface to be used by GPU to modify =
the
> >>>> + *                 ACTLR register bits, currently used to configure
> >>>> + *                 Partially-Resident-Region (PRR) feature's
> >>>> + *                 setup and reset sequence as requested.
> >>>>     *
> >>>>     * The GPU driver (drm/msm) and adreno-smmu work together for con=
trolling
> >>>>     * the GPU's SMMU instance.  This is by necessity, as the GPU is =
directly
> >>>> @@ -67,6 +70,7 @@ struct adreno_smmu_priv {
> >>>>        void (*get_fault_info)(const void *cookie, struct adreno_smmu=
_fault_info *info);
> >>>>        void (*set_stall)(const void *cookie, bool enabled);
> >>>>        void (*resume_translation)(const void *cookie, bool terminate=
);
> >>>> +    void (*set_prr)(const void *cookie, phys_addr_t page_addr, bool=
 set);
> >>>>    };
> >>>>
> >>>>    #endif /* __ADRENO_SMMU_PRIV_H */
> >>>> --
> >>>> 2.34.1
> >>>>
