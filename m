Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF2A6F505
	for <iommu@lists.linux.dev>; Mon, 17 Jun 2024 10:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718620039; cv=none; b=LyAA075AK91SYqL4KiJ4qBqLOAKvvCzPxj3/SmtMSc2n22L2pKZS24koxbMy/ydbcjRB2bhLqYE3YL0NYrN2zqXjg2QU91qSFuJH2qMLbLGAl0GcYtzR0W6mmbTpYiUL81nMrFRw+SpJWUW/BPhbgh7hFqy6R5usaarD9wfWXAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718620039; c=relaxed/simple;
	bh=SvwAskc/fCFbqGp3xdpej0VX4LFAyKSwyjET0MIsa04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ig+egyZD3aBE8pb6KthOD1FLs65dP35e1UddhXVFMlsiHJZ3ECb5eETUCGeYlDYKIY3m/I5evto6/mz2jfKCcP09U9aOolsEvdCUEBh0vSoqzmjyWxjMDsXm7J0Hkx4fzoqHE25vE+6uXeu5ACyh9h76l/atpK6YWcMqTLqm6XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bYq9TDaa; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bYq9TDaa"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57c8bd6b655so15467a12.0
        for <iommu@lists.linux.dev>; Mon, 17 Jun 2024 03:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718620036; x=1719224836; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97HNlrom0vmgCUPq2mVyJqaT77fVYxrQT7MRjlCumz4=;
        b=bYq9TDaaCLSmUNgl7E1pmHaSgG+5oQaSg/WtGqBgrzDnnLXZpVP/hlJknFHW7UHGss
         kdaEg/Pl566AfD94PLJL1isMrGMoMC7EW80RQCs1kt9+A7ThULj0Zp0UecaPyaIt0mAV
         LrZG+Mvlkfxurlka/B2HsSrsHz4vA6fKAPFaNvwQ3RxjPpHizSvxy2sUwUEKxp1qw7Z/
         pliSGxfc8fzDcCLKZAXmdpZUyKU8AxcBLRKwsR1jxDd6ahEqm8AzeG38yFknOIhmNGQR
         SLr0WsF/6yXLkHX3yg2GXogCOOe+RHDChmRyxO0b7pC3fbd1y2yFfVZT74HvaDs8WDqk
         3IfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718620036; x=1719224836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97HNlrom0vmgCUPq2mVyJqaT77fVYxrQT7MRjlCumz4=;
        b=YobEGIRN7ADsXY7qA2coXpByJ6mWu2Avpxds7a7ayixYvA2sH9g1wS03P06VHy03og
         4B0/7jIH23jVMmWrstxLvCN+fkexMGrDqEwYnJ56jJMVXxWmGOFtlUUWsFf5BV7PnOQM
         2PtZvMGOnc48O82UW8kE13rVFfKwfMfT/XXlnzFgluznekuwbZtnQqFEBXdnHRDDwftp
         OdUzUfnoGPnyKWePF5XBPyeBnpV0i2ckAMie7FWxIVZ7JPmqKKUDgvrCXlR1B8tjpYOx
         RG5sf/Ukb8xIWWq+vOPGNYgaIJlnlv8aFtEw+W8QZ89c20mokCckd3/pC46Ez7rW/CZo
         hO7Q==
X-Gm-Message-State: AOJu0Yw8OEqe7RhCBdSWMwEF2nRmyfm7GIJsoVJGvTyeHEXqrGIjbzaD
	P5XMZEGqnrdERfEhodBeNxsQ9U1D6gQ1fdHL8c3f4GaHAFG1RcT39msp5UW6p7/Ur8MCWoFu5zC
	MnHzTqBfh0ok/L52kvuC5c3IRkbh09mVLiTPs
X-Google-Smtp-Source: AGHT+IE6YBCU6PK9TX7WgOKq154u5fmiFEOZ+kbbMuOv/cOg6c5dK4O+QtvjUVBauAMglII7sNP483BUPy+TaGxyVb8=
X-Received: by 2002:a05:6402:50d2:b0:57c:cfa9:837b with SMTP id
 4fb4d7f45d1cf-57ccfa98704mr158097a12.0.1718620035876; Mon, 17 Jun 2024
 03:27:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240604150136.493962-1-robdclark@gmail.com>
In-Reply-To: <20240604150136.493962-1-robdclark@gmail.com>
From: Pranjal Shrivastava <praan@google.com>
Date: Mon, 17 Jun 2024 15:57:04 +0530
Message-ID: <CAN6iL-Qz5--_bE=s8DKMtZFLJuNZca13ageGn48n4W7EKLUEUg@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu: Pretty-print context fault related regs
To: Rob Clark <robdclark@gmail.com>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	Stephen Boyd <swboyd@chromium.org>, Rob Clark <robdclark@chromium.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jerry Snitselaar <jsnitsel@redhat.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,
On Tue, Jun 4, 2024 at 8:32=E2=80=AFPM Rob Clark <robdclark@gmail.com> wrot=
e:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Parse out the bitfields for easier-to-read fault messages.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> Stephen was wanting easier to read fault messages.. so I typed this up.
>
> Resend with the new iommu list address
>
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 53 +++++++++++++++++++++++++--
>  drivers/iommu/arm/arm-smmu/arm-smmu.h |  5 +++
>  2 files changed, 54 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/ar=
m-smmu/arm-smmu.c
> index c572d877b0e1..06712d73519c 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -411,6 +411,8 @@ static irqreturn_t arm_smmu_context_fault(int irq, vo=
id *dev)
>         unsigned long iova;
>         struct arm_smmu_domain *smmu_domain =3D dev;
>         struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> +       static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
> +                                     DEFAULT_RATELIMIT_BURST);
>         int idx =3D smmu_domain->cfg.cbndx;
>         int ret;
>
> @@ -425,10 +427,53 @@ static irqreturn_t arm_smmu_context_fault(int irq, =
void *dev)
>         ret =3D report_iommu_fault(&smmu_domain->domain, NULL, iova,
>                 fsynr & ARM_SMMU_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_F=
AULT_READ);
>
> -       if (ret =3D=3D -ENOSYS)
> -               dev_err_ratelimited(smmu->dev,
> -               "Unhandled context fault: fsr=3D0x%x, iova=3D0x%08lx, fsy=
nr=3D0x%x, cbfrsynra=3D0x%x, cb=3D%d\n",
> -                           fsr, iova, fsynr, cbfrsynra, idx);
> +       if (ret =3D=3D -ENOSYS && __ratelimit(&rs)) {
> +               static const struct {
> +                       u32 mask; const char *name;
> +               } fsr_bits[] =3D {
> +                       { ARM_SMMU_FSR_MULTI,  "MULTI" },
> +                       { ARM_SMMU_FSR_SS,     "SS"    },
> +                       { ARM_SMMU_FSR_UUT,    "UUT"   },
> +                       { ARM_SMMU_FSR_ASF,    "ASF"   },
> +                       { ARM_SMMU_FSR_TLBLKF, "TLBLKF" },
> +                       { ARM_SMMU_FSR_TLBMCF, "TLBMCF" },
> +                       { ARM_SMMU_FSR_EF,     "EF"     },
> +                       { ARM_SMMU_FSR_PF,     "PF"     },
> +                       { ARM_SMMU_FSR_AFF,    "AFF"    },
> +                       { ARM_SMMU_FSR_TF,     "TF"     },

I think we are missing to log the translation scheme i.e. `Format
bits[10:9]` field of this register as per the SMMUv2 spec. Maybe add
that too?

> +               }, fsynr0_bits[] =3D {
> +                       { ARM_SMMU_FSYNR0_WNR,    "WNR"    },
> +                       { ARM_SMMU_FSYNR0_PNU,    "PNU"    },
> +                       { ARM_SMMU_FSYNR0_IND,    "IND"    },
> +                       { ARM_SMMU_FSYNR0_NSATTR, "NSATTR" },
> +                       { ARM_SMMU_FSYNR0_PTWF,   "PTWF"   },
> +                       { ARM_SMMU_FSYNR0_AFR,    "AFR"    },
> +               };
> +
> +               pr_err("%s %s: Unhandled context fault: fsr=3D0x%x (",
> +                      dev_driver_string(smmu->dev), dev_name(smmu->dev),=
 fsr);
> +
> +               for (int i =3D 0, n =3D 0; i < ARRAY_SIZE(fsr_bits); i++)=
 {
> +                       if (fsr & fsr_bits[i].mask) {
> +                               pr_cont("%s%s", (n > 0) ? "|" : "", fsr_b=
its[i].name);
> +                               n++;
> +                       }
> +               }

Nit: Maybe add a line-wrap here after logging the iova?
Not trying to sound like a terminal geek, but a full log with pr_cont
could get very long (> 80 characters).
So, let's log fsr & iova in one line, fsynr and others in the next.

> +
> +               pr_cont("), iova=3D0x%08lx, fsynr=3D0x%x (S1CBNDX=3D%u", =
iova, fsynr,
> +                       (fsynr >> 16) & 0xff);
> +
> +               for (int i =3D 0; i < ARRAY_SIZE(fsynr0_bits); i++) {
> +                       if (fsynr & fsynr0_bits[i].mask) {
> +                               pr_cont("|%s", fsynr0_bits[i].name);
> +                       }
> +               }
> +
> +               pr_cont("|PLVL=3D%u), cbfrsynra=3D0x%x, cb=3D%d\n",
> +                       fsynr & 0x3,   /* FSYNR0.PLV */
> +                       cbfrsynra, idx);
> +
> +       }
>
>         arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
>         return IRQ_HANDLED;
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/ar=
m-smmu/arm-smmu.h
> index 836ed6799a80..3b051273718b 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -223,6 +223,11 @@ enum arm_smmu_cbar_type {
>
>  #define ARM_SMMU_CB_FSYNR0             0x68
>  #define ARM_SMMU_FSYNR0_WNR            BIT(4)
> +#define ARM_SMMU_FSYNR0_PNU            BIT(5)
> +#define ARM_SMMU_FSYNR0_IND            BIT(6)
> +#define ARM_SMMU_FSYNR0_NSATTR         BIT(8)
> +#define ARM_SMMU_FSYNR0_PTWF           BIT(10)
> +#define ARM_SMMU_FSYNR0_AFR            BIT(11)
>

Nit: Worth prefixing these with "CB_" i.e. "ARM_SMMU_CB_FSYNR0_* " to
avoid confusion with "GFSYNR0".

>  #define ARM_SMMU_CB_FSYNR1             0x6c
>
> --
> 2.45.1
>
>
Thanks,
Pranjal
