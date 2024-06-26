Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81FE19069C
	for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 19:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719430968; cv=none; b=T3YhF5y03RBGTq3R1vRgtdO+VlG5Ut2wwTM7Y+hELIgrpQHqyZrJmxDuCMwX5vcYvq70gGWM7GUudX0qrnNp+0felyBFqPjAaIPJXvzyOapFIpl8ACRSEV1AER6uyBFAjUNbrmk+Pljx/MVcOtBERFqmlKrKRI+4t6uJlEp4zFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719430968; c=relaxed/simple;
	bh=KnycliXpjTywgUB93eWlGGJIIzjJFqb1Qo/gsxBibeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qxwCcUlg9+krVVc3sjb9vfqj+juphS3kmoZ1hfkMDHIxYLnMnEX4880KPOgqHg7N9q5yWKlRK/zP2sV+dQLzc6pWLn+Ww09CaM3057Jje7BQhVy8LGeP+mGqcOLCXNfw/c00HM6JDZqJl6/49U/IZ3a05KJDMCS5ZH6UTdc4JA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtkUBnq7; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtkUBnq7"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6fe61793e2so315957466b.0
        for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 12:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719430965; x=1720035765; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XVjiSCKp6ff4yqYS16EKaOsJZe+5cWeRbw3meRHAO0=;
        b=mtkUBnq76KsVkpo/Nstd/ob4wXJWfQqISmO2MHr4kaA/b22xeoOr+cHUxfx2QsyJsB
         e1kBXafn6QgcQhROOnJEDrIME8ceJ2Tj/Qgbrpuq7YqMA+TBhuf0rK76gE2OCEP1zJ3L
         Blf0D3fEdnj3izY5Xf4nPTDX6UjyJiwvwr/5qzaBaEE6aAHsCH6LwvGrfHznHm8hD6Iw
         hINEvoOXEwn1rhgbAVbLu8nY0xdy1ENjBK5OOshDyUrkvnvQyJZoSb+KgBAvc+8w4ue4
         fY53Jyk8hvNUlq4KUvY5jIVKu6s7nBst0toy5nUYqgsRJ7henN5c5umlcVOmQT/FX/v6
         xbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719430965; x=1720035765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XVjiSCKp6ff4yqYS16EKaOsJZe+5cWeRbw3meRHAO0=;
        b=MuSCFCevzCKPqD1wPxaYWnwt7CAcUVdqoMdO9ksFupK2n24y3kFsk+Kpg+FhetITef
         AQhpuSly8kPvxTPA2kc4P/6GfsuRXCG521z7Lc83YMA5h4MI+pvd/mtUM7kFD9xSOa+V
         PSouDY9DEdQDaROg7P+YEdzoB6QCM0ZBScHt8CfbDb2BTBg/K8vvQozJ3Grg96kFshg+
         /QUsTiwx/isKvaI6RQDhajRLLxdxNN05N/Jwu60maeu+z+ATPrYqhGbGZWDvVzFBsBxZ
         6CSso2QwT7BvGcveKPqwl7vqMbSqCkIe3SSK1FXIW/uAC9XvXcxPK3TJdluMIuGKXEvt
         p8DQ==
X-Gm-Message-State: AOJu0YxZnqv1kgPYbc8QE4dnZ9km5SYtpBDbDSk09oez3yCO74NsDffx
	ZuozyEiRC6K0y3ZiMzMe33RVKdqiXg3tIZz3zOgl59YrjesvEjy0pG8ggrY8o5zO7Cw5byXiPqo
	5GNrCySyLfcz/5C2dEZIY4EYXXQo=
X-Google-Smtp-Source: AGHT+IHZ7+M0//vnr/yEEMWB1PM0XC1LdxSQZA17e33ejob9RSQ/62tBAze3GUi9mthGDUhd28M/H3hKfJbxg5iTTNo=
X-Received: by 2002:a50:d653:0:b0:57d:3b8:85e6 with SMTP id
 4fb4d7f45d1cf-57d4bddfba2mr9714346a12.39.1719430964871; Wed, 26 Jun 2024
 12:42:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240626163842.205631-1-robdclark@gmail.com> <CAN6iL-T8Bt1Gz+YrqTvMzBs=AYN4x67TQW4OqnU-nYSOcj2Sdw@mail.gmail.com>
In-Reply-To: <CAN6iL-T8Bt1Gz+YrqTvMzBs=AYN4x67TQW4OqnU-nYSOcj2Sdw@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 26 Jun 2024 12:42:31 -0700
Message-ID: <CAF6AEGv1Ufa4XjEsM4s=ZxoYdq+ijszk2woLu8oYLBLYkmE2KQ@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/arm-smmu: Pretty-print context fault related regs
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	Stephen Boyd <swboyd@chromium.org>, Robin Murphy <robin.murphy@arm.com>, 
	Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jerry Snitselaar <jsnitsel@redhat.com>, Rob Herring <robh@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Georgi Djakov <quic_c_gdjako@quicinc.com>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 12:08=E2=80=AFPM Pranjal Shrivastava <praan@google.=
com> wrote:
>
> Hi Rob,
>
>
> On Wed, Jun 26, 2024 at 10:08=E2=80=AFPM Rob Clark <robdclark@gmail.com> =
wrote:
> >
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Parse out the bitfields for easier-to-read fault messages.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> > I kept with the dev_err, which matches qcom_smmu_context_fault.  It is
> > only adding two extra lines, and it is ratelimited.
> >
> > I also converted qcom_smmu_context_fault() to use the helpers to do the
> > parsing, rather than more or less duplicating.
> >
> >  .../iommu/arm/arm-smmu/arm-smmu-qcom-debug.c  | 21 +++---
> >  drivers/iommu/arm/arm-smmu/arm-smmu.c         | 70 ++++++++++++++++++-
> >  drivers/iommu/arm/arm-smmu/arm-smmu.h         | 58 +++++++++------
> >  3 files changed, 110 insertions(+), 39 deletions(-)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c b/drivers=
/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
> > index 552199cbd9e2..ee7eab273e1a 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
> > @@ -429,22 +429,17 @@ irqreturn_t qcom_smmu_context_fault(int irq, void=
 *dev)
> >                 phys_addr_t phys_atos =3D qcom_smmu_verify_fault(smmu_d=
omain, iova, fsr);
> >
> >                 if (__ratelimit(&_rs)) {
> > +                       char buf[80];
>
> Super Nit: I'm not a fan of hardcoding the buffer size but I'm also not s=
ure
> if this makes a strong enough case for a macro definition. Any thoughts, =
anyone?
>
> > +
> >                         dev_err(smmu->dev,
> >                                 "Unhandled context fault: fsr=3D0x%x, i=
ova=3D0x%08lx, fsynr=3D0x%x, cbfrsynra=3D0x%x, cb=3D%d\n",
> >                                 fsr, iova, fsynr, cbfrsynra, idx);
> > -                       dev_err(smmu->dev,
> > -                               "FSR    =3D %08x [%s%s%s%s%s%s%s%s%s], =
SID=3D0x%x\n",
> > -                               fsr,
> > -                               (fsr & 0x02) ? "TF " : "",
> > -                               (fsr & 0x04) ? "AFF " : "",
> > -                               (fsr & 0x08) ? "PF " : "",
> > -                               (fsr & 0x10) ? "EF " : "",
> > -                               (fsr & 0x20) ? "TLBMCF " : "",
> > -                               (fsr & 0x40) ? "TLBLKF " : "",
> > -                               (fsr & 0x80) ? "MHF " : "",
> > -                               (fsr & 0x40000000) ? "SS " : "",
> > -                               (fsr & 0x80000000) ? "MULTI " : "",
> > -                               cbfrsynra);
> > +
> > +                       arm_smmu_parse_fsr(buf, fsr);
> > +                       dev_err(smmu->dev, "FSR: %s\n", buf);
> > +
> > +                       arm_smmu_parse_fsynr0(buf, fsynr);
> > +                       dev_err(smmu->dev, "FSYNR0: %s\n", buf);
> >
> >                         dev_err(smmu->dev,
> >                                 "soft iova-to-phys=3D%pa\n", &phys_soft=
);
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/=
arm-smmu/arm-smmu.c
> > index 87c81f75cf84..7f5ca75d5ebe 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > @@ -405,12 +405,67 @@ static const struct iommu_flush_ops arm_smmu_s2_t=
lb_ops_v1 =3D {
> >         .tlb_add_page   =3D arm_smmu_tlb_add_page_s2_v1,
> >  };
> >
> > +void arm_smmu_parse_fsr(char buf[80], u32 fsr)
> > +{
> > +       static const struct {
> > +               u32 mask;
> > +               const char *name;
> > +       } fsr_bits[] =3D {
> > +               { ARM_SMMU_CB_FSR_MULTI,  "MULTI"  },
> > +               { ARM_SMMU_CB_FSR_SS,     "SS"     },
> > +               { ARM_SMMU_CB_FSR_UUT,    "UUT"    },
> > +               { ARM_SMMU_CB_FSR_ASF,    "ASF"    },
> > +               { ARM_SMMU_CB_FSR_TLBLKF, "TLBLKF" },
> > +               { ARM_SMMU_CB_FSR_TLBMCF, "TLBMCF" },
> > +               { ARM_SMMU_CB_FSR_EF,     "EF"     },
> > +               { ARM_SMMU_CB_FSR_PF,     "PF"     },
> > +               { ARM_SMMU_CB_FSR_AFF,    "AFF"    },
> > +               { ARM_SMMU_CB_FSR_TF,     "TF"     },
> > +       };
> > +       char *p =3D buf;
> > +
> > +       p +=3D sprintf(p, "FORMAT=3D%u",
> > +                    (u32)FIELD_GET(ARM_SMMU_CB_FSR_FORMAT, fsr));
> > +
> > +       for (int i =3D 0; i < ARRAY_SIZE(fsr_bits); i++)
> > +               if (fsr & fsr_bits[i].mask)
> > +                       p +=3D sprintf(p, "|%s", fsr_bits[i].name);
> > +}
>
> Buffer overflow alert: I suggest passing the buffer size as an
> additional "size" parameter to the function.
> Based on that size parameter, we must ensure that `p` doesn't reach
> out of bounds.
> Maybe using snprintf() to limit the num of characters to the "size"
> parameter would make more sense.

I thought about this, but decided that, since nothing about the string
length is attacker controlled, and there were really only two users,
the simpler "just make the buffer big enough" approach would be fine.
It isn't like there will be a whole bunch more bitfields added.

Perhaps I should just add a #define for buf length, and a WARN_ON() if
that is exceeded.  That plus a selftest which calls both the fxns with
register value of ~0 should be enough to prevent any future change
from introducing an overflow.

BR,
-R

> > +
> > +void arm_smmu_parse_fsynr0(char buf[80], u32 fsynr)
>
> Ditto, for this function and also for the signatures in the .h file.
>
>
> > +{
> > +       static const struct {
> > +               u32 mask;
> > +               const char *name;
> > +       } fsynr0_bits[] =3D {
> > +               { ARM_SMMU_CB_FSYNR0_WNR,    "WNR"    },
> > +               { ARM_SMMU_CB_FSYNR0_PNU,    "PNU"    },
> > +               { ARM_SMMU_CB_FSYNR0_IND,    "IND"    },
> > +               { ARM_SMMU_CB_FSYNR0_NSATTR, "NSATTR" },
> > +               { ARM_SMMU_CB_FSYNR0_PTWF,   "PTWF"   },
> > +               { ARM_SMMU_CB_FSYNR0_AFR,    "AFR"    },
> > +       };
> > +       char *p =3D buf;
> > +
> > +       p +=3D sprintf(p, "S1CBNDX=3D%u",
> > +                    (u32)FIELD_GET(ARM_SMMU_CB_FSYNR0_S1CBNDX, fsynr))=
;
> > +
> > +       for (int i =3D 0; i < ARRAY_SIZE(fsynr0_bits); i++)
> > +               if (fsynr & fsynr0_bits[i].mask)
> > +                       p +=3D sprintf(p, "|%s", fsynr0_bits[i].name);
> > +
> > +       p +=3D sprintf(p, "|PLVL=3D%u",
> > +                    (u32)FIELD_GET(ARM_SMMU_CB_FSYNR0_PLVL, fsynr));
> > +}
> > +
> >  static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
> >  {
> >         u32 fsr, fsynr, cbfrsynra;
> >         unsigned long iova;
> >         struct arm_smmu_domain *smmu_domain =3D dev;
> >         struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> > +       static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
> > +                                     DEFAULT_RATELIMIT_BURST);
> >         int idx =3D smmu_domain->cfg.cbndx;
> >         int ret;
> >
> > @@ -423,13 +478,22 @@ static irqreturn_t arm_smmu_context_fault(int irq=
, void *dev)
> >         cbfrsynra =3D arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(id=
x));
> >
> >         ret =3D report_iommu_fault(&smmu_domain->domain, NULL, iova,
> > -               fsynr & ARM_SMMU_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU=
_FAULT_READ);
> > +               fsynr & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IO=
MMU_FAULT_READ);
> > +
> > +       if (ret =3D=3D -ENOSYS && __ratelimit(&rs)) {
> > +               char buf[80];
> >
> > -       if (ret =3D=3D -ENOSYS)
> > -               dev_err_ratelimited(smmu->dev,
> > +               dev_err(smmu->dev,
> >                 "Unhandled context fault: fsr=3D0x%x, iova=3D0x%08lx, f=
synr=3D0x%x, cbfrsynra=3D0x%x, cb=3D%d\n",
> >                             fsr, iova, fsynr, cbfrsynra, idx);
> >
> > +               arm_smmu_parse_fsr(buf, fsr);
> > +               dev_err(smmu->dev, "FSR: %s\n", buf);
> > +
> > +               arm_smmu_parse_fsynr0(buf, fsynr);
> > +               dev_err(smmu->dev, "FSYNR0: %s\n", buf);
> > +       }
> > +
> >         arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
> >         return IRQ_HANDLED;
> >  }
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/=
arm-smmu/arm-smmu.h
> > index 4765c6945c34..763ea52fca64 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> > @@ -196,34 +196,46 @@ enum arm_smmu_cbar_type {
> >  #define ARM_SMMU_CB_PAR_F              BIT(0)
> >
> >  #define ARM_SMMU_CB_FSR                        0x58
> > -#define ARM_SMMU_FSR_MULTI             BIT(31)
> > -#define ARM_SMMU_FSR_SS                        BIT(30)
> > -#define ARM_SMMU_FSR_UUT               BIT(8)
> > -#define ARM_SMMU_FSR_ASF               BIT(7)
> > -#define ARM_SMMU_FSR_TLBLKF            BIT(6)
> > -#define ARM_SMMU_FSR_TLBMCF            BIT(5)
> > -#define ARM_SMMU_FSR_EF                        BIT(4)
> > -#define ARM_SMMU_FSR_PF                        BIT(3)
> > -#define ARM_SMMU_FSR_AFF               BIT(2)
> > -#define ARM_SMMU_FSR_TF                        BIT(1)
> > -
> > -#define ARM_SMMU_FSR_IGN               (ARM_SMMU_FSR_AFF |            =
 \
> > -                                        ARM_SMMU_FSR_ASF |            =
 \
> > -                                        ARM_SMMU_FSR_TLBMCF |         =
 \
> > -                                        ARM_SMMU_FSR_TLBLKF)
> > -
> > -#define ARM_SMMU_FSR_FAULT             (ARM_SMMU_FSR_MULTI |          =
 \
> > -                                        ARM_SMMU_FSR_SS |             =
 \
> > -                                        ARM_SMMU_FSR_UUT |            =
 \
> > -                                        ARM_SMMU_FSR_EF |             =
 \
> > -                                        ARM_SMMU_FSR_PF |             =
 \
> > -                                        ARM_SMMU_FSR_TF |             =
 \
> > +#define ARM_SMMU_CB_FSR_MULTI          BIT(31)
> > +#define ARM_SMMU_CB_FSR_SS             BIT(30)
> > +#define ARM_SMMU_CB_FSR_FORMAT         GENMASK(10, 9)
> > +#define ARM_SMMU_CB_FSR_UUT            BIT(8)
> > +#define ARM_SMMU_CB_FSR_ASF            BIT(7)
> > +#define ARM_SMMU_CB_FSR_TLBLKF         BIT(6)
> > +#define ARM_SMMU_CB_FSR_TLBMCF         BIT(5)
> > +#define ARM_SMMU_CB_FSR_EF             BIT(4)
> > +#define ARM_SMMU_CB_FSR_PF             BIT(3)
> > +#define ARM_SMMU_CB_FSR_AFF            BIT(2)
> > +#define ARM_SMMU_CB_FSR_TF             BIT(1)
> > +
> > +void arm_smmu_parse_fsr(char buf[80], u32 fsr);
> > +
> > +#define ARM_SMMU_FSR_IGN               (ARM_SMMU_CB_FSR_AFF |         =
 \
> > +                                        ARM_SMMU_CB_FSR_ASF |         =
 \
> > +                                        ARM_SMMU_CB_FSR_TLBMCF |      =
 \
> > +                                        ARM_SMMU_CB_FSR_TLBLKF)
> > +
> > +#define ARM_SMMU_FSR_FAULT             (ARM_SMMU_CB_FSR_MULTI |       =
 \
> > +                                        ARM_SMMU_CB_FSR_SS |          =
 \
> > +                                        ARM_SMMU_CB_FSR_UUT |         =
 \
> > +                                        ARM_SMMU_CB_FSR_EF |          =
 \
> > +                                        ARM_SMMU_CB_FSR_PF |          =
 \
> > +                                        ARM_SMMU_CB_FSR_TF |          =
 \
> >                                          ARM_SMMU_FSR_IGN)
> >
> >  #define ARM_SMMU_CB_FAR                        0x60
> >
> >  #define ARM_SMMU_CB_FSYNR0             0x68
> > -#define ARM_SMMU_FSYNR0_WNR            BIT(4)
> > +#define ARM_SMMU_CB_FSYNR0_PLVL                GENMASK(1, 0)
> > +#define ARM_SMMU_CB_FSYNR0_WNR         BIT(4)
> > +#define ARM_SMMU_CB_FSYNR0_PNU         BIT(5)
> > +#define ARM_SMMU_CB_FSYNR0_IND         BIT(6)
> > +#define ARM_SMMU_CB_FSYNR0_NSATTR      BIT(8)
> > +#define ARM_SMMU_CB_FSYNR0_PTWF                BIT(10)
> > +#define ARM_SMMU_CB_FSYNR0_AFR         BIT(11)
> > +#define ARM_SMMU_CB_FSYNR0_S1CBNDX     GENMASK(23, 16)
> > +
> > +void arm_smmu_parse_fsynr0(char buf[80], u32 fsynr);
>
> Apart from the buffer overflow, everything else looks fine to me.
>
> >
> >  #define ARM_SMMU_CB_FSYNR1             0x6c
> >
> > --
> > 2.45.2
> >
