Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38AE2222DE
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 20:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723249; cv=none; b=GS7YyhZcB/kt1ASmHOxPAbBVYOdD9kx6BUGQF2Rkzjeytl7DnKVTTPuzCTq7xmGzzGyIJp1UZC1jfY5h+rXQp2zNpN/J8oZN1q8C9Np/N4+Ci/LZGZb+iGOy4UvV6iOs44MHx5LXjbQZ8BEehcffJ6KekAW+jEKxluI81qkp3Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723249; c=relaxed/simple;
	bh=jE4Zi6mLfr5s2J8OrtBs/rBYkdtHyED4KBrwkpGSoa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYh4VFMPcIWuLyGGLfrVjwO49i3QWLxhEb0eU3xPv1VAqCzzsAN1tdKWIa0KfIPwFSb9dNQeB0bm4x9+xdLiwn7kKIjp3DzvGLHbC+JcGZlkSvkkYbaZ5HhXgadrQ/2MGVzOULri5MxynscROVRZTrI/1BfsRPtBI1JyKNumTGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxTODFHJ; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxTODFHJ"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d43bb5727fso16230335ab.1
        for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 13:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741723247; x=1742328047; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gpeic0WcwHZpDjI5JkWgQuSUr4e/vgwMJ9BK0UvjAlo=;
        b=JxTODFHJ+B3iT5eKuQ7bVnWHYPpnSJsNbht290aAHekqfi8vPkG0SEla/Z/ixnlp9t
         WqxDS//aUjXWHuouSct5DOYpxalZlxekqagJXM0fD8MimtFyknTkhRVSP6MDrlse9svH
         8qZ8hqPs/xXqI/OPwykEJNnayb7JRJnNNRaInJtg1sROPdEPw6d5XliyE29aLBnodMCh
         fUMsNuQguY/MwcP0BSDO582DRRKuPUTU0YL81j8JVytm5qaXjlaEG/VvcLVUCzuiFtqG
         UUF47Sr7dXPMWOR2kcHLclQg26slusyDqSgGmueEv95kb10E/xDGDpX696cudmnzV3v5
         UBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741723247; x=1742328047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gpeic0WcwHZpDjI5JkWgQuSUr4e/vgwMJ9BK0UvjAlo=;
        b=I2/opckWsBEBCbzliPlY5knFecIdZGm6Ojwhy8gnhcKIIVGXGarjxw2/BwjFGSQ+gv
         nhCXIQDSCLpsjrsJQmmcfbV9Z8rK6VlgnwfJ3HaEJyaFOgKRNU9cfCRhlfdgPcF2HQiD
         vO8mcKoOelhG5WlcIWWB1mct8fVZlcb3bRPY7UYocp/EcmYm7B+45nwMAKnb+/yRbKNH
         EPsub9UEZB0/0UOcwg57Pde/G1H2C0FKYPi+zhTmtqe5oz8A0ShQ6l6SSD3gkzDDmhVd
         gK2mP8zblyYaaxeIOOGeZfIMrOL/9qX+Y+boWMlbdZWirmSfjNOse1aNtZl5K+1p5TpQ
         DhFg==
X-Forwarded-Encrypted: i=1; AJvYcCWLjPRb8L+taZ7dJffgaUQwl6+8vFSsGFCtqMMOCDUfHmjELhPdNwWznHJApyK3HQ/wBiLp9g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/U52NaJyok+XjmpTUepF2JzE87CQn7XVv4EPY0C8Wp0Kp41ju
	gP0NOGdBsEDLyFuogrQyD2Azle4iLJF5P5R5p01Umie4QBlgnamUHblEHAt9SsiI72dKz1cOMl2
	ov5gs9R37ABEr01QsoKb7vMWzBB0=
X-Gm-Gg: ASbGncu+a5K6TXX0lwctw0YWnNHZLh0KJRRsUrTzFc2Vsx93ZuarG/+UNjNBZEUWhMa
	toj6eoygFO/v6hZ/7/Hmp+BF7vxZvg8Zvg+08s++vGD162+9MSFnfixcAzuJSgf6eoWfHL1rm+L
	EUbOsqDQpsaEU5yHgG8dHFq8a5Rp0SwrRgZv+GnqZOgEhVlYg2a4HHa0O8
X-Google-Smtp-Source: AGHT+IHnEnfmBrcYN5CgiJSCUEKuYdpRvskKfowRAYORIl7YVlWFJTR/3hVXxyuW1gKd0NsDNWQe7lPtHwZEAYj9Mqw=
X-Received: by 2002:a05:6e02:164a:b0:3d0:235b:4810 with SMTP id
 e9e14a558f8ab-3d4418d50e2mr212944605ab.2.1741723246490; Tue, 11 Mar 2025
 13:00:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250304-msm-gpu-fault-fixes-next-v4-0-be14be37f4c3@gmail.com>
 <20250304-msm-gpu-fault-fixes-next-v4-2-be14be37f4c3@gmail.com>
 <20250311180807.GC5216@willie-the-truck> <CACu1E7Hw6vGbTQ7t-Hj3ziycZhPxtOGSDkt7o4fNUx91KDcXfg@mail.gmail.com>
In-Reply-To: <CACu1E7Hw6vGbTQ7t-Hj3ziycZhPxtOGSDkt7o4fNUx91KDcXfg@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 11 Mar 2025 13:00:34 -0700
X-Gm-Features: AQ5f1JqJJW0DJckWYNGGABDX1xOTUcg1Jhe5MZo7XOUNOKHatuENCACaKvteaIA
Message-ID: <CAF6AEGs8PoZBpFesQ_DGcngn4X24wzFy=zn2mAUJepdibxoKog@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] iommu/arm-smmu-qcom: Don't read fault registers directly
To: Connor Abbott <cwabbott0@gmail.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 12:42=E2=80=AFPM Connor Abbott <cwabbott0@gmail.com=
> wrote:
>
> On Tue, Mar 11, 2025 at 2:08=E2=80=AFPM Will Deacon <will@kernel.org> wro=
te:
> >
> > On Tue, Mar 04, 2025 at 11:56:48AM -0500, Connor Abbott wrote:
> > > In some cases drm/msm has to resume a stalled transaction directly in
> > > its fault handler. Experimentally this doesn't work on SMMU500 if the
> > > fault hasn't already been acknowledged by clearing FSR. Rather than
> > > trying to clear FSR in msm's fault handler and implementing a
> > > tricky handshake to avoid accidentally clearing FSR twice, we want to
> > > clear FSR before calling the fault handlers, but this means that the
> > > contents of registers can change underneath us in the fault handler a=
nd
> > > msm currently uses a private function to read the register contents f=
or
> > > its own purposes in its fault handler, such as using the
> > > implementation-defined FSYNR1 to determine which block caused the fau=
lt.
> > > Fix this by making msm use the register values already read by arm-sm=
mu
> > > itself before clearing FSR rather than messing around with reading
> > > registers directly.
> > >
> > > Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
> > > ---
> > >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 19 +++++++++----------
> > >  drivers/iommu/arm/arm-smmu/arm-smmu.c      | 14 +++++++-------
> > >  drivers/iommu/arm/arm-smmu/arm-smmu.h      | 21 +++++++++++---------=
-
> > >  3 files changed, 27 insertions(+), 27 deletions(-)
> >
> > [...]
> >
> > > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/ar=
m/arm-smmu/arm-smmu.h
> > > index d3bc77dcd4d40f25bc70f3289616fb866649b022..411d807e0a70338337166=
35efb3968a0bd3ff237 100644
> > > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> > > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> > > @@ -373,6 +373,16 @@ enum arm_smmu_domain_stage {
> > >       ARM_SMMU_DOMAIN_NESTED,
> > >  };
> > >
> > > +struct arm_smmu_context_fault_info {
> > > +     unsigned long iova;
> > > +     u64 ttbr0;
> > > +     u32 fsr;
> > > +     u32 fsynr0;
> > > +     u32 fsynr1;
> > > +     u32 cbfrsynra;
> > > +     u32 contextidr;
> > > +};
> > > +
> > >  struct arm_smmu_domain {
> > >       struct arm_smmu_device          *smmu;
> > >       struct io_pgtable_ops           *pgtbl_ops;
> > > @@ -380,6 +390,7 @@ struct arm_smmu_domain {
> > >       const struct iommu_flush_ops    *flush_ops;
> > >       struct arm_smmu_cfg             cfg;
> > >       enum arm_smmu_domain_stage      stage;
> > > +     struct arm_smmu_context_fault_info cfi;
> >
> > Does this mean we have to serialise all faults for a given domain? That
> > can't be right...
> >
> > Will
>
> They are already serialized? There's only one of each register per
> context bank, so you can only have one context fault at a time per
> context bank, and AFAIK a context bank is 1:1 with a domain. Also this
> struct is only written and then read inside the context bank's
> interrupt handler, and you can only have one interrupt at a time, no?
>
> Connor

And if it was a race condition with cfi getting overridden, it would
have already been an equivalent race condition currently when reading
the values from registers (ie. the register values could have changed
in the elapsed time)

So no additional serialization needed here.

BR,
-R
