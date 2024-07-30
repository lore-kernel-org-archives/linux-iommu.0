Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD636757FC
	for <iommu@lists.linux.dev>; Tue, 30 Jul 2024 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357597; cv=none; b=t1zKBEeXvxB4ilkm4qlK0k3x2mlxC9YeFLzGSMX2MFY0a7I5kfRqZ8v+tWzhhG1ZS44QJjZnBHzCMGqGBVXKg60WbI0/mM/aBpm+t2F+cGFoq6n3mQD863/3HOSgKOy8ag+mptM+RlBxWSWssxfrjFC3Q7ZBu0Dw6EN8PCR4/0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357597; c=relaxed/simple;
	bh=qLxZqKuTsUhXJlp4omzcBe+y0yee7AHKrukmb8NNlRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFd4cKB/Wh+rL6TKio73drMxPmyal124yI45GQhJ+gaD6Z6f/dXXlFOyIqXzdTOE2zT5E+apedYVlr7g26bduPhERziGHVosryumai5eq7lfhVwWDljOhLWzCIxM8pd+gRgqH8UF0Ymx2Rltxsu69Gpgu3jtahZe7VHVHBgNSBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ho8aw05Y; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ho8aw05Y"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ef2cce8be8so62337341fa.1
        for <iommu@lists.linux.dev>; Tue, 30 Jul 2024 09:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722357594; x=1722962394; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fO87RtbN6Fg9vcoOtB0cm5t0/OE3a9XN2G9gEOAZms=;
        b=ho8aw05YekhkJVVHvrr/h16Me8bdnY1rgmBTF26Hvl/6fFBg30L5yGG87M1Kj5+N1V
         fbRIzbppTBCojLyCJABL+7C4sTcnqR5JK5pCJQDtOnPLVOBE5WOSlV9WAjLYl/EXn3Oi
         UioY7BeeuK81TEaPh+35F/VC/uH+Hkve9or7LxQbnSa9v5JLr2B3tYmpbBjVQJZRwkvN
         Qb8hLmz7hVNwsD6qyMStHO05ZK+thFfopLiWB03y5M5DTYbA5onYlNqjWGwgQbrwu5ks
         h1mRDdS3nai9Y5+jSeBRZvif3jrPHzRvi0+nOBZHe25Djb2uRc89+Bn9B2CUMbEbBtrW
         fzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722357594; x=1722962394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fO87RtbN6Fg9vcoOtB0cm5t0/OE3a9XN2G9gEOAZms=;
        b=a4+VtP5L2C0DV17ZRWJ/kgvph4uU5eDjlQwB9dx/c7L5C1fQyRHd8bVgyqikbytRBl
         h21mlB0ubk540ea9LPE/wcVSVcgbp4ZUJNPcsJJydafoVwBpzVo1ik/QwCHR7Dd+y0+g
         huBEHt1jy5hpjXkugDdxXOVbC7LroWONOTzEhuuLlY4lzhF9P7hCJ+pMmNds0GaT4w3v
         6Lp7gDz/8WnfGrqn/WObaP9UXD8lXkzmzaHpGoy8oazTu8mqDFSwE7YXbUIfM9vZVBwb
         T2P1sZQhgciZ0Q0+Txl5sNP5uXoxaYFSfMk3suON2eg5L2nNeS1+IHpeoYVbCm+IbJD3
         GFpA==
X-Forwarded-Encrypted: i=1; AJvYcCWze11iznL47sBwk9Fg7ELoy96bOJ1HWCjSlhttHeV8jMpBmyvtQtiwpbYm1Wn/TT8qj93RmuidTjlzknx6frNGp7EAy+g=
X-Gm-Message-State: AOJu0YyST3PjsLbzlMzvkfSHwMojjs603hwxGj1fio211vGs5s0a703/
	ligNHS9hLCLfDGYzkCusVP86bRyAKjw8NqvFcAIL7jnC9BLhp9Wz9yhDji1Ia6q5VN72bhc5dP8
	4qx87HYKDfbIxEErDJeX1jk0Qu2k=
X-Google-Smtp-Source: AGHT+IFmBof/Y6IZmxQHisPWxkUedNGPtjOQevzn3NPqM7iEjaGbYOOIkNDYQLhLGKx5sDWlwamk3WSJCvg5Sqdqdmk=
X-Received: by 2002:a2e:7a11:0:b0:2ef:1f51:c4ee with SMTP id
 38308e7fff4ca-2f12ebcafaemr83664291fa.9.1722357593713; Tue, 30 Jul 2024
 09:39:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240729-topic-845_gpu_smmu-v1-1-8e372abbde41@kernel.org>
In-Reply-To: <20240729-topic-845_gpu_smmu-v1-1-8e372abbde41@kernel.org>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 30 Jul 2024 09:39:42 -0700
Message-ID: <CAF6AEGsV7xfknnJ+-sQdHvzqCMc9=TFy6L3e6cM52MaaE3HNfw@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Work around SDM845 Adreno SMMU w/
 16K pages
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 1:37=E2=80=AFAM Konrad Dybcio <konradybcio@kernel.o=
rg> wrote:
>
> From: Konrad Dybcio <konrad.dybcio@linaro.org>
>
> SDM845's Adreno SMMU is unique in that it actually advertizes support
> for 16K (and 32M) pages, which doesn't hold for newer SoCs.
>
> This however, seems either broken in the hardware implementation, the
> hypervisor middleware that abstracts the SMMU, or there's a bug in the
> Linux kernel somewhere down the line that nobody managed to track down.
>
> Booting SDM845 with 16K page sizes and drm/msm results in:
>
> *** gpu fault: ttbr0=3D0000000000000000 iova=3D000100000000c000 dir=3DREA=
D
> type=3DTRANSLATION source=3DCP (0,0,0,0)
>
> right after loading the firmware. The GPU then starts spitting out
> illegal intstruction errors, as it's quite obvious that it got a
> bogus pointer.
>
> Hide 16K support on SDM845's Adreno SMMU to work around this.
>
> Reported-by: Sumit Semwal <sumit.semwal@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> There's a mismatch in sender/committer addresses but that's "fine":
> https://lore.kernel.org/linux-usb/2024072734-scenic-unwilling-71ea@gregkh=
/
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/a=
rm/arm-smmu/arm-smmu-qcom.c
> index 36c6b36ad4ff..d25825c05817 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -338,6 +338,15 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_devic=
e *smmu)
>         return 0;
>  }
>
> +static int qcom_adreno_smmuv2_cfg_probe(struct arm_smmu_device *smmu)
> +{
> +       /* SDM845 Adreno SMMU advertizes 16K pages support, but something=
 is broken */
> +       if (of_device_is_compatible(smmu->dev->of_node, "qcom,sdm845-smmu=
-v2"))
> +               smmu->features &=3D ~ARM_SMMU_FEAT_FMT_AARCH64_16K;

jfwiw, it looks like we need this for sc7180 as well.. probably just
remove the "if" and mask out 16K for all smmu-v2, until we know that
there is somewhere that it _does_ work?

BR,
-R


> +
> +       return 0;
> +}
> +
>  static void qcom_smmu_write_s2cr(struct arm_smmu_device *smmu, int idx)
>  {
>         struct arm_smmu_s2cr *s2cr =3D smmu->s2crs + idx;
> @@ -436,6 +445,7 @@ static const struct arm_smmu_impl sdm845_smmu_500_imp=
l =3D {
>
>  static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl =3D {
>         .init_context =3D qcom_adreno_smmu_init_context,
> +       .cfg_probe =3D qcom_adreno_smmuv2_cfg_probe,
>         .def_domain_type =3D qcom_smmu_def_domain_type,
>         .alloc_context_bank =3D qcom_adreno_smmu_alloc_context_bank,
>         .write_sctlr =3D qcom_adreno_smmu_write_sctlr,
>
> ---
> base-commit: 931a3b3bccc96e7708c82b30b2b5fa82dfd04890
> change-id: 20240726-topic-845_gpu_smmu-ab738f7a013c
>
> Best regards,
> --
> Konrad Dybcio <konradybcio@kernel.org>
>
