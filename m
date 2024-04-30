Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171C738DE4
	for <iommu@lists.linux.dev>; Tue, 30 Apr 2024 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714503653; cv=none; b=NEC1BN0IkfRTy/F/F+vbIcJirIr6f8SYtd/ZOT47b/SmqAGpzWiM6BPIYOQgYeCThgR56upx3lSEjKz9Z+ip9c5eL7q9K6Egg2z1fk1DxN5nvr2OJg+d1QnfEL9EkNNgjRaM/bvot+72zgfHCHgfzaQ18ApQLsoluZXZVPgkfRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714503653; c=relaxed/simple;
	bh=u/gdSWdGM8mYYMgrUDNuHsUJmS41lA5p3je7EAW1HdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8mAqI7kyVLi3dKZX1Z3/pdJDLOOmmCLmjlkeHnKAc1Nob+7H6Oe+bYbw6jpvxVN2snynKnJvZZiv2+If88sNJ7rHjQtmNZkP150vL2tCrzEFe9MfCzQQ3OkZLvw7ubN8Nj93qiqJQTO690oBRs2T/7rdnCn/qzX15NrnHBnfzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gfobebjt; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gfobebjt"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5725cfa2434so1969944a12.2
        for <iommu@lists.linux.dev>; Tue, 30 Apr 2024 12:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714503629; x=1715108429; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHowd7htZFxY677z1I+HnpA7wxpWxJyclfFsUx4Xnwk=;
        b=Gfobebjtgr0rnWZxsnjwDbmrR25dhgKd8+R925gDydsNajHVwgul+US/gfNeRePvre
         1h7ybki0uqmHYiTZzPr520eCzbaJ0Po7qlvO+/PDVSop/49GlxzoklrC0lXmvrtcFFQ9
         u7+rwHbjOg3Mq6BhPy7oB+0JHlDkNtG2/nwL5YsAeRLUHsziJZRZQgPhIt6pxzM9U0GG
         zjJtiKF22lpM3QxFR0zfTNY/Yx1L+/uQEgbwUy98B0kcZoyUt48xvuQBDO4dHwaMwOu/
         uVhnsN+XJDKPumOBYFHvNw4L0eSquPgj81sDsN24zp3xgHV+3g/i+/SihJu6Klry9L14
         Yd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714503629; x=1715108429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHowd7htZFxY677z1I+HnpA7wxpWxJyclfFsUx4Xnwk=;
        b=edmFeulRqoyFqZpg8AdVv0ZFZEdfYIO3l8qjTsVcYg6aiQU7dMjlzO4ZMjTyKeUqLN
         rU36GiJ8/Ve3xBgyRO7u7Mlho4er8ZIm8JYfCmQ5WNZoRzHmlV2HIFKuE0eCkUzJhr6Y
         Tbr+TRfTGMrV3ggBb/8ZHthF3uSa6tVF2uQdj3Z95Ati/cjSl7hLBy42mcfAEj4otKpW
         TUh7UwVY3GnZhPs3GLUzq7DpQd6PcxCiQwNUBbQ7wi4/Br37mbUekL+OKd0+lxmjiQUC
         pe0ZxWEc/n9p1YIy1CX1ByX3hK8XZGZl7o8ixE84bIzstTIMh52WmZgiIIRTrCgp5nK1
         ETDg==
X-Forwarded-Encrypted: i=1; AJvYcCVtMXyffWV7/uY6+PwF3Src3CpUW6zik+bKEyTowRVYSxZjgyKrKOr5gVgqEkdpfmpUkH0bYl+p0wY2pu3eYF4nK4AvbXI=
X-Gm-Message-State: AOJu0YzVSO+EdMWVGYaHAzbg3PAuSt1//mZimTL7lQeuMWeoLNyLeWDw
	dv85J3YFMOMCUnkJsOaAzHqtYPSJ/tUo18b1nPYzC6lqUq+x4Z+ZDY2dNkO2YQDIG4J2RFBnQxz
	bMKwR+d3TCdZOfz7IlrGB99bXQ8Q=
X-Google-Smtp-Source: AGHT+IHiCnT1wBxkeZPjxMy2GYxAXUTW3RAlqRgeZqMNovVmwAifCqMTzfxkI/+EHfgj0kHaYExgEM7fOKl+feI68qo=
X-Received: by 2002:a50:c353:0:b0:570:5bcc:f749 with SMTP id
 q19-20020a50c353000000b005705bccf749mr147139edb.29.1714503629075; Tue, 30 Apr
 2024 12:00:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240123144543.9405-1-quic_bibekkum@quicinc.com> <20240123144543.9405-4-quic_bibekkum@quicinc.com>
In-Reply-To: <20240123144543.9405-4-quic_bibekkum@quicinc.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 30 Apr 2024 12:00:16 -0700
Message-ID: <CAF6AEGs3_wBNo58EbGicFoQuq8--fDohTGv1JSFgoViygLS5Lg@mail.gmail.com>
Subject: Re: [PATCH v9 3/5] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	dmitry.baryshkov@linaro.org, konrad.dybcio@linaro.org, jsnitsel@redhat.com, 
	quic_bjorande@quicinc.com, mani@kernel.org, quic_eberman@quicinc.com, 
	robdclark@chromium.org, u.kleine-koenig@pengutronix.de, robh@kernel.org, 
	vladimir.oltean@nxp.com, quic_pkondeti@quicinc.com, quic_molvera@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 7:00=E2=80=AFAM Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
> Currently in Qualcomm  SoCs the default prefetch is set to 1 which allows
> the TLB to fetch just the next page table. MMU-500 features ACTLR
> register which is implementation defined and is used for Qualcomm SoCs
> to have a custom prefetch setting enabling TLB to prefetch the next set
> of page tables accordingly allowing for faster translations.
>
> ACTLR value is unique for each SMR (Stream matching register) and stored
> in a pre-populated table. This value is set to the register during
> context bank initialisation.
>
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 61 ++++++++++++++++++++++
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h | 16 +++++-
>  drivers/iommu/arm/arm-smmu/arm-smmu.c      |  5 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      |  5 ++
>  4 files changed, 84 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/a=
rm/arm-smmu/arm-smmu-qcom.c
> index 333daeb18c1c..6004c6d9a7b2 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -215,10 +215,42 @@ static bool qcom_adreno_can_do_ttbr1(struct arm_smm=
u_device *smmu)
>         return true;
>  }
>
> +static void qcom_smmu_set_actlr(struct device *dev, struct arm_smmu_devi=
ce *smmu, int cbndx,
> +               const struct actlr_config *actlrcfg, const size_t num_act=
lrcfg)
> +{
> +       struct arm_smmu_master_cfg *cfg =3D dev_iommu_priv_get(dev);
> +       struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
> +       struct arm_smmu_smr *smr;
> +       u16 mask;
> +       int idx;
> +       u16 id;
> +       int i;
> +       int j;
> +
> +       for (i =3D 0; i < num_actlrcfg; i++) {
> +               id =3D actlrcfg[i].sid;
> +               mask =3D actlrcfg[i].mask;
> +
> +               for_each_cfg_sme(cfg, fwspec, j, idx) {
> +                       smr =3D &smmu->smrs[idx];
> +                       if (smr_is_subset(smr, id, mask)) {
> +                               arm_smmu_cb_write(smmu, cbndx, ARM_SMMU_C=
B_ACTLR,
> +                                               actlrcfg[i].actlr);

So, this makes ACTLR look like kind of a FIFO.  But I'm looking at
downstream kgsl's PRR thing (which we'll need to implement vulkan
sparse residency), and it appears to be wanting to set BIT(5) in ACTLR
to enable PRR.

        val =3D KGSL_IOMMU_GET_CTX_REG(ctx, KGSL_IOMMU_CTX_ACTLR);
        val |=3D FIELD_PREP(KGSL_IOMMU_ACTLR_PRR_ENABLE, 1);
        KGSL_IOMMU_SET_CTX_REG(ctx, KGSL_IOMMU_CTX_ACTLR, val);

Any idea how this works?  And does it need to be done before or after
the ACTLR programming done in this patch?

BR,
-R

> +                               break;
> +                       }
> +               }
> +       }
> +}
> +
>  static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_do=
main,
>                 struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>  {
> +       struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> +       struct qcom_smmu *qsmmu =3D to_qcom_smmu(smmu);
> +       const struct actlr_variant *actlrvar;
> +       int cbndx =3D smmu_domain->cfg.cbndx;
>         struct adreno_smmu_priv *priv;
> +       int i;
>
>         smmu_domain->cfg.flush_walk_prefer_tlbiasid =3D true;
>
> @@ -248,6 +280,18 @@ static int qcom_adreno_smmu_init_context(struct arm_=
smmu_domain *smmu_domain,
>         priv->set_stall =3D qcom_adreno_smmu_set_stall;
>         priv->resume_translation =3D qcom_adreno_smmu_resume_translation;
>
> +       actlrvar =3D qsmmu->data->actlrvar;
> +       if (!actlrvar)
> +               return 0;
> +
> +       for (i =3D 0; i < qsmmu->data->num_smmu ; i++) {
> +               if (actlrvar[i].io_start =3D=3D smmu->ioaddr) {
> +                       qcom_smmu_set_actlr(dev, smmu, cbndx, actlrvar[i]=
.actlrcfg,
> +                                      actlrvar[i].num_actlrcfg);
> +                       break;
> +               }
> +       }
> +
>         return 0;
>  }
>
> @@ -274,7 +318,24 @@ static const struct of_device_id qcom_smmu_client_of=
_match[] __maybe_unused =3D {
>  static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>                 struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>  {
> +       struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> +       struct qcom_smmu *qsmmu =3D to_qcom_smmu(smmu);
> +       const struct actlr_variant *actlrvar;
> +       int cbndx =3D smmu_domain->cfg.cbndx;
> +       int i;
> +
>         smmu_domain->cfg.flush_walk_prefer_tlbiasid =3D true;
> +       actlrvar =3D qsmmu->data->actlrvar;
> +       if (!actlrvar)
> +               return 0;
> +
> +       for (i =3D 0; i < qsmmu->data->num_smmu ; i++) {
> +               if (actlrvar[i].io_start =3D=3D smmu->ioaddr) {
> +                       qcom_smmu_set_actlr(dev, smmu, cbndx, actlrvar[i]=
.actlrcfg,
> +                                      actlrvar[i].num_actlrcfg);
> +                       break;
> +               }
> +       }
>
>         return 0;
>  }
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h b/drivers/iommu/a=
rm/arm-smmu/arm-smmu-qcom.h
> index f3b91963e234..3f651242de7c 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /*
> - * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reser=
ved.
> + * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All rights =
reserved.
>   */
>
>  #ifndef _ARM_SMMU_QCOM_H
> @@ -24,8 +24,22 @@ struct qcom_smmu_config {
>         const u32 *reg_offset;
>  };
>
> +struct actlr_config {
> +       u16 sid;
> +       u16 mask;
> +       u32 actlr;
> +};
> +
> +struct actlr_variant {
> +       const resource_size_t io_start;
> +       const struct actlr_config * const actlrcfg;
> +       const size_t num_actlrcfg;
> +};
> +
>  struct qcom_smmu_match_data {
> +       const struct actlr_variant * const actlrvar;
>         const struct qcom_smmu_config *cfg;
> +       const size_t num_smmu;
>         const struct arm_smmu_impl *impl;
>         const struct arm_smmu_impl *adreno_impl;
>  };
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/ar=
m-smmu/arm-smmu.c
> index d6d1a2a55cc0..0c7f700b27dd 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -990,9 +990,10 @@ static int arm_smmu_find_sme(struct arm_smmu_device =
*smmu, u16 id, u16 mask)
>                  * expect simply identical entries for this case, but the=
re's
>                  * no harm in accommodating the generalisation.
>                  */
> -               if ((mask & smrs[i].mask) =3D=3D mask &&
> -                   !((id ^ smrs[i].id) & ~smrs[i].mask))
> +
> +               if (smr_is_subset(&smrs[i], id, mask))
>                         return i;
> +
>                 /*
>                  * If the new entry has any other overlap with an existin=
g one,
>                  * though, then there always exists at least one stream I=
D
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/ar=
m-smmu/arm-smmu.h
> index 703fd5817ec1..2e4f65412c6b 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -501,6 +501,11 @@ static inline void arm_smmu_writeq(struct arm_smmu_d=
evice *smmu, int page,
>                 writeq_relaxed(val, arm_smmu_page(smmu, page) + offset);
>  }
>
> +static inline bool smr_is_subset(struct arm_smmu_smr *smrs, u16 id, u16 =
mask)
> +{
> +       return (mask & smrs->mask) =3D=3D mask && !((id ^ smrs->id) & ~sm=
rs->mask);
> +}
> +
>  #define ARM_SMMU_GR0           0
>  #define ARM_SMMU_GR1           1
>  #define ARM_SMMU_CB(s, n)      ((s)->numpage + (n))
> --
> 2.17.1
>
>
