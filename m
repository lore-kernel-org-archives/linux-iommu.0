Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDF31F76A5
	for <iommu@lists.linux.dev>; Mon, 28 Apr 2025 20:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745873793; cv=none; b=rlngrPY2tIS86unp1L4Q3/Xcoz+04aANLxR3CHwU3r8uNpT/SprUHpSitALKqoG5RDKrYoFFnFbWQHbrvXwL/1pjg29gYqpsMyEG4ggH+XCrtSJBU8gmM6G0N/NZr39wqW4jJ/JynpwBmIIwzZHZzY+x8CiiEEK0PutfPfuru2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745873793; c=relaxed/simple;
	bh=l7iXHepWlROyET1PLqg7bGCjYmNsb+Nn9VgqvRlbzmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MeouUjc/P1wiuv/D3p/aFdWw3TSb6sxJxzClSJ9lKieKkh7GjZqEuGoF3RT5giDLddaGKvoHEmmofbalgR1C6qg7ZXwEu4rFuSGSsgKY25WMUziM6s1YshsLGaDEtQMyBD7Cm4NhDVtGDl3RZ31iadK1IvbQJjlVl2gs+laGqrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNXY3mqE; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNXY3mqE"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22401f4d35aso64762005ad.2
        for <iommu@lists.linux.dev>; Mon, 28 Apr 2025 13:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745873791; x=1746478591; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7+KwwMScg2wIn1wFiZ7xCslKNcpSi/KKVTjv87cSzPQ=;
        b=aNXY3mqE4bTB4905rfCrmUs/IKgIvB1IuvbDkeXIZGsVhdcQVw/CzfVGmCL0js3Q2l
         rH3m/5V/J7dHTp9sjJaHQPu2u0cJgTGG7FLRXOVpgqntWG/dewndpXzcgA4drCn8zW0b
         H2jGGLX+4GOlf3qx/c63eqPaQEC0WgGDdehlTzV6cF1Im5zlQ0uglLZLUaphiIn0BOX9
         nKOcGDu+aTokew+OXNE5/ylmiiWSEhEocpQFgbU5Dk6mehcG/gxD9Lmw/7WenVOazpzg
         SVE5WR/PF6ANWrort/SxnmyuYL945C3ooS4E5EXhNAOqh2DVcFuzwhYYY8nbf0Pd7DQW
         w2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745873791; x=1746478591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7+KwwMScg2wIn1wFiZ7xCslKNcpSi/KKVTjv87cSzPQ=;
        b=mlZlwJZkhJmTX3Ovb1sI9hJMTs7PBM4m9CpDlJGNWUgk1Wz4s3MOnV8ImliFEZS2uR
         9jB90S3RK2y0y/6t0g+gZJR3vmdyzNui7pVQSmOaAlMqhTuO9mqAvrsVC8Xihj2UWPJk
         iTyif2TV22QTKlxYyzF12IGFfXriepbnZcKW/9/4aHXuz6Hc3busxh7XxSOz4vvYzIIJ
         pSImQFhB9yznhTG3F1TRVAue62QPGPOle6GCxrsIxaNWSdABaEXjLCX9jK0m17jB8yqy
         aUUxSLkn/h3mDTbuifvcwzQr2qQtIjYN/aQVCiPaSk2NEECYJxwfGtfr7llUuDIiSRSr
         5tPg==
X-Forwarded-Encrypted: i=1; AJvYcCWgRUgYY1YYdQ2wmEf9LlKlo8EJg76nGOrePi+MqSShn/AGk1iIl6Ux6IsJ+KjaXcb/W037GQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyq+1Ov8NWF6okDf4KtKnYJOfav1YBLZ3dWEoFP3LEM9rY022++
	V4D4EZK9PHFiiTiH4/ZqMYdLk9do57Y+jVMSu3J79SCmo6qOoNYNYq+cZw==
X-Gm-Gg: ASbGncvMGoTnIbHlVxj8IeL17Vj8a1SBqICb6XBRUYFF+sCa5Q4gDdzptjCd3+Mu71T
	ut+nMQth2PMAgGyRSOcH+hwy8jhkZcEie8BwDM8GTL2DS1vk6aCTdXP+2qt/dIZJ+VGrMtK4f02
	eSf6Zdaak+YNDvFIyrUlWDVqxcLGBTMLij2OSGOOVKedoTRQdjDyG3XOb/jSSm1rrTQiIL9ZH6Z
	aGShHYFWtjUMuLMIKjGLD5BX9xmeyNzJgY8oPMvkYdvAYCJtnvK8Z0vMgArB+ZTMZu6P7PTwXLg
	CNBOU/wTHiT9viT2mW0gbAluxkdqOBWaZ5sG8bTPUHsS29BOuYDAviBsbVJ6AGQuz9HDNy0hq6s
	FrnSvUo1KHSzg9KI=
X-Google-Smtp-Source: AGHT+IGKtMSFhDrKALYHacjDf6o2U+ErId2ldlU83bKr18MjClQcRoYfhtohAxt8HdoNAwV1+GksqQ==
X-Received: by 2002:a17:903:194b:b0:223:50f0:b97 with SMTP id d9443c01a7336-22de7097d8emr6300835ad.52.1745873791175;
        Mon, 28 Apr 2025 13:56:31 -0700 (PDT)
Received: from localhost ([2a00:79e0:3e00:2601:3afc:446b:f0df:eadc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db51051c6sm87904215ad.206.2025.04.28.13.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 13:56:30 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	Connor Abbott <cwabbott0@gmail.com>,
	Rob Clark <robdclark@chromium.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>,
	Christopher Snowhill <chris@kode54.net>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Eugene Lepshy <fekz115@gmail.com>,
	iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM),
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Jonathan Marek <jonathan@marek.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b),
	Marijn Suijten <marijn.suijten@somainline.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sean Paul <sean@poorly.run>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v3 00/33] drm/msm: sparse / "VM_BIND" support
Date: Mon, 28 Apr 2025 13:54:07 -0700
Message-ID: <20250428205619.227835-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

Conversion to DRM GPU VA Manager[1], and adding support for Vulkan Sparse
Memory[2] in the form of:

1. A new VM_BIND submitqueue type for executing VM MSM_SUBMIT_BO_OP_MAP/
   MAP_NULL/UNMAP commands

2. A new VM_BIND ioctl to allow submitting batches of one or more
   MAP/MAP_NULL/UNMAP commands to a VM_BIND submitqueue

I did not implement support for synchronous VM_BIND commands.  Since
userspace could just immediately wait for the `SUBMIT` to complete, I don't
think we need this extra complexity in the kernel.  Synchronous/immediate
VM_BIND operations could be implemented with a 2nd VM_BIND submitqueue.

The corresponding mesa MR: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/32533

Changes in v3:
- Switched to seperate VM_BIND ioctl.  This makes the UABI a bit
  cleaner, but OTOH the userspace code was cleaner when the end result
  of either type of VkQueue lead to the same ioctl.  So I'm a bit on
  the fence.
- Switched to doing the gpuvm bookkeeping synchronously, and only
  deferring the pgtable updates.  This avoids needing to hold any resv
  locks in the fence signaling path, resolving the last shrinker related
  lockdep complaints.  OTOH it means userspace can trigger invalid
  pgtable updates with multiple VM_BIND queues.  In this case, we ensure
  that unmaps happen completely (to prevent userspace from using this to
  access free'd pages), mark the context as unusable, and move on with
  life.
- Link to v2: https://lore.kernel.org/all/20250319145425.51935-1-robdclark@gmail.com/

Changes in v2:
- Dropped Bibek Kumar Patro's arm-smmu patches[3], which have since been
  merged.
- Pre-allocate all the things, and drop HACK patch which disabled shrinker.
  This includes ensuring that vm_bo objects are allocated up front, pre-
  allocating VMA objects, and pre-allocating pages used for pgtable updates.
  The latter utilizes io_pgtable_cfg callbacks for pgtable alloc/free, that
  were initially added for panthor. 
- Add back support for BO dumping for devcoredump.
- Link to v1 (RFC): https://lore.kernel.org/dri-devel/20241207161651.410556-1-robdclark@gmail.com/T/#t

[1] https://www.kernel.org/doc/html/next/gpu/drm-mm.html#drm-gpuvm
[2] https://docs.vulkan.org/spec/latest/chapters/sparsemem.html
[3] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=909700

Rob Clark (33):
  drm/gpuvm: Don't require obj lock in destructor path
  drm/gpuvm: Allow VAs to hold soft reference to BOs
  iommu/io-pgtable-arm: Add quirk to quiet WARN_ON()
  drm/msm: Rename msm_file_private -> msm_context
  drm/msm: Improve msm_context comments
  drm/msm: Rename msm_gem_address_space -> msm_gem_vm
  drm/msm: Remove vram carveout support
  drm/msm: Collapse vma allocation and initialization
  drm/msm: Collapse vma close and delete
  drm/msm: Don't close VMAs on purge
  drm/msm: drm_gpuvm conversion
  drm/msm: Convert vm locking
  drm/msm: Use drm_gpuvm types more
  drm/msm: Split out helper to get iommu prot flags
  drm/msm: Add mmu support for non-zero offset
  drm/msm: Add PRR support
  drm/msm: Rename msm_gem_vma_purge() -> _unmap()
  drm/msm: Lazily create context VM
  drm/msm: Add opt-in for VM_BIND
  drm/msm: Mark VM as unusable on GPU hangs
  drm/msm: Add _NO_SHARE flag
  drm/msm: Crashdump prep for sparse mappings
  drm/msm: rd dumping prep for sparse mappings
  drm/msm: Crashdec support for sparse
  drm/msm: rd dumping support for sparse
  drm/msm: Extract out syncobj helpers
  drm/msm: Use DMA_RESV_USAGE_BOOKKEEP/KERNEL
  drm/msm: Add VM_BIND submitqueue
  drm/msm: Support IO_PGTABLE_QUIRK_NO_WARN_ON
  drm/msm: Support pgtable preallocation
  drm/msm: Split out map/unmap ops
  drm/msm: Add VM_BIND ioctl
  drm/msm: Bump UAPI version

 drivers/gpu/drm/drm_gpuvm.c                   |   15 +-
 drivers/gpu/drm/msm/Kconfig                   |    1 +
 drivers/gpu/drm/msm/Makefile                  |    1 +
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c         |   25 +-
 drivers/gpu/drm/msm/adreno/a2xx_gpummu.c      |    5 +-
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c         |   17 +-
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c         |   17 +-
 drivers/gpu/drm/msm/adreno/a5xx_debugfs.c     |    4 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |   22 +-
 drivers/gpu/drm/msm/adreno/a5xx_power.c       |    2 +-
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c     |   10 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c         |   32 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h         |    2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |   49 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c   |    6 +-
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c     |   10 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c    |    4 -
 drivers/gpu/drm/msm/adreno/adreno_gpu.c       |   88 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h       |   23 +-
 .../drm/msm/disp/dpu1/dpu_encoder_phys_wb.c   |   14 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c   |   18 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.h   |    2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |   18 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c     |   14 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h     |    4 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c     |    6 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c      |   28 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c    |   12 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c     |    4 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c      |   19 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c    |   12 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c            |   14 +-
 drivers/gpu/drm/msm/msm_drv.c                 |  183 +--
 drivers/gpu/drm/msm/msm_drv.h                 |   35 +-
 drivers/gpu/drm/msm/msm_fb.c                  |   18 +-
 drivers/gpu/drm/msm/msm_fbdev.c               |    2 +-
 drivers/gpu/drm/msm/msm_gem.c                 |  489 +++----
 drivers/gpu/drm/msm/msm_gem.h                 |  217 ++-
 drivers/gpu/drm/msm/msm_gem_prime.c           |   15 +
 drivers/gpu/drm/msm/msm_gem_shrinker.c        |    4 +-
 drivers/gpu/drm/msm/msm_gem_submit.c          |  295 ++--
 drivers/gpu/drm/msm/msm_gem_vma.c             | 1265 +++++++++++++++--
 drivers/gpu/drm/msm/msm_gpu.c                 |  171 ++-
 drivers/gpu/drm/msm/msm_gpu.h                 |  132 +-
 drivers/gpu/drm/msm/msm_iommu.c               |  298 +++-
 drivers/gpu/drm/msm/msm_kms.c                 |   18 +-
 drivers/gpu/drm/msm/msm_kms.h                 |    2 +-
 drivers/gpu/drm/msm/msm_mmu.h                 |   38 +-
 drivers/gpu/drm/msm/msm_rd.c                  |   62 +-
 drivers/gpu/drm/msm/msm_ringbuffer.c          |    4 +-
 drivers/gpu/drm/msm/msm_submitqueue.c         |   86 +-
 drivers/gpu/drm/msm/msm_syncobj.c             |  172 +++
 drivers/gpu/drm/msm/msm_syncobj.h             |   37 +
 drivers/iommu/io-pgtable-arm.c                |   18 +-
 include/drm/drm_gpuvm.h                       |   12 +-
 include/linux/io-pgtable.h                    |    8 +
 include/uapi/drm/msm_drm.h                    |  149 +-
 57 files changed, 3012 insertions(+), 1216 deletions(-)
 create mode 100644 drivers/gpu/drm/msm/msm_syncobj.c
 create mode 100644 drivers/gpu/drm/msm/msm_syncobj.h

-- 
2.49.0

