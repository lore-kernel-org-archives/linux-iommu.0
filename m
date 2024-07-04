Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FFB1B1503
	for <iommu@lists.linux.dev>; Thu,  4 Jul 2024 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720108721; cv=none; b=GsYK8ZHr9Jt3liGsTR+Djdq6QKD8VKPxWS0ddl/IvIv4beE80YEDCNVeIFuEZ8r2WaAxSEIj4zOELbPHIegFWJ7C6frjbRvFCaLWnw9QjyYXi5LFZH1bbNvXqYhqqlRQJPGuyZQDQ5Y2IYprS593ehOd4z/cQkqo/SB7FTkyd2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720108721; c=relaxed/simple;
	bh=Vw9cYiWmBWfb8TTsaP6MPM8WxWX5thyZbtwBWEFIH6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYKHWl9rj5xcOsu6iE90tJURny6pdE8O69x90wdprkt4rlvwpA45Kj7S+Mt4mvF4u9klKggY+jouBHrbRrYqUptVQlDqHsy6utsSOxkVuVJv9U9Zxsbbv5u56iFlmVcJoCHyI47so/ZaRqrh7Zvddx3NnN8RXLcVwVsw3KMzljU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfFBrcJ4; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfFBrcJ4"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6cb130027aso48757366b.2
        for <iommu@lists.linux.dev>; Thu, 04 Jul 2024 08:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720108718; x=1720713518; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGlL/uE7TDzKfiVbTPhEKK0ePrDxqpfFWq/HFd9CIio=;
        b=TfFBrcJ4k6iInmg5DObVbDD41h/YSKbf2q5gtTyoYkwbNLWXVmTZLdKCKulSgRQkIy
         livYlYGRRJdw2z/C+D6FzZKf8licq7KfYA+kJFSZTiyceeeh8f4855nHjfSIEG6rHgwQ
         /VJEy43v4m3cgdeDBTTMtIALCYZCfCyosNT8PpPg6GhRg4XcEnTbWRtpC/c11r6nXHb2
         DLMiwDrRk7J8E9wnWGkO5GBc0epzNADo3QkEtIaEESuCKa0g7ihIFDyc6aQqGg1N0CHk
         O811++dZGlZYegEIweyWoidCGlqb2j1NpTGQmWZ34NeC2sb0usgwIGrk6IWQ4cwesB83
         OggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720108718; x=1720713518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGlL/uE7TDzKfiVbTPhEKK0ePrDxqpfFWq/HFd9CIio=;
        b=DQ4D/99CCPEn7UfvLUbVychp1iWb8zrPQpkOHx2VfUDitW0kqIXGiwe+kHLaiRKwkd
         cxjnSbP4wzZfeiv55F8yvT8+9fFS20c2C/Nn2srqOd7dG6+Y/3bWW7CDbofFlP29X/pY
         Dd3oJlaAUFcZp8Zd6s7+IgLu0+SprBn56i8fNABxDHxnTg2Jdj2YJ97QxpPyXVgjhdHx
         TCpPlpF/JJpeMwD2Gm8ut4t1+/bQ9CzHDIPgsFvpcpLFMAdVVkNIjn3YXzK6re6A0BJq
         1ogBmJUcRQfGpv9gbSdcL2csY8bJcRJuz4WiEfVT9MKNryvTNi5QzMUGogdYOwXwNJLa
         axsw==
X-Forwarded-Encrypted: i=1; AJvYcCVkbjbaf4zwLxPTCbPFaBzXnbWX3QXPw6EXAzsySqviaIzhCvOinkq15OLEfm+et/le21DzvT3I13m3eWN6969rwCKB8N8=
X-Gm-Message-State: AOJu0YzBUYd6+Df53TPgwAwDiEie1ggJMGjtkhLuyTh2Zsq/IR1UB6x4
	1RJmkrbBSY2l4EBeke4GIJ3zcAyTNHlmDr7oQVduvaw2s6V37U8tJd5JDIVVBUTIwS9AA+ZA0gF
	4KjSgtZV7N6MtMAIxf2f0zw+pyeY=
X-Google-Smtp-Source: AGHT+IErblZt7bgFomQcrLEXumFkfKSXuHPwhtBd2lP9n6LZzEj45+6eygT0JdMZl+luoWXHBcNvx4nQ61KnR9k20lo=
X-Received: by 2002:a05:6402:27d0:b0:57a:3046:1cd8 with SMTP id
 4fb4d7f45d1cf-58e5994dfc1mr1915766a12.7.1720108717922; Thu, 04 Jul 2024
 08:58:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240628140435.1652374-1-quic_bibekkum@quicinc.com>
 <20240628140435.1652374-7-quic_bibekkum@quicinc.com> <CAF6AEGvroi8rJimFv95tkWmRFa5_aTpBJ7GFcRAuZpLGdSyEYQ@mail.gmail.com>
 <0650ba0a-4453-4e2d-8a76-0f396ac1999c@quicinc.com> <CAF6AEGv_9e-TDW1r0N4-db6pY_aV_EZFqrpNbATVS5Vy6+fs1g@mail.gmail.com>
 <4a5f54c7-120e-427d-8a0a-9fb83e13a72e@quicinc.com> <CAF6AEGtrtFNxDWtuADA4oOHhZJ=dJZcGaJ1XLFJt4fe4Xp=pTA@mail.gmail.com>
 <3b7c05b1-8f36-4c81-a55c-dbb467314099@quicinc.com> <CAF6AEGuRKU+DkL0-b3xdR1R45_MiiKQYRRXEXYz-xohu8rUaEQ@mail.gmail.com>
In-Reply-To: <CAF6AEGuRKU+DkL0-b3xdR1R45_MiiKQYRRXEXYz-xohu8rUaEQ@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 4 Jul 2024 08:58:25 -0700
Message-ID: <CAF6AEGtbw06-gOSvX9gAbi=SA801gmD3_8c5xkOU-G9g2qKptQ@mail.gmail.com>
Subject: Re: [PATCH v13 6/6] iommu/arm-smmu: add support for PRR bit setup
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, 
	jsnitsel@redhat.com, robh@kernel.org, krzysztof.kozlowski@linaro.org, 
	quic_c_gdjako@quicinc.com, dmitry.baryshkov@linaro.org, 
	konrad.dybcio@linaro.org, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 7:46=E2=80=AFAM Rob Clark <robdclark@gmail.com> wrot=
e:
>
> On Wed, Jul 3, 2024 at 4:38=E2=80=AFAM Bibek Kumar Patro
> <quic_bibekkum@quicinc.com> wrote:
> >
> >
> >
> > On 7/2/2024 2:01 AM, Rob Clark wrote:
> > > On Mon, Jul 1, 2024 at 4:01=E2=80=AFAM Bibek Kumar Patro
> > > <quic_bibekkum@quicinc.com> wrote:
> > >>
> > >>
> > >>
> > >> On 6/28/2024 9:14 PM, Rob Clark wrote:
> > >>> On Fri, Jun 28, 2024 at 8:10=E2=80=AFAM Bibek Kumar Patro
> > >>> <quic_bibekkum@quicinc.com> wrote:
> > >>>>
> > >>>>
> > >>>>
> > >>>> On 6/28/2024 7:47 PM, Rob Clark wrote:
> > >>>>> On Fri, Jun 28, 2024 at 7:05=E2=80=AFAM Bibek Kumar Patro
> > >>>>> <quic_bibekkum@quicinc.com> wrote:
> > >>>>>>
> > >>>>>> Add an adreno-smmu-priv interface for drm/msm to call
> > >>>>>> into arm-smmu-qcom and initiate the PRR bit setup or reset
> > >>>>>> sequence as per request.
> > >>>>>>
> > >>>>>> This will be used by GPU to setup the PRR bit and related
> > >>>>>> configuration registers through adreno-smmu private
> > >>>>>> interface instead of directly poking the smmu hardware.
> > >>>>>>
> > >>>>>> Suggested-by: Rob Clark <robdclark@gmail.com>
> > >>>>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> > >>>>>> ---
> > >>>>>>     drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 23 ++++++++++++=
++++++++++
> > >>>>>>     drivers/iommu/arm/arm-smmu/arm-smmu.h      |  2 ++
> > >>>>>>     include/linux/adreno-smmu-priv.h           |  6 +++++-
> > >>>>>>     3 files changed, 30 insertions(+), 1 deletion(-)
> > >>>>>>
> > >>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/driver=
s/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > >>>>>> index bd101a161d04..64571a1c47b8 100644
> > >>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > >>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > >>>>>> @@ -28,6 +28,7 @@
> > >>>>>>     #define PREFETCH_SHALLOW       (1 << PREFETCH_SHIFT)
> > >>>>>>     #define PREFETCH_MODERATE      (2 << PREFETCH_SHIFT)
> > >>>>>>     #define PREFETCH_DEEP          (3 << PREFETCH_SHIFT)
> > >>>>>> +#define GFX_ACTLR_PRR          (1 << 5)
> > >>>>>>
> > >>>>>>     static const struct actlr_config sc7280_apps_actlr_cfg[] =3D=
 {
> > >>>>>>            { 0x0800, 0x04e0, PREFETCH_DEFAULT | CMTLB },
> > >>>>>> @@ -235,6 +236,27 @@ static void qcom_adreno_smmu_resume_transla=
tion(const void *cookie, bool termina
> > >>>>>>            arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_RESUM=
E, reg);
> > >>>>>>     }
> > >>>>>>
> > >>>>>> +static void qcom_adreno_smmu_set_prr(const void *cookie, phys_a=
ddr_t page_addr, bool set)
> > >>>>>> +{
> > >>>>>> +       struct arm_smmu_domain *smmu_domain =3D (void *)cookie;
> > >>>>>> +       struct arm_smmu_cfg *cfg =3D &smmu_domain->cfg;
> > >>>>>> +       struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> > >>>>>> +       u32 reg =3D 0;
> > >>>>>> +
> > >>>>>> +       writel_relaxed(lower_32_bits(page_addr),
> > >>>>>> +                               smmu->base + ARM_SMMU_GFX_PRR_CF=
G_LADDR);
> > >>>>>> +
> > >>>>>> +       writel_relaxed(upper_32_bits(page_addr),
> > >>>>>> +                               smmu->base + ARM_SMMU_GFX_PRR_CF=
G_UADDR);
> > >>>>>> +
> > >>>>>> +       reg =3D  arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_=
ACTLR);
> > >>>>>> +       reg &=3D ~GFX_ACTLR_PRR;
> > >>>>>> +       if (set)
> > >>>>>> +               reg |=3D FIELD_PREP(GFX_ACTLR_PRR, 1);
> > >>>>>> +       arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_ACTLR, r=
eg);
> > >>>>>> +
> > >>>>>
> > >>>>> nit, extra line
> > >>>>>
> > >>>>
> > >>>> Ack, will remove this. Thanks for pointing out.
> > >>>>
> > >>>>> Also, if you passed a `struct page *` instead, then you could dro=
p the
> > >>>>> bool param, ie. passing NULL for the page would disable PRR.  But=
 I
> > >>>>> can go either way if others have a strong preference for phys_add=
r_t.
> > >>>>>
> > >>>>
> > >>>> Oh okay, this looks simple to reset the prr bit.
> > >>>> But since this page is allocated and is used inside gfx driver
> > >>>> before being utilized for prr bit operation, would it be safe for
> > >>>> drm/gfx driver to keep a reference to this page in smmu driver?
> > >>>>
> > >>>> Since we only need the page address for configuring the
> > >>>> CFG_UADDR/CFG_LADDR registers so passed the phys_addr_t.
> > >>>
> > >>> I don't think the smmu driver needs to keep a reference to the page=
..
> > >>> we can just say it is the responsibility of the drm driver to call
> > >>> set_prr(NULL) before freeing the page
> > >>>
> > >>
> > >> That makes sense. If we go by this NULL page method to disable the P=
RR,
> > >> we would have to set the address registers to reset value as well.
> > >>
> > >> The sequence would be like the following as per my understaning:
> > >> - Check if it's NULL page
> > >> - Set the PRR_CFG_UADDR/PRR_CFG_LADDR to reset values i.e - 0x0 for
> > >>     these registers
> > >> - Reset the PRR bit in actlr register
> > >>
> > >> Similar to this snippet:
> > >>
> > >> #PRR_RESET_ADDR 0x0
> > >>
> > >> --------------
> > >> reg =3D  arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_ACTLR);
> > >> reg &=3D ~GFX_ACTLR_PRR;
> > >> arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_ACTLR, reg);
> > >>
> > >> if (!prr_page) {
> > >>          writel_relaxed(PRR_RESET_ADDR,
> > >>                          smmu->base + ARM_SMMU_GFX_PRR_CFG_LADDR);
> > >>          writel_relaxed(PRR_RESET_ADDR),
> > >>                           smmu->base + ARM_SMMU_GFX_PRR_CFG_UADDR);
> > >>          return;
> > >> }
> > >>
> > >>
> > >> writel_relaxed(lower_32_bits(page_to_phys(prr_page)),
> > >>                  smmu->base + ARM_SMMU_GFX_PRR_CFG_LADDR);
> > >>
> > >> writel_relaxed(upper_32_bits(page_to_phys(prr_page)),
> > >>                  smmu->base + ARM_SMMU_GFX_PRR_CFG_UADDR);
> > >>
> > >> reg |=3D FIELD_PREP(GFX_ACTLR_PRR, 1);
> > >> arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_ACTLR, reg);
> > >> -----------------
> > >>
> > >> If looks good, will implement the same in next version.
> > >
> > > yeah, that looks like it could work..
> > >
> > > you probably don't need to zero out the PRR_CFG_*ADDR when disabling,
> > > and probably could avoid double writing ACTLR, but that is getting
> > > into bikeshedding
> > >
> >
> > Actually Rob, since you rightly pointed this out.
> > I crosschecked again on these registers.
> > PRR_CFG_*ADDR is a global register in SMMU space but
> > ACTLR register including PRR bit is a per-domain register.
> > There might also be a situation where PRR feature need to be
> > disabled or enabled separately for each domain.
> > So I think it would be cleaner to have two apis, set_prr_addr(),
> > set_prr_bit().
> > set_prr_addr() will be used only to set this PRR_CFG_*ADDR
> > register by passing a 'struct page *'
> > set_prr_bit() will be used as a switch for PRR feature,
> > where required smmu_domain will be passed along with
> > the bool value to set/reset the PRR bit depending on which this
> > feature will be enabled/disabled for the selected domain.
>
> on a related note, adreno has been using arm-smmu for a number of
> generations, I guess not all support PRR?  The drm driver will need to
> know whether PRR is supported (and expose that to userspace to let the
> UMD know whether to expose certain extensions).  How should this work?

So, I noticed in the x1e80100.dtsi that there is a gpu_prr_mem
reserved section..  maybe we should be connecting this to the smmu
driver in dt, and using that to detect presence of PRR?  Ie. the smmu
driver would configure PRR_CFG_*ADDR based on the reserved mem, and
the interface to drm would just be to enable/disable PRR, returning an
error code if the reserved mem section isn't there.

This simplifies the interface, and handles the question of how to
detect if PRR is supported.

BR,
-R

> BR,
> -R
>
> > Thanks & regards,
> > Bibek
> >
> > > BR,
> > > -R
> > >
> > >>
> > >> Thanks & regards,
> > >> Bibek
> > >>
> > >>> BR,
> > >>> -R
> > >>>
> > >>>>> Otherwise, lgtm
> > >>>>>
> > >>>>> BR,
> > >>>>> -R
> > >>>>>
> > >>>>
> > >>>> Thanks & regards,
> > >>>> Bibek
> > >>>>
> > >>>>>> +}
> > >>>>>> +
> > >>>>>>     #define QCOM_ADRENO_SMMU_GPU_SID 0
> > >>>>>>
> > >>>>>>     static bool qcom_adreno_smmu_is_gpu_device(struct device *de=
v)
> > >>>>>> @@ -407,6 +429,7 @@ static int qcom_adreno_smmu_init_context(str=
uct arm_smmu_domain *smmu_domain,
> > >>>>>>            priv->get_fault_info =3D qcom_adreno_smmu_get_fault_i=
nfo;
> > >>>>>>            priv->set_stall =3D qcom_adreno_smmu_set_stall;
> > >>>>>>            priv->resume_translation =3D qcom_adreno_smmu_resume_=
translation;
> > >>>>>> +       priv->set_prr =3D qcom_adreno_smmu_set_prr;
> > >>>>>>
> > >>>>>>            actlrvar =3D qsmmu->data->actlrvar;
> > >>>>>>            if (!actlrvar)
> > >>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iom=
mu/arm/arm-smmu/arm-smmu.h
> > >>>>>> index d9c2ef8c1653..3076bef49e20 100644
> > >>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> > >>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> > >>>>>> @@ -154,6 +154,8 @@ enum arm_smmu_cbar_type {
> > >>>>>>     #define ARM_SMMU_SCTLR_M               BIT(0)
> > >>>>>>
> > >>>>>>     #define ARM_SMMU_CB_ACTLR              0x4
> > >>>>>> +#define ARM_SMMU_GFX_PRR_CFG_LADDR     0x6008
> > >>>>>> +#define ARM_SMMU_GFX_PRR_CFG_UADDR     0x600C
> > >>>>>>
> > >>>>>>     #define ARM_SMMU_CB_RESUME             0x8
> > >>>>>>     #define ARM_SMMU_RESUME_TERMINATE      BIT(0)
> > >>>>>> diff --git a/include/linux/adreno-smmu-priv.h b/include/linux/ad=
reno-smmu-priv.h
> > >>>>>> index c637e0997f6d..d6e2ca9f8d8c 100644
> > >>>>>> --- a/include/linux/adreno-smmu-priv.h
> > >>>>>> +++ b/include/linux/adreno-smmu-priv.h
> > >>>>>> @@ -49,7 +49,10 @@ struct adreno_smmu_fault_info {
> > >>>>>>      *                 before set_ttbr0_cfg().  If stalling on f=
ault is enabled,
> > >>>>>>      *                 the GPU driver must call resume_translati=
on()
> > >>>>>>      * @resume_translation: Resume translation after a fault
> > >>>>>> - *
> > >>>>>> + * @set_prr:      Extendible interface to be used by GPU to mod=
ify the
> > >>>>>> + *                 ACTLR register bits, currently used to confi=
gure
> > >>>>>> + *                 Partially-Resident-Region (PRR) feature's
> > >>>>>> + *                 setup and reset sequence as requested.
> > >>>>>>      *
> > >>>>>>      * The GPU driver (drm/msm) and adreno-smmu work together fo=
r controlling
> > >>>>>>      * the GPU's SMMU instance.  This is by necessity, as the GP=
U is directly
> > >>>>>> @@ -67,6 +70,7 @@ struct adreno_smmu_priv {
> > >>>>>>         void (*get_fault_info)(const void *cookie, struct adreno=
_smmu_fault_info *info);
> > >>>>>>         void (*set_stall)(const void *cookie, bool enabled);
> > >>>>>>         void (*resume_translation)(const void *cookie, bool term=
inate);
> > >>>>>> +    void (*set_prr)(const void *cookie, phys_addr_t page_addr, =
bool set);
> > >>>>>>     };
> > >>>>>>
> > >>>>>>     #endif /* __ADRENO_SMMU_PRIV_H */
> > >>>>>> --
> > >>>>>> 2.34.1
> > >>>>>>
