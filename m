Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E7216D9BA
	for <iommu@lists.linux.dev>; Mon,  1 Jul 2024 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863070; cv=none; b=NvN4HI+NBRzLEuRmbwygNvZpkvf9uljMbcQUc3PdztjbdS6WkHOb0AbX6r+LVaRDR57x7WNq2s+o4sTUzm0BM+WWqvVp0GHFm3+c6V3ORozl9DuHe87NM/Xy2s9vdhskPX7UURGhozniVVuhAHJcQvm5HfTvLbAks3o3Gh8Gtrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863070; c=relaxed/simple;
	bh=V+wB/ltGBrLU9N/H/am14HG/PuGa0tq8Vu6/n7Sz1DI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEQuUL8QuXhbAJG2TsjD5QBOQ6dMxg7Ig6RWUqwlwBRWvQ56KBers18uSnbMx0odOXi9wbonfSAOK0ChrQxuAOO0A4xO/t8uUvg54zsIDlwp14WyeeZN1lUFVbNMv1H3IhsCMzqZ4MWNpkGj6nWd9Z1hNVy+Q8aVdLFWVtpcNfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4GGGbgiL; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4GGGbgiL"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57d00a51b71so11044a12.0
        for <iommu@lists.linux.dev>; Mon, 01 Jul 2024 12:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719863067; x=1720467867; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2c/PpBc8IIOCEBBeHe6Yjk+A3PKmtwznWMLX77MwI0=;
        b=4GGGbgiL9krPr2oKNY8G1202ye7pNiK3L3NWZ4bNsK8y/T2PRoHvvhiPbwkV9z7aGm
         0MJ3ayjHMD359l+niLiD9Ii8BhX2Smf71V+soOa5iYpT3YOCZibMVPfFmDv0v/+Vl326
         QK5xcLGf2Ia5qb1UTyffU6AhQpRvlhhD3xoiLxEqICzDR82eA1zpJOXuddcN8qoJCQpl
         F6UpxIZAZwXGASr5+3DQ2e0KevzniUM6mCxW8qfRhLNvzIU2Ap1WOskjQSoc5py7JaL5
         WnRkLC5Nh5jfvZXteYXm5lRQKxDes2X88tAjE82eiAIDQ9v/qG9dD5mfwcgDFX8ss7Bi
         gg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863067; x=1720467867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2c/PpBc8IIOCEBBeHe6Yjk+A3PKmtwznWMLX77MwI0=;
        b=GxqQPJd4MDLpQ59eKs+pKbsYqBuw0/J5oUN9hkCZXmUjNQ0lw9Mc0d2G4eehm1JkPI
         qAbkOQZw6b+BHsm7P7a2lWcjr2xDTiSPD/SdEjQRRoZHfn7OzdWyQYG3KR5FefGaE6Bb
         7i5s4wndYZ8fK8vSRkiwdcPcxCof8rAUP7zvL7Y+mr62VsP4+mwgGbb7UEZGW2mOdTep
         u3V1ET0Jwxcb8QDoRt3cFE27Mx9sjDSbFPBfN++jWxx/yGvXXCC0qHZgAJFDU+O5e82T
         wsQTiy9drP+lNNhsZplyDE0ceZUdAUy0phUa20PWjchjrJVnKDsigGYriRFxEnZUXBn/
         2UEg==
X-Gm-Message-State: AOJu0YzZAj9y5f2lsYGBOSOD/HH/m9+U8rEzWc0nTHsuWEOabyBoV47n
	j6PFGCS2RR3sInbjClOEHG3vyqHDUIpihfgqy5Czc8d9QB2hecN2+qrGg5N/Z1pClH6iWGOyOfl
	judpnpuR4aDXuJl2ZXdAKLNNWwxKkm3Bk8lvN
X-Google-Smtp-Source: AGHT+IGXyqeBH6uxaqA2835dXMeshEUVmsgRwXvBckmfmlcoRp+e/9eTxFThJp5T0ctjsPZfrI27AIoBuljktqA1qkM=
X-Received: by 2002:a50:9f83:0:b0:58b:15e4:d786 with SMTP id
 4fb4d7f45d1cf-58b15e4d929mr83573a12.5.1719863066884; Mon, 01 Jul 2024
 12:44:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240701162025.375134-1-robdclark@gmail.com> <20240701162025.375134-4-robdclark@gmail.com>
In-Reply-To: <20240701162025.375134-4-robdclark@gmail.com>
From: Pranjal Shrivastava <praan@google.com>
Date: Tue, 2 Jul 2024 01:14:14 +0530
Message-ID: <CAN6iL-Sc5mvFd1_PydZZ8m1VS7KtPHtO5QpyX38n3OcGSj9b_A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu: Pretty-print context fault related regs
To: Rob Clark <robdclark@gmail.com>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	Stephen Boyd <swboyd@chromium.org>, Robin Murphy <robin.murphy@arm.com>, 
	Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jerry Snitselaar <jsnitsel@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Georgi Djakov <quic_c_gdjako@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 9:50=E2=80=AFPM Rob Clark <robdclark@gmail.com> wrot=
e:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Parse out the bitfields for easier-to-read fault messages.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  .../iommu/arm/arm-smmu/arm-smmu-qcom-debug.c  | 52 +++++---------
>  drivers/iommu/arm/arm-smmu/arm-smmu.c         | 70 +++++++++++++++----
>  drivers/iommu/arm/arm-smmu/arm-smmu.h         | 21 ++++++
>  3 files changed, 92 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c b/drivers/i=
ommu/arm/arm-smmu/arm-smmu-qcom-debug.c
> index 681fbdfc325d..ef93f825f11f 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
> @@ -383,64 +383,44 @@ irqreturn_t qcom_smmu_context_fault(int irq, void *=
dev)
>         struct arm_smmu_domain *smmu_domain =3D dev;
>         struct io_pgtable_ops *ops =3D smmu_domain->pgtbl_ops;
>         struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> -       u32 fsr, fsynr, cbfrsynra, resume =3D 0;
> +       struct arm_smmu_context_fault_info cfi;
> +       u32 resume =3D 0;
>         int idx =3D smmu_domain->cfg.cbndx;
>         phys_addr_t phys_soft;
> -       unsigned long iova;
>         int ret, tmp;
>
>         static DEFINE_RATELIMIT_STATE(_rs,
>                                       DEFAULT_RATELIMIT_INTERVAL,
>                                       DEFAULT_RATELIMIT_BURST);
>
> -       fsr =3D arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
> -       if (!(fsr & ARM_SMMU_CB_FSR_FAULT))
> -               return IRQ_NONE;
> +       arm_smmu_read_context_fault_info(smmu, idx, &cfi);
>
> -       fsynr =3D arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSYNR0);
> -       iova =3D arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_FAR);
> -       cbfrsynra =3D arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(idx)=
);
> +       if (!(cfi.fsr & ARM_SMMU_CB_FSR_FAULT))
> +               return IRQ_NONE;
>
>         if (list_empty(&tbu_list)) {
> -               ret =3D report_iommu_fault(&smmu_domain->domain, NULL, io=
va,
> -                                        fsynr & ARM_SMMU_CB_FSYNR0_WNR ?=
 IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
> +               ret =3D report_iommu_fault(&smmu_domain->domain, NULL, cf=
i.iova,
> +                                        cfi.fsynr & ARM_SMMU_CB_FSYNR0_W=
NR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
>
>                 if (ret =3D=3D -ENOSYS)
> -                       dev_err_ratelimited(smmu->dev,
> -                                           "Unhandled context fault: fsr=
=3D0x%x, iova=3D0x%08lx, fsynr=3D0x%x, cbfrsynra=3D0x%x, cb=3D%d\n",
> -                                           fsr, iova, fsynr, cbfrsynra, =
idx);
> +                       arm_smmu_print_context_fault_info(smmu, idx, &cfi=
);
>
> -               arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
> +               arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, cfi.fsr);
>                 return IRQ_HANDLED;
>         }
>
> -       phys_soft =3D ops->iova_to_phys(ops, iova);
> +       phys_soft =3D ops->iova_to_phys(ops, cfi.iova);
>
> -       tmp =3D report_iommu_fault(&smmu_domain->domain, NULL, iova,
> -                                fsynr & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_F=
AULT_WRITE : IOMMU_FAULT_READ);
> +       tmp =3D report_iommu_fault(&smmu_domain->domain, NULL, cfi.iova,
> +                                cfi.fsynr & ARM_SMMU_CB_FSYNR0_WNR ? IOM=
MU_FAULT_WRITE : IOMMU_FAULT_READ);
>         if (!tmp || tmp =3D=3D -EBUSY) {
>                 ret =3D IRQ_HANDLED;
>                 resume =3D ARM_SMMU_RESUME_TERMINATE;
>         } else {
> -               phys_addr_t phys_atos =3D qcom_smmu_verify_fault(smmu_dom=
ain, iova, fsr);
> +               phys_addr_t phys_atos =3D qcom_smmu_verify_fault(smmu_dom=
ain, cfi.iova, cfi.fsr);
>
>                 if (__ratelimit(&_rs)) {
> -                       dev_err(smmu->dev,
> -                               "Unhandled context fault: fsr=3D0x%x, iov=
a=3D0x%08lx, fsynr=3D0x%x, cbfrsynra=3D0x%x, cb=3D%d\n",
> -                               fsr, iova, fsynr, cbfrsynra, idx);
> -                       dev_err(smmu->dev,
> -                               "FSR    =3D %08x [%s%s%s%s%s%s%s%s%s], SI=
D=3D0x%x\n",
> -                               fsr,
> -                               (fsr & 0x02) ? "TF " : "",
> -                               (fsr & 0x04) ? "AFF " : "",
> -                               (fsr & 0x08) ? "PF " : "",
> -                               (fsr & 0x10) ? "EF " : "",
> -                               (fsr & 0x20) ? "TLBMCF " : "",
> -                               (fsr & 0x40) ? "TLBLKF " : "",
> -                               (fsr & 0x80) ? "MHF " : "",
> -                               (fsr & 0x40000000) ? "SS " : "",
> -                               (fsr & 0x80000000) ? "MULTI " : "",
> -                               cbfrsynra);
> +                       arm_smmu_print_context_fault_info(smmu, idx, &cfi=
);
>
>                         dev_err(smmu->dev,
>                                 "soft iova-to-phys=3D%pa\n", &phys_soft);
> @@ -474,10 +454,10 @@ irqreturn_t qcom_smmu_context_fault(int irq, void *=
dev)
>          */
>         if (tmp !=3D -EBUSY) {
>                 /* Clear the faulting FSR */
> -               arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
> +               arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, cfi.fsr);
>
>                 /* Retry or terminate any stalled transactions */
> -               if (fsr & ARM_SMMU_CB_FSR_SS)
> +               if (cfi.fsr & ARM_SMMU_CB_FSR_SS)
>                         arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_RESUME, =
resume);
>         }
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/ar=
m-smmu/arm-smmu.c
> index 23cf91ac409b..79ec911ae151 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -405,32 +405,72 @@ static const struct iommu_flush_ops arm_smmu_s2_tlb=
_ops_v1 =3D {
>         .tlb_add_page   =3D arm_smmu_tlb_add_page_s2_v1,
>  };
>
> +
> +void arm_smmu_read_context_fault_info(struct arm_smmu_device *smmu, int =
idx,
> +                                     struct arm_smmu_context_fault_info =
*cfi)
> +{
> +       cfi->iova =3D arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_FAR);
> +       cfi->fsr =3D arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
> +       cfi->fsynr =3D arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSYNR0);
> +       cfi->cbfrsynra =3D arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA=
(idx));
> +}
> +
> +void arm_smmu_print_context_fault_info(struct arm_smmu_device *smmu, int=
 idx,
> +                                      const struct arm_smmu_context_faul=
t_info *cfi)
> +{
> +       dev_dbg(smmu->dev,
> +               "Unhandled context fault: fsr=3D0x%x, iova=3D0x%08lx, fsy=
nr=3D0x%x, cbfrsynra=3D0x%x, cb=3D%d\n",
> +               cfi->fsr, cfi->iova, cfi->fsynr, cfi->cbfrsynra, idx);
> +
> +       dev_err(smmu->dev, "FSR    =3D %08x [%s%sFormat=3D%u%s%s%s%s%s%s%=
s%s], SID=3D0x%x\n",
> +               cfi->fsr,
> +               (cfi->fsr & ARM_SMMU_CB_FSR_MULTI)  ? "MULTI " : "",
> +               (cfi->fsr & ARM_SMMU_CB_FSR_SS)     ? "SS " : "",
> +               (u32)FIELD_GET(ARM_SMMU_CB_FSR_FORMAT, cfi->fsr),
> +               (cfi->fsr & ARM_SMMU_CB_FSR_UUT)    ? " UUT" : "",
> +               (cfi->fsr & ARM_SMMU_CB_FSR_ASF)    ? " ASF" : "",
> +               (cfi->fsr & ARM_SMMU_CB_FSR_TLBLKF) ? " TLBLKF" : "",
> +               (cfi->fsr & ARM_SMMU_CB_FSR_TLBMCF) ? " TLBMCF" : "",
> +               (cfi->fsr & ARM_SMMU_CB_FSR_EF)     ? " EF" : "",
> +               (cfi->fsr & ARM_SMMU_CB_FSR_PF)     ? " PF" : "",
> +               (cfi->fsr & ARM_SMMU_CB_FSR_AFF)    ? " AFF" : "",
> +               (cfi->fsr & ARM_SMMU_CB_FSR_TF)     ? " TF" : "",
> +               cfi->cbfrsynra);
> +
> +       dev_err(smmu->dev, "FSYNR0 =3D %08x [S1CBNDX=3D%u%s%s%s%s%s%s PLV=
L=3D%u]\n",
> +               cfi->fsynr,
> +               (u32)FIELD_GET(ARM_SMMU_CB_FSYNR0_S1CBNDX, cfi->fsynr),
> +               (cfi->fsynr & ARM_SMMU_CB_FSYNR0_AFR) ? " AFR" : "",
> +               (cfi->fsynr & ARM_SMMU_CB_FSYNR0_PTWF) ? " PTWF" : "",
> +               (cfi->fsynr & ARM_SMMU_CB_FSYNR0_NSATTR) ? " NSATTR" : ""=
,
> +               (cfi->fsynr & ARM_SMMU_CB_FSYNR0_IND) ? " IND" : "",
> +               (cfi->fsynr & ARM_SMMU_CB_FSYNR0_PNU) ? " PNU" : "",
> +               (cfi->fsynr & ARM_SMMU_CB_FSYNR0_WNR) ? " WNR" : "",
> +               (u32)FIELD_GET(ARM_SMMU_CB_FSYNR0_PLVL, cfi->fsynr));
> +}
> +
>  static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>  {
> -       u32 fsr, fsynr, cbfrsynra;
> -       unsigned long iova;
> +       struct arm_smmu_context_fault_info cfi;
>         struct arm_smmu_domain *smmu_domain =3D dev;
>         struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> +       static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
> +                                     DEFAULT_RATELIMIT_BURST);
>         int idx =3D smmu_domain->cfg.cbndx;
>         int ret;
>
> -       fsr =3D arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
> -       if (!(fsr & ARM_SMMU_CB_FSR_FAULT))
> -               return IRQ_NONE;
> +       arm_smmu_read_context_fault_info(smmu, idx, &cfi);
>
> -       fsynr =3D arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSYNR0);
> -       iova =3D arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_FAR);
> -       cbfrsynra =3D arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(idx)=
);
> +       if (!(cfi.fsr & ARM_SMMU_CB_FSR_FAULT))
> +               return IRQ_NONE;
>
> -       ret =3D report_iommu_fault(&smmu_domain->domain, NULL, iova,
> -               fsynr & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMM=
U_FAULT_READ);
> +       ret =3D report_iommu_fault(&smmu_domain->domain, NULL, cfi.iova,
> +               cfi.fsynr & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE : =
IOMMU_FAULT_READ);
>
> -       if (ret =3D=3D -ENOSYS)
> -               dev_err_ratelimited(smmu->dev,
> -               "Unhandled context fault: fsr=3D0x%x, iova=3D0x%08lx, fsy=
nr=3D0x%x, cbfrsynra=3D0x%x, cb=3D%d\n",
> -                           fsr, iova, fsynr, cbfrsynra, idx);
> +       if (ret =3D=3D -ENOSYS && __ratelimit(&rs))
> +               arm_smmu_print_context_fault_info(smmu, idx, &cfi);
>
> -       arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
> +       arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, cfi.fsr);
>         return IRQ_HANDLED;
>  }
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/ar=
m-smmu/arm-smmu.h
> index b04a00126a12..e2aeb511ae90 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -198,6 +198,7 @@ enum arm_smmu_cbar_type {
>  #define ARM_SMMU_CB_FSR                        0x58
>  #define ARM_SMMU_CB_FSR_MULTI          BIT(31)
>  #define ARM_SMMU_CB_FSR_SS             BIT(30)
> +#define ARM_SMMU_CB_FSR_FORMAT         GENMASK(10, 9)
>  #define ARM_SMMU_CB_FSR_UUT            BIT(8)
>  #define ARM_SMMU_CB_FSR_ASF            BIT(7)
>  #define ARM_SMMU_CB_FSR_TLBLKF         BIT(6)
> @@ -223,7 +224,14 @@ enum arm_smmu_cbar_type {
>  #define ARM_SMMU_CB_FAR                        0x60
>
>  #define ARM_SMMU_CB_FSYNR0             0x68
> +#define ARM_SMMU_CB_FSYNR0_PLVL                GENMASK(1, 0)
>  #define ARM_SMMU_CB_FSYNR0_WNR         BIT(4)
> +#define ARM_SMMU_CB_FSYNR0_PNU         BIT(5)
> +#define ARM_SMMU_CB_FSYNR0_IND         BIT(6)
> +#define ARM_SMMU_CB_FSYNR0_NSATTR      BIT(8)
> +#define ARM_SMMU_CB_FSYNR0_PTWF                BIT(10)
> +#define ARM_SMMU_CB_FSYNR0_AFR         BIT(11)
> +#define ARM_SMMU_CB_FSYNR0_S1CBNDX     GENMASK(23, 16)
>
>  #define ARM_SMMU_CB_FSYNR1             0x6c
>
> @@ -533,4 +541,17 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct a=
rm_smmu_device *smmu);
>  void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx);
>  int arm_mmu500_reset(struct arm_smmu_device *smmu);
>
> +struct arm_smmu_context_fault_info {
> +       unsigned long iova;
> +       u32 fsr;
> +       u32 fsynr;
> +       u32 cbfrsynra;
> +};

Super Nit: (non-block) Let's define this with the structs above.
Right below struct arm_smmu_master_cfg.

> +
> +void arm_smmu_read_context_fault_info(struct arm_smmu_device *smmu, int =
idx,
> +                                     struct arm_smmu_context_fault_info =
*cfi);
> +
> +void arm_smmu_print_context_fault_info(struct arm_smmu_device *smmu, int=
 idx,
> +                                      const struct arm_smmu_context_faul=
t_info *cfi);
> +
>  #endif /* _ARM_SMMU_H */
> --
> 2.45.2
>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
