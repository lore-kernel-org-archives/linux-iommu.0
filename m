Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B209B36139
	for <iommu@lists.linux.dev>; Tue, 18 Jun 2024 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726845; cv=none; b=Hahx3MHM5mBIpHOUvc5b6SPmw/jb4+JDXcg0V3sW0jmi4yduWYowUI2jIEOehy9bwgNZgwyvi6pYCjbXKUttwpvSS/BLG4u4iSMApho+wYKzyHp08mauvKFd6xe5rPW+BwIAzF2ldFQwioS8Yg0Rkfr6WXEtavcxOVvFa/BFJ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726845; c=relaxed/simple;
	bh=lZl6YIavIF+kRDulfiKUTLyof9QcmEhxe+li2JzXlLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7j9Y7rxJBBTac0jt5KZYK1zGHKZiqelkyTziEF/IexbFjxP+xLjzHjuo8uuh9IzY+YNdWAqEfM1KnpF4e+xw3n9aiNqY6neizHK+Uxr1mmoVK5X+ncnMcdIse1ZvYg+b4pF1WWzlbZkvhQw4pm35s0c5J2ow0Qq3ObMr3uXgSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtXODlZE; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtXODlZE"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57cb9a370ddso6428453a12.1
        for <iommu@lists.linux.dev>; Tue, 18 Jun 2024 09:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718726842; x=1719331642; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0oM9Lpuyn36KdHk2D3fEb1p8PoQOkcQghffKZ0RgOmI=;
        b=PtXODlZE6hNbWqxpp4/RTiNxC2Lm8dJDsMCmaeGI1EBxyOaUMonyDmoDhftuQj3WNn
         bzK8bzma4JV4kdy1nd2B+ecOwCVhgcIcSfZXcX2pxt69xA0BDKJuWms709zeWRija4es
         3CLT2JSDofNzbxpYjBNDWivZKPiSHqFoIqYbBGbGMkocnc8/SzZ9mYrXZ9BpDOUbuoSj
         +ILbzw7o3ldJBB0IiNcsUdOohsLq9O+mSX7I2mpM6OG09tpAgNgDZKFaezVcsz3z/Wy6
         ox0wvQFj9X9VzJdVkXqGEmUEzC6Cw+3moWnHPIhQrC6Dq9siz8rzEV6OizzcI8YBGdex
         /2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718726842; x=1719331642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0oM9Lpuyn36KdHk2D3fEb1p8PoQOkcQghffKZ0RgOmI=;
        b=ivcCU0MnsYXZ4mqZUrCz4UqXWubwA/Et82AlmsZua4c9SFdFl6NBp+ti3dHCCfgWEP
         fkSrujRsGrvEwfKkt/P8V/lZpqwvjJAIOjDwtnJm9orwE9gdToC+O3QDaJatJ2Qwx4Lk
         kQwNYW/mtQ+ZqlDIo97Zc+wguE16upQckXAhIz/Iirq8SfPBLPFnld1P/w4C1cEDo2/o
         ihaf1BfbxC2QHilp8U3AMlsyGrBUNSaTMDe/bU6yp7CusjsLgfDTM+6Ck0PrKHOwb6aW
         UvUfbt1gFRj9IzgzZk0f9MADt3OvgsYZg8X+A2pVsWNaJFXRsxycgJAUR9wjwlSkk5as
         zK1A==
X-Forwarded-Encrypted: i=1; AJvYcCXKspLJMeCyHVe2fYPsUw+HGWl/SMyaQnv+fr3f9rw5pOBgN6AJhvOoO2JVFKgdu1toLytHDlrHFH7seKdRErnBHo+h5ig=
X-Gm-Message-State: AOJu0YznLZoFp5XkUnfAnBjjKdftFoGG6Ift5jurKh3K3D2bWsXJf//m
	wET8WoL+Co/z53tZvv/495TqKzsyBRErlkVaf6/98O4yD508wgFicpKo+zUh3+PI2BR/l1QrSZ9
	hAx3iX/WGnT98H3zbJXSk10RcHaI=
X-Google-Smtp-Source: AGHT+IFjs9EVPcZ5EknH2hY5Vbz8DsydHG3hYmm4TN1ZEiaP41SGEv3GZKkeX6J3Eq7upNhMrDdxW/FP0IiAJe48pFE=
X-Received: by 2002:a50:d648:0:b0:57c:61a2:ed47 with SMTP id
 4fb4d7f45d1cf-57cbd67f6b1mr7309877a12.24.1718726841682; Tue, 18 Jun 2024
 09:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240604150136.493962-1-robdclark@gmail.com> <6f97a4b4-cdbe-466c-80d4-adc8da305f75@arm.com>
 <CAF6AEGv+Ge2SD4=j1QhXfG+KkOzvFM+LieCqKuM20YL8gp5PRQ@mail.gmail.com>
 <80fc63e5-0e79-47b3-91ae-90d7c7bc3f66@arm.com> <CAF6AEGuDq=YcyKuTfr1xZtff+VGyeeVWe40E4KEy--umwepcEQ@mail.gmail.com>
 <CAN6iL-QqZXsFDB=3yCfqQeF0H5QaS_Trm62FxvDF-+qPoQ-VNA@mail.gmail.com>
In-Reply-To: <CAN6iL-QqZXsFDB=3yCfqQeF0H5QaS_Trm62FxvDF-+qPoQ-VNA@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 18 Jun 2024 09:07:09 -0700
Message-ID: <CAF6AEGv8LgAA91C+SkmDZ2besZyA8iCpgn6BStBJ7htZ21T9dg@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu: Pretty-print context fault related regs
To: Pranjal Shrivastava <praan@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>, 
	Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jerry Snitselaar <jsnitsel@redhat.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 8:47=E2=80=AFAM Pranjal Shrivastava <praan@google.c=
om> wrote:
>
> On Tue, Jun 18, 2024 at 8:28=E2=80=AFPM Rob Clark <robdclark@gmail.com> w=
rote:
> >
> > On Mon, Jun 17, 2024 at 10:33=E2=80=AFAM Robin Murphy <robin.murphy@arm=
.com> wrote:
> > >
> > > On 2024-06-17 5:18 pm, Rob Clark wrote:
> > > > On Mon, Jun 17, 2024 at 6:07=E2=80=AFAM Robin Murphy <robin.murphy@=
arm.com> wrote:
> > > >>
> > > >> On 04/06/2024 4:01 pm, Rob Clark wrote:
> > > >>> From: Rob Clark <robdclark@chromium.org>
> > > >>>
> > > >>> Parse out the bitfields for easier-to-read fault messages.
> > > >>>
> > > >>> Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > >>> ---
> > > >>> Stephen was wanting easier to read fault messages.. so I typed th=
is up.
> > > >>>
> > > >>> Resend with the new iommu list address
> > > >>>
> > > >>>    drivers/iommu/arm/arm-smmu/arm-smmu.c | 53 +++++++++++++++++++=
++++++--
> > > >>>    drivers/iommu/arm/arm-smmu/arm-smmu.h |  5 +++
> > > >>>    2 files changed, 54 insertions(+), 4 deletions(-)
> > > >>>
> > > >>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iomm=
u/arm/arm-smmu/arm-smmu.c
> > > >>> index c572d877b0e1..06712d73519c 100644
> > > >>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > >>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > >>> @@ -411,6 +411,8 @@ static irqreturn_t arm_smmu_context_fault(int=
 irq, void *dev)
> > > >>>        unsigned long iova;
> > > >>>        struct arm_smmu_domain *smmu_domain =3D dev;
> > > >>>        struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> > > >>> +     static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVA=
L,
> > > >>> +                                   DEFAULT_RATELIMIT_BURST);
> > > >>>        int idx =3D smmu_domain->cfg.cbndx;
> > > >>>        int ret;
> > > >>>
> > > >>> @@ -425,10 +427,53 @@ static irqreturn_t arm_smmu_context_fault(i=
nt irq, void *dev)
> > > >>>        ret =3D report_iommu_fault(&smmu_domain->domain, NULL, iov=
a,
> > > >>>                fsynr & ARM_SMMU_FSYNR0_WNR ? IOMMU_FAULT_WRITE : =
IOMMU_FAULT_READ);
> > > >>>
> > > >>> -     if (ret =3D=3D -ENOSYS)
> > > >>> -             dev_err_ratelimited(smmu->dev,
> > > >>> -             "Unhandled context fault: fsr=3D0x%x, iova=3D0x%08l=
x, fsynr=3D0x%x, cbfrsynra=3D0x%x, cb=3D%d\n",
> > > >>> -                         fsr, iova, fsynr, cbfrsynra, idx);
> > > >>> +     if (ret =3D=3D -ENOSYS && __ratelimit(&rs)) {
> > > >>> +             static const struct {
> > > >>> +                     u32 mask; const char *name;
> > > >>> +             } fsr_bits[] =3D {
> > > >>> +                     { ARM_SMMU_FSR_MULTI,  "MULTI" },
> > > >>> +                     { ARM_SMMU_FSR_SS,     "SS"    },
> > > >>> +                     { ARM_SMMU_FSR_UUT,    "UUT"   },
> > > >>> +                     { ARM_SMMU_FSR_ASF,    "ASF"   },
> > > >>> +                     { ARM_SMMU_FSR_TLBLKF, "TLBLKF" },
> > > >>> +                     { ARM_SMMU_FSR_TLBMCF, "TLBMCF" },
> > > >>> +                     { ARM_SMMU_FSR_EF,     "EF"     },
> > > >>> +                     { ARM_SMMU_FSR_PF,     "PF"     },
> > > >>> +                     { ARM_SMMU_FSR_AFF,    "AFF"    },
> > > >>> +                     { ARM_SMMU_FSR_TF,     "TF"     },
> > > >>> +             }, fsynr0_bits[] =3D {
> > > >>> +                     { ARM_SMMU_FSYNR0_WNR,    "WNR"    },
> > > >>> +                     { ARM_SMMU_FSYNR0_PNU,    "PNU"    },
> > > >>> +                     { ARM_SMMU_FSYNR0_IND,    "IND"    },
> > > >>> +                     { ARM_SMMU_FSYNR0_NSATTR, "NSATTR" },
> > > >>> +                     { ARM_SMMU_FSYNR0_PTWF,   "PTWF"   },
> > > >>> +                     { ARM_SMMU_FSYNR0_AFR,    "AFR"    },
> > > >>> +             };
> > > >>> +
> > > >>> +             pr_err("%s %s: Unhandled context fault: fsr=3D0x%x =
(",
> > > >>> +                    dev_driver_string(smmu->dev), dev_name(smmu-=
>dev), fsr);
> > > >>> +
> > > >>> +             for (int i =3D 0, n =3D 0; i < ARRAY_SIZE(fsr_bits)=
; i++) {
> > > >>> +                     if (fsr & fsr_bits[i].mask) {
> > > >>> +                             pr_cont("%s%s", (n > 0) ? "|" : "",=
 fsr_bits[i].name);
> > > >>
> > > >> Given that SMMU faults have a high likelihood of correlating with =
other
> > > >> errors, e.g. the initiating device also reporting that it got an a=
bort
> > > >> back, this much pr_cont is a recipe for an unreadable mess. Furthe=
rmore,
> > > >> just imagine how "helpful" this would be when faults in two contex=
ts are
> > > >> reported by two different CPUs at the same time ;)
> > > >
> > > > It looks like arm_smmu_context_fault() is only used with non-thread=
ed
> > > > irq's.  And this fallback is only used if driver doesn't register i=
t's
> > > > own fault handler.  So I don't think this will be a problem.
> > >
> > > You don't think two different IRQs can fire on two different CPUs at =
the
> > > same time (or close to)? It's already bad enough when multiple CPUs
> > > panic and one has to pick apart line-by-line interleaving of the
> > > registers/stacktraces - imagine how much more utterly unusable that
> > > would be with bits of different dumps randomly pr_cont'ed together on=
to
> > > the same line(s)...
> >
> > _different_ irq's, yes
> >
> > Anyways, the reason for pr_cont() was that there wasn't another
> > reasonable way to decide where separator chars were needed with a
> > single pr_err().  I could instead construct a string on stack and
> > print that in a single call, but pr_cont() seemed like the more
> > reasonable alternative.
> >
> > BR,
> > -R
>
> The string approach sounds good to me, if possible, let's break this
> out into a helper function, something like `arm_smmu_log_ctx_fault`
> and put it under a module parameter, I guess? Not sure if this
> requires a new Kconfig option, would like Robin's opinion on this.

I did notice that qcom_smmu_context_fault() appeared recently, also
adding similar pretty-print.. but only for things with a tbu driver
(and a bit more open coded).  So a helper would probably make sense.

Less sure about mod param or Kconfig, but I tend to be of the opinion
that the kernel already has too much configurability.. others may have
a different view.

BR,
-R

> Thanks,
> Pranjal
>
> >
> > > Even when unrelated stuff gets interleaved because other CPUs just
> > > happen to be calling printk() at the same time for unrelated reasons
> > > it's still annoying, and pr_cont makes a bigger mess than not.
> > > >> I'd prefer to retain the original message as-is, so there is at le=
ast
> > > >> still an unambiguous "atomic" view of a fault's entire state, then
> > > >> follow it with a decode more in the style of arm64's ESR logging. =
TBH I
> > > >> also wouldn't disapprove of hiding the additional decode behind a
> > > >> command-line/runtime parameter, since a fault storm can cripple a =
system
> > > >> enough as it is, without making the interrupt handler spend even l=
onger
> > > >> printing to a potentially slow console.
> > > >
> > > > It _is_ ratelimited.  But we could perhaps use a higher loglevel (p=
r_debug?)
> > >
> > > Yeah, I'd have no complaint with pr_debug/dev_dbg either, if that sui=
ts
> > > your use case. True that the ratelimit may typically mitigate the
> > > overall impact, but still in the worst case with a sufficiently slow
> > > console and/or a sufficiently large amount to print per __ratelimit()
> > > call, it can end up being slow enough to stay below the threshold. Do=
n't
> > > ask me how I know that :)
> > >
> > > Thanks,
> > > Robin.
