Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B9F3A8D8
	for <iommu@lists.linux.dev>; Thu, 22 Aug 2024 23:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724368542; cv=none; b=D7KBJ9P3HItJmDSH1+BqaFiDTp0zU+L1c55QOIpdiHGjst0fRC8akqsKKy9rkDBwCZIhvNtOjZFtCxXa/3o+itc9hPL2VTh44DldLUGttAT1GdILoonFDIaVZqeiSrBxvuxNNSbMHk0lmGacHd5JK+1YOfeMv2e2Seqk2SL3D+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724368542; c=relaxed/simple;
	bh=FmOH4VCHQ7RRV3os04x39johr6N30/iNrwZAk4GnNfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0OlyKfHEPCUEvc1CkFltYiKnS9FpDrg7uJ0xNpJ9FBnnV3jmHb2DfnBPb17oterVX9MlG0+BJigt83yjuD+1B7vlkcuWqEAG3a7H7M7jV0uEcA4IyIGVXDfIjnGrpRO+J83cDyDR0BwzCcgOqLUMtQmcRUO3B+uJ6q9Ul4/Kwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvFUK2b7; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvFUK2b7"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5bed72ff2f2so1859599a12.2
        for <iommu@lists.linux.dev>; Thu, 22 Aug 2024 16:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724368538; x=1724973338; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlY1SNCKTKo0ttR05+nbVrXCxk2tU/xwtzki62FkZqk=;
        b=WvFUK2b7HOt9chI4+kyGntBDJG66MeZRX6L2AbhKYBLC+yCQ87GxVUFC31x4LUqY+i
         EsDp7IwwaHdZasUYqU00eDjBAODXWL79zUmjsXnXWfLrQXLgJr0R3Tkkm1zJbUMRLOlx
         ZHXSnWZY9ilP/4NdBuum/9MTgy44ousam/Cdf0ISQpBu5lOjn0FBjc6UfFBjWKv/yrm/
         APvrcCr1ZcZe43Jsgo5w3qaPOr+G/ofzHkabq6Bl+h3iz2ggPIaV1CvLx4R1QqGWx6rP
         tlA7wZW/fbq7j+Qj1pbaEIsY6x5TzPLOVnveX180q7v1iP4X5ESkMSnIgCCx5Ezpv2r4
         84qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724368538; x=1724973338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlY1SNCKTKo0ttR05+nbVrXCxk2tU/xwtzki62FkZqk=;
        b=fRZRMEQYYIjnDcqDRsRmF6ZBBRvr62tQQNFlp+/gCI381jla+CupRt2KeH6YlBqVRJ
         5KN2bndOjgAD1h/dtMm+eFFUnmIP6DdIKGOTWBolOx8mTKL6Yj4zQwE1o4W0/h2z0CS0
         QqR0ifQ8qc8OPCnLU9ruC1/DiyWu2l6Vv77p6O3TyhOqUPxMFnat4XcK89WP1/y0AOHN
         f3PuP+PEIWs0e1Q+al+t+j9NyLapxivAEzsTTYHxqaMfhqfCVGSG+At28Cz2BbsF0Fkx
         ZAClm9Fpcdj+pbrvZ5DDtlkJWhnk45/+YfW2pmkbRDWsNVDRG3RBBgyc+hu3UkQR233M
         C/hw==
X-Gm-Message-State: AOJu0Yy18nhyTOtiRK3yqPAO8ppNi/ItyTdAUYPEYgtyOF22DDyDuJyI
	PP4r2tu10cMgSqAylW79VwjoqUaxxFK8xvATSVybEn6BX8mjRkHMjt0ZRyj7TJauCQCfiL3Qj3h
	TejbBWZ+Z+r2ZNINvtEhEUX0RphA=
X-Google-Smtp-Source: AGHT+IHnSJYv0lPhOFFX0bl0T7rDppf3ajTMjwwg0WAsK4RjyNO+BvVGm1/RFj3FQoF0uV7st09q2ymgIkwION7q1MA=
X-Received: by 2002:a05:6402:40c5:b0:57c:9d54:67db with SMTP id
 4fb4d7f45d1cf-5c08916a094mr117351a12.9.1724368537311; Thu, 22 Aug 2024
 16:15:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240820171652.145673-1-robdclark@gmail.com> <20240820171652.145673-5-robdclark@gmail.com>
 <20240822203401.odfmdlqto6lsqefz@hu-akhilpo-hyd.qualcomm.com>
In-Reply-To: <20240822203401.odfmdlqto6lsqefz@hu-akhilpo-hyd.qualcomm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 22 Aug 2024 16:15:24 -0700
Message-ID: <CAF6AEGtGCT=TSp2XRmPaqb23dk42V_ic06OCB+JLEp6f5Y4tNg@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] drm/msm: Extend gpu devcore dumps with pgtbl info
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, Mostafa Saleh <smostafa@google.com>, 
	Will Deacon <will@kernel.org>, Rob Clark <robdclark@chromium.org>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, 
	"open list:DRM DRIVER for Qualcomm Adreno GPUs" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 1:34=E2=80=AFPM Akhil P Oommen <quic_akhilpo@quicin=
c.com> wrote:
>
> On Tue, Aug 20, 2024 at 10:16:47AM -0700, Rob Clark wrote: > From: Rob Cl=
ark <robdclark@chromium.org>
> >
> > In the case of iova fault triggered devcore dumps, include additional
> > debug information based on what we think is the current page tables,
> > including the TTBR0 value (which should match what we have in
> > adreno_smmu_fault_info unless things have gone horribly wrong), and
> > the pagetable entries traversed in the process of resolving the
> > faulting iova.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 10 ++++++++++
> >  drivers/gpu/drm/msm/msm_gpu.c           |  9 +++++++++
> >  drivers/gpu/drm/msm/msm_gpu.h           |  8 ++++++++
> >  drivers/gpu/drm/msm/msm_iommu.c         | 22 ++++++++++++++++++++++
> >  drivers/gpu/drm/msm/msm_mmu.h           |  3 ++-
> >  5 files changed, 51 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/=
msm/adreno/adreno_gpu.c
> > index 1c6626747b98..3848b5a64351 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > @@ -864,6 +864,16 @@ void adreno_show(struct msm_gpu *gpu, struct msm_g=
pu_state *state,
> >               drm_printf(p, "  - dir=3D%s\n", info->flags & IOMMU_FAULT=
_WRITE ? "WRITE" : "READ");
> >               drm_printf(p, "  - type=3D%s\n", info->type);
> >               drm_printf(p, "  - source=3D%s\n", info->block);
> > +
> > +             /* Information extracted from what we think are the curre=
nt
> > +              * pgtables.  Hopefully the TTBR0 matches what we've extr=
acted
> > +              * from the SMMU registers in smmu_info!
> > +              */
> > +             drm_puts(p, "pgtable-fault-info:\n");
> > +             drm_printf(p, "  - ttbr0: %.16llx\n", (u64)info->pgtbl_tt=
br0);
>
> "0x" prefix? Otherwise, it is a bit confusing when the below one is
> decimal.

mixed feelings, the extra 0x is annoying when pasting into calc which
is a simple way to get binary decoding

OTOH none of this is machine decoded so I guess we could change it

> > +             drm_printf(p, "  - asid: %d\n", info->asid);
> > +             drm_printf(p, "  - ptes: %.16llx %.16llx %.16llx %.16llx\=
n",
> > +                        info->ptes[0], info->ptes[1], info->ptes[2], i=
nfo->ptes[3]);
>
> Does crashdec decodes this?

No, it just passed thru for human eyeballs

crashdec _does_ have some logic to flag buffers that are "near" the
faulting iova to help identify if the fault is an underflow/overflow
(which has been, along with the pte trail, useful to debug some
issues)

BR,
-R

> -Akhil.
>
> >       }
> >
> >       drm_printf(p, "rbbm-status: 0x%08x\n", state->rbbm_status);
> > diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gp=
u.c
> > index 3666b42b4ecd..bf2f8b2a7ccc 100644
> > --- a/drivers/gpu/drm/msm/msm_gpu.c
> > +++ b/drivers/gpu/drm/msm/msm_gpu.c
> > @@ -281,6 +281,15 @@ static void msm_gpu_crashstate_capture(struct msm_=
gpu *gpu,
> >       if (submit) {
> >               int i;
> >
> > +             if (state->fault_info.ttbr0) {
> > +                     struct msm_gpu_fault_info *info =3D &state->fault=
_info;
> > +                     struct msm_mmu *mmu =3D submit->aspace->mmu;
> > +
> > +                     msm_iommu_pagetable_params(mmu, &info->pgtbl_ttbr=
0,
> > +                                                &info->asid);
> > +                     msm_iommu_pagetable_walk(mmu, info->iova, info->p=
tes);
> > +             }
> > +
> >               state->bos =3D kcalloc(submit->nr_bos,
> >                       sizeof(struct msm_gpu_state_bo), GFP_KERNEL);
> >
> > diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gp=
u.h
> > index 1f02bb9956be..82e838ba8c80 100644
> > --- a/drivers/gpu/drm/msm/msm_gpu.h
> > +++ b/drivers/gpu/drm/msm/msm_gpu.h
> > @@ -101,6 +101,14 @@ struct msm_gpu_fault_info {
> >       int flags;
> >       const char *type;
> >       const char *block;
> > +
> > +     /* Information about what we think/expect is the current SMMU sta=
te,
> > +      * for example expected_ttbr0 should match smmu_info.ttbr0 which
> > +      * was read back from SMMU registers.
> > +      */
> > +     phys_addr_t pgtbl_ttbr0;
> > +     u64 ptes[4];
> > +     int asid;
> >  };
> >
> >  /**
> > diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_=
iommu.c
> > index 2a94e82316f9..3e692818ba1f 100644
> > --- a/drivers/gpu/drm/msm/msm_iommu.c
> > +++ b/drivers/gpu/drm/msm/msm_iommu.c
> > @@ -195,6 +195,28 @@ struct iommu_domain_geometry *msm_iommu_get_geomet=
ry(struct msm_mmu *mmu)
> >       return &iommu->domain->geometry;
> >  }
> >
> > +int
> > +msm_iommu_pagetable_walk(struct msm_mmu *mmu, unsigned long iova, uint=
64_t ptes[4])
> > +{
> > +     struct msm_iommu_pagetable *pagetable;
> > +     struct arm_lpae_io_pgtable_walk_data wd =3D {};
> > +
> > +     if (mmu->type !=3D MSM_MMU_IOMMU_PAGETABLE)
> > +             return -EINVAL;
> > +
> > +     pagetable =3D to_pagetable(mmu);
> > +
> > +     if (!pagetable->pgtbl_ops->pgtable_walk)
> > +             return -EINVAL;
> > +
> > +     pagetable->pgtbl_ops->pgtable_walk(pagetable->pgtbl_ops, iova, &w=
d);
> > +
> > +     for (int i =3D 0; i < ARRAY_SIZE(wd.ptes); i++)
> > +             ptes[i] =3D wd.ptes[i];
> > +
> > +     return 0;
> > +}
> > +
> >  static const struct msm_mmu_funcs pagetable_funcs =3D {
> >               .map =3D msm_iommu_pagetable_map,
> >               .unmap =3D msm_iommu_pagetable_unmap,
> > diff --git a/drivers/gpu/drm/msm/msm_mmu.h b/drivers/gpu/drm/msm/msm_mm=
u.h
> > index 88af4f490881..96e509bd96a6 100644
> > --- a/drivers/gpu/drm/msm/msm_mmu.h
> > +++ b/drivers/gpu/drm/msm/msm_mmu.h
> > @@ -53,7 +53,8 @@ static inline void msm_mmu_set_fault_handler(struct m=
sm_mmu *mmu, void *arg,
> >  struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent);
> >
> >  int msm_iommu_pagetable_params(struct msm_mmu *mmu, phys_addr_t *ttbr,
> > -             int *asid);
> > +                            int *asid);
> > +int msm_iommu_pagetable_walk(struct msm_mmu *mmu, unsigned long iova, =
uint64_t ptes[4]);
> >  struct iommu_domain_geometry *msm_iommu_get_geometry(struct msm_mmu *m=
mu);
> >
> >  #endif /* __MSM_MMU_H__ */
> > --
> > 2.46.0
> >
