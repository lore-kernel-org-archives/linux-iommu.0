Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B8F18786A
	for <iommu@lists.linux.dev>; Mon, 29 Jul 2024 21:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287285; cv=none; b=bMLjOzh/1SIPnAhSedyv3yp1v0IhQPj4Lo3yuqKjwU9BssR9wXARolcg21ZnGfiI2NzXfq94CL1l1k4SwUn+/3Rj7tYObQMTRDpOTpzvpkvxPYtaPWYHrIO7iPWz4ZDScBvggOJYta1L8meSEkYqVHwLqlXqEb3Y1HjD1d3oJrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287285; c=relaxed/simple;
	bh=OcZtNmdtHF+XkCy+E9vzpd6R8tDn2qzRIhlajvUxQu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PqInRbq9RKR7uS4J4qODnF8uZBUhRSuCHgBdtgJEZZKC/ZDJUJNlkLBiCjT6S6oeMdAC2VhcsO5SK7iQuUMrAuwB5uXqJD3NhJ1WJWYTfLCLIwbRJfVSkASu/71qhQVZ/nTQXzywOk9FGrqvVU2MaXoG1krKetsYOmhjNUOzU/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aw8gXshf; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aw8gXshf"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52f01afa11cso5916672e87.0
        for <iommu@lists.linux.dev>; Mon, 29 Jul 2024 14:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722287281; x=1722892081; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzXJIqth9bEo+nRe6h+G7v8ZDrLX2fE6gE0P7vn4heA=;
        b=aw8gXshfgaKJsBKUn2Qv/K0mWcFC/4KNqqifQs4XUyl3SZUkdelm5532mg9ueGHg73
         NzD0QEDW6We8n1aEYBXgxa5flmmWUzRBYcnVfD7adlV4w6GEv0kHkcc8zsEogTpqeKJ6
         StPFkH04gln64Xo4VckptEPD6pERdQ/q3y9IRwTTjmzYthqrEX799BRuQ5X/+H7juTIn
         KS04VLN4Uvspi2wAhApHv9omPfVX4AMg3UxpHZtfWwBiZZ+gqE6/vybrP3vk5SPqP+Gm
         XPAVlcuavclPYhjCbywheLaeRJZSJKu7UwJznATnPaYi6d5bQSZNiDdwb7JvTKRLG9sB
         pv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722287281; x=1722892081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzXJIqth9bEo+nRe6h+G7v8ZDrLX2fE6gE0P7vn4heA=;
        b=CGaD3jwFuS7Niva1ThtZ2nceIWuN5BMsdQFTRY6hjiCvAoVUvKydVYKmv9Efe6ekn9
         FEWGWgwuPbna9tw5BgkNw+nkX69oZtU7Anf7XpIxszIEWCM4gQvCcFwBKQcfTCmDYM5X
         Jon/3iP74o/vG///cjTkh6gNkT9GxQnYmoFoHGi7oHJXaX2rggpnLY3eNdR9hVFOmrza
         2I3S1ue/e2hRJ0xlxNm+vENqV7sn1lDMXkolACZ9BmgAnOIHbcQeJqRbLtSXjXKBdoiV
         zWYnuXOgBz/rVyCZzL512jwUnWEK358WUQruHLytLcmrBM7eZ3KRTjRMl4kRa6xCn3g5
         8+jg==
X-Forwarded-Encrypted: i=1; AJvYcCUf7LVkPEklCNamKy2ZWLS9qOPoVFrTLheBEfe0Lv9jDCgrUsSG+0Fq7gzbfWtMRvLuTotjYd/6EFxpYaplTdY3u0tpcR8=
X-Gm-Message-State: AOJu0YysJ6bXlzNtVwmrTb+kj+sU2oE+LLfnKSeo72PI/LhZ8fBPDSpu
	paHWNbNrY140qSlWiDg2eMlPq4C62uMWe/ZPCxgDIASrP3BXCiGnN991ectiwrjb4Rm7ke140Xr
	0qLXBW0qnEUqzheif9JKISo/yYLk=
X-Google-Smtp-Source: AGHT+IF6aH+bYNqvga3Gl0sGvW+d1EEZTqeGYdfaA8mpHucMkdBKslrEwZ8d2MwpoDR1A6jIuuYOC86DZD1ilv41PUY=
X-Received: by 2002:ac2:5054:0:b0:52e:9cf0:69db with SMTP id
 2adb3069b0e04-5309b2c2ad0mr4910530e87.46.1722287280937; Mon, 29 Jul 2024
 14:08:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240729-topic-845_gpu_smmu-v1-1-8e372abbde41@kernel.org> <osxynb352ubxgcb5tv3u7mskkon23nmm3gxkfiiiqss5zp67jf@fv5d6bob2rgp>
In-Reply-To: <osxynb352ubxgcb5tv3u7mskkon23nmm3gxkfiiiqss5zp67jf@fv5d6bob2rgp>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 29 Jul 2024 14:07:49 -0700
Message-ID: <CAF6AEGuWULwrJDWW37nQhByTpc-2bBYVv3b_Ac6OCwaJ83Ed9w@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Work around SDM845 Adreno SMMU w/
 16K pages
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 1:14=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Mon, Jul 29, 2024 at 10:37:48AM GMT, Konrad Dybcio wrote:
> > From: Konrad Dybcio <konrad.dybcio@linaro.org>
> >
> > SDM845's Adreno SMMU is unique in that it actually advertizes support
> > for 16K (and 32M) pages, which doesn't hold for newer SoCs.
> >
> > This however, seems either broken in the hardware implementation, the
> > hypervisor middleware that abstracts the SMMU, or there's a bug in the
> > Linux kernel somewhere down the line that nobody managed to track down.
> >
> > Booting SDM845 with 16K page sizes and drm/msm results in:
> >
> > *** gpu fault: ttbr0=3D0000000000000000 iova=3D000100000000c000 dir=3DR=
EAD
> > type=3DTRANSLATION source=3DCP (0,0,0,0)
> >
> > right after loading the firmware. The GPU then starts spitting out
> > illegal intstruction errors, as it's quite obvious that it got a
> > bogus pointer.
> >
> > Hide 16K support on SDM845's Adreno SMMU to work around this.
> >
> > Reported-by: Sumit Semwal <sumit.semwal@linaro.org>
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> > There's a mismatch in sender/committer addresses but that's "fine":
> > https://lore.kernel.org/linux-usb/2024072734-scenic-unwilling-71ea@greg=
kh/
> > ---
> >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu=
/arm/arm-smmu/arm-smmu-qcom.c
> > index 36c6b36ad4ff..d25825c05817 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > @@ -338,6 +338,15 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_dev=
ice *smmu)
> >       return 0;
> >  }
> >
> > +static int qcom_adreno_smmuv2_cfg_probe(struct arm_smmu_device *smmu)
> > +{
> > +     /* SDM845 Adreno SMMU advertizes 16K pages support, but something=
 is broken */
> > +     if (of_device_is_compatible(smmu->dev->of_node, "qcom,sdm845-smmu=
-v2"))
> > +             smmu->features &=3D ~ARM_SMMU_FEAT_FMT_AARCH64_16K;
>
> Shouldn't we hide that uncoditionally as it's likely that none of v2
> Adreno SMMUs support 16k pages?

Hmm, that would be unfortunate to have the GPU not supporting the CPU
page size.  I guess we could still map 16k pages as multiple 4k pages,
but that is a bit sad..

BR,
-R

>
> > +
> > +     return 0;
> > +}
> > +
> >  static void qcom_smmu_write_s2cr(struct arm_smmu_device *smmu, int idx=
)
> >  {
> >       struct arm_smmu_s2cr *s2cr =3D smmu->s2crs + idx;
> > @@ -436,6 +445,7 @@ static const struct arm_smmu_impl sdm845_smmu_500_i=
mpl =3D {
> >
> >  static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl =3D {
> >       .init_context =3D qcom_adreno_smmu_init_context,
> > +     .cfg_probe =3D qcom_adreno_smmuv2_cfg_probe,
> >       .def_domain_type =3D qcom_smmu_def_domain_type,
> >       .alloc_context_bank =3D qcom_adreno_smmu_alloc_context_bank,
> >       .write_sctlr =3D qcom_adreno_smmu_write_sctlr,
> >
> > ---
> > base-commit: 931a3b3bccc96e7708c82b30b2b5fa82dfd04890
> > change-id: 20240726-topic-845_gpu_smmu-ab738f7a013c
> >
> > Best regards,
> > --
> > Konrad Dybcio <konradybcio@kernel.org>
> >
>
> --
> With best wishes
> Dmitry
