Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD4E379
	for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 01:01:25 +0000 (UTC)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-34ba9d6561aso526325ab.2
        for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 18:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692234084; x=1692838884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBPzqaP5DfSy9q7dC4AwA+Rsr/csT2NvsA7E32jUJuA=;
        b=QGnJcmg1M+N/dT923UTrS1eGYdpA3rFOCMdbqNUxkcSOLh9Z4WRuJL+ygkC5SoQDov
         4zZspO8ijqOPwC4Y6q+AyRUMTAbgTZtEuF5+hFwsA2mStm3suhBdkQcjgxgMNXcKFzFY
         cP5BIXlhRaSD2k5PwrPxxuKZCf4Ar7X6RBtLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692234084; x=1692838884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBPzqaP5DfSy9q7dC4AwA+Rsr/csT2NvsA7E32jUJuA=;
        b=EGsH+w5XxsaEjjqKP+KzSKKUiopkFtKWKQAUHMslEE/szni7gBq5HVnn8wd8CBj6QX
         /U4/LikM7rlBRpGhJLU11EOd6SifYDAL5Lqu8U37ObCiwR43ag3ah7wW6sxfsS+Dj6fa
         C+pza/xJ36xNBTcx61t1gbLmLx+gY4UE8tV/KzilUQ8YECuQ3oyW7j6Gafkojg+Qza6V
         9aqQzvAGMviAd0fux4uKfRsFcTmkgh+Bsw73wFaG6laBi9kx7OXGyQ2gyGA7ce/dIGsq
         uHJPYHBnyIxij7/eqksY6tPL2nXi7J8RuIYbq9Dmgja0gSjwM5e2Q0mJwwXdMeuWsI3o
         Ow0Q==
X-Gm-Message-State: AOJu0Ywozf+LCLjYcH8LwexY93V9mtEbBis1WwSvzPXzbK1Xp31t9Kc+
	F0tu9ejkaQXNhgNnvc4hL+JjyUHXq1AqiDS74Z3tfg==
X-Google-Smtp-Source: AGHT+IEo14MBJ7bucS0gCKsBBraoOjjpAOGAUF/QzHhj9Y32H9nyJ2x0B+77O/LnjzTJw8GGAEHN/dUcgLJ7WpUdn+k=
X-Received: by 2002:a05:6e02:1a6b:b0:349:191:af05 with SMTP id
 w11-20020a056e021a6b00b003490191af05mr5442592ilv.16.1692234084205; Wed, 16
 Aug 2023 18:01:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230816225509.11070-1-quic_aprasann@quicinc.com>
In-Reply-To: <20230816225509.11070-1-quic_aprasann@quicinc.com>
From: Rob Clark <robdclark@chromium.org>
Date: Wed, 16 Aug 2023 18:01:13 -0700
Message-ID: <CAJs_Fx7132o3iHDH0ZR7L9G69o2YV2-jC0v15shQcEhH6=-6RA@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-qcom: NULL pointer check for driver data
To: Aravind Vijayakumar <quic_aprasann@quicinc.com>
Cc: will@kernel.org, joro@8bytes.org, robin.murphy@arm.com, 
	dmitry.baryshkov@linaro.org, quic_bjorande@quicinc.com, 
	konrad.dybcio@linaro.org, quic_eberman@quicinc.com, quic_psodagud@quicinc.com, 
	quic_rvishwak@quicinc.com, quic_saipraka@quicinc.com, 
	quic_molvera@quicinc.com, marijn.suijten@somainline.org, mani@kernel.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 3:55=E2=80=AFPM Aravind Vijayakumar
<quic_aprasann@quicinc.com> wrote:
>
> The driver_data is NULL when qcom_adreno_smmu_init_context()
> is called before the dev_set_drvdata() from the client driver
> and is resulting in kernel crash.
>
> So add a null pointer check to handle the scenario
> where the client driver for the GPU SMMU device would
> be setting the driver data after the smmu client device
> probe is done and not necessarily before that. The function
> qcom_adreno_smmu_init_context() assumes that the client
> driver always set the driver data using dev_set_drvdata()
> before the smmu client device probe, but this assumption
> is not always true.
>
> Signed-off-by: Aravind Vijayakumar <quic_aprasann@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/a=
rm/arm-smmu/arm-smmu-qcom.c
> index c71afda79d64..5323f82264ca 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -231,6 +231,9 @@ static int qcom_adreno_smmu_init_context(struct arm_s=
mmu_domain *smmu_domain,
>          */
>
>         priv =3D dev_get_drvdata(dev);
> +       if (!priv)
> +               return 0;

could this -EPROBE_DEFER instead, or something like that?  I think you
patch as proposed would result in per-process gpu pgtables silently
failing

BR,
-R

> +
>         priv->cookie =3D smmu_domain;
>         priv->get_ttbr1_cfg =3D qcom_adreno_smmu_get_ttbr1_cfg;
>         priv->set_ttbr0_cfg =3D qcom_adreno_smmu_set_ttbr0_cfg;
> --
> 2.40.1
>
