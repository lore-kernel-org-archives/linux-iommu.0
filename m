Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9138E1BF305
	for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719584254; cv=none; b=GkDy4zm9ey7D+OcuOwXptKE6vFGkZfF+v6DZkoXkxbWvwd3uB2pY8vWzkLbUhTUy5vImbsOtjJKimcpcJB25E6gEs+Oxw0nnxGBW0AzshiJkrchgkzkUenAjhZ8JCdzwzXJYzCjp9cPdLoOWVV0ADXcMkzhYDgsKo/n+LMYfGyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719584254; c=relaxed/simple;
	bh=Ydmge2jXvUltuSBS3uDjrxGcWKj6zkL+i043pry6h80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSdjI07AgAEHtgUvrZed5WkKP/VRs+NhMirlX0NLmefNAR/3NcN6HW73p0tWhoAM/Sc/ubquuVeZwIp694zijeVdbO0cRZTiEPVqzsrFShr2WVJp6xycHvaKu/PRStqX+0rcifWLlnzQZK5Q47OT8+aUK5me5C0DRFARayeFpYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GErAciOY; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GErAciOY"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57cc30eaf0aso402192a12.2
        for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 07:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719584250; x=1720189050; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUZfsgVRZxSnQOE+V7qWG65GlTuqoj2VVa3LE3t/3OE=;
        b=GErAciOYQbPVyVcrlw5vFh6bZCFPPM33ZK+4dniUgaEZVW4N+alWdqlpJbbPuYw37O
         v+Ga3KUFSCCXbros331i8nu+KChEGvyYtL8KwUQw/ZIgSX9X+1uC/En4Ejwx+dcs0Mhe
         ivbpVCmkTm1MJN0MlhxHptEUQBNn6sumq2+2ET0M7uvyRDRmjmfqmSwbhBI8AwppcXh8
         8hw7eZ9IDntnHUiQMepcBxQOF7BqgyVQXnTALX9oIfEnW7ch8T61XfgFwLfPLFbzr1qr
         weaxVW2yGJ/yLNw5MMu//65iVwVsiQsCGWwaDPY+0MH9JMOKfsVHlpouT8VIUllXQ32M
         QLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719584250; x=1720189050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUZfsgVRZxSnQOE+V7qWG65GlTuqoj2VVa3LE3t/3OE=;
        b=vL2U87ZRwyVHtEonBVCUg9EjREIzsSc24F4196ua/xQ8XPTFdg+m6eVmheKRPEbE/f
         2vEIQmwrnlbHBFRbZP41+5ILkk53AX2LqtehxgSilZjohipQNjfOg8AAL4t9nGkp9Cf6
         Ld/PPQh2g+fOcaypiydlLetnjyHsYLyCwztByZpG3WuLcPti7XZK80r7btrkZuXRD+K8
         TdlIiKAhSHotZBANSq0CeBR9kpD5HAgZcUoWvMlT53tvNxy5sCtNIlAwCSpNMMeDwkJY
         IiEFbdA/rolELqElfvYH0/z4OTkG8P/gJLoQSotBbLEMSxTsDaBovAY0c6ICudKn43Gm
         wlDw==
X-Forwarded-Encrypted: i=1; AJvYcCWN73VDwTKTD/bA76e4jZ7gT6zOCodWVItzmUAZqbS2y2BvfB28lXlugRwL43AiI4Ei7tpQJH8TKBbhf8oHIYZ4sfh8xYY=
X-Gm-Message-State: AOJu0YwCTSJnr0OJurSbXkwu9tgOyTdJNJnMBZxrTLCvgABG4CbGjiXQ
	CVmc134/QQqhT1AkweF3RAf1JOD6SUK9l/h2S3rPTIqRdA3vztVP0zAUFqW9Y8ugJkpv2y0zcFS
	5CHcKVITDBZtDYuErI9u5wj3EGXU=
X-Google-Smtp-Source: AGHT+IFuP1Mc9O5IzSHeKzAD4lyy6B7kIx7ruZTd+TTFQ6LgZ8Bny0sYM+gfTL0wj7e4jUrhs5wD+k3GzQg3LDmK3N4=
X-Received: by 2002:a50:ab5b:0:b0:57d:2659:9143 with SMTP id
 4fb4d7f45d1cf-57d4bde078cmr13706394a12.37.1719584249785; Fri, 28 Jun 2024
 07:17:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240628140435.1652374-1-quic_bibekkum@quicinc.com> <20240628140435.1652374-7-quic_bibekkum@quicinc.com>
In-Reply-To: <20240628140435.1652374-7-quic_bibekkum@quicinc.com>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 28 Jun 2024 07:17:17 -0700
Message-ID: <CAF6AEGvroi8rJimFv95tkWmRFa5_aTpBJ7GFcRAuZpLGdSyEYQ@mail.gmail.com>
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

On Fri, Jun 28, 2024 at 7:05=E2=80=AFAM Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
> Add an adreno-smmu-priv interface for drm/msm to call
> into arm-smmu-qcom and initiate the PRR bit setup or reset
> sequence as per request.
>
> This will be used by GPU to setup the PRR bit and related
> configuration registers through adreno-smmu private
> interface instead of directly poking the smmu hardware.
>
> Suggested-by: Rob Clark <robdclark@gmail.com>
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 23 ++++++++++++++++++++++
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      |  2 ++
>  include/linux/adreno-smmu-priv.h           |  6 +++++-
>  3 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/a=
rm/arm-smmu/arm-smmu-qcom.c
> index bd101a161d04..64571a1c47b8 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -28,6 +28,7 @@
>  #define PREFETCH_SHALLOW       (1 << PREFETCH_SHIFT)
>  #define PREFETCH_MODERATE      (2 << PREFETCH_SHIFT)
>  #define PREFETCH_DEEP          (3 << PREFETCH_SHIFT)
> +#define GFX_ACTLR_PRR          (1 << 5)
>
>  static const struct actlr_config sc7280_apps_actlr_cfg[] =3D {
>         { 0x0800, 0x04e0, PREFETCH_DEFAULT | CMTLB },
> @@ -235,6 +236,27 @@ static void qcom_adreno_smmu_resume_translation(cons=
t void *cookie, bool termina
>         arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_RESUME, reg);
>  }
>
> +static void qcom_adreno_smmu_set_prr(const void *cookie, phys_addr_t pag=
e_addr, bool set)
> +{
> +       struct arm_smmu_domain *smmu_domain =3D (void *)cookie;
> +       struct arm_smmu_cfg *cfg =3D &smmu_domain->cfg;
> +       struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> +       u32 reg =3D 0;
> +
> +       writel_relaxed(lower_32_bits(page_addr),
> +                               smmu->base + ARM_SMMU_GFX_PRR_CFG_LADDR);
> +
> +       writel_relaxed(upper_32_bits(page_addr),
> +                               smmu->base + ARM_SMMU_GFX_PRR_CFG_UADDR);
> +
> +       reg =3D  arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_ACTLR);
> +       reg &=3D ~GFX_ACTLR_PRR;
> +       if (set)
> +               reg |=3D FIELD_PREP(GFX_ACTLR_PRR, 1);
> +       arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_ACTLR, reg);
> +

nit, extra line

Also, if you passed a `struct page *` instead, then you could drop the
bool param, ie. passing NULL for the page would disable PRR.  But I
can go either way if others have a strong preference for phys_addr_t.

Otherwise, lgtm

BR,
-R

> +}
> +
>  #define QCOM_ADRENO_SMMU_GPU_SID 0
>
>  static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
> @@ -407,6 +429,7 @@ static int qcom_adreno_smmu_init_context(struct arm_s=
mmu_domain *smmu_domain,
>         priv->get_fault_info =3D qcom_adreno_smmu_get_fault_info;
>         priv->set_stall =3D qcom_adreno_smmu_set_stall;
>         priv->resume_translation =3D qcom_adreno_smmu_resume_translation;
> +       priv->set_prr =3D qcom_adreno_smmu_set_prr;
>
>         actlrvar =3D qsmmu->data->actlrvar;
>         if (!actlrvar)
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/ar=
m-smmu/arm-smmu.h
> index d9c2ef8c1653..3076bef49e20 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -154,6 +154,8 @@ enum arm_smmu_cbar_type {
>  #define ARM_SMMU_SCTLR_M               BIT(0)
>
>  #define ARM_SMMU_CB_ACTLR              0x4
> +#define ARM_SMMU_GFX_PRR_CFG_LADDR     0x6008
> +#define ARM_SMMU_GFX_PRR_CFG_UADDR     0x600C
>
>  #define ARM_SMMU_CB_RESUME             0x8
>  #define ARM_SMMU_RESUME_TERMINATE      BIT(0)
> diff --git a/include/linux/adreno-smmu-priv.h b/include/linux/adreno-smmu=
-priv.h
> index c637e0997f6d..d6e2ca9f8d8c 100644
> --- a/include/linux/adreno-smmu-priv.h
> +++ b/include/linux/adreno-smmu-priv.h
> @@ -49,7 +49,10 @@ struct adreno_smmu_fault_info {
>   *                 before set_ttbr0_cfg().  If stalling on fault is enab=
led,
>   *                 the GPU driver must call resume_translation()
>   * @resume_translation: Resume translation after a fault
> - *
> + * @set_prr:      Extendible interface to be used by GPU to modify the
> + *                 ACTLR register bits, currently used to configure
> + *                 Partially-Resident-Region (PRR) feature's
> + *                 setup and reset sequence as requested.
>   *
>   * The GPU driver (drm/msm) and adreno-smmu work together for controllin=
g
>   * the GPU's SMMU instance.  This is by necessity, as the GPU is directl=
y
> @@ -67,6 +70,7 @@ struct adreno_smmu_priv {
>      void (*get_fault_info)(const void *cookie, struct adreno_smmu_fault_=
info *info);
>      void (*set_stall)(const void *cookie, bool enabled);
>      void (*resume_translation)(const void *cookie, bool terminate);
> +    void (*set_prr)(const void *cookie, phys_addr_t page_addr, bool set)=
;
>  };
>
>  #endif /* __ADRENO_SMMU_PRIV_H */
> --
> 2.34.1
>
