Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C116253B76
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203527; cv=none; b=FrV0QrSEq/nxOv1tT+GXCw4KbDZ6qSdHdto6znF5qDlZrzRiWqQjl/mZ2PzhOi3cgG9LqVR7TyGpi2JFigkQ81JyyASe31/bVG6KQ2pK3R/aMVK9nUQ7hhCnSCXYmT8u1MVSRGNNYCr7CWGihRyDM/U4HymeMSyuwmAOMJKI2nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203527; c=relaxed/simple;
	bh=5IZF43266tVOPpXKJ+edVRwFMIRrRRwzhduxrJwCjcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVYvN+9toRUGRIa3RYNcs/PUYDsOWSNjXlZFm/d0FqRydHYUdwc2lzzOjLHlIfn0n9sZQgIqr8m8F7yEDG8xkmqreVL9S2wPJ93aKw7xb/Xi0RWJsPyRHTujlXC6eTGomhwfNvtXlCxmzFvSF9opDGD29gC50LksL1XUP0EU3d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJK30yHm; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJK30yHm"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2234f57b892so16868035ad.1
        for <iommu@lists.linux.dev>; Wed, 05 Mar 2025 11:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741203525; x=1741808325; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VSNFszbahKaJkcW+v0MHhL95zb4sCAydonSXrjA+2M=;
        b=IJK30yHmMcScTN7CHXMEIKDSiaXFwBmq0DMBUtiSnBPwg/WyJdYfcd7UiBHpd973wT
         LS4ZLWQdBW7/0JImx0TE9jLVmNtKy0ZThZCGoc8t/wWjCb2jIo6WMDDDf/2f9dysl4pQ
         tLJTleNOtc5zx4zXkRW8ixrdPwV3xu+1ic5Ck/NoRioHIr8Zb4iX5voTwJAeKe//KwTU
         ZRDBxQyAx0qcxWNC0ZAAXFyxrMPFWKNqmDebtgLgXTVT44M0CFjHyyfmmLyTA+HwjJUa
         J+Jn4THMbdWfyvmk8AXe6lboPSeWl95c6c/M8X+VcPoEBHep3KtPXQWIQD8JbgSWlY4U
         tI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741203525; x=1741808325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VSNFszbahKaJkcW+v0MHhL95zb4sCAydonSXrjA+2M=;
        b=s65XwA73s0py8GCaDKx6SlT3RUklxcLlcTNCtBrD4atEBFvr+XGRIyQWINPFwTtNxF
         8te/Cv4LAtp8dH+l9wLqsJR2uem5FiVGO+BnqBfC38XG9WRyxgWF1rg3BO4s8YBL0sK7
         z1+SAcXBo6pJtmOCmaEoJmF0dLAb8qGROpuBoDcZslmCxa3bKqIbE10tir2DqR8NrErN
         Ijc4ktysW+mleVmRXCLOodUfYpGVfs0NO1Tc2Vy3LzohnEoolWhzstbqy/6i2MYWJw+f
         rIsv9A6dQAS+kh6FsQGtD5B7XkXqzYndlBnqlcftZwMfKd4twFAm5RsdVa/xAUUpfd0r
         mpWw==
X-Forwarded-Encrypted: i=1; AJvYcCXqaasO3RazxVNaMBz/8AZcTVLV2+0MOWlZpnf1VDbVyj/vZEHATaoysYr1izQ6W4fheJIh9A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwibtnMv5o/LTkvAgofEEYnXDVkXmgmwa1WCn42a2iKalfz+uwd
	iuyeEf7Uf6Axn4sv4vxpKLdo+AHUNbvfWb7CiH6V+k+NQEM4l+ggyad6pPYr/gqTOe4lvWDdO/d
	3n2AA6xtwq95hgS31rrZWUef1GIE=
X-Gm-Gg: ASbGncvq+2zPB7JQIeL6UUHaJlhcRmT78NktW/73pJ5M4Hsy/IYO0TOCHCw2H8rEqgz
	dyOMoOKMbyd4G5UuS0eUL7Czg8E18q9mzkew6E7NDFXaTvHqxF+8fdExswBhcruCovqPS33ZH9N
	0Um17KFnmMmmBZlCLh5W9QUn9lvA==
X-Google-Smtp-Source: AGHT+IGkUD67LVwvrDDzeIP3Gk8ODe8QE0TQVfS+q8UCYC5dtWHz2mbZqV0v//k1ot8vwNyp2q8z92TRSaaL2MCYYq8=
X-Received: by 2002:a17:903:11c3:b0:223:397e:a55b with SMTP id
 d9443c01a7336-223f1c9821cmr25525185ad.4.1741203524671; Wed, 05 Mar 2025
 11:38:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250304-msm-gpu-fault-fixes-next-v4-0-be14be37f4c3@gmail.com>
 <20250304-msm-gpu-fault-fixes-next-v4-5-be14be37f4c3@gmail.com> <CAF6AEGufRP9NuqC1gYy6jrQ9z+XqGFd7KNsbQw8C8NscSOJnJQ@mail.gmail.com>
In-Reply-To: <CAF6AEGufRP9NuqC1gYy6jrQ9z+XqGFd7KNsbQw8C8NscSOJnJQ@mail.gmail.com>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Wed, 5 Mar 2025 14:38:32 -0500
X-Gm-Features: AQ5f1Jp1eKuGw2SRyjhHwJJ1tVPBo4HU7lGgDAsHmIIiVFDPfMP5Apowl_tCUTo
Message-ID: <CACu1E7FPO253T+EvdJdaBuqh3kb7H_r7WhBE+bVxSHMPq6ixEg@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] drm/msm: Temporarily disable stall-on-fault after
 a page fault
To: Rob Clark <robdclark@gmail.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 2:07=E2=80=AFPM Rob Clark <robdclark@gmail.com> wrot=
e:
>
> On Tue, Mar 4, 2025 at 8:57=E2=80=AFAM Connor Abbott <cwabbott0@gmail.com=
> wrote:
> >
> > When things go wrong, the GPU is capable of quickly generating millions
> > of faulting translation requests per second. When that happens, in the
> > stall-on-fault model each access will stall until it wins the race to
> > signal the fault and then the RESUME register is written. This slows
> > processing page faults to a crawl as the GPU can generate faults much
> > faster than the CPU can acknowledge them. It also means that all
> > available resources in the SMMU are saturated waiting for the stalled
> > transactions, so that other transactions such as transactions generated
> > by the GMU, which shares a context bank with the GPU, cannot proceed.
>
> Nit, the GMU does not actually share a cb.. looking on x1e80100.dtsi,
> the GMU has cb 5 and gpu has 0 and 1.  (Currently we just use the
> first, but I guess the 2nd would be used if we supported protected
> content?)

Yeah, I realized after writing this that's the case. But I guess the
QoS issues happen even with separate context banks due to the way they
allocate translation units?

Connor

>
> fwiw, you can read this from dtsi, ie. in the GMU node, "iommus =3D
> <&adreno_smmu 5 0x0>;"
>
> > This causes a GMU watchdog timeout, which leads to a failed reset
> > because GX cannot collapse when there is a transaction pending and a
> > permanently hung GPU.
> >
> > On older platforms with qcom,smmu-v2, it seems that when one transactio=
n
> > is stalled subsequent faulting transactions are terminated, which avoid=
s
> > this problem, but the MMU-500 follows the spec here.
> >
> > To work around these problem, disable stall-on-fault as soon as we get =
a
> > page fault until a cooldown period after pagefaults stop. This allows
> > the GMU some guaranteed time to continue working. We only use
> > stall-on-fault to halt the GPU while we collect a devcoredump and we
> > always terminate the transaction afterward, so it's fine to miss some
> > subsequent page faults. We also keep it disabled so long as the current
> > devcoredump hasn't been deleted, because in that case we likely won't
> > capture another one if there's a fault.
> >
> > After this commit HFI messages still occasionally time out, because the
> > crashdump handler doesn't run fast enough to let the GMU resume, but th=
e
> > driver seems to recover from it. This will probably go away after the
> > HFI timeout is increased.
> >
> > Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
> > ---
> >  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  2 ++
> >  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   |  4 ++++
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 42 +++++++++++++++++++++++++=
+++++++-
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.h | 24 +++++++++++++++++++
> >  drivers/gpu/drm/msm/msm_iommu.c         |  9 +++++++
> >  drivers/gpu/drm/msm/msm_mmu.h           |  1 +
> >  6 files changed, 81 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/ms=
m/adreno/a5xx_gpu.c
> > index 71dca78cd7a5324e9ff5b14f173e2209fa42e196..670141531112c9d29cef8ef=
1fd51b74759fdd6d2 100644
> > --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> > @@ -131,6 +131,8 @@ static void a5xx_submit(struct msm_gpu *gpu, struct=
 msm_gem_submit *submit)
> >         struct msm_ringbuffer *ring =3D submit->ring;
> >         unsigned int i, ibs =3D 0;
> >
> > +       adreno_check_and_reenable_stall(adreno_gpu);
> > +
> >         if (IS_ENABLED(CONFIG_DRM_MSM_GPU_SUDO) && submit->in_rb) {
> >                 ring->cur_ctx_seqno =3D 0;
> >                 a5xx_submit_in_rb(gpu, submit);
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/ms=
m/adreno/a6xx_gpu.c
> > index 0ae29a7c8a4d3f74236a35cc919f69d5c0a384a0..5a34cd2109a2d74c9284144=
8a61ccb0d4f34e264 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > @@ -212,6 +212,8 @@ static void a6xx_submit(struct msm_gpu *gpu, struct=
 msm_gem_submit *submit)
> >         struct msm_ringbuffer *ring =3D submit->ring;
> >         unsigned int i, ibs =3D 0;
> >
> > +       adreno_check_and_reenable_stall(adreno_gpu);
> > +
> >         a6xx_set_pagetable(a6xx_gpu, ring, submit);
> >
> >         get_stats_counter(ring, REG_A6XX_RBBM_PERFCTR_CP(0),
> > @@ -335,6 +337,8 @@ static void a7xx_submit(struct msm_gpu *gpu, struct=
 msm_gem_submit *submit)
> >         struct msm_ringbuffer *ring =3D submit->ring;
> >         unsigned int i, ibs =3D 0;
> >
> > +       adreno_check_and_reenable_stall(adreno_gpu);
> > +
> >         /*
> >          * Toggle concurrent binning for pagetable switch and set the t=
hread to
> >          * BR since only it can execute the pagetable switch packets.
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/=
msm/adreno/adreno_gpu.c
> > index 1238f326597808eb28b4c6822cbd41a26e555eb9..bac586101dc0494f46b069a=
8440a45825dfe9b5e 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > @@ -246,16 +246,53 @@ u64 adreno_private_address_space_size(struct msm_=
gpu *gpu)
> >         return SZ_4G;
> >  }
> >
> > +void adreno_check_and_reenable_stall(struct adreno_gpu *adreno_gpu)
> > +{
> > +       struct msm_gpu *gpu =3D &adreno_gpu->base;
> > +       unsigned long flags;
> > +
> > +       /*
> > +        * Wait until the cooldown period has passed and we would actua=
lly
> > +        * collect a crashdump to re-enable stall-on-fault.
> > +        */
> > +       spin_lock_irqsave(&adreno_gpu->fault_stall_lock, flags);
> > +       if (!adreno_gpu->stall_enabled &&
> > +                       ktime_after(ktime_get(), adreno_gpu->stall_reen=
able_time) &&
> > +                       !READ_ONCE(gpu->crashstate)) {
> > +               adreno_gpu->stall_enabled =3D true;
> > +
> > +               gpu->aspace->mmu->funcs->set_stall(gpu->aspace->mmu, tr=
ue);
> > +       }
> > +       spin_unlock_irqrestore(&adreno_gpu->fault_stall_lock, flags);
> > +}
> > +
> >  #define ARM_SMMU_FSR_TF                 BIT(1)
> >  #define ARM_SMMU_FSR_PF                        BIT(3)
> >  #define ARM_SMMU_FSR_EF                        BIT(4)
> > +#define ARM_SMMU_FSR_SS                        BIT(30)
> >
> >  int adreno_fault_handler(struct msm_gpu *gpu, unsigned long iova, int =
flags,
> >                          struct adreno_smmu_fault_info *info, const cha=
r *block,
> >                          u32 scratch[4])
> >  {
> > +       struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> >         const char *type =3D "UNKNOWN";
> > -       bool do_devcoredump =3D info && !READ_ONCE(gpu->crashstate);
> > +       bool do_devcoredump =3D info && (info->fsr & ARM_SMMU_FSR_SS) &=
&
> > +               !READ_ONCE(gpu->crashstate);
> > +       unsigned long irq_flags;
> > +
> > +       /*
> > +        * In case there is a subsequent storm of pagefaults, disable
> > +        * stall-on-fault for at least half a second.
> > +        */
> > +       spin_lock_irqsave(&adreno_gpu->fault_stall_lock, irq_flags);
> > +       if (adreno_gpu->stall_enabled) {
> > +               adreno_gpu->stall_enabled =3D false;
> > +
> > +               gpu->aspace->mmu->funcs->set_stall(gpu->aspace->mmu, fa=
lse);
> > +       }
> > +       adreno_gpu->stall_reenable_time =3D ktime_add_ms(ktime_get(), 5=
00);
> > +       spin_unlock_irqrestore(&adreno_gpu->fault_stall_lock, irq_flags=
);
> >
> >         /*
> >          * If we aren't going to be resuming later from fault_worker, t=
hen do
> > @@ -1143,6 +1180,9 @@ int adreno_gpu_init(struct drm_device *drm, struc=
t platform_device *pdev,
> >                 adreno_gpu->info->inactive_period);
> >         pm_runtime_use_autosuspend(dev);
> >
> > +       spin_lock_init(&adreno_gpu->fault_stall_lock);
> > +       adreno_gpu->stall_enabled =3D true;
> > +
> >         return msm_gpu_init(drm, pdev, &adreno_gpu->base, &funcs->base,
> >                         gpu_name, &adreno_gpu_config);
> >  }
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/=
msm/adreno/adreno_gpu.h
> > index dcf454629ce037b2a8274a6699674ad754ce1f07..a528036b46216bd898f6d48=
c5fb0555c4c4b053b 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> > @@ -205,6 +205,28 @@ struct adreno_gpu {
> >         /* firmware: */
> >         const struct firmware *fw[ADRENO_FW_MAX];
> >
> > +       /**
> > +        * fault_stall_lock:
>
> nit, @fault_stall_lock:  And for
> fault_stall_reenable_time/stall_enabled, it wouldn't hurt to add
> something along the lines of "Protected by @fault_stall_lock".  I've
> been slowly trying to improve the comment docs over time, I have some
> of that in my vmbind patchset.
>
> Anyways, with those nits addressed, r-b
>
> BR,
> -R
>
> > +        *
> > +        * Serialize changes to stall-on-fault state.
> > +        */
> > +       spinlock_t fault_stall_lock;
> > +
> > +       /**
> > +        * fault_stall_reenable_time:
> > +        *
> > +        * if stall_enabled is false, when to reenable stall-on-fault.
> > +        */
> > +       ktime_t stall_reenable_time;
> > +
> > +       /**
> > +        * stall_enabled:
> > +        *
> > +        * Whether stall-on-fault is currently enabled.
> > +        */
> > +       bool stall_enabled;
> > +
> > +
> >         struct {
> >                 /**
> >                  * @rgb565_predicator: Unknown, introduced with A650 fa=
mily,
> > @@ -629,6 +651,8 @@ int adreno_fault_handler(struct msm_gpu *gpu, unsig=
ned long iova, int flags,
> >                          struct adreno_smmu_fault_info *info, const cha=
r *block,
> >                          u32 scratch[4]);
> >
> > +void adreno_check_and_reenable_stall(struct adreno_gpu *gpu);
> > +
> >  int adreno_read_speedbin(struct device *dev, u32 *speedbin);
> >
> >  /*
> > diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_=
iommu.c
> > index 2a94e82316f95c5f9dcc37ef0a4664a29e3492b2..8d5380e6dcc217c7c209b51=
527bf15748b3ada71 100644
> > --- a/drivers/gpu/drm/msm/msm_iommu.c
> > +++ b/drivers/gpu/drm/msm/msm_iommu.c
> > @@ -351,6 +351,14 @@ static void msm_iommu_resume_translation(struct ms=
m_mmu *mmu)
> >                 adreno_smmu->resume_translation(adreno_smmu->cookie, tr=
ue);
> >  }
> >
> > +static void msm_iommu_set_stall(struct msm_mmu *mmu, bool enable)
> > +{
> > +       struct adreno_smmu_priv *adreno_smmu =3D dev_get_drvdata(mmu->d=
ev);
> > +
> > +       if (adreno_smmu->set_stall)
> > +               adreno_smmu->set_stall(adreno_smmu->cookie, enable);
> > +}
> > +
> >  static void msm_iommu_detach(struct msm_mmu *mmu)
> >  {
> >         struct msm_iommu *iommu =3D to_msm_iommu(mmu);
> > @@ -399,6 +407,7 @@ static const struct msm_mmu_funcs funcs =3D {
> >                 .unmap =3D msm_iommu_unmap,
> >                 .destroy =3D msm_iommu_destroy,
> >                 .resume_translation =3D msm_iommu_resume_translation,
> > +               .set_stall =3D msm_iommu_set_stall,
> >  };
> >
> >  struct msm_mmu *msm_iommu_new(struct device *dev, unsigned long quirks=
)
> > diff --git a/drivers/gpu/drm/msm/msm_mmu.h b/drivers/gpu/drm/msm/msm_mm=
u.h
> > index 88af4f490881f2a6789ae2d03e1c02d10046331a..2694a356a17904e7572b767=
b16ed0cee806406cf 100644
> > --- a/drivers/gpu/drm/msm/msm_mmu.h
> > +++ b/drivers/gpu/drm/msm/msm_mmu.h
> > @@ -16,6 +16,7 @@ struct msm_mmu_funcs {
> >         int (*unmap)(struct msm_mmu *mmu, uint64_t iova, size_t len);
> >         void (*destroy)(struct msm_mmu *mmu);
> >         void (*resume_translation)(struct msm_mmu *mmu);
> > +       void (*set_stall)(struct msm_mmu *mmu, bool enable);
> >  };
> >
> >  enum msm_mmu_type {
> >
> > --
> > 2.47.1
> >
