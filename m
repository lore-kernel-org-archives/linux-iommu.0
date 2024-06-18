Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908444D8A4
	for <iommu@lists.linux.dev>; Tue, 18 Jun 2024 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725653; cv=none; b=I2q2Nsm1yZu78knUAmjWTtDSOYPFcVC0VzvToDMf69Ke210WJMIsk8Tg0JsPaPeyoGQFNH94KthZSDVG1tPsdC0gP943nfOKDhTvv3D3OjggjkhCTZb0nDCmZQXH2Zw9GuBgqFZIn5OMfwthACXPsKOXdn3sC+3weAQzFr5fLXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725653; c=relaxed/simple;
	bh=XCRMCtMXHLNjJphVTMnh6comGtEq0JkrfmVck3CYyJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jU/EhchXemJ915iyP91/HtMd4eIjh491YG9IO5/FXGhYxp6drlQXAGpY5bhsqVnnH35ae/iKxoDsshcW9LREMXA2aFoyLLk38DCgD96mfUBUFu5onM2w3UJSaAivDNdCEsnBwrhDBGaUcjsLDaE3NDYbkMwd01+SVFsgyO7JNtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pPgr0Q6e; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pPgr0Q6e"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57d00a51b71so9336a12.0
        for <iommu@lists.linux.dev>; Tue, 18 Jun 2024 08:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718725649; x=1719330449; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIYSvCXFkVXQmYm1PIRRFm8B3H0HwGnr9/yZnHJpI1w=;
        b=pPgr0Q6er9CI23F92rF4gm4hQAnFXYVf51fI3PkP9AdBKYNeadExe+BDC87SDwXxOq
         1M4grXLqwep0W/ya7t2qtktPkN/5p2/JwO1QZmND85hCyLV+Jqd145HxPIB5dvLLiD+k
         L67p94ckFb8tsDpLzEOghpwGc8FpT57HQe7pKtHoAc9w8X4LftkioCylluVsMkaYPkff
         0jBygKlPa3gqAbOv0g7krQn95ix6CoHrhyu50ltc/uE1Ur5dV1fitWhaoQqhp+JT0fqW
         3SzG7xaW/VbknZRnxPQjsqNId8UH/0XoZ4dS3bTSjVwbmzZa/pY2/PLqROykteGEmM37
         a9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718725649; x=1719330449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIYSvCXFkVXQmYm1PIRRFm8B3H0HwGnr9/yZnHJpI1w=;
        b=de/M3CVlMQHVsp4afVU441eSiKCduyjxSNNs7HXG8L/yd4PXZBC6Ox4UuwQBuLJQVM
         ZWldWhniHCC5WZ9q+WAh4OLEVKDuHasnOoQLnR/HizlHFmVXx+TKxV6JXNJg1x94/NNS
         u9qkufGhYTtmq0nhaZ0XKI9WcVlKQjjqxkapNPlAGly5eCoZq6LroG8GjsjVPWitUvFp
         To+1HgEBddU+EuB7wgLyF7H4OQm/elfDu8YB3uJvn7yzuk32yHswfei1DqaQ3bvStwoq
         G43aYclczatuH1JPk8B3FEfAEvOh5YYY8mm7QU9p13ocubDlzEaQ+MoSBxKRtnSJzkG1
         Uedw==
X-Forwarded-Encrypted: i=1; AJvYcCXzOCL9ButFYgd9zWxi6mZ+LTZlOtumW+7dj/BScbahQvMWF2V8i8sTtZz+gX0HjP91o2KhOJ2VvUm5iN9POs0WpyFP8+Q=
X-Gm-Message-State: AOJu0Yzw3N+iui30N6XkpxykGGej9ZPISKIPx4NDTu77D3K5HcRfPSAp
	ANWXRq2Luw/JWZ5wxLS4CIYLe8lSQKXWXZTo0qzFaz3tp6mGTr0pD1oMA7jaUot9gr435IVH7E7
	c6GaXtdatTysl+B2UY6As5+j99CrrUZjclRRw
X-Google-Smtp-Source: AGHT+IGfuDoMA+ic7c2YA4o3KutLmUvASmQxBSlR3RtUYS4iqh4ijSRMHAtX1YilNE8UVVSIEYNMLL2QquCsQRyU8I0=
X-Received: by 2002:a05:6402:5247:b0:57c:b80b:b2f4 with SMTP id
 4fb4d7f45d1cf-57cf91338c0mr252013a12.6.1718725648780; Tue, 18 Jun 2024
 08:47:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240604150136.493962-1-robdclark@gmail.com> <6f97a4b4-cdbe-466c-80d4-adc8da305f75@arm.com>
 <CAF6AEGv+Ge2SD4=j1QhXfG+KkOzvFM+LieCqKuM20YL8gp5PRQ@mail.gmail.com>
 <80fc63e5-0e79-47b3-91ae-90d7c7bc3f66@arm.com> <CAF6AEGuDq=YcyKuTfr1xZtff+VGyeeVWe40E4KEy--umwepcEQ@mail.gmail.com>
In-Reply-To: <CAF6AEGuDq=YcyKuTfr1xZtff+VGyeeVWe40E4KEy--umwepcEQ@mail.gmail.com>
From: Pranjal Shrivastava <praan@google.com>
Date: Tue, 18 Jun 2024 21:17:16 +0530
Message-ID: <CAN6iL-QqZXsFDB=3yCfqQeF0H5QaS_Trm62FxvDF-+qPoQ-VNA@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu: Pretty-print context fault related regs
To: Rob Clark <robdclark@gmail.com>
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

On Tue, Jun 18, 2024 at 8:28=E2=80=AFPM Rob Clark <robdclark@gmail.com> wro=
te:
>
> On Mon, Jun 17, 2024 at 10:33=E2=80=AFAM Robin Murphy <robin.murphy@arm.c=
om> wrote:
> >
> > On 2024-06-17 5:18 pm, Rob Clark wrote:
> > > On Mon, Jun 17, 2024 at 6:07=E2=80=AFAM Robin Murphy <robin.murphy@ar=
m.com> wrote:
> > >>
> > >> On 04/06/2024 4:01 pm, Rob Clark wrote:
> > >>> From: Rob Clark <robdclark@chromium.org>
> > >>>
> > >>> Parse out the bitfields for easier-to-read fault messages.
> > >>>
> > >>> Signed-off-by: Rob Clark <robdclark@chromium.org>
> > >>> ---
> > >>> Stephen was wanting easier to read fault messages.. so I typed this=
 up.
> > >>>
> > >>> Resend with the new iommu list address
> > >>>
> > >>>    drivers/iommu/arm/arm-smmu/arm-smmu.c | 53 +++++++++++++++++++++=
++++--
> > >>>    drivers/iommu/arm/arm-smmu/arm-smmu.h |  5 +++
> > >>>    2 files changed, 54 insertions(+), 4 deletions(-)
> > >>>
> > >>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/=
arm/arm-smmu/arm-smmu.c
> > >>> index c572d877b0e1..06712d73519c 100644
> > >>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > >>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > >>> @@ -411,6 +411,8 @@ static irqreturn_t arm_smmu_context_fault(int i=
rq, void *dev)
> > >>>        unsigned long iova;
> > >>>        struct arm_smmu_domain *smmu_domain =3D dev;
> > >>>        struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> > >>> +     static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
> > >>> +                                   DEFAULT_RATELIMIT_BURST);
> > >>>        int idx =3D smmu_domain->cfg.cbndx;
> > >>>        int ret;
> > >>>
> > >>> @@ -425,10 +427,53 @@ static irqreturn_t arm_smmu_context_fault(int=
 irq, void *dev)
> > >>>        ret =3D report_iommu_fault(&smmu_domain->domain, NULL, iova,
> > >>>                fsynr & ARM_SMMU_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IO=
MMU_FAULT_READ);
> > >>>
> > >>> -     if (ret =3D=3D -ENOSYS)
> > >>> -             dev_err_ratelimited(smmu->dev,
> > >>> -             "Unhandled context fault: fsr=3D0x%x, iova=3D0x%08lx,=
 fsynr=3D0x%x, cbfrsynra=3D0x%x, cb=3D%d\n",
> > >>> -                         fsr, iova, fsynr, cbfrsynra, idx);
> > >>> +     if (ret =3D=3D -ENOSYS && __ratelimit(&rs)) {
> > >>> +             static const struct {
> > >>> +                     u32 mask; const char *name;
> > >>> +             } fsr_bits[] =3D {
> > >>> +                     { ARM_SMMU_FSR_MULTI,  "MULTI" },
> > >>> +                     { ARM_SMMU_FSR_SS,     "SS"    },
> > >>> +                     { ARM_SMMU_FSR_UUT,    "UUT"   },
> > >>> +                     { ARM_SMMU_FSR_ASF,    "ASF"   },
> > >>> +                     { ARM_SMMU_FSR_TLBLKF, "TLBLKF" },
> > >>> +                     { ARM_SMMU_FSR_TLBMCF, "TLBMCF" },
> > >>> +                     { ARM_SMMU_FSR_EF,     "EF"     },
> > >>> +                     { ARM_SMMU_FSR_PF,     "PF"     },
> > >>> +                     { ARM_SMMU_FSR_AFF,    "AFF"    },
> > >>> +                     { ARM_SMMU_FSR_TF,     "TF"     },
> > >>> +             }, fsynr0_bits[] =3D {
> > >>> +                     { ARM_SMMU_FSYNR0_WNR,    "WNR"    },
> > >>> +                     { ARM_SMMU_FSYNR0_PNU,    "PNU"    },
> > >>> +                     { ARM_SMMU_FSYNR0_IND,    "IND"    },
> > >>> +                     { ARM_SMMU_FSYNR0_NSATTR, "NSATTR" },
> > >>> +                     { ARM_SMMU_FSYNR0_PTWF,   "PTWF"   },
> > >>> +                     { ARM_SMMU_FSYNR0_AFR,    "AFR"    },
> > >>> +             };
> > >>> +
> > >>> +             pr_err("%s %s: Unhandled context fault: fsr=3D0x%x ("=
,
> > >>> +                    dev_driver_string(smmu->dev), dev_name(smmu->d=
ev), fsr);
> > >>> +
> > >>> +             for (int i =3D 0, n =3D 0; i < ARRAY_SIZE(fsr_bits); =
i++) {
> > >>> +                     if (fsr & fsr_bits[i].mask) {
> > >>> +                             pr_cont("%s%s", (n > 0) ? "|" : "", f=
sr_bits[i].name);
> > >>
> > >> Given that SMMU faults have a high likelihood of correlating with ot=
her
> > >> errors, e.g. the initiating device also reporting that it got an abo=
rt
> > >> back, this much pr_cont is a recipe for an unreadable mess. Furtherm=
ore,
> > >> just imagine how "helpful" this would be when faults in two contexts=
 are
> > >> reported by two different CPUs at the same time ;)
> > >
> > > It looks like arm_smmu_context_fault() is only used with non-threaded
> > > irq's.  And this fallback is only used if driver doesn't register it'=
s
> > > own fault handler.  So I don't think this will be a problem.
> >
> > You don't think two different IRQs can fire on two different CPUs at th=
e
> > same time (or close to)? It's already bad enough when multiple CPUs
> > panic and one has to pick apart line-by-line interleaving of the
> > registers/stacktraces - imagine how much more utterly unusable that
> > would be with bits of different dumps randomly pr_cont'ed together onto
> > the same line(s)...
>
> _different_ irq's, yes
>
> Anyways, the reason for pr_cont() was that there wasn't another
> reasonable way to decide where separator chars were needed with a
> single pr_err().  I could instead construct a string on stack and
> print that in a single call, but pr_cont() seemed like the more
> reasonable alternative.
>
> BR,
> -R

The string approach sounds good to me, if possible, let's break this
out into a helper function, something like `arm_smmu_log_ctx_fault`
and put it under a module parameter, I guess? Not sure if this
requires a new Kconfig option, would like Robin's opinion on this.

Thanks,
Pranjal

>
> > Even when unrelated stuff gets interleaved because other CPUs just
> > happen to be calling printk() at the same time for unrelated reasons
> > it's still annoying, and pr_cont makes a bigger mess than not.
> > >> I'd prefer to retain the original message as-is, so there is at leas=
t
> > >> still an unambiguous "atomic" view of a fault's entire state, then
> > >> follow it with a decode more in the style of arm64's ESR logging. TB=
H I
> > >> also wouldn't disapprove of hiding the additional decode behind a
> > >> command-line/runtime parameter, since a fault storm can cripple a sy=
stem
> > >> enough as it is, without making the interrupt handler spend even lon=
ger
> > >> printing to a potentially slow console.
> > >
> > > It _is_ ratelimited.  But we could perhaps use a higher loglevel (pr_=
debug?)
> >
> > Yeah, I'd have no complaint with pr_debug/dev_dbg either, if that suits
> > your use case. True that the ratelimit may typically mitigate the
> > overall impact, but still in the worst case with a sufficiently slow
> > console and/or a sufficiently large amount to print per __ratelimit()
> > call, it can end up being slow enough to stay below the threshold. Don'=
t
> > ask me how I know that :)
> >
> > Thanks,
> > Robin.
