Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2BE149C52
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717521230; cv=none; b=BWvfbgwqu7gUbvXDaMeIHLxGAYA6oqgwa1eB3WO/ke1VE9ZlT2Ok/k5IFfAPbA3PXdmYex1iTwopV6Nrlgwhk5S+IqHA5BvcjYC2e10RQ8xAYhwDkF5QbpFu5lY29sL7yYbSd0SBTiW5kju3Jt2D92yCd6gImf7p9rwKq7XXhWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717521230; c=relaxed/simple;
	bh=CMATLtHwVglZBZD8dhXY31CD/YKyPjonB2JuUGesnGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0NEVcwmh1vV/Ra+uvShoRHh/W/U/qMjhaIxb74V5EHpuj1oZ70XdcaavNap0Dz8OYR+vSdaho/Ev8YxtmvvgOPM9Tzlcbif4A/jTGFdhPi67gTZp06K6m+wEY39ZEFZ7aaU2o8YP8vtmkIH2d+41f6AMJVNvRzE8se1RIjnloA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCl5wvks; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCl5wvks"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4401151aad1so16903771cf.1
        for <iommu@lists.linux.dev>; Tue, 04 Jun 2024 10:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717521228; x=1718126028; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sudKpB/2Hr1Z7tzGSj92kMGoRjpOvxRwb9JzL2QNqJ8=;
        b=RCl5wvksrFDfI68aWQ8rIrbuFWj1dfaqQcRBs8gR2FoG3DID9r35OT8BlfkQ2HQNOX
         xc7cNwDXvvGVDQ9nag8lG5l3eKylV7jma7Ce8zRGpfZoxetJkW89pP39mQFE40Kh9VCY
         ObmMkfBDgALl9cKnQDz+jKVE0cnNvUmF+iIZsooWcfgnubvyNhpz6vemLCs3FxBpvdrf
         Dlf4Ydffn8MABp9A2JrzQCI6iautLLBgWI6pQGD3LOwLQbyMkd67bkmjuoDN/rcMEjZB
         npzeyIbfGO+1tlZLcGGeTZRLL+MyKbjTzHGtN3Po+Zv83XR05NyGBSf2siA51Z/JHaJZ
         102Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717521228; x=1718126028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sudKpB/2Hr1Z7tzGSj92kMGoRjpOvxRwb9JzL2QNqJ8=;
        b=nXPrHRT3FSbsRvVSbFOmt6lZgdwptUVRVee1fBQUR6VGjlRu2fWFPPnqfLr5u+wiXu
         /fuT2Hv0Hj+XQPk4lPsNoSEl/JmUNl9NOacKB3a24lHXw9Vd8r06pniSs3gI+Kstzp/t
         i2Sx5eCKYPwTBT8TzCLkWCgGsEOXTh3FGaQo3Yp6ggIasTKSkBb6R2ipA/ZkvbXMMUHw
         TowYN9VHDMvdPAoUCekRKL0sV0DBppksPI99eImehclEyWZNVxd8Ei3deLzTQMtkfMNL
         HqVE3GlMP4FkILNOylExn341npza9dDEows0Lny5uFKLI+2M1VpYH17pUaBBabYUoSLm
         trUw==
X-Forwarded-Encrypted: i=1; AJvYcCVAF7VkbHHnjGi9SnIO1kzOxYSV6ssm5p6hmKDcZRmmW42Lrgl1k1i+kwUuW346XCMGriiZrKVrXUFzTufJbXz78G5Hn9o=
X-Gm-Message-State: AOJu0Yzxpbtjoh7Z0qPtSmcPl6z0I5RFC67z+gcOTkvz9A9lk/0qQ4ft
	SS6cm0/rS6W4BOr+UwDTuak/tulPRKOMDJJZorp0JtJdEhc411Pk7quFm5XgyNA4cxl4fqtQzo7
	ffyrGiso9He7u/IU/oMsw0nYPqf4=
X-Google-Smtp-Source: AGHT+IGDavzMqg1YxgefpG5JC3iDriDmgPEM0Ng6adDKFCKTwp2M6FdaPIc6YV1jKnHIPeqJV4CJilGX8pUiDfvc5cY=
X-Received: by 2002:a05:622a:181a:b0:43c:7c7f:97b0 with SMTP id
 d75a77b69052e-43ff54ff7e5mr111658481cf.42.1717521227920; Tue, 04 Jun 2024
 10:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240116150411.23876-1-quic_bibekkum@quicinc.com> <20240116150411.23876-5-quic_bibekkum@quicinc.com>
In-Reply-To: <20240116150411.23876-5-quic_bibekkum@quicinc.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 4 Jun 2024 10:13:33 -0700
Message-ID: <CAF6AEGsO+qxMPG8P5gPwt2KUvNscuUbLZ9OzHNGKJA_=bnoshw@mail.gmail.com>
Subject: Re: [PATCH v8 4/5] iommu/arm-smmu: add ACTLR data and support for SM8550
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

On Tue, Jan 16, 2024 at 7:06=E2=80=AFAM Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
> Add ACTLR data table for SM8550 along with support for
> same including SM8550 specific implementation operations.
>
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 85 ++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/a=
rm/arm-smmu/arm-smmu-qcom.c
> index e6fad02aae92..26acfbdafd0f 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -23,6 +23,12 @@
>
>  #define CPRE                   (1 << 1)
>  #define CMTLB                  (1 << 0)
> +#define PREFETCH_SHIFT         8
> +#define PREFETCH_DEFAULT       0
> +#define PREFETCH_SHALLOW       (1 << PREFETCH_SHIFT)
> +#define PREFETCH_MODERATE      (2 << PREFETCH_SHIFT)
> +#define PREFETCH_DEEP          (3 << PREFETCH_SHIFT)
> +#define PREFETCH_SWITCH_GFX    (5 << 3)

so, PREFETCH_SWITCH_GFX seems to actually be two things, b5 is
actually PRR_ENABLE and b3 is ??

Probably you should drop the PRR_ENABLE, and perhaps give b3 a better name

BR,
-R

>
>  struct actlr_config {
>         u16 sid;
> @@ -30,6 +36,75 @@ struct actlr_config {
>         u32 actlr;
>  };
>
> +static const struct actlr_config sm8550_apps_actlr_cfg[] =3D {
> +       { 0x18a0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> +       { 0x18e0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> +       { 0x0800, 0x0020, PREFETCH_DEFAULT | CMTLB },
> +       { 0x1800, 0x00c0, PREFETCH_DEFAULT | CMTLB },
> +       { 0x1820, 0x0000, PREFETCH_DEFAULT | CMTLB },
> +       { 0x1860, 0x0000, PREFETCH_DEFAULT | CMTLB },
> +       { 0x0c01, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x0c02, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x0c03, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x0c04, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x0c05, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x0c06, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x0c07, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x0c08, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x0c09, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x0c0c, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x0c0d, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x0c0e, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x0c0f, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x1961, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x1962, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x1963, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x1964, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x1965, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x1966, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x1967, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x1968, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x1969, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x196c, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x196d, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x196e, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x196f, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x19c1, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x19c2, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x19c3, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x19c4, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x19c5, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x19c6, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x19c7, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x19c8, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x19c9, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x19cc, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x19cd, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x19ce, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x19cf, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x1c00, 0x0002, PREFETCH_SHALLOW | CPRE | CMTLB },
> +       { 0x1c01, 0x0000, PREFETCH_DEFAULT | CMTLB },
> +       { 0x1920, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> +       { 0x1923, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> +       { 0x1924, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> +       { 0x1940, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> +       { 0x1941, 0x0004, PREFETCH_SHALLOW | CPRE | CMTLB },
> +       { 0x1943, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> +       { 0x1944, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> +       { 0x1947, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> +};
> +
> +static const struct actlr_config sm8550_gfx_actlr_cfg[] =3D {
> +       { 0x0000, 0x03ff, PREFETCH_SWITCH_GFX | PREFETCH_DEEP | CPRE | CM=
TLB },
> +};
> +
> +static const struct actlr_variant sm8550_actlr[] =3D {
> +       { .io_start =3D 0x15000000, .actlrcfg =3D sm8550_apps_actlr_cfg,
> +                       .num_actlrcfg =3D ARRAY_SIZE(sm8550_apps_actlr_cf=
g) },
> +       { .io_start =3D 0x03da0000, .actlrcfg =3D sm8550_gfx_actlr_cfg,
> +                       .num_actlrcfg =3D ARRAY_SIZE(sm8550_gfx_actlr_cfg=
) },
> +};
> +
>  static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
>  {
>         return container_of(smmu, struct qcom_smmu, smmu);
> @@ -601,6 +676,15 @@ static const struct qcom_smmu_match_data sdm845_smmu=
_500_data =3D {
>         /* Also no debug configuration. */
>  };
>
> +
> +static const struct qcom_smmu_match_data sm8550_smmu_500_impl0_data =3D =
{
> +       .impl =3D &qcom_smmu_500_impl,
> +       .adreno_impl =3D &qcom_adreno_smmu_500_impl,
> +       .cfg =3D &qcom_smmu_impl0_cfg,
> +       .actlrvar =3D sm8550_actlr,
> +       .num_smmu =3D ARRAY_SIZE(sm8550_actlr),
> +};
> +
>  static const struct qcom_smmu_match_data qcom_smmu_500_impl0_data =3D {
>         .impl =3D &qcom_smmu_500_impl,
>         .adreno_impl =3D &qcom_adreno_smmu_500_impl,
> @@ -635,6 +719,7 @@ static const struct of_device_id __maybe_unused qcom_=
smmu_impl_of_match[] =3D {
>         { .compatible =3D "qcom,sm8250-smmu-500", .data =3D &qcom_smmu_50=
0_impl0_data },
>         { .compatible =3D "qcom,sm8350-smmu-500", .data =3D &qcom_smmu_50=
0_impl0_data },
>         { .compatible =3D "qcom,sm8450-smmu-500", .data =3D &qcom_smmu_50=
0_impl0_data },
> +       { .compatible =3D "qcom,sm8550-smmu-500", .data =3D &sm8550_smmu_=
500_impl0_data },
>         { .compatible =3D "qcom,smmu-500", .data =3D &qcom_smmu_500_impl0=
_data },
>         { }
>  };
> --
> 2.17.1
>
>
