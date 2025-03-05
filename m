Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AFB2E339F
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201807; cv=none; b=trPU8zLaH/z0KJXXQs3/crTysd9pZ8SwQWGAAe9Cs3mzYc/h0/gQirv1zL244wG0ULfR+UpdU3BRCV9HRFY+mwN0sCUjlkXE3WpC+DSvrtZt08Kgwyr79sJZ6UGWX/bOiLXH6qWdYb+0glHzcMjKkeGmlWK23uZKiRVOoMPaxfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201807; c=relaxed/simple;
	bh=9sg2W0Xm8LswKwh5NENYu0yag2aaKtRAfhaYjEk0Giw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPAQQzHhijie5i1Uyu8jB7Zust8aKRHaGhBL3fiDBYg0m/L12HpYZOpcCuEhnUs3h8PoNF0vfoSEE7DhUUZmku84JI2hUDBx+h1xpQX5YeqqZl9UileeVAbHcpSCE2jR5H8UW53mfDa0S9a3PMpsrWaEMZjQbOm75ynb2RdKQPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbxdFtez; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbxdFtez"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d3e25323cfso56646705ab.3
        for <iommu@lists.linux.dev>; Wed, 05 Mar 2025 11:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741201805; x=1741806605; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MaiMyt+dgXQn1FXtXZ4qzvS0McmvnfMbhAjNl5s0fqs=;
        b=KbxdFtez8kTKCPtBVznGQ6VJyoX2CjcaTOKiGWpHFvoV0TfDpDZJv3CwLBhzbTdzXB
         uNFR2pDQRrJQ+vSUvmocdPABmYGGdYDUh3Zbrqb59OE7gPj3kU0wrJ7tMMbv7Tc1/V4M
         o0wfKHC8HCUouvinN/ki9XNDV45/ptkr07+MKVWWNXUJU4p2rwG8Saks7l8huh3qjAgL
         94P8U8L80Z3RTHvtXsyHjClA+JIfOHKDMh7q1w8AYf3rPWv2oVn3Md6cwydMv2TvX5/c
         tbLvkXYTdgHJ/HG+H3Ms75152JMTgvU1rG2K5/L21n7qgjS6fmFyB1lh18JXhbF4MCuw
         E7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741201805; x=1741806605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MaiMyt+dgXQn1FXtXZ4qzvS0McmvnfMbhAjNl5s0fqs=;
        b=l9HykYNDcFFymhXVlJa2SfzBGgc/MxuepCUujPReXsvedsDJZZzDXhNcSCrFzpTfUT
         gdssNbWdnv0c/W23EsgWPFxod3+WvJBOql7PV7wuSD5QTFZY1QPvnHXANAa05XkJAohW
         ZAjlr1963au05PMOBRgq7usYdzfzudqgnxRWyQXjs+2empncEMBDcK5Dry2KLWzbcl+P
         Jc6UoOq5Mv2EVVRUqiFjAoUi3HFUYwa2fLZ38K+oG5YEP1vX17n9WJv+sKJGjO0S3FFO
         xJjiilzWaCzr+x+WkWRMQ+01RQMC2yc6h5LHvKiIQShJNVnTC9bz6sD+vmgZReMk3UmL
         9SDw==
X-Forwarded-Encrypted: i=1; AJvYcCVxQMu3fS5RVKsdT4Ly0ee7BWdCLFyUa9p8zLWP6bu1T/nc0YLmP1YUXtuNjBk6RLMgkuzIww==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvBD3wXHqnZokWGhw8ptik/h88KMaV1ZcBht1ptGRFRKBfx3OF
	9JdDYFXqJPSmA0W8UJ2CzIzmNnZqeOfLq7CVcYxcug8uX0kGtSVxjd7x7x88lBwCwKR/VanMvyz
	ipmsEfdKIAsa+8yLBeqEIxboSFdA=
X-Gm-Gg: ASbGncuxJ/r63m4sYJ56AzhMAR9qNoiFhPb0nI1ZspOWGKkrmtrVyAYnynovAheoZXT
	FE0JLFOtwEMS4oJjuNT2TMJ6JLCiTVgjYZeSOosphzWGT7us9jUVOSZo6j/V+7PucUzdX6MoFcX
	GCX6P9OjbxyBVw6i/BQ10Dk7S3Bg==
X-Google-Smtp-Source: AGHT+IHwXUPkcwmz1dEZv6qs1mqFyRbKWhc6VLppFLp13raa+hash9p1l8om7PD+XzyVVCshzoOtuLCzkfE1/WnrK9s=
X-Received: by 2002:a92:c54e:0:b0:3d3:dfc2:912f with SMTP id
 e9e14a558f8ab-3d42b8a6723mr65466505ab.7.1741201805384; Wed, 05 Mar 2025
 11:10:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250304-msm-gpu-fault-fixes-next-v4-0-be14be37f4c3@gmail.com> <20250304-msm-gpu-fault-fixes-next-v4-4-be14be37f4c3@gmail.com>
In-Reply-To: <20250304-msm-gpu-fault-fixes-next-v4-4-be14be37f4c3@gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 5 Mar 2025 11:09:52 -0800
X-Gm-Features: AQ5f1JraaawwkUmCt4yL_sk7YXrsKqREgeX17Qs1rzauOQ1SG0Q4PNOpFqsI15E
Message-ID: <CAF6AEGszbZ_2J_LkkPMuCeQwma1xtO2=ZwWQcyrsxb+=qb-koQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] iommu/arm-smmu-qcom: Make set_stall work when the
 device is on
To: Connor Abbott <cwabbott0@gmail.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 8:57=E2=80=AFAM Connor Abbott <cwabbott0@gmail.com> =
wrote:
>
> Up until now we have only called the set_stall callback during
> initialization when the device is off. But we will soon start calling it
> to temporarily disable stall-on-fault when the device is on, so handle
> that by checking if the device is on and writing SCTLR.
>
> Signed-off-by: Connor Abbott <cwabbott0@gmail.com>

Reviewed-by: Rob Clark <robdclark@gmail.com>

> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 30 ++++++++++++++++++++++++=
+++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/a=
rm/arm-smmu/arm-smmu-qcom.c
> index a428e53add08d451fb2152e3ab80e0fba936e214..d34a0d917013bb3d5a24b3ce7=
2f48e3b38474da2 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -77,12 +77,36 @@ static void qcom_adreno_smmu_set_stall(const void *co=
okie, bool enabled)
>  {
>         struct arm_smmu_domain *smmu_domain =3D (void *)cookie;
>         struct arm_smmu_cfg *cfg =3D &smmu_domain->cfg;
> -       struct qcom_smmu *qsmmu =3D to_qcom_smmu(smmu_domain->smmu);
> +       struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> +       struct qcom_smmu *qsmmu =3D to_qcom_smmu(smmu);
> +       u32 mask =3D BIT(cfg->cbndx);
> +       bool stall_changed =3D !!(qsmmu->stall_enabled & mask) !=3D enabl=
ed;
> +       unsigned long flags;
>
>         if (enabled)
> -               qsmmu->stall_enabled |=3D BIT(cfg->cbndx);
> +               qsmmu->stall_enabled |=3D mask;
>         else
> -               qsmmu->stall_enabled &=3D ~BIT(cfg->cbndx);
> +               qsmmu->stall_enabled &=3D ~mask;
> +
> +       /*
> +        * If the device is on and we changed the setting, update the reg=
ister.
> +        */
> +       if (stall_changed && pm_runtime_get_if_active(smmu->dev) > 0) {
> +               spin_lock_irqsave(&smmu_domain->cb_lock, flags);
> +
> +               u32 reg =3D arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_C=
B_SCTLR);
> +
> +               if (enabled)
> +                       reg |=3D ARM_SMMU_SCTLR_CFCFG;
> +               else
> +                       reg &=3D ~ARM_SMMU_SCTLR_CFCFG;
> +
> +               arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_SCTLR, re=
g);
> +
> +               spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
> +
> +               pm_runtime_put_autosuspend(smmu->dev);
> +       }
>  }
>
>  static void qcom_adreno_smmu_resume_translation(const void *cookie, bool=
 terminate)
>
> --
> 2.47.1
>
