Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB9B83CD3
	for <iommu@lists.linux.dev>; Fri, 22 Nov 2024 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732293303; cv=none; b=a2E2WIOQnwB5hmpMUsIdaTzpoLnhj4gjfQlMu8yhctWt2yY7T4Hlxf6yPWMhkvVJfuE0qPKluDyaWHW9L8Ijxgy31lIHZPKwr3X1Yx0J3MdFeatasbXe1qYU1mze+5eZAMyrm6GPnqGeaxhDVxy7kk4sY5OT+LSlS+fUatOjZms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732293303; c=relaxed/simple;
	bh=QmYCrbrZ0QjT4nfwEGLidKiS2Xq+j8XtbaNx/WThNd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFkRRkv+WwyapbbHAq/N1X2R2XVdVc2N1IrVAWwEx/heauajC3A4o8HJJH/AWau7HeqvJtrl+9+BQh7j7oN4sOxCGWYltDzP2cX06+Gr2oEBwg1TiXYmfD5ZNlHn6qJw+ZI80BV5GeuW2+WtrhBKmoDT966mDuamyihhZctStc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiJ3OS/E; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiJ3OS/E"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-83aba65556cso82100139f.3
        for <iommu@lists.linux.dev>; Fri, 22 Nov 2024 08:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732293301; x=1732898101; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GReVTWBGYFw/FTP8yPSarz5HbeY1G9Mo/s/2dusNN00=;
        b=HiJ3OS/EWPHVSOx6aQsTIhDvKWZLUy3y8+NjsYGpB6dwL8fhYLzFScqBvhcWSqap5Y
         dVsmN1sbZNiSg3OSK/mRG5ftQ/ftFyXJHzBYbNqaDrc+S+fRtoTM1fH+suU5RRNGh0iM
         uGKzMNoE//vom9A+LRPxE1fADQk4TttyxTC85DbSsDSJvYC9U0evBbgR2zQh3YpTnFuC
         iQBl9isdH3Kj1twOoytRDb8IFGj2wnjpHVKX+3YhMDM7VnoEqIN1YniRggjPOt3L2P4F
         luIBADnqg6cWccePozP56vxG4FtgI4mP9VqTquOWKc+V1qeJ7cvuvPVzHr/P3m/MRDVx
         UPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732293301; x=1732898101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GReVTWBGYFw/FTP8yPSarz5HbeY1G9Mo/s/2dusNN00=;
        b=dGqFniVoRSypZsBpeduoiF8OKs312YJ8Wdg4QYdsPETadKl5kB87HW6NyMGmvmqT/7
         fInbF/3G6z7xfiHLcbci/FBk6dIBtrWVuq6B3DTS6l2Lqrep8PEs/bvtkr2ywlBwPhcx
         F4Sej/odumKaP3OUi28GQ7EPSRPNo/BBAJZX5eTUtjnEDtUH3GpAEbY+0A1aqAn0tp6C
         zJ0IldiSpLep89s15FXcDQ5dtI2yWiu5Gzl8L31DT+bgf3AwmGlPIGHG2vP7Hf9ps1ka
         iTO7EtnKz5My+/87KUxAGMdsMWhqiri41ofWXer0TRx/mQSgYtIz7iS2i5JJtDOTRyJb
         +c3A==
X-Forwarded-Encrypted: i=1; AJvYcCUU+t0+5t6odz9JjJANEP7+P6u98n35n1fc8VO9omQjERwDQQG1PuLtAR8dW5kvVwDVsqz0UA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLhtYSOQvWuVN+IWBk9k1e356ORT3Uv/PTpCT/ZPTWS72R7Z/E
	21NUiwcDIxGVLcAqkvPORI5gWYulKcMYHTIm3r1vBqC4Br+2ZBerszCgPkbr9vkc7ePKh98uOpI
	ze9j0XYVYhAQWJIRHZN4gJALeKa8=
X-Gm-Gg: ASbGncvrSEG5fK1dbbk6rWnIN2lzfjG4l7OvIzfaIXK4BcHGOgef8h+XDpcXG3kqloA
	qaWrcRfZptzgynB4F+R8f6PeiZYNcWFQpognJMYGlsgnJI5hYaB0MXOI1igz6ug==
X-Google-Smtp-Source: AGHT+IHCczpv5MTe10j+ysaRXaFSBOv7fYB9EL4QC/DbZ6+Wyvs0DC3CMZrZNaNLbRff8uCbLJwlKESwT+n24Kb5K0A=
X-Received: by 2002:a05:6602:3c8:b0:83d:e526:fde7 with SMTP id
 ca18e2360f4ac-83ecdca5850mr480494439f.6.1732293300996; Fri, 22 Nov 2024
 08:35:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241114160721.1527934-1-quic_bibekkum@quicinc.com>
 <20241114160721.1527934-4-quic_bibekkum@quicinc.com> <CAF6AEGuwWsAkRyF-h5Aj3KzM7iksb12HsfJ5Ks+-P8hv60MWFg@mail.gmail.com>
 <CAF6AEGvVteuOOMod6yw9_6eOn2PxAx+BR8sVOHAHp7Ts8XigBw@mail.gmail.com> <5696afa2-c4ab-42fe-b29a-6ecee622fbb4@quicinc.com>
In-Reply-To: <5696afa2-c4ab-42fe-b29a-6ecee622fbb4@quicinc.com>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 22 Nov 2024 08:34:49 -0800
Message-ID: <CAF6AEGuMmdnOmATMy8f+YgGxfrYb5mkG_qgy870wZPebKaZjVQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v17 3/5] iommu/arm-smmu: add support for PRR bit setup
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, 
	jsnitsel@redhat.com, robh@kernel.org, krzysztof.kozlowski@linaro.org, 
	quic_c_gdjako@quicinc.com, dmitry.baryshkov@linaro.org, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Connor Abbott <cwabbott0@gmail.com>, 
	Rob Clark <robdclark@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 8:20=E2=80=AFAM Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
>
>
> On 11/21/2024 3:40 AM, Rob Clark wrote:
> > On Wed, Nov 20, 2024 at 9:17=E2=80=AFAM Rob Clark <robdclark@gmail.com>=
 wrote:
> >>
> >> On Thu, Nov 14, 2024 at 8:10=E2=80=AFAM Bibek Kumar Patro
> >> <quic_bibekkum@quicinc.com> wrote:
> >>>
> >>> Add an adreno-smmu-priv interface for drm/msm to call
> >>> into arm-smmu-qcom and initiate the PRR bit setup or reset
> >>> sequence as per request.
> >>>
> >>> This will be used by GPU to setup the PRR bit and related
> >>> configuration registers through adreno-smmu private
> >>> interface instead of directly poking the smmu hardware.
> >>>
> >>> Suggested-by: Rob Clark <robdclark@gmail.com>
> >>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> >>> ---
> >>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 37 +++++++++++++++++++=
+++
> >>>   drivers/iommu/arm/arm-smmu/arm-smmu.h      |  2 ++
> >>>   include/linux/adreno-smmu-priv.h           | 14 ++++++++
> >>>   3 files changed, 53 insertions(+)
> >>>
> >>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iom=
mu/arm/arm-smmu/arm-smmu-qcom.c
> >>> index d26f5aea248e..0e4f3fbda961 100644
> >>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>> @@ -16,6 +16,8 @@
> >>>
> >>>   #define QCOM_DUMMY_VAL -1
> >>>
> >>> +#define GFX_ACTLR_PRR          (1 << 5)
> >>> +
> >>>   static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
> >>>   {
> >>>          return container_of(smmu, struct qcom_smmu, smmu);
> >>> @@ -99,6 +101,32 @@ static void qcom_adreno_smmu_resume_translation(c=
onst void *cookie, bool termina
> >>>          arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_RESUME, reg)=
;
> >>>   }
> >>>
> >>> +static void qcom_adreno_smmu_set_prr_bit(const void *cookie, bool se=
t)
> >>> +{
> >>> +       struct arm_smmu_domain *smmu_domain =3D (void *)cookie;
> >>> +       struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> >>> +       struct arm_smmu_cfg *cfg =3D &smmu_domain->cfg;
> >>> +       u32 reg =3D 0;
> >>> +
> >>> +       reg =3D  arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_ACTLR=
);
> >>> +       reg &=3D ~GFX_ACTLR_PRR;
> >>> +       if (set)
> >>> +               reg |=3D FIELD_PREP(GFX_ACTLR_PRR, 1);
> >>> +       arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_ACTLR, reg);
> >>> +}
> >>> +
> >>> +static void qcom_adreno_smmu_set_prr_addr(const void *cookie, phys_a=
ddr_t page_addr)
> >>> +{
> >>> +       struct arm_smmu_domain *smmu_domain =3D (void *)cookie;
> >>> +       struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> >>> +
> >>> +       writel_relaxed(lower_32_bits(page_addr),
> >>> +                               smmu->base + ARM_SMMU_GFX_PRR_CFG_LAD=
DR);
> >>> +
> >>> +       writel_relaxed(upper_32_bits(page_addr),
> >>> +                               smmu->base + ARM_SMMU_GFX_PRR_CFG_UAD=
DR);
> >>> +}
> >>> +
> >>>   #define QCOM_ADRENO_SMMU_GPU_SID 0
> >>>
> >>>   static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
> >>> @@ -210,6 +238,7 @@ static bool qcom_adreno_can_do_ttbr1(struct arm_s=
mmu_device *smmu)
> >>>   static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *sm=
mu_domain,
> >>>                  struct io_pgtable_cfg *pgtbl_cfg, struct device *dev=
)
> >>>   {
> >>> +       const struct device_node *np =3D smmu_domain->smmu->dev->of_n=
ode;
> >>>          struct adreno_smmu_priv *priv;
> >>>
> >>>          smmu_domain->cfg.flush_walk_prefer_tlbiasid =3D true;
> >>> @@ -239,6 +268,14 @@ static int qcom_adreno_smmu_init_context(struct =
arm_smmu_domain *smmu_domain,
> >>>          priv->get_fault_info =3D qcom_adreno_smmu_get_fault_info;
> >>>          priv->set_stall =3D qcom_adreno_smmu_set_stall;
> >>>          priv->resume_translation =3D qcom_adreno_smmu_resume_transla=
tion;
> >>> +       priv->set_prr_bit =3D NULL;
> >>> +       priv->set_prr_addr =3D NULL;
> >>> +
> >>> +       if (of_device_is_compatible(np, "qcom,smmu-500") &&
> >>> +                       of_device_is_compatible(np, "qcom,adreno-smmu=
")) {
> >>
> >> fwiw, it seems like PRR actually works on sc7180, which is _not_
> >> mmu-500, so I guess the support actually goes back further.
> >>
> >> I'm curious if we can just rely on this being supported by any hw that
> >> has a6xx or newer?
> >
> >
> > Also, unrelated, but we can't assume the smmu is powered when drm
> > driver calls set_prr_bit/addr, could you add in runpm get/put around
> > the register access?
> >
>
> I see, thanks for this observation.
> It's surely a possible case, when they access these registers
> SMMU state is off.
> I will add the suggested runpm ops around the register access.
>
> > Otherwise Conner and I have vk sparse residency working now
> >
>
> Sorry, could not get this. Did you mean that vk sparse residency
> is working now using this patch?

Yes, vk sparse residency is working with this patch (plus addition of
runpm get/put, plus drm/msm patches plus turnip patches) ;-)

BR,
-R

> Thanks & regards,
> Bibek
>
> > BR,
> > -R
> >
> >>
> >>> +               priv->set_prr_bit =3D qcom_adreno_smmu_set_prr_bit;
> >>> +               priv->set_prr_addr =3D qcom_adreno_smmu_set_prr_addr;
> >>> +       }
> >>>
> >>>          return 0;
> >>>   }
> >>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/ar=
m/arm-smmu/arm-smmu.h
> >>> index e2aeb511ae90..2dbf3243b5ad 100644
> >>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> >>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> >>> @@ -154,6 +154,8 @@ enum arm_smmu_cbar_type {
> >>>   #define ARM_SMMU_SCTLR_M               BIT(0)
> >>>
> >>>   #define ARM_SMMU_CB_ACTLR              0x4
> >>> +#define ARM_SMMU_GFX_PRR_CFG_LADDR     0x6008
> >>> +#define ARM_SMMU_GFX_PRR_CFG_UADDR     0x600C
> >>>
> >>>   #define ARM_SMMU_CB_RESUME             0x8
> >>>   #define ARM_SMMU_RESUME_TERMINATE      BIT(0)
> >>> diff --git a/include/linux/adreno-smmu-priv.h b/include/linux/adreno-=
smmu-priv.h
> >>> index c637e0997f6d..614665153b3e 100644
> >>> --- a/include/linux/adreno-smmu-priv.h
> >>> +++ b/include/linux/adreno-smmu-priv.h
> >>> @@ -50,6 +50,18 @@ struct adreno_smmu_fault_info {
> >>>    *                 the GPU driver must call resume_translation()
> >>>    * @resume_translation: Resume translation after a fault
> >>>    *
> >>> + * *CAUTION* : PRR callbacks (set_prr_bit/set_prr_addr) are NULL ter=
minated for
> >>> + *             targets without PRR support. Exercise caution and ver=
ify target
> >>> + *             capabilities before invoking these callbacks to preve=
nt potential
> >>> + *             runtime errors or unexpected behavior.
> >>> + *
> >>> + * @set_prr_bit:   Extendible interface to be used by GPU to modify =
the
> >>> + *                ACTLR register bits, currently used to configure
> >>> + *                Partially-Resident-Region (PRR) bit for feature's
> >>> + *                setup and reset sequence as requested.
> >>> + * @set_prr_addr:  Configure the PRR_CFG_*ADDR register with the
> >>> + *                physical address of PRR page passed from
> >>> + *                GPU driver.
> >>>    *
> >>>    * The GPU driver (drm/msm) and adreno-smmu work together for contr=
olling
> >>>    * the GPU's SMMU instance.  This is by necessity, as the GPU is di=
rectly
> >>> @@ -67,6 +79,8 @@ struct adreno_smmu_priv {
> >>>       void (*get_fault_info)(const void *cookie, struct adreno_smmu_f=
ault_info *info);
> >>>       void (*set_stall)(const void *cookie, bool enabled);
> >>>       void (*resume_translation)(const void *cookie, bool terminate);
> >>> +    void (*set_prr_bit)(const void *cookie, bool set);
> >>> +    void (*set_prr_addr)(const void *cookie, phys_addr_t page_addr);
> >>>   };
> >>>
> >>>   #endif /* __ADRENO_SMMU_PRIV_H */
> >>> --
> >>> 2.34.1
> >>>
>
