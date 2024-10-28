Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBFB1E22E6
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730150198; cv=none; b=ZfRgoI3hiEGRbXZwDz782uPk6awqzjIgUj5qmIH5+ix5Ph2ruLyHPuFj8CWvvAPOzk5diJVPgrex4KSA6O6xBAwHWen33ho4fKitZR57CoAM59OEl7y7AljUpAAob6S/W9HLJkoUdWOjlumPaWhXBqe9NQ7GaiFFU/jah6G1LDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730150198; c=relaxed/simple;
	bh=TB/aR6e8qqZZ/NbQWYKoSmUDPWYT7mmVzJZlaNyn1Cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1U21oXVlIeeucaAVlSEkPH8OdOoPv9E+q9zM2NBiFCdhW4Apf09s4/ozH3Yn+dAnWPJcqA/rG26GhuTVYtIzy611nyXMb4Vwyd8kdKdsKwgtnyxY9XjzZA8P0fNt/9av7n78LcAMb5FzYedtOKmIbU6e2oIdFQ7sp/m1ux+xzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hABLr6qG; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hABLr6qG"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a3a6abcbf1so19036965ab.2
        for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 14:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730150194; x=1730754994; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktS5JZlVOvEaixmraj14grQIGS0mOTMVZfsZ8ze71Ik=;
        b=hABLr6qG14GeEa5efskuf9mO/Rs1+f0mMjC7su12z+r7qbe+xv72mV9lyOHiZ1qBeT
         AkQ3OCSodQG6eg7kQoVWz0Dm14WBhtgmnLFswl+TOSBeK6s6Bi4ZkiKPPOOs33DYcguf
         /XUduOcpV3G0KrwKRbVgzgSJ11equxNeHnJPGOlvghpUZz79UGXSg9/DUz8fRrCPLRmJ
         600j/1lc+T2Gy22dzFgp0BGGfXgUvLjhg6KDWRThwehgG+2s4HkSoU6HvXG1Hf3QWLHh
         B8nyxKcGq6+vGOCuHdQ/9RppnVxJW39zBT3Bz+49CPQK1MTXbNvT7AF6pj2CzUzH1/X5
         3vFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730150194; x=1730754994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktS5JZlVOvEaixmraj14grQIGS0mOTMVZfsZ8ze71Ik=;
        b=slZDANoet5Jdk48PoZ0FK4/wAYN4ZXbTK11DAyVOzvRkoDT+Vl5j3xQ8/CgdrM6nTz
         zcAwzbZQ9kRg/5xTg6OYH60Aqzqnw8Nb/sRf40rOvUdM0Ici82l8880LmOHSUmXgwSJU
         LvsjabE3KXkGXCMOfOfUSbcv/mUNVZrkHR/9juLfb/6LBWaUxFddNWcLbq15ebQ7POO4
         FWSP/kqxwNgjwX1r+Tp8Ex6zJ1pHDwgjZn5KuACxr6qtSdv30sBgdC+N7iJSmUQBY/TL
         ioTcsxjmTFcfJ6cpaU94rPf3gMwKPfxC3EnrvCQ8I4ejPLM/Ymu1t9l3LLvdzhRCK9ty
         HRJg==
X-Forwarded-Encrypted: i=1; AJvYcCUixwyBQjcM8hBXN2T2Rl5ACz219fF7X+/VP+kVD9h+Vq658t6EgRN0+Mrd3FVfMd9FBEz44Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+USYLplrsDHwbmjHcKLg82QYePVdEhGPCii9XCCihz+cUb87D
	Nd+r9ho26aeSUCLJ6mpGSRDfSg5nnu9t0+M3DANWb0Q10P+NP9uaWPHnihveG6+9Oer5wNETKpj
	SgA+u7O3X9tv43ya59UgGlDRBuKk=
X-Google-Smtp-Source: AGHT+IG9XrLh5NKIexOxyfcazqPge3CPHDgNBsyKjId3gtC/MJJHMtgd1LcfGFYvXzXYtIB2lAVzQZdmZdFDCxa0qBU=
X-Received: by 2002:a05:6e02:20c8:b0:3a0:8c68:7705 with SMTP id
 e9e14a558f8ab-3a4ed3012b2mr68380955ab.21.1730150194399; Mon, 28 Oct 2024
 14:16:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241008125410.3422512-1-quic_bibekkum@quicinc.com> <20241008125410.3422512-6-quic_bibekkum@quicinc.com>
In-Reply-To: <20241008125410.3422512-6-quic_bibekkum@quicinc.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 28 Oct 2024 14:16:22 -0700
Message-ID: <CAF6AEGtOn3+99KMVRvpH=8Qs-g52ajVQyeBkxThSES_dEdVH+Q@mail.gmail.com>
Subject: Re: [PATCH v16 5/5] iommu/arm-smmu: add ACTLR data and support for qcom_smmu_500
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, 
	jsnitsel@redhat.com, robh@kernel.org, krzysztof.kozlowski@linaro.org, 
	quic_c_gdjako@quicinc.com, dmitry.baryshkov@linaro.org, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 5:55=E2=80=AFAM Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
> Add ACTLR data table for qcom_smmu_500 including
> corresponding data entry and set prefetch value by
> way of a list of compatible strings.
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/a=
rm/arm-smmu/arm-smmu-qcom.c
> index 2d2c1e75632c..dd4fb883ebcd 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -25,8 +25,31 @@
>
>  #define CPRE                   (1 << 1)
>  #define CMTLB                  (1 << 0)
> +#define PREFETCH_SHIFT         8
> +#define PREFETCH_DEFAULT       0
> +#define PREFETCH_SHALLOW       (1 << PREFETCH_SHIFT)
> +#define PREFETCH_MODERATE      (2 << PREFETCH_SHIFT)
> +#define PREFETCH_DEEP          (3 << PREFETCH_SHIFT)
>  #define GFX_ACTLR_PRR          (1 << 5)
>
> +static const struct of_device_id qcom_smmu_actlr_client_of_match[] =3D {
> +       { .compatible =3D "qcom,adreno",
> +                       .data =3D (const void *) (PREFETCH_DEEP | CPRE | =
CMTLB) },
> +       { .compatible =3D "qcom,adreno-gmu",
> +                       .data =3D (const void *) (PREFETCH_DEEP | CPRE | =
CMTLB) },
> +       { .compatible =3D "qcom,adreno-smmu",
> +                       .data =3D (const void *) (PREFETCH_DEEP | CPRE | =
CMTLB) },
> +       { .compatible =3D "qcom,fastrpc",
> +                       .data =3D (const void *) (PREFETCH_DEEP | CPRE | =
CMTLB) },
> +       { .compatible =3D "qcom,sc7280-mdss",
> +                       .data =3D (const void *) (PREFETCH_SHALLOW | CPRE=
 | CMTLB) },
> +       { .compatible =3D "qcom,sc7280-venus",
> +                       .data =3D (const void *) (PREFETCH_SHALLOW | CPRE=
 | CMTLB) },
> +       { .compatible =3D "qcom,sm8550-mdss",
> +                       .data =3D (const void *) (PREFETCH_DEFAULT | CMTL=
B) },
> +       { }
> +};

I guess by now there are some more entries to add
("qcom,x1e80100-mdss", for example), but I guess those could be
followup patches

Reviewed-by: Rob Clark <robdclark@gmail.com>

> +
>  static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
>  {
>         return container_of(smmu, struct qcom_smmu, smmu);
> @@ -640,6 +663,7 @@ static const struct qcom_smmu_match_data qcom_smmu_50=
0_impl0_data =3D {
>         .impl =3D &qcom_smmu_500_impl,
>         .adreno_impl =3D &qcom_adreno_smmu_500_impl,
>         .cfg =3D &qcom_smmu_impl0_cfg,
> +       .client_match =3D qcom_smmu_actlr_client_of_match,
>  };
>
>  /*
> --
> 2.34.1
>
