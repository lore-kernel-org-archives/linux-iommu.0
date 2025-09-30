Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C27F24886E
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 08:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759221688; cv=none; b=N9Tes2qW57hG0QYFRyYAh5VTaJq4tQ9JodlQw09orovI7mKp/bW09XdYITH0kLpyLXlE1gzqH6hkZCA7GoEs/rxZTNUNDBq7oAqLYV0321rhBJouLCE6DP+xkHYmILvJcF7wyuX2epE/zLAajdt/RQ8AU2QGeHHPFUFAOE/qGOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759221688; c=relaxed/simple;
	bh=aC/miStcGaKdpIRjl2Q0dBtV8nE75FDH/wwGkO/uuUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZhAGOKfcNjV3BDnM4J6IBMqwXKr/pEomireKmdIovKHLxa1AJnDayAuOMpNGAdFw+tsBc7lzWqSxP+QVrNWqfOkGKrieTS1r/vlgwUzhYOrfmegIRDH5G18K4yT9MiGGBqyiw3gV6K46u5S9DAzZaIqyFcuvmDMFUa09S24QfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kx6FU7zb; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kx6FU7zb"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33450918e4fso841466a91.1
        for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 01:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759221686; x=1759826486; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LD18/ABsae/KSnhXL/eHSriuLA+lvY1QWo8o6q93AWc=;
        b=Kx6FU7zbecjRIyKdr3ny4WHDEmxkFWbAXZrL/dp3cOtQSNjURmVx2ETaSqB6rkRYOB
         5YekkLp7O3/Ax5O8EoYByFxCiQyg5wEDlCQ8IJySTer69KuEQ8oHuqdFT9qkylBkmKbo
         gzWJAdLDYtcvIpXwKOFPT6XyJj6TAhg+PJVSPEONDAT9erG5CRloGpEyiUhv7XUC8a5u
         5rKAa2DmhJESEX73iKdH3MXsl7ISTstvOzvQrfK4mjyEY53FIQc1YbAzdCjR2AFNllPa
         HYQ+ZnuGc77OoHSNGuVm5ifRWKtAaZLfZcheq+al8QW0kY23wHqu+wEjQCKN7R4Q+GPt
         VvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759221686; x=1759826486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LD18/ABsae/KSnhXL/eHSriuLA+lvY1QWo8o6q93AWc=;
        b=M7T0e/0KVQX+WYjqAbOpP95ZO1rUrjT+JQPywBv7d27qwZ5yhizLHJOQJ1OXs7aj7K
         bke7UlHC+hR1I2G0ysbTwVVJ2VnK6bYO+3pxguF59aB1/sA1WWbpmEjfw6nU5AMeTz+5
         VYTr/WL+U9B6FL0HwviefIiM8IFJlyYHecYqDcLEt6reXcb8uw3KeJg8jVj8lVRbrCv5
         SVY6nFdE6r0o1k3DTJIMGvpFhDKHke6kfPstNX0iGsxrG0TGe8QzipX3+Hbxt6VXELQA
         XAjeTJJdppf2/Xy8YlHDNMldeWPDmq14Quha4EhoiZHPytm+jeeVHXK64mUz6TqpeB//
         w1lQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+QihXfEvvxzZTBfEa6S6s6s0pTkK3va89eGVfe8lSzXECmpGENcHt73//nhD52yHLqmxpsg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzc53safCXf4fdXaWzHBqzbDdOeIfvqagOt/6Q5Iu/Z3XCm8Vkc
	8vbjs7fpvqVNz3RqDozQjUGqlYIUYJDv4Nm+DrZOBk0Bbfq1tRYcWCTMEsFd750ikYj911wmMuH
	2519qdBdhArJYKxmtwQVh7EvD4qRTRqQ=
X-Gm-Gg: ASbGncutynkWcUpibrShK0vbDwnj5dDLjNm4wlVH7H7O+IBDHnXxNtHLWBUlO281rDL
	Yl2Fx/CjQCRNB6BU8uNxsW/VFsiRN2qNCe8q3Id3me78KJkVfpJ4KzPH+IRF2Sfwj7b0u5kONWz
	JTH+eQWxcz9U70Nav9O/IzABqMIDTxbj/j1KdOnWTt6Dq/PLJzlg31jSrdeJtlcDq2jb/gl9cRW
	oE/sQy0oaUlBBXpNcNxlYMQ1wAZmXTBT828PuCcTg+T9ymYTUovNUdLge6U
X-Google-Smtp-Source: AGHT+IG8jS1oLrn1olK1K1w0EZGHqly9vQX63ht+yCXO/XvKfJd4n+viViUghipUmXbk+vV+THGXMgTQG2PcwGuQ8Lg=
X-Received: by 2002:a17:90b:1b49:b0:330:7fd8:9b05 with SMTP id
 98e67ed59e1d1-3342a2bee5dmr10495028a91.3.1759221685419; Tue, 30 Sep 2025
 01:41:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-12-73530b0700ed@oss.qualcomm.com>
 <ks3ppjsy35wka2at5nxrr74l5mvzr4l6ovm5ncohanu2gn3ytl@gt2mzwjehq73> <CACSVV00AFEJVti7BryA-_sosmBKCuDtX7+NEi4aL4X98AqR1Qg@mail.gmail.com>
In-Reply-To: <CACSVV00AFEJVti7BryA-_sosmBKCuDtX7+NEi4aL4X98AqR1Qg@mail.gmail.com>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Tue, 30 Sep 2025 10:41:13 +0200
X-Gm-Features: AS18NWBO5tNAKAQ348z4ldUTuvm0KCN25KN4j612LeJ0DJ-orMAiAdk5W7QF5qw
Message-ID: <CACu1E7H0Y9wLwN=ztx+YSQLMQuqOF0hYPqvF-VdXyFW65og6og@mail.gmail.com>
Subject: Re: [PATCH 12/17] drm/msm/adreno: Introduce A8x GPU Support
To: rob.clark@oss.qualcomm.com
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Akhil P Oommen <akhilpo@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>, 
	Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jonathan Marek <jonathan@marek.ca>, 
	Jordan Crouse <jordan@cosmicpenguin.net>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 10:08=E2=80=AFAM Rob Clark <rob.clark@oss.qualcomm.=
com> wrote:
>
> On Tue, Sep 30, 2025 at 12:43=E2=80=AFAM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Tue, Sep 30, 2025 at 11:18:17AM +0530, Akhil P Oommen wrote:
> > > A8x is the next generation of Adreno GPUs, featuring a significant
> > > hardware design change. A major update to the design is the introduct=
ion
> > > of Slice architecture. Slices are sort of mini-GPUs within the GPU wh=
ich
> > > are more independent in processing Graphics and compute workloads. Al=
so,
> > > in addition to the BV and BR pipe we saw in A7x, CP has more concurre=
ncy
> > > with additional pipes.
> > >
> > > From a software interface perspective, these changes have a significa=
nt
> > > impact on the KMD side. First, the GPU register space has been extens=
ively
> > > reorganized. Second, to avoid  a register space explosion caused by t=
he
> > > new slice architecture and additional pipes, many registers are now
> > > virtualized, instead of duplicated as in A7x. KMD must configure an
> > > aperture register with the appropriate slice and pipe ID before acces=
sing
> > > these virtualized registers.
> > >
> > > This patch adds only a skeleton support for the A8x family. An A8x GP=
U
> > > support will be added in an upcoming patch.
> >
> > Consider this lands in a commit message. What would it mean in the Git
> > history?
> >
> > >
> > > Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> > > ---
> > >  drivers/gpu/drm/msm/Makefile                      |    1 +
> > >  drivers/gpu/drm/msm/adreno/a6xx_gpu.c             |  103 +-
> > >  drivers/gpu/drm/msm/adreno/a6xx_gpu.h             |   21 +
> > >  drivers/gpu/drm/msm/adreno/a8xx_gpu.c             | 1238 +++++++++++=
++++++++++
> > >  drivers/gpu/drm/msm/adreno/adreno_gpu.h           |    7 +
> > >  drivers/gpu/drm/msm/registers/adreno/a6xx.xml     |    1 -
> > >  drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml |    1 +
> > >  7 files changed, 1344 insertions(+), 28 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makef=
ile
> > > index 7acf2cc13cd047eb7f5b3f14e1a42a1cc145e087..8aa7d07303fb0cd668697=
67cb6298b38a621b366 100644
> > > --- a/drivers/gpu/drm/msm/Makefile
> > > +++ b/drivers/gpu/drm/msm/Makefile
> > > @@ -24,6 +24,7 @@ adreno-y :=3D \
> > >       adreno/a6xx_gmu.o \
> > >       adreno/a6xx_hfi.o \
> > >       adreno/a6xx_preempt.o \
> > > +     adreno/a8xx_gpu.o \
> > >
> > >  adreno-$(CONFIG_DEBUG_FS) +=3D adreno/a5xx_debugfs.o \
> > >
> > > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/=
msm/adreno/a6xx_gpu.c
> > > index bd4f98b5457356c5454d0316e59d7e8253401712..4aeeaceb1fb30a9d68ac6=
36c14249e3853ef73ac 100644
> > > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > > @@ -239,14 +239,21 @@ static void a6xx_set_pagetable(struct a6xx_gpu =
*a6xx_gpu,
> > >       }
> > >
> > >       if (!sysprof) {
> > > -             if (!adreno_is_a7xx(adreno_gpu)) {
> > > +             if (!(adreno_is_a7xx(adreno_gpu) || adreno_is_a8xx(adre=
no_gpu))) {
> >
> > Here and in several other similar places:
> >
> >                 if (!adreno_is_a7xx(adreno_gpu) &&
> >                     !adreno_is_a8xx(adreno_gpu))) {
> >
> > >                       /* Turn off protected mode to write to special =
registers */
> > >                       OUT_PKT7(ring, CP_SET_PROTECTED_MODE, 1);
> > >                       OUT_RING(ring, 0);
> > >               }
> > >
> > > -             OUT_PKT4(ring, REG_A6XX_RBBM_PERFCTR_SRAM_INIT_CMD, 1);
> > > -             OUT_RING(ring, 1);
> > > +             if (adreno_is_a8xx(adreno_gpu)) {
> > > +                     OUT_PKT4(ring, REG_A8XX_RBBM_PERFCTR_SRAM_INIT_=
CMD, 1);
> > > +                     OUT_RING(ring, 1);
> > > +                     OUT_PKT4(ring, REG_A8XX_RBBM_SLICE_PERFCTR_SRAM=
_INIT_CMD, 1);
> > > +                     OUT_RING(ring, 1);
> > > +             } else {
> > > +                     OUT_PKT4(ring, REG_A6XX_RBBM_PERFCTR_SRAM_INIT_=
CMD, 1);
> > > +                     OUT_RING(ring, 1);
> > > +             }
> > >       }
> > >
> > >       /* Execute the table update */
> > > @@ -275,7 +282,7 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a=
6xx_gpu,
> > >        * to make sure BV doesn't race ahead while BR is still switchi=
ng
> > >        * pagetables.
> > >        */
> > > -     if (adreno_is_a7xx(&a6xx_gpu->base)) {
> > > +     if (adreno_is_a7xx(&a6xx_gpu->base) && adreno_is_a8xx(&a6xx_gpu=
->base)) {
> > >               OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
> > >               OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SE=
T_THREAD_BR);
> > >       }
> > > @@ -289,20 +296,22 @@ static void a6xx_set_pagetable(struct a6xx_gpu =
*a6xx_gpu,
> > >       OUT_RING(ring, CACHE_INVALIDATE);
> > >
> > >       if (!sysprof) {
> > > +             u32 reg_status =3D adreno_is_a8xx(adreno_gpu) ?
> > > +                     REG_A8XX_RBBM_PERFCTR_SRAM_INIT_STATUS :
> > > +                     REG_A6XX_RBBM_PERFCTR_SRAM_INIT_STATUS;
> > >               /*
> > >                * Wait for SRAM clear after the pgtable update, so the
> > >                * two can happen in parallel:
> > >                */
> > >               OUT_PKT7(ring, CP_WAIT_REG_MEM, 6);
> > >               OUT_RING(ring, CP_WAIT_REG_MEM_0_FUNCTION(WRITE_EQ));
> > > -             OUT_RING(ring, CP_WAIT_REG_MEM_POLL_ADDR_LO(
> > > -                             REG_A6XX_RBBM_PERFCTR_SRAM_INIT_STATUS)=
);
> > > +             OUT_RING(ring, CP_WAIT_REG_MEM_POLL_ADDR_LO(reg_status)=
);
> > >               OUT_RING(ring, CP_WAIT_REG_MEM_POLL_ADDR_HI(0));
> > >               OUT_RING(ring, CP_WAIT_REG_MEM_3_REF(0x1));
> > >               OUT_RING(ring, CP_WAIT_REG_MEM_4_MASK(0x1));
> > >               OUT_RING(ring, CP_WAIT_REG_MEM_5_DELAY_LOOP_CYCLES(0));
> > >
> > > -             if (!adreno_is_a7xx(adreno_gpu)) {
> > > +             if (!(adreno_is_a7xx(adreno_gpu) || adreno_is_a8xx(adre=
no_gpu))) {
> > >                       /* Re-enable protected mode: */
> > >                       OUT_PKT7(ring, CP_SET_PROTECTED_MODE, 1);
> > >                       OUT_RING(ring, 1);
> > > @@ -441,6 +450,7 @@ static void a7xx_submit(struct msm_gpu *gpu, stru=
ct msm_gem_submit *submit)
> > >       struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> > >       struct msm_ringbuffer *ring =3D submit->ring;
> > >       unsigned int i, ibs =3D 0;
> > > +     u32 rbbm_perfctr_cp0, cp_always_on_counter;
> > >
> > >       adreno_check_and_reenable_stall(adreno_gpu);
> > >
> > > @@ -460,10 +470,16 @@ static void a7xx_submit(struct msm_gpu *gpu, st=
ruct msm_gem_submit *submit)
> > >       if (gpu->nr_rings > 1)
> > >               a6xx_emit_set_pseudo_reg(ring, a6xx_gpu, submit->queue)=
;
> > >
> > > -     get_stats_counter(ring, REG_A7XX_RBBM_PERFCTR_CP(0),
> > > -             rbmemptr_stats(ring, index, cpcycles_start));
> > > -     get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_COUNTER,
> > > -             rbmemptr_stats(ring, index, alwayson_start));
> > > +     if (adreno_is_a8xx(adreno_gpu)) {
> > > +             rbbm_perfctr_cp0 =3D REG_A8XX_RBBM_PERFCTR_CP(0);
> > > +             cp_always_on_counter =3D REG_A8XX_CP_ALWAYS_ON_COUNTER;
> > > +     } else {
> > > +             rbbm_perfctr_cp0 =3D REG_A7XX_RBBM_PERFCTR_CP(0);
> > > +             cp_always_on_counter =3D REG_A6XX_CP_ALWAYS_ON_COUNTER;
> > > +     }
> > > +
> > > +     get_stats_counter(ring, rbbm_perfctr_cp0, rbmemptr_stats(ring, =
index, cpcycles_start));
> > > +     get_stats_counter(ring, cp_always_on_counter, rbmemptr_stats(ri=
ng, index, alwayson_start));
> > >
> > >       OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
> > >       OUT_RING(ring, CP_SET_THREAD_BOTH);
> > > @@ -510,10 +526,8 @@ static void a7xx_submit(struct msm_gpu *gpu, str=
uct msm_gem_submit *submit)
> > >               OUT_RING(ring, 0x00e); /* IB1LIST end */
> > >       }
> > >
> > > -     get_stats_counter(ring, REG_A7XX_RBBM_PERFCTR_CP(0),
> > > -             rbmemptr_stats(ring, index, cpcycles_end));
> > > -     get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_COUNTER,
> > > -             rbmemptr_stats(ring, index, alwayson_end));
> > > +     get_stats_counter(ring, rbbm_perfctr_cp0, rbmemptr_stats(ring, =
index, cpcycles_end));
> > > +     get_stats_counter(ring, cp_always_on_counter, rbmemptr_stats(ri=
ng, index, alwayson_end));
> > >
> > >       /* Write the fence to the scratch register */
> > >       OUT_PKT4(ring, REG_A6XX_CP_SCRATCH(2), 1);
> > > @@ -706,8 +720,11 @@ static int a6xx_calc_ubwc_config(struct adreno_g=
pu *gpu)
> > >       /* Copy the data into the internal struct to drop the const qua=
lifier (temporarily) */
> > >       *cfg =3D *common_cfg;
> > >
> > > -     cfg->ubwc_swizzle =3D 0x6;
> > > -     cfg->highest_bank_bit =3D 15;
> > > +     /* Use common config as is for A8x */
> > > +     if (!adreno_is_a8xx(gpu)) {
> > > +             cfg->ubwc_swizzle =3D 0x6;
> > > +             cfg->highest_bank_bit =3D 15;
> > > +     }
> > >
> > >       if (adreno_is_a610(gpu)) {
> > >               cfg->highest_bank_bit =3D 13;
> > > @@ -818,7 +835,7 @@ static void a6xx_set_ubwc_config(struct msm_gpu *=
gpu)
> > >                 cfg->macrotile_mode);
> > >  }
> > >
> > > -static void a7xx_patch_pwrup_reglist(struct msm_gpu *gpu)
> > > +void a7xx_patch_pwrup_reglist(struct msm_gpu *gpu)
> > >  {
> > >       struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> > >       struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> > > @@ -868,7 +885,7 @@ static void a7xx_patch_pwrup_reglist(struct msm_g=
pu *gpu)
> > >       lock->dynamic_list_len =3D 0;
> > >  }
> > >
> > > -static int a7xx_preempt_start(struct msm_gpu *gpu)
> > > +int a7xx_preempt_start(struct msm_gpu *gpu)
> > >  {
> > >       struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> > >       struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> > > @@ -925,7 +942,7 @@ static int a6xx_cp_init(struct msm_gpu *gpu)
> > >       return a6xx_idle(gpu, ring) ? 0 : -EINVAL;
> > >  }
> > >
> > > -static int a7xx_cp_init(struct msm_gpu *gpu)
> > > +int a7xx_cp_init(struct msm_gpu *gpu)
> > >  {
> > >       struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> > >       struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> > > @@ -993,7 +1010,7 @@ static bool a6xx_ucode_check_version(struct a6xx=
_gpu *a6xx_gpu,
> > >               return false;
> > >
> > >       /* A7xx is safe! */
> > > -     if (adreno_is_a7xx(adreno_gpu) || adreno_is_a702(adreno_gpu))
> > > +     if (adreno_is_a7xx(adreno_gpu) || adreno_is_a702(adreno_gpu) ||=
 adreno_is_a8xx(adreno_gpu))
> > >               return true;
> > >
> > >       /*
> > > @@ -2161,7 +2178,7 @@ void a6xx_bus_clear_pending_transactions(struct=
 adreno_gpu *adreno_gpu, bool gx_
> > >  void a6xx_gpu_sw_reset(struct msm_gpu *gpu, bool assert)
> > >  {
> > >       /* 11nm chips (e.g. ones with A610) have hw issues with the res=
et line! */
> > > -     if (adreno_is_a610(to_adreno_gpu(gpu)))
> > > +     if (adreno_is_a610(to_adreno_gpu(gpu)) || adreno_is_a8xx(to_adr=
eno_gpu(gpu)))
> > >               return;
> > >
> > >       gpu_write(gpu, REG_A6XX_RBBM_SW_RESET_CMD, assert);
> > > @@ -2192,7 +2209,12 @@ static int a6xx_gmu_pm_resume(struct msm_gpu *=
gpu)
> > >
> > >       msm_devfreq_resume(gpu);
> > >
> > > -     adreno_is_a7xx(adreno_gpu) ? a7xx_llc_activate(a6xx_gpu) : a6xx=
_llc_activate(a6xx_gpu);
> > > +     if (adreno_is_a8xx(adreno_gpu))
> > > +             a8xx_llc_activate(a6xx_gpu);
> > > +     else if (adreno_is_a7xx(adreno_gpu))
> > > +             a7xx_llc_activate(a6xx_gpu);
> > > +     else
> > > +             a6xx_llc_activate(a6xx_gpu);
> > >
> > >       return ret;
> > >  }
> > > @@ -2561,10 +2583,8 @@ static struct msm_gpu *a6xx_gpu_init(struct dr=
m_device *dev)
> > >       adreno_gpu->base.hw_apriv =3D
> > >               !!(config->info->quirks & ADRENO_QUIRK_HAS_HW_APRIV);
> > >
> > > -     /* gpu->info only gets assigned in adreno_gpu_init() */
> > > -     is_a7xx =3D config->info->family =3D=3D ADRENO_7XX_GEN1 ||
> > > -               config->info->family =3D=3D ADRENO_7XX_GEN2 ||
> > > -               config->info->family =3D=3D ADRENO_7XX_GEN3;
> > > +     /* gpu->info only gets assigned in adreno_gpu_init(). A8x is in=
cluded intentionally */
> > > +     is_a7xx =3D config->info->family >=3D ADRENO_7XX_GEN1;
> >
> > Is A8xx also a part of is_a7xx? What about the A9XX which will come at
> > some point in future?
> >
> > >
> > >       a6xx_llc_slices_init(pdev, a6xx_gpu, is_a7xx);
> > >
> > > +
> > > +int a8xx_gpu_feature_probe(struct msm_gpu *gpu)
> > > +{
> > > +     struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> > > +     struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> > > +     u32 fuse_val;
> > > +     int ret;
> > > +
> > > +     /*
> > > +      * Assume that if qcom scm isn't available, that whatever
> > > +      * replacement allows writing the fuse register ourselves.
> > > +      * Users of alternative firmware need to make sure this
> > > +      * register is writeable or indicate that it's not somehow.
> > > +      * Print a warning because if you mess this up you're about to
> > > +      * crash horribly.
> > > +      */
> > > +     if (!qcom_scm_is_available()) {
> >
> > How can it be not available here?
> >
> > > +             dev_warn_once(gpu->dev->dev,
> > > +                     "SCM is not available, poking fuse register\n")=
;
> > > +             a6xx_llc_write(a6xx_gpu, REG_A7XX_CX_MISC_SW_FUSE_VALUE=
,
> > > +                     A7XX_CX_MISC_SW_FUSE_VALUE_RAYTRACING |
> > > +                     A7XX_CX_MISC_SW_FUSE_VALUE_FASTBLEND |
> > > +                     A7XX_CX_MISC_SW_FUSE_VALUE_LPAC);
> > > +             adreno_gpu->has_ray_tracing =3D true;
> > > +             return 0;
> > > +     }
> > > +
> > > +     ret =3D qcom_scm_gpu_init_regs(QCOM_SCM_GPU_ALWAYS_EN_REQ |
> > > +                                  QCOM_SCM_GPU_TSENSE_EN_REQ);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     /*
> > > +      * On a750 raytracing may be disabled by the firmware, find out
> >
> > It's a8xx-related code, why do you have a750 in the comment?
>
> This is actually related to >=3D a750..  from a brief look it seems like
> the whole fuse thing can be split into a helper and shared btwn
> a7xx/a8xx?

It seems like we can just reuse a7xx_cx_mem_init() with maybe some
slight changes to the generation check instead of copying and pasting
it here.

Connor

>
> BR,
> -R
>
> > > +      * whether that's the case. The scm call above sets the fuse
> > > +      * register.
> > > +      */
> > > +     fuse_val =3D a6xx_llc_read(a6xx_gpu,
> > > +                              REG_A7XX_CX_MISC_SW_FUSE_VALUE);
> > > +     adreno_gpu->has_ray_tracing =3D
> > > +             !!(fuse_val & A7XX_CX_MISC_SW_FUSE_VALUE_RAYTRACING);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +
> > > +#define GBIF_CLIENT_HALT_MASK                BIT(0)
> > > +#define GBIF_ARB_HALT_MASK           BIT(1)
> > > +#define VBIF_XIN_HALT_CTRL0_MASK     GENMASK(3, 0)
> > > +#define VBIF_RESET_ACK_MASK          0xF0
> > > +#define GPR0_GBIF_HALT_REQUEST               0x1E0
> > > +
> > > +void a8xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_g=
pu, bool gx_off)
> > > +{
> > > +     struct msm_gpu *gpu =3D &adreno_gpu->base;
> > > +
> > > +     if (gx_off) {
> > > +             /* Halt the gx side of GBIF */
> > > +             gpu_write(gpu, REG_A8XX_RBBM_GBIF_HALT, 1);
> > > +             spin_until(gpu_read(gpu, REG_A8XX_RBBM_GBIF_HALT_ACK) &=
 1);
> > > +     }
> > > +
> > > +     /* Halt new client requests on GBIF */
> > > +     gpu_write(gpu, REG_A6XX_GBIF_HALT, GBIF_CLIENT_HALT_MASK);
> > > +     spin_until((gpu_read(gpu, REG_A6XX_GBIF_HALT_ACK) &
> > > +                     (GBIF_CLIENT_HALT_MASK)) =3D=3D GBIF_CLIENT_HAL=
T_MASK);
> > > +
> > > +     /* Halt all AXI requests on GBIF */
> > > +     gpu_write(gpu, REG_A6XX_GBIF_HALT, GBIF_ARB_HALT_MASK);
> > > +     spin_until((gpu_read(gpu,  REG_A6XX_GBIF_HALT_ACK) &
> > > +                     (GBIF_ARB_HALT_MASK)) =3D=3D GBIF_ARB_HALT_MASK=
);
> > > +
> > > +     /* The GBIF halt needs to be explicitly cleared */
> > > +     gpu_write(gpu, REG_A6XX_GBIF_HALT, 0x0);
> > > +}
> > > +
> > > +int a8xx_gmu_get_timestamp(struct msm_gpu *gpu, uint64_t *value)
> > > +{
> > > +     struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> > > +     struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> > > +
> > > +     mutex_lock(&a6xx_gpu->gmu.lock);
> > > +
> > > +     /* Force the GPU power on so we can read this register */
> > > +     a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_PERFCOUNTER_SET);
> > > +
> > > +     *value =3D gpu_read64(gpu, REG_A8XX_CP_ALWAYS_ON_COUNTER);
> > > +
> > > +     a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_PERFCOUNTER_SET);
> > > +
> > > +     mutex_unlock(&a6xx_gpu->gmu.lock);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +u64 a8xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rat=
e)
> > > +{
> > > +     struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> > > +     struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> > > +     u64 busy_cycles;
> > > +
> > > +     /* 19.2MHz */
> > > +     *out_sample_rate =3D 19200000;
> > > +
> > > +     busy_cycles =3D gmu_read64(&a6xx_gpu->gmu,
> > > +                     REG_A8XX_GMU_CX_GMU_POWER_COUNTER_XOCLK_0_L,
> > > +                     REG_A8XX_GMU_CX_GMU_POWER_COUNTER_XOCLK_0_H);
> > > +
> > > +     return busy_cycles;
> > > +}
> > > +
> > > +bool a8xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
> > > +{
> > > +     return true;
> > > +}
> > > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/dr=
m/msm/adreno/adreno_gpu.h
> > > index 9831401c3bc865b803c2f9759d5e2ffcd79d19f8..6a2157f31122ba0c2f2a7=
005c98e3e4f1ada6acc 100644
> > > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> > > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> > > @@ -90,6 +90,13 @@ struct adreno_reglist {
> > >       u32 value;
> > >  };
> > >
> > > +/* Reglist with pipe information */
> > > +struct adreno_reglist_pipe {
> > > +     u32 offset;
> > > +     u32 value;
> > > +     u32 pipe;
> > > +};
> > > +
> > >  struct adreno_speedbin {
> > >       uint16_t fuse;
> > >       uint16_t speedbin;
> > > diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml b/drivers/=
gpu/drm/msm/registers/adreno/a6xx.xml
> > > index ddde2e03b748f447b5e57571e2b04c68f8f2efc2..c3a202c8dce65d414c89b=
f76f1cb458b206b4eca 100644
> > > --- a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
> > > +++ b/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
> > > @@ -4876,7 +4876,6 @@ by a particular renderpass/blit.
> > >  <domain name=3D"A6XX_CX_MISC" width=3D"32" prefix=3D"variant" varset=
=3D"chip">
> > >       <reg32 offset=3D"0x0001" name=3D"SYSTEM_CACHE_CNTL_0"/>
> > >       <reg32 offset=3D"0x0002" name=3D"SYSTEM_CACHE_CNTL_1"/>
> > > -     <reg32 offset=3D"0x0087" name=3D"SLICE_ENABLE_FINAL" variants=
=3D"A8XX-"/>
> >
> > Why?
> >
> > >       <reg32 offset=3D"0x0039" name=3D"CX_MISC_TCM_RET_CNTL" variants=
=3D"A7XX-"/>
> > >       <reg32 offset=3D"0x0087" name=3D"CX_MISC_SLICE_ENABLE_FINAL" va=
riants=3D"A8XX"/>
> > >       <reg32 offset=3D"0x0400" name=3D"CX_MISC_SW_FUSE_VALUE" variant=
s=3D"A7XX-">
> > > diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml b/driv=
ers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
> > > index 5dce7934056dd6472c368309b4894f0ed4a4d960..c4e00b1263cda65dce89c=
2f16860e5bf6f1c6244 100644
> > > --- a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
> > > +++ b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
> > > @@ -60,6 +60,7 @@ xsi:schemaLocation=3D"https://gitlab.freedesktop.or=
g/freedreno/ rules-fd.xsd">
> > >       <reg32 offset=3D"0x1f400" name=3D"GMU_ICACHE_CONFIG"/>
> > >       <reg32 offset=3D"0x1f401" name=3D"GMU_DCACHE_CONFIG"/>
> > >       <reg32 offset=3D"0x1f40f" name=3D"GMU_SYS_BUS_CONFIG"/>
> > > +     <reg32 offset=3D"0x1f50b" name=3D"GMU_MRC_GBIF_QOS_CTRL"/>
> > >       <reg32 offset=3D"0x1f800" name=3D"GMU_CM3_SYSRESET"/>
> > >       <reg32 offset=3D"0x1f801" name=3D"GMU_CM3_BOOT_CONFIG"/>
> > >       <reg32 offset=3D"0x1f81a" name=3D"GMU_CM3_FW_BUSY"/>
> > >
> > > --
> > > 2.51.0
> > >
> >
> > --
> > With best wishes
> > Dmitry
