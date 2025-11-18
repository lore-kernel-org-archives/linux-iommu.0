Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175BB364E8E
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481389; cv=none; b=qsLWkXJKci0aeGFsmtUE4cBz6QaMheKhaI2HEyFPoK469liJ20i1XmlMvjzHDtqXTmvITn8+1NK5IICWWilNJOkO2MLyCtW1tEVD63taXGuN3SRaPWKn9b/dW4cLrbN5ONVfclTo0niK0j81yqHgXhJkb1M5cW5+GHwB1elDgfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481389; c=relaxed/simple;
	bh=FoI/0yIBhBAAdixBGW8+u3ufsR/IeE2MFhE0qzpG8vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxWjV+ZlToO4VUYkm9nALP+3/f3VqXnZ4kDlpjuVB0Fjwo+85JJoHO8ERGSl6biKxgDi6wFaf4i75kpjmm0PkNg9YuQ3CB4Y1sB+huDMhQNDv5oACCWWJYt1sFQywqetNcHOR6z41azb3BjX7PoVdIZusU4Glui6tWRNM2Or1iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H83R3r/r; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H83R3r/r"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-343e2e1a580so1084185a91.3
        for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 07:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763481387; x=1764086187; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5WRdUpA2CUE7aS1AisvjTy+gobCtbtissttVLsKK2w=;
        b=H83R3r/rCVxE8kC6CQ4UAcyzEOL23adnDvDtRYCIKD+joJB44amHAnKfT6e/qEHSRs
         UutjcCTall6cUlqQJSD9vsi37WOW/3aUfepyXU5m/4MBi0bX5cqiN9PjZYlGMaljmaFQ
         dK6OOAnz2YRempKKMH9SzYbpdOGEE6B/55k3g89F1P+shPsvIByt8q4dbBGBvyeUSF3Y
         +oQ+VkQG2hz/jLp9RwHZSy5bQh9Fo8RcqgabsLptTFVCYWCk5xzt2lzYqq0oG12COMOC
         JD0OWNF/tV+r/Tpg1954Het59GNvs30+dN9j+QuRBGHp3xRxT39Vr7ack4eqERh3TLnd
         o06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763481387; x=1764086187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M5WRdUpA2CUE7aS1AisvjTy+gobCtbtissttVLsKK2w=;
        b=q9dUAJ1TbQ8IPPkFHqzogqq4SwjRBWJL4FuNCOAvg/tDQ8Rz508t7BLVd3JOH+iAxv
         edDmrMvNRpDqaV+MNsMV/Gw3Qhb03Pp9bmP2SXp2cNIeuMAdfPL9buIZBpxBZjjOsoS4
         0XahKD4fov7/KpHeG4jBYn0w++CzvI25XeAmI940z1lOlqXcJfMezkRCq1CuUKmddadE
         8LCUYUcaDstuYNzKHmwIX6a1+HGN1atTwd/WtTutx4ltDuPvhn47/Jv1EpXMIhX08L2Y
         qF9nvz6fqYWktCfyGa6xOtmrrkBz+YnTPiYapnNLnAwN1UWOH0V7L9F8RsQauggmWdCK
         S1OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf5m2sPAamKxcP4Qkm2akqfPKu10u7zgmcd+x/EWqK/TVMbmg1eAKMiZmbGACL0UdbCEFfwg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzn9CNdjfM86D9dgMU3dx7LGZvgKo+xWeTTsa+gi4S0mZjQ/roU
	Rag2+d/s+Zfd6K7weheO5U1zbMS7jGRfh6mcm5g/KywfFDT3Mhgv9GFJdJyu7sbcqS/S5bHJI4q
	JmXLyqJQkJKokJRvoCApzpV4PZYCPark=
X-Gm-Gg: ASbGnctHHZ7EtD1ecFSUwI38HgGkKuPzCeCRLD0+hvYj6TnDuJlNeTD1765cE5ME5Ua
	N1HGqPUMYaUqvNX9Wk2vHDV3FPqQ5L00kVJQ+EyAAxJzTtUuFHByw3j7/EXh7SoqQc3RR0K0WBd
	yR/xWFCM/GzclmE4M+duG6IhqonFASItNEKt+vIVLjsO2aLX0mrXFIkMU1trPAqMXw2GfxeHe8G
	afy58lonUfDXZJWaMD8VH0RWDIkENdOv9hVR59UZU1QDAcgrcd0kMJnk/0/pBELF5j6fx55Mae/
	+tyyAr5Z28NclvvH
X-Google-Smtp-Source: AGHT+IE8t1o/EHIJG7uVd/X+qmNh/IfoMFCfRZRkp7Xo8e8ghyzgHnHIC3pizFSaKdc3W9ZzA4z9Bd0F68Sq2swtnFU=
X-Received: by 2002:a17:90b:1b01:b0:341:b5a2:3e78 with SMTP id
 98e67ed59e1d1-343fa74f0bfmr9250914a91.3.1763481387271; Tue, 18 Nov 2025
 07:56:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251118-kaana-gpu-support-v4-0-86eeb8e93fb6@oss.qualcomm.com> <20251118-kaana-gpu-support-v4-15-86eeb8e93fb6@oss.qualcomm.com>
In-Reply-To: <20251118-kaana-gpu-support-v4-15-86eeb8e93fb6@oss.qualcomm.com>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Tue, 18 Nov 2025 10:56:16 -0500
X-Gm-Features: AWmQ_bmdki1r5-87hufvE1VD2aBWZ9nuG-r_2OiqIAnZ7-v6leUi15c6-xeP3Cc
Message-ID: <CACu1E7HzsnSjz0SiUJT0SMNJ7cFhiNdtUE9jKHpvD3UzG6EegQ@mail.gmail.com>
Subject: Re: [PATCH v4 15/22] drm/msm/adreno: Support AQE engine
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>, 
	Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Jessica Zhang <jesszhan0024@gmail.com>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Jonathan Marek <jonathan@marek.ca>, 
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

On Tue, Nov 18, 2025 at 3:53=E2=80=AFAM Akhil P Oommen <akhilpo@oss.qualcom=
m.com> wrote:
>
> AQE (Applicaton Qrisc Engine) is a dedicated core inside CP which aides
> in Raytracing related workloads. Add support for loading the AQE firmware
> and initialize the necessary registers.
>
> Since AQE engine has dependency on preemption context records, expose
> Raytracing support to userspace only when preemption is enabled.

I guess the plan is to expose MSM_PARAM_AQE later once preemption
records are in place and for now just load the firmware to ensure that
people have it?

The interrupt error handling is still missing, but I guess that can be
handled later if that's the plan.

Connor

>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 22 ++++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h   |  2 ++
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c   |  3 +++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h |  1 +
>  4 files changed, 28 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index 810b64b909f5..9a643bcccdcf 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1118,6 +1118,23 @@ static int a6xx_ucode_load(struct msm_gpu *gpu)
>                 }
>         }
>
> +       if (!a6xx_gpu->aqe_bo && adreno_gpu->fw[ADRENO_FW_AQE]) {
> +               a6xx_gpu->aqe_bo =3D adreno_fw_create_bo(gpu,
> +                       adreno_gpu->fw[ADRENO_FW_AQE], &a6xx_gpu->aqe_iov=
a);
> +
> +               if (IS_ERR(a6xx_gpu->aqe_bo)) {
> +                       int ret =3D PTR_ERR(a6xx_gpu->aqe_bo);
> +
> +                       a6xx_gpu->aqe_bo =3D NULL;
> +                       DRM_DEV_ERROR(&gpu->pdev->dev,
> +                               "Could not allocate AQE ucode: %d\n", ret=
);
> +
> +                       return ret;
> +               }
> +
> +               msm_gem_object_set_name(a6xx_gpu->aqe_bo, "aqefw");
> +       }
> +
>         /*
>          * Expanded APRIV and targets that support WHERE_AM_I both need a
>          * privileged buffer to store the RPTR shadow
> @@ -2400,6 +2417,11 @@ static void a6xx_destroy(struct msm_gpu *gpu)
>                 drm_gem_object_put(a6xx_gpu->sqe_bo);
>         }
>
> +       if (a6xx_gpu->aqe_bo) {
> +               msm_gem_unpin_iova(a6xx_gpu->aqe_bo, gpu->vm);
> +               drm_gem_object_put(a6xx_gpu->aqe_bo);
> +       }
> +
>         if (a6xx_gpu->shadow_bo) {
>                 msm_gem_unpin_iova(a6xx_gpu->shadow_bo, gpu->vm);
>                 drm_gem_object_put(a6xx_gpu->shadow_bo);
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.h
> index e6218b0b9732..3a054fcdeb4a 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> @@ -59,6 +59,8 @@ struct a6xx_gpu {
>
>         struct drm_gem_object *sqe_bo;
>         uint64_t sqe_iova;
> +       struct drm_gem_object *aqe_bo;
> +       uint64_t aqe_iova;
>
>         struct msm_ringbuffer *cur_ring;
>         struct msm_ringbuffer *next_ring;
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a8xx_gpu.c
> index c9cd7546024a..e011e80ceb50 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -627,6 +627,9 @@ static int hw_init(struct msm_gpu *gpu)
>                 goto out;
>
>         gpu_write64(gpu, REG_A8XX_CP_SQE_INSTR_BASE, a6xx_gpu->sqe_iova);
> +       if (a6xx_gpu->aqe_iova)
> +               gpu_write64(gpu, REG_A8XX_CP_AQE_INSTR_BASE_0, a6xx_gpu->=
aqe_iova);
> +
>         /* Set the ringbuffer address */
>         gpu_write64(gpu, REG_A6XX_CP_RB_BASE, gpu->rb[0]->iova);
>         gpu_write(gpu, REG_A6XX_CP_RB_CNTL, MSM_GPU_RB_CNTL_DEFAULT);
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.h
> index c496b63ffd41..0aca222c46bc 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -27,6 +27,7 @@ enum {
>         ADRENO_FW_PFP =3D 1,
>         ADRENO_FW_GMU =3D 1, /* a6xx */
>         ADRENO_FW_GPMU =3D 2,
> +       ADRENO_FW_AQE =3D 3,
>         ADRENO_FW_MAX,
>  };
>
>
> --
> 2.51.0
>
