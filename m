Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF0F1DFE1C
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 21:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730150047; cv=none; b=JsOH7obBM9xZnY/42KPsKL/U9iup+8m+KeDD+STAk2M/misaidUmDLlB+LCMz1zatiVOZaBoQW9Y0Dz/VPhD1w3zamX/49qX/q3QHZ2UykiP6YpGzvjUb0m+bc+9GiwtOxusvtH3xk0PhJTUWXPtzB1/mskAq2ExkI/7m5YX6vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730150047; c=relaxed/simple;
	bh=3S+njuOUwc1MmOeJ6CkGxI4sXeklNqZ8QHWP5vGtsP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AU1TOW/b1VL6SEJnuvxJRUQ3i3SJ9xDm8PWEGQonIKySLxEJVKuJR7y3k1q53DbtPiZSlRYV5JBiYC5ATCkaoCrbw3TmDSEeBlWlinjsfO9cxN8GNIiZRfeY6FOW1H8abonmUPGXxK4Tra5bF3110BUCkemyitSneVIXk+lh8nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5ukrzqa; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5ukrzqa"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a4d2d028b3so17857265ab.1
        for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 14:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730150045; x=1730754845; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9okxa3Q0g0QmicSYuvHmUoOcciSTa4JWfgy8EOP1LU=;
        b=E5ukrzqa1Q8r4qM42r6VbuGpG22OQHJtwdCritElYrGewF3g1lWD/E4OcoWnfXfB3F
         8gqZhuUMMQ+RYKg3cUHHU6EtXGshvwIYXPBJvvlFg5wWYUDiNkWlCXHbVqxnPq/S105l
         br06yWGKmVRTAK4WqNAZGx5GJr33ngm193LfeRq6+ZGHJeXb/YumuGK0GxUyqHb5vfFU
         s9ASJiUSEzhsM8X8ARCfX3ZrXDyICZhySpLDewUgM5rezJ4PSh7sLJ81wjUJi8e4nQkd
         z8vewRYkspAje4qBlamlPC6itE0u5dSSyPmz+ed9AjFUdgHRw3p7BYhJGTAuZV9eYo68
         nFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730150045; x=1730754845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9okxa3Q0g0QmicSYuvHmUoOcciSTa4JWfgy8EOP1LU=;
        b=hga9gNmpSAI9993y4+Li/D8U2T7OKBKarp1zJc+y8IvzR2R5rMlFDo779F53KnNJXa
         uCxjOOCK+YOO7COFH2UoIxziN5B1W/lR68LCZ4YMmWaysugNR4OVmtAIRSMcxJ7nxrnY
         usrjmouGViP8Te2/8xWxektvzU+yl1QOJWFft8M9Y6Mt5nzUXnbEbwaqu8ERFHNeXxoU
         14HsAvhJpwJZ/5onpy/Zc+1DK0dw0jfj4f5nPOyjC38/M/uCWyokR/pJeVXT7aWeAWB6
         wl5SUMhknPkefJ1FkM1TaW2z6CWcLB92q6boKiPcA7FSyhJpSyu3tBA5Gx7H0K3ZcAcI
         g17g==
X-Forwarded-Encrypted: i=1; AJvYcCWiG9dQAwX6vuQ9xspHvjLP0s/ICauvxkvupnxzIzt/Q8+cAc8rYS41HI+92M7jFtjzi+YepQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwBOqUH+qqVS3dEr3GkVERb24zhFbYKbgx1bDnZ4aw++VqmC27/
	VCsbxZtyO5Q45hjMXVeI3kcuSYCcAst0br/Yt+NG/BHzFuvNLIeLPsB4E6NolvTlzcSutMBaGgG
	BWr/eg3Hu/SmntKKjtm3EvLBcsWE=
X-Google-Smtp-Source: AGHT+IEoro3zvUNoTUS9DRoCkr30RdGb4Txbh508oi+qXOwLzunjNjeXZW5mwOUVMfFBSM2AC0IlmPQVR59TYAjtfdc=
X-Received: by 2002:a05:6e02:3dc2:b0:3a0:9f85:d74f with SMTP id
 e9e14a558f8ab-3a4ed338581mr88116405ab.16.1730150044912; Mon, 28 Oct 2024
 14:14:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241008125410.3422512-1-quic_bibekkum@quicinc.com> <20241008125410.3422512-4-quic_bibekkum@quicinc.com>
In-Reply-To: <20241008125410.3422512-4-quic_bibekkum@quicinc.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 28 Oct 2024 14:13:53 -0700
Message-ID: <CAF6AEGst2uOosTiu63mr95w=Km1bMEQbryxEAGRpiUKqr_rM-g@mail.gmail.com>
Subject: Re: [PATCH v16 3/5] iommu/arm-smmu: add support for PRR bit setup
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, 
	jsnitsel@redhat.com, robh@kernel.org, krzysztof.kozlowski@linaro.org, 
	quic_c_gdjako@quicinc.com, dmitry.baryshkov@linaro.org, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 5:54=E2=80=AFAM Bibek Kumar Patro
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

Reviewed-by: Rob Clark <robdclark@gmail.com>

> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 37 ++++++++++++++++++++++
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      |  2 ++
>  include/linux/adreno-smmu-priv.h           | 10 +++++-
>  3 files changed, 48 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/a=
rm/arm-smmu/arm-smmu-qcom.c
> index 6e0a2a43e45a..38ac9cab763b 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -25,6 +25,7 @@
>
>  #define CPRE                   (1 << 1)
>  #define CMTLB                  (1 << 0)
> +#define GFX_ACTLR_PRR          (1 << 5)
>
>  static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
>  {
> @@ -109,6 +110,40 @@ static void qcom_adreno_smmu_resume_translation(cons=
t void *cookie, bool termina
>         arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_RESUME, reg);
>  }
>
> +static void qcom_adreno_smmu_set_prr_bit(const void *cookie, bool set)
> +{
> +       struct arm_smmu_domain *smmu_domain =3D (void *)cookie;
> +       struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> +       const struct device_node *np =3D smmu->dev->of_node;
> +       struct arm_smmu_cfg *cfg =3D &smmu_domain->cfg;
> +       u32 reg =3D 0;
> +
> +       if (of_device_is_compatible(np, "qcom,smmu-500") &&
> +                       of_device_is_compatible(np, "qcom,adreno-smmu")) =
{
> +               reg =3D  arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_A=
CTLR);
> +               reg &=3D ~GFX_ACTLR_PRR;
> +               if (set)
> +                       reg |=3D FIELD_PREP(GFX_ACTLR_PRR, 1);
> +               arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_ACTLR, re=
g);
> +       }
> +}
> +
> +static void qcom_adreno_smmu_set_prr_addr(const void *cookie, phys_addr_=
t page_addr)
> +{
> +       struct arm_smmu_domain *smmu_domain =3D (void *)cookie;
> +       struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> +       const struct device_node *np =3D smmu->dev->of_node;
> +
> +       if (of_device_is_compatible(np, "qcom,smmu-500") &&
> +                       of_device_is_compatible(np, "qcom,adreno-smmu")) =
{
> +               writel_relaxed(lower_32_bits(page_addr),
> +                                       smmu->base + ARM_SMMU_GFX_PRR_CFG=
_LADDR);
> +
> +               writel_relaxed(upper_32_bits(page_addr),
> +                                       smmu->base + ARM_SMMU_GFX_PRR_CFG=
_UADDR);
> +       }
> +}
> +
>  #define QCOM_ADRENO_SMMU_GPU_SID 0
>
>  static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
> @@ -249,6 +284,8 @@ static int qcom_adreno_smmu_init_context(struct arm_s=
mmu_domain *smmu_domain,
>         priv->get_fault_info =3D qcom_adreno_smmu_get_fault_info;
>         priv->set_stall =3D qcom_adreno_smmu_set_stall;
>         priv->resume_translation =3D qcom_adreno_smmu_resume_translation;
> +       priv->set_prr_bit =3D qcom_adreno_smmu_set_prr_bit;
> +       priv->set_prr_addr =3D qcom_adreno_smmu_set_prr_addr;
>
>         return 0;
>  }
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/ar=
m-smmu/arm-smmu.h
> index e2aeb511ae90..2dbf3243b5ad 100644
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
> index c637e0997f6d..03466eb16933 100644
> --- a/include/linux/adreno-smmu-priv.h
> +++ b/include/linux/adreno-smmu-priv.h
> @@ -49,7 +49,13 @@ struct adreno_smmu_fault_info {
>   *                 before set_ttbr0_cfg().  If stalling on fault is enab=
led,
>   *                 the GPU driver must call resume_translation()
>   * @resume_translation: Resume translation after a fault
> - *
> + * @set_prr_bit:   Extendible interface to be used by GPU to modify the
> + *                ACTLR register bits, currently used to configure
> + *                Partially-Resident-Region (PRR) bit for feature's
> + *                setup and reset sequence as requested.
> + * @set_prr_addr:  Configure the PRR_CFG_*ADDR register with the
> + *                physical address of PRR page passed from
> + *                GPU driver.
>   *
>   * The GPU driver (drm/msm) and adreno-smmu work together for controllin=
g
>   * the GPU's SMMU instance.  This is by necessity, as the GPU is directl=
y
> @@ -67,6 +73,8 @@ struct adreno_smmu_priv {
>      void (*get_fault_info)(const void *cookie, struct adreno_smmu_fault_=
info *info);
>      void (*set_stall)(const void *cookie, bool enabled);
>      void (*resume_translation)(const void *cookie, bool terminate);
> +    void (*set_prr_bit)(const void *cookie, bool set);
> +    void (*set_prr_addr)(const void *cookie, phys_addr_t page_addr);
>  };
>
>  #endif /* __ADRENO_SMMU_PRIV_H */
> --
> 2.34.1
>
