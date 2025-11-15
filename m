Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0701D63F3
	for <iommu@lists.linux.dev>; Sat, 15 Nov 2025 01:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763169001; cv=none; b=pgfkkoGXrlUNEfxnRP+50ZRlR4Td2Ygvrdh+j7zkWeIjDi2ECJIIrZ9oER5iJajsEnj7KRAt/2TLfhCAUNLvgTGmrazCiY034sYPyCjnWLJgtJoAa1s7ybXwImyd8a74lRADYsnvSAhZOxLT2AXTC5d9ozWfOrK8JlJQsyiNemM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763169001; c=relaxed/simple;
	bh=DKi4sfK3OoMGkgubSa+To/YAjgv5sLBhHCyNIeECLAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KO2lyyy1k/cAHgJ6osO6P7Qfld//oYzdf/uZROlPkgcVYqEo8l5Kq1/XEquNVIdpsfpjuWsHpSD3xR8loJ4BW5XLf/M1gc+YZTnPRR6OPFxMZqJbjqTNLXh2Kn6wH2ggl7vABw6aAMuG2pyykSols0PJ7zdHYqmA9MRwaauTnrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0ZYg5rf; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0ZYg5rf"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-433261f2045so11302875ab.3
        for <iommu@lists.linux.dev>; Fri, 14 Nov 2025 17:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763168999; x=1763773799; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0qRv7D69CzuYjO3j1EhxqH/ct/yNh/3IP2tz5K1Gqw=;
        b=A0ZYg5rfXLC2wWMscLIZa6GMulcDU8nc0eUYsfQ6sUmx4fu9SP7NwVai5QxUUT1HhR
         XRl7CZKfTC9NSMjoXVh2euGntyZFmx4MeIHbUtxKqYykNWkoz7TGW1GkHWFJvvYq/dqb
         E0GWbnx/GiewOi+inJP5/Kd5/7z0+GeDmsevJIfiOVahGy3vrjq4hxjeGHuTKCFe9WXU
         8pJlEeyTIBDY4RFwt6z/wRj37G42D5iVdBVsObnSJVsH/oWy1RwBPG0jBLVYxPwkktP6
         nEBXWFrUjDWT7G2NJz6tnaghfWi04zo2YYEstmHJ6EI38tgwABG1kFw5Hh/5EPMRjIrk
         eqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763168999; x=1763773799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o0qRv7D69CzuYjO3j1EhxqH/ct/yNh/3IP2tz5K1Gqw=;
        b=kiUZNCMRSzjDVQph5FhlGG5/W+XWY7Yg9QBSrH/CqVjKN0E9JIoly+EvbT6ysSDtUu
         wL98M0agWrUYZxJnb6qhPZ83vD7Bha4qkdmeoB7KVfKzQFovN/SP07VwEkAuCWkhamc6
         QXNLzGSXYnFgVEaI29HZzV4/55oh5MFqug7LpfC4X/lu745pEwosfMP7dmogXkU4INL0
         GTtU2XMWw2uJqKGD1/gaZngzz6TE6I92Q2owIwFEEv+DBIpdJxCd6n8X5hROW9HEgxPm
         2hDTrVPks4baaHGLp2+IIMRnfDkh8mYfR2W1cBm7mawHVQYO2H7WNJl2PmIWFWa3cCAJ
         FcYA==
X-Forwarded-Encrypted: i=1; AJvYcCXcFsbYi+nr703cM5RkkRDlkU68dNualSqgals+CMyeYQL4VTHQeNGdyYEvDT4TT+jvX/MhKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDtTZydCd/Jlkuo/Zr0wrVwoC3A4nKaqoza25GvRM58efJSxpb
	3TYQYC+KUIRRbm0vgvIwPsUoXLVkLL75n22reDpZ56LfH65i6dWInIDIes0slpA+lv62doZ2zF9
	6dqNMX+PnJBFZ/CYoNce6bTMZWtDWZWQ=
X-Gm-Gg: ASbGncvwATxED2nz4ynYobKph+AecXffhDbpEkeQASJiH9BWkjbOKnYlwPe9d+DlzY1
	bAWvSopp6hqHnxYxy68lNjkbj8h/jGEGSQ9+kI4EUocFnEALZ/YjDB66b/44cFGrCMqMr4NZ9fG
	9/BxkQ4Iw9N1rfQNaFNnh7VX6ImIC+a6qOWkAfFZZKND4XoLYPYaWLZ36sbzm1av1RDf/mn0CP1
	PVxQu/pCxq/al6P8nqAR3rO9ySz1lSOW5UIjOjvGaI7bx18sO9jj2oIcFiV94XpyyQz4xrtxhiT
	TE7scw==
X-Google-Smtp-Source: AGHT+IGKr+SF3i4IMqwtFmH1LrnsWvseLPJ1eP5fnws2PS56tgVe0SFilID5gX/syOfN/2tpbyjVHNc8lJjWhGJSBeY=
X-Received: by 2002:a05:6e02:3784:b0:433:2812:8066 with SMTP id
 e9e14a558f8ab-4348c91b9ecmr67887805ab.23.1763168998948; Fri, 14 Nov 2025
 17:09:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251114-kaana-gpu-support-v3-0-92300c7ec8ff@oss.qualcomm.com>
In-Reply-To: <20251114-kaana-gpu-support-v3-0-92300c7ec8ff@oss.qualcomm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 14 Nov 2025 17:09:47 -0800
X-Gm-Features: AWmQ_blMGRjNwnGFGy7X8EnS3-0DGpK0qt7AurVAQy8ubC4mlk6tdicKfSfYn9U
Message-ID: <CAF6AEGt=qUeEcNbyETriZLnpwt+Zg7K2N7SUsc4Riu5z54VaoQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/20] drm/msm/adreno: Introduce Adreno 8xx family support
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
	Thomas Zimmermann <tzimmermann@suse.de>, Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Rob Clark <rob.clark@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 3:29=E2=80=AFPM Akhil P Oommen <akhilpo@oss.qualcom=
m.com> wrote:
>
> This series adds the A8xx HWL along with Adreno 840 GPU support to the
> drm-msm driver. A8x is the next generation in the Adreno family,
> featuring a significant hardware design change. A major update to the
> design is the introduction of 'Slice' architecture. Slices are sort of
> mini-GPUs within the GPU which are more independent in processing Graphic=
s
> and compute workloads. Also, in addition to the BV and BR pipe we saw in
> A7x, CP has more concurrency with additional pipes.
>
> From KMD-HW SWI perspective, there is significant register shuffling in
> some of the blocks. For slice or aperture related registers which are
> virtualized now, KMD/crashdumper has to configure an aperture register
> to access them. On the GMU front, there are some shuffling in register
> offsets, but it is manageable as of now. There is a new HFI message to
> transfer data tables and new power related features to support higher
> peak currents and thermal mitigations.
>
> Adreno 840 GPU is the second generation architecture in the A8x family
> present in Kaanapali (a.k.a Snapdragon 8 Elite Gen 5) chipset [1]. It
> has a maximum of 3 slices with 2 SPs per slice. Along with the 3-slice
> configuration, there is also another 2-slice SKU (Partial Slice SKU).
> A840 GPU has a bigger 18MB of GMEM which can be utilized for graphics
> and compute workload. It also features improved Concurrent binning
> support, UBWC v6 etc.
>
> Adreno X2-85 GPU present in Glymur chipset is very similar to A840
> architecturally. So adding initial support for it requires just an
> additional entry in the catalog with the necessary register lists.
>
> This series adds only the driver side support along with a few dt binding=
s
> updates. Devicetree patches will be sent separately, but those who
> are interested can take look at it from the Qualcomm's public tree [2].
> Features like coredump, gmu power features, ifpc, preemption etc will be
> added in a future series.
>
> Initial few patches are for improving code sharing between a6xx/a7xx and
> a8x routines. Then there is a patch to rebase GMU register offsets from
> GPU's base. Rest of the patches add A8x HWL and Adreno 840/X2-85 GPU
> support.
>
> Mesa support for A8x/A840 GPU is WIP and will be posted in the near
> future.

mesa support: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/384=
50

BR,
-R

> [1] https://www.qualcomm.com/products/mobile/snapdragon/smartphones/snapd=
ragon-8-series-mobile-platforms/snapdragon-8-elite-gen-5
> [2] https://git.codelinaro.org/clo/linux-kernel/kernel-qcom/-/commit/5fb7=
2c27909d56660db6afe8e3e08a09bd83a284
>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
> Changes in v3:
> - Squash gpu smmu bindings patches for Kaana and Glymur (Krzysztof)
> - Reuse a6xx_flush() and drop the patch that added submit_flush callback
> - Fix GBIF configs for a640 and a650 family (Konrad)
> - Add partial SKU detection support
> - Correct Chipids in the catalog
> - Add a new patch to drop SCRATCH reg dumps (Rob)
> - Read slice info right after CX gdsc is up
> - Don't drop raytracing support if preemption is unsupported
> - Drop the unused A840 pwrup list (Konrad)
> - Updates to A840 nonctxt list (Rob)
> - Capture trailers
> - Link to v2: https://lore.kernel.org/r/20251110-kaana-gpu-support-v2-0-b=
ef18acd5e94@oss.qualcomm.com
>
> Changes in v2:
> - Rebase on top of next-20251110 tag
> - Include support for Glymur chipset
> - Drop the ubwc_config driver patch as it is picked up
> - Sync the latest a6xx register definitions from Rob's tree
> - New patch to do LRZ flush to fix pagefaults
> - Reuse a7xx_cx_mem_init(). Dropped related patch (Connor)
> - Few changes around cp protect configuration to align it with downstream
> - Fix the incorrect register usage at few places
> - Updates to non-ctxt register list
> - Serialize aperture updates (Rob)
> - More helpful cp error irq logging
> - Split A8x GMU support patch (Dmitry)
> - Use devm_platform_get_and_ioremap_resource in GMU init (Konrad)
> - Link to v1: https://lore.kernel.org/r/20250930-kaana-gpu-support-v1-0-7=
3530b0700ed@oss.qualcomm.com
>
> ---
> Akhil P Oommen (20):
>       drm/msm/a6xx: Flush LRZ cache before PT switch
>       drm/msm/a6xx: Fix the gemnoc workaround
>       drm/msm/a6xx: Skip dumping SCRATCH registers
>       drm/msm/adreno: Common-ize PIPE definitions
>       drm/msm/adreno: Move adreno_gpu_func to catalogue
>       drm/msm/adreno: Move gbif_halt() to adreno_gpu_func
>       drm/msm/adreno: Add MMU fault handler to adreno_gpu_func
>       drm/msm/a6xx: Sync latest register definitions
>       drm/msm/a6xx: Rebase GMU register offsets
>       drm/msm/a8xx: Add support for A8x GMU
>       drm/msm/a6xx: Improve MX rail fallback in RPMH vote init
>       drm/msm/a6xx: Share dependency vote table with GMU
>       drm/msm/adreno: Introduce A8x GPU Support
>       drm/msm/adreno: Support AQE engine
>       drm/msm/a8xx: Add support for Adreno 840 GPU
>       drm/msm/adreno: Do CX GBIF config before GMU start
>       drm/msm/a8xx: Add support for Adreno X2-85 GPU
>       dt-bindings: arm-smmu: Add Kaanapali and Glymur GPU SMMU
>       dt-bindings: display/msm/gmu: Add Adreno 840 GMU
>       dt-bindings: display/msm/gmu: Add Adreno X2-85 GMU
>
>  .../devicetree/bindings/display/msm/gmu.yaml       |   60 +-
>  .../devicetree/bindings/iommu/arm,smmu.yaml        |    2 +
>  drivers/gpu/drm/msm/Makefile                       |    2 +
>  drivers/gpu/drm/msm/adreno/a2xx_catalog.c          |    7 +-
>  drivers/gpu/drm/msm/adreno/a2xx_gpu.c              |   50 +-
>  drivers/gpu/drm/msm/adreno/a2xx_gpu.h              |    2 +
>  drivers/gpu/drm/msm/adreno/a3xx_catalog.c          |   13 +-
>  drivers/gpu/drm/msm/adreno/a3xx_gpu.c              |   52 +-
>  drivers/gpu/drm/msm/adreno/a3xx_gpu.h              |    2 +
>  drivers/gpu/drm/msm/adreno/a4xx_catalog.c          |    7 +-
>  drivers/gpu/drm/msm/adreno/a4xx_gpu.c              |   54 +-
>  drivers/gpu/drm/msm/adreno/a4xx_gpu.h              |    2 +
>  drivers/gpu/drm/msm/adreno/a5xx_catalog.c          |   17 +-
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |   61 +-
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.h              |    1 +
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c          |  369 +++-
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |  287 ++-
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |   25 +-
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |  393 ++--
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |   31 +-
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h        |   18 +-
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c              |   53 +
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.h              |   17 +
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c              | 1205 ++++++++++++
>  drivers/gpu/drm/msm/adreno/adreno_device.c         |    4 +-
>  .../gpu/drm/msm/adreno/adreno_gen7_0_0_snapshot.h  |  420 ++---
>  .../gpu/drm/msm/adreno/adreno_gen7_2_0_snapshot.h  |  332 ++--
>  .../gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h  |  470 ++---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h            |   38 +-
>  drivers/gpu/drm/msm/registers/adreno/a6xx.xml      | 1954 ++++++++++++++=
+-----
>  .../gpu/drm/msm/registers/adreno/a6xx_enums.xml    |    2 +-
>  drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml  |  283 +--
>  .../gpu/drm/msm/registers/adreno/a7xx_enums.xml    |    7 -
>  .../drm/msm/registers/adreno/a8xx_descriptors.xml  |  120 ++
>  .../gpu/drm/msm/registers/adreno/a8xx_enums.xml    |  289 +++
>  .../gpu/drm/msm/registers/adreno/adreno_common.xml |   12 +
>  36 files changed, 5008 insertions(+), 1653 deletions(-)
> ---
> base-commit: edf57d8dafc63f9298a209e518ea6a2e0df78ed0
> change-id: 20250929-kaana-gpu-support-11d21c8fa1dc
>
> Best regards,
> --
> Akhil P Oommen <akhilpo@oss.qualcomm.com>
>
