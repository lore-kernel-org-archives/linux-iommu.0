Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7991798F
	for <iommu@lists.linux.dev>; Mon, 17 Jun 2024 16:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718641152; cv=none; b=EMP/z9WzkvEbOrbx9Tra/4QUWT1yBaHCu42JppApvHKYyWj8LtkTMYH+Ddxr9AFZBHuCdCbxubaX3aK/69c3ARvso/Wa6xTW3ggpwbQqb+N1dZAU3lG4ocbQj6FmDCO6gNgMpKWHLeZ3D5Tou7JWCdddHLtIJ7lbmeLoclL6k74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718641152; c=relaxed/simple;
	bh=FmhPQfQ5feq6Pdtc9ii1dfPikGHb7AG/Rda3yIBJEP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkLE27T+5voTR+04vtSU3of0/CySETwPWdD9E97lYFfpzF3QsMcu/BkgkDhnjKjN8x1kQ1WlSFtWiN0+v1KqBkKgE9AwQgSRspKotrlHTHCZsQUFu0fkGWqprTx30SIqrrGsgVPaSI9n8dDNtR1IgqhcgTQhxsrsifZDlz55Lcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ro+tNCsi; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ro+tNCsi"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57cc1c00ba6so3708839a12.1
        for <iommu@lists.linux.dev>; Mon, 17 Jun 2024 09:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718641148; x=1719245948; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4f+Dl0F9St/jKePz11795biSESZ4u70V8qkqWg98PCo=;
        b=Ro+tNCsiK3vyxnWoeyrJ+S5ASUwbSWmPb7v9aLu8MlHPuHzD0+mOZmefB8sNzpF96N
         qMXQPWr5aJW4SlNjJUKS64Dc3pKJlCRduZOcRnMF7pXYQ+HxD7YUvgrwRrTvpdetVZXk
         qStS219eeRuBk7Nnmik1L7qZUN3BXV0RRSMDV5TAmWlLMhi0EnxVI6gvd1LRd2kjT8n1
         fsEPcsyI+ogJSQQJbD6wWXWRYoQH1fwbJAOk55WD95uGANubkEm5tN6e6r3BfTJ9tYdm
         Egq1MdFpYiiGibDxP7T+rX/AxQR2Dd5N9UNMGewzXAev2dIe2v1vY9092swdoYQFkxpq
         vUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718641148; x=1719245948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4f+Dl0F9St/jKePz11795biSESZ4u70V8qkqWg98PCo=;
        b=ipF7Pm2dpLRO4wZNI/3Yorqe//QyCBTJC07eN559vLiZ84YG1yMNgnDfPbhqWoAWIg
         ckmx7g/sMF971zRnAXHpGIArDm58TXqN4WS95hhsNNSbmsoAxIRquGUheIx0VaRuWqo5
         sUpM3MGClJUNj7IF9WVt4rTb9mVW1vsfMj5KpptQo+imQQY+ux+mY0opZ262ZaEkcT8/
         RE3jiem/BCxay1OSNuX4uYtdVHTx+VVHvb5k0ZACBgP61GJOfIWyJ9mmquUlHJqBu5Wy
         ylFF3UWlHDaXgOetzngKX5J/XEMg2rBtwy0CQtOe8qmE1UZWLFVwDdEcydTtgBtTonZK
         1nQg==
X-Gm-Message-State: AOJu0YzzDm2s2hUBLgSKYSTj73DggJw/SxMnMJhgwltYtwW7N0y4nOwb
	fP0dEvi7/RVFrLNXb8KDKW3WhRFP6U991+2//r5aeltFpf+3LflAUMt8d3aT1T02j+IcZPNAYqw
	IoG3aLOIP7S/0zxwxOqn759c3O68=
X-Google-Smtp-Source: AGHT+IHqZzEdtlyMkCNsseF68BDJPs2czZokbGtFxCUl3W3wkWnizzsiBI7L1361ucsGCA7fQDzl+O8HU+dijyHkEPk=
X-Received: by 2002:a50:cd49:0:b0:57c:a701:2311 with SMTP id
 4fb4d7f45d1cf-57cbd6c6e20mr7027701a12.26.1718641147869; Mon, 17 Jun 2024
 09:19:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240604150136.493962-1-robdclark@gmail.com> <6f97a4b4-cdbe-466c-80d4-adc8da305f75@arm.com>
In-Reply-To: <6f97a4b4-cdbe-466c-80d4-adc8da305f75@arm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 17 Jun 2024 09:18:55 -0700
Message-ID: <CAF6AEGv+Ge2SD4=j1QhXfG+KkOzvFM+LieCqKuM20YL8gp5PRQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu: Pretty-print context fault related regs
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	Stephen Boyd <swboyd@chromium.org>, Rob Clark <robdclark@chromium.org>, 
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jerry Snitselaar <jsnitsel@redhat.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 6:07=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 04/06/2024 4:01 pm, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Parse out the bitfields for easier-to-read fault messages.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> > Stephen was wanting easier to read fault messages.. so I typed this up.
> >
> > Resend with the new iommu list address
> >
> >   drivers/iommu/arm/arm-smmu/arm-smmu.c | 53 +++++++++++++++++++++++++-=
-
> >   drivers/iommu/arm/arm-smmu/arm-smmu.h |  5 +++
> >   2 files changed, 54 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/=
arm-smmu/arm-smmu.c
> > index c572d877b0e1..06712d73519c 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > @@ -411,6 +411,8 @@ static irqreturn_t arm_smmu_context_fault(int irq, =
void *dev)
> >       unsigned long iova;
> >       struct arm_smmu_domain *smmu_domain =3D dev;
> >       struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> > +     static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
> > +                                   DEFAULT_RATELIMIT_BURST);
> >       int idx =3D smmu_domain->cfg.cbndx;
> >       int ret;
> >
> > @@ -425,10 +427,53 @@ static irqreturn_t arm_smmu_context_fault(int irq=
, void *dev)
> >       ret =3D report_iommu_fault(&smmu_domain->domain, NULL, iova,
> >               fsynr & ARM_SMMU_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_F=
AULT_READ);
> >
> > -     if (ret =3D=3D -ENOSYS)
> > -             dev_err_ratelimited(smmu->dev,
> > -             "Unhandled context fault: fsr=3D0x%x, iova=3D0x%08lx, fsy=
nr=3D0x%x, cbfrsynra=3D0x%x, cb=3D%d\n",
> > -                         fsr, iova, fsynr, cbfrsynra, idx);
> > +     if (ret =3D=3D -ENOSYS && __ratelimit(&rs)) {
> > +             static const struct {
> > +                     u32 mask; const char *name;
> > +             } fsr_bits[] =3D {
> > +                     { ARM_SMMU_FSR_MULTI,  "MULTI" },
> > +                     { ARM_SMMU_FSR_SS,     "SS"    },
> > +                     { ARM_SMMU_FSR_UUT,    "UUT"   },
> > +                     { ARM_SMMU_FSR_ASF,    "ASF"   },
> > +                     { ARM_SMMU_FSR_TLBLKF, "TLBLKF" },
> > +                     { ARM_SMMU_FSR_TLBMCF, "TLBMCF" },
> > +                     { ARM_SMMU_FSR_EF,     "EF"     },
> > +                     { ARM_SMMU_FSR_PF,     "PF"     },
> > +                     { ARM_SMMU_FSR_AFF,    "AFF"    },
> > +                     { ARM_SMMU_FSR_TF,     "TF"     },
> > +             }, fsynr0_bits[] =3D {
> > +                     { ARM_SMMU_FSYNR0_WNR,    "WNR"    },
> > +                     { ARM_SMMU_FSYNR0_PNU,    "PNU"    },
> > +                     { ARM_SMMU_FSYNR0_IND,    "IND"    },
> > +                     { ARM_SMMU_FSYNR0_NSATTR, "NSATTR" },
> > +                     { ARM_SMMU_FSYNR0_PTWF,   "PTWF"   },
> > +                     { ARM_SMMU_FSYNR0_AFR,    "AFR"    },
> > +             };
> > +
> > +             pr_err("%s %s: Unhandled context fault: fsr=3D0x%x (",
> > +                    dev_driver_string(smmu->dev), dev_name(smmu->dev),=
 fsr);
> > +
> > +             for (int i =3D 0, n =3D 0; i < ARRAY_SIZE(fsr_bits); i++)=
 {
> > +                     if (fsr & fsr_bits[i].mask) {
> > +                             pr_cont("%s%s", (n > 0) ? "|" : "", fsr_b=
its[i].name);
>
> Given that SMMU faults have a high likelihood of correlating with other
> errors, e.g. the initiating device also reporting that it got an abort
> back, this much pr_cont is a recipe for an unreadable mess. Furthermore,
> just imagine how "helpful" this would be when faults in two contexts are
> reported by two different CPUs at the same time ;)

It looks like arm_smmu_context_fault() is only used with non-threaded
irq's.  And this fallback is only used if driver doesn't register it's
own fault handler.  So I don't think this will be a problem.

> I'd prefer to retain the original message as-is, so there is at least
> still an unambiguous "atomic" view of a fault's entire state, then
> follow it with a decode more in the style of arm64's ESR logging. TBH I
> also wouldn't disapprove of hiding the additional decode behind a
> command-line/runtime parameter, since a fault storm can cripple a system
> enough as it is, without making the interrupt handler spend even longer
> printing to a potentially slow console.

It _is_ ratelimited.  But we could perhaps use a higher loglevel (pr_debug?=
)

BR,
-R

> > +                             n++;
> > +                     }
> > +             }
> > +
> > +             pr_cont("), iova=3D0x%08lx, fsynr=3D0x%x (S1CBNDX=3D%u", =
iova, fsynr,
> > +                     (fsynr >> 16) & 0xff);
>
> Please define all the bitfields properly (and I agree with Pranjal about
> the naming).
>
> Thanks,
> Robin.
>
> > +
> > +             for (int i =3D 0; i < ARRAY_SIZE(fsynr0_bits); i++) {
> > +                     if (fsynr & fsynr0_bits[i].mask) {
> > +                             pr_cont("|%s", fsynr0_bits[i].name);
> > +                     }
> > +             }
> > +
> > +             pr_cont("|PLVL=3D%u), cbfrsynra=3D0x%x, cb=3D%d\n",
> > +                     fsynr & 0x3,   /* FSYNR0.PLV */
> > +                     cbfrsynra, idx);
> > +
> > +     }
> >
> >       arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
> >       return IRQ_HANDLED;
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/=
arm-smmu/arm-smmu.h
> > index 836ed6799a80..3b051273718b 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> > @@ -223,6 +223,11 @@ enum arm_smmu_cbar_type {
> >
> >   #define ARM_SMMU_CB_FSYNR0          0x68
> >   #define ARM_SMMU_FSYNR0_WNR         BIT(4)
> > +#define ARM_SMMU_FSYNR0_PNU          BIT(5)
> > +#define ARM_SMMU_FSYNR0_IND          BIT(6)
> > +#define ARM_SMMU_FSYNR0_NSATTR               BIT(8)
> > +#define ARM_SMMU_FSYNR0_PTWF         BIT(10)
> > +#define ARM_SMMU_FSYNR0_AFR          BIT(11)
> >
> >   #define ARM_SMMU_CB_FSYNR1          0x6c
> >
