Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E538280019
	for <iommu@lists.linux.dev>; Tue, 20 May 2025 17:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747763103; cv=none; b=EVQU0hLcFiu/mJ6ffP0okU2FJ5onhKJ73hlW3Pf7vqxSim9/wE0AjpZcX8aqQCZb6S2ZkVQ0yP25DNmP9QcGoh5pmMIhZ8ulJpxAgSGQ8fabhycVXTVcTrytA2kkYxgH06A2d4O+x5qAA43B73n9H/1elmOW0zP8PvjFbEfqQf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747763103; c=relaxed/simple;
	bh=PfUViJW6wIlPq1eq8mbT7TIDbT/guCIxVWkThk/PvMg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ABTo8l/ID/kqvgTjzBjFYCv0B2Y35oLSEXALQmuWTQHkgl2LQfSn/Rbke2g98DfnFHPyIeW1bNdl7NHqPhnqwO4OLjNc0Nni6ZyRwr6EftmoMFWH2B8e3Ms0MVPeCrW/x5ND7aVsV21xstVAvWAHphRZBqQTW9ah+wvy8OwfZ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzJE/+YK; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzJE/+YK"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6f2b58f0d09so8731716d6.3
        for <iommu@lists.linux.dev>; Tue, 20 May 2025 10:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747763100; x=1748367900; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NQzNVxSYCC2FNoqYgqHcnaCCKOuJ/N1MxANOboKaTNU=;
        b=PzJE/+YK289s4jolVoNMhmXvUGbGQ6/0UWBMnNOXzB4F97vpgB8yRiS4SgYayeZXBp
         jWmsrhb6f/kgj3ZgQ6CIjSdP0/g+dP9hKAoCIptXrkZdSwFFe0TfGpM8ZK/x13VQFmfG
         2wn7FZe1+1M+MfZnSv+Sv4qonD2S1MlH41CM0gUTcQT09C86L7hV0KFCvFnHUXg26Vob
         qnR9kkKTQ/R7OqH/GRO2v0iJt5Ea+LxJ7g2GBnRfMLxbIpvqkr2xVMjzAYjnVu6DTJO7
         aI8a36qgE6V+TIC2TLsuMU1yQoYbVyhp2blBe3A4BuojoYAgannRZLCb4OywyFESv5pO
         SNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747763100; x=1748367900;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQzNVxSYCC2FNoqYgqHcnaCCKOuJ/N1MxANOboKaTNU=;
        b=QD+y0xhcPZmBZBFjwyK64Ky6aGSCp9IUEABQWXok2MVNsiCtTkb9kGdOeJx0Ai4C+O
         maeaxF2HMCaooPlK0gh9UKZ/IwXE+Ft3FPrinyvkNEnE1xMbo0OK/Rhyo1+pgQUOnTgl
         Mji4VMKmt85dQLCVZux1jjcjReUDYGtQ0vjMgd0s7UQ20ClG1+Ko+Udix+yh/xWJEdPL
         0QB2nWO1dg8h77zQ8ZVBZFT5ks80I46NFiJT11r1BK1hiU9UfzvPd61LCsBeMkGuAcc0
         TjonGQr5Gc0akHDUX2I0ghuHpq/Ia5h8LokV2zBjyvKWBr4/xVHtOu2+TiGx80LiJsCg
         ks4w==
X-Gm-Message-State: AOJu0YzIAPpsK/hpwohCaFWnEK7hdQ7QpoibmgxGc2+j191PFG7cN11f
	4O+ZN4EyKKjeEB2PF1e+9fgi+WShLJ66T4xblcrK/9ur55xRzc+5CC95
X-Gm-Gg: ASbGncuB9aiNNvT6v3tENJvqmHDSYJ8pZSgXVvqIlz6UoRk1d47gyaIN1NYPp7m5lYS
	E3alOfUCoRWayictOhJcuU96kuo9VarxDtqbJxNuQwESVf1exiV5pz6vXoiLdAJNo6Co69nXXvr
	hRUU8BNMGy8kggsfatuE8Pa6D6NW8wXWMN2uXM0bkMySdTiioW1ADUlF9YN+eElwwlb2DxuJ+65
	VCR1v/piKA7Gg61acLff+ej+SVpzjJQXa5jjqJzaGmbedOteZoS6h76uQF8Js37dOnlenbQxbbC
	MDEMj6GcfhPs5TY/tdtqKAwq9XaRSCFRuWjaMU5vGsSaPMkIV8oqlwtJrxLH9RfCd7gLXfFO+Io
	cSsVfoVys/JhtaN476rY=
X-Google-Smtp-Source: AGHT+IFMsjsAlp/KmRWJUce4mkstVxqQCTLw9Ds84YBX1CPbtRzn3h6pU65n5IYZAossuniw2u+bEw==
X-Received: by 2002:ad4:5941:0:b0:6e4:4034:5ae8 with SMTP id 6a1803df08f44-6f8b0881b97mr96409666d6.5.1747763099887;
        Tue, 20 May 2025 10:44:59 -0700 (PDT)
Received: from [192.168.124.1] (syn-067-243-142-039.res.spectrum.com. [67.243.142.39])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b096ddb4sm74126586d6.78.2025.05.20.10.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 10:44:59 -0700 (PDT)
From: Connor Abbott <cwabbott0@gmail.com>
Subject: [PATCH v7 0/7] iommu/arm-smmu, drm/msm: Fixes for stall-on-fault
Date: Tue, 20 May 2025 13:44:49 -0400
Message-Id: <20250520-msm-gpu-fault-fixes-next-v7-0-96cd1cc9ae05@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJG/LGgC/43QzW6DMAwH8Fepcl4mx/nuae8x7RCCoZEKVISiT
 hXvvtBLEQe049+Wf5b9ZJnGRJmdT0820pxyGvoS7MeJxUvoW+KpLpkhoAYhLO9yx9vbnTfhfp1
 4kx6UeU+PiXtDErwDlCRYGb+N9OqW6e+fki8pT8P4+9o0i7X6D3QWHHgVfSUlVrqG6qvtQrp+x
 qFjKzrjBkI4gLBAtZEmKkALCveQ3EJ4AMkCQWgCgNBOo9hD6g1JUAeQWk8joSqStlFR7iG9gYQ
 /gHSBvNWmPMDXtYt7yLwhLfQBZAqkGsKgnQzOui20LMsfL98kES0CAAA=
X-Change-ID: 20250117-msm-gpu-fault-fixes-next-96e3098023e1
To: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, freedreno@lists.freedesktop.org, 
 Connor Abbott <cwabbott0@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747763098; l=5530;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=PfUViJW6wIlPq1eq8mbT7TIDbT/guCIxVWkThk/PvMg=;
 b=5U797NgALzxcffx0leSrLRx1UFnLBJFlcaQFBXdBnTf3m7QtKC4YUXE3mTgPy90CLhOCn90dd
 v0Vi2w8OTqSCx9eFDdF5aGe4NS03I/NHUey6Cy2chM88n0n9EJx2tgP
X-Developer-Key: i=cwabbott0@gmail.com; a=ed25519;
 pk=dkpOeRSXLzVgqhy0Idr3nsBr4ranyERLMnoAgR4cHmY=

drm/msm uses the stall-on-fault model to record the GPU state on the
first GPU page fault to help debugging. On systems where the GPU is
paired with a MMU-500, there were two problems:

1. The MMU-500 doesn't de-assert its interrupt line until the fault is
   resumed, which led to a storm of interrupts until the fault handler
   was called. If we got unlucky and the fault handler was on the same
   CPU as the interrupt, there was a deadlock.
2. The GPU is capable of generating page faults much faster than we can
   resume them. GMU (GPU Management Unit) shares the same context bank
   as the GPU, so if there was a sudden spurt of page faults it would be
   effectively starved and would trigger a watchdog reset, made even
   worse because the GPU cannot be reset while there's a pending
   transaction leaving the GPU permanently wedged.

Patches 1-2 and 4 fix the first problem by switching the IRQ to be a
threaded IRQ and then making drm/msm do its devcoredump work
synchronously in the threaded IRQ. Patch 4 is dependent on patches 1-2.
Patch 6 fixes the second problem and is dependent on patch 3. Patch 5 is
a cleanup for patch 4 and patch 7 is a subsequent further cleanup to get
rid of the resume_fault() callback once we switch resuming to being done
by the SMMU's fault handler.

I've organized the series in the order that it should be picked up:

- Patches 1-3 need to be applied to the iommu tree first.
- Patches 4-6, which depend on 1-3 should be taken by drm/msm. We will
  probably want to create an immutable tag and merge it into drm/msm to
  be able to take them in the same cycle and avoid the temporary
  regression noted in patch 2.
- Patch 7 can be applied to the iommu tree later, it's just a smaller
  cleanup dependent on the changes landing in drm/msm.

Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
---
Changes in v7:
- Rebase on v6.15-rc2.
- Add debugfs entry for whether stall-on-fault is enabled to help igt
  tests that want to wait until the cooldown period is over to collect a
  devcoredump (Rob).
- Link to v6: https://lore.kernel.org/r/20250515-msm-gpu-fault-fixes-next-v6-0-4fe2a583a878@gmail.com

Changes in v6:
- Rewrite to use a threaded IRQ instead in iommu/arm-smmu (Will). As a
  result we can drop most of the previous changes and instead move
  writing RESUME to the fault handler.
- Link to v5: https://lore.kernel.org/r/20250319-msm-gpu-fault-fixes-next-v5-0-97561209dd8c@gmail.com

Changes in v5:
- Don't read CONTEXTIDR for stage 2 domains.
- Clarify that we don't need TLB invalidation when changing
  SMMU_CBn_SCTLR.CFCFG.
- Link to v4: https://lore.kernel.org/r/20250304-msm-gpu-fault-fixes-next-v4-0-be14be37f4c3@gmail.com

Changes in v4:
- Add patches 1-2, which fix reading registers in drm/msm when
  acknowledging the fault early. This was Robin's preferred solution
  compared to making drm/msm's fault handler tell arm-smmu to resume the
  fault.
- Link to v3: https://lore.kernel.org/r/20250122-msm-gpu-fault-fixes-next-v3-0-0afa00158521@gmail.com

Changes in v3:
- Acknowledge the fault before resuming the transaction in patch 1.
- Add suggested extra context to commit messages.
- Link to v2: https://lore.kernel.org/r/20250120-msm-gpu-fault-fixes-next-v2-0-d636c4027042@gmail.com

Changes in v2:
- Remove unnecessary _irqsave when locking in IRQ handler (Robin)
- Reuse existing spinlock for CFIE manipulation (Robin)
- Lock CFCFG manipulation against concurrent CFIE manipulation
- Don't use timer to re-enable stall-on-fault. (Rob)
- Use more descriptive name for the function that re-enables
  stall-on-fault if the cooldown period has ended. (Rob)
- Link to v1: https://lore.kernel.org/r/20250117-msm-gpu-fault-fixes-next-v1-0-bc9b332b5d0b@gmail.com

---
Connor Abbott (7):
      iommu/arm-smmu-qcom: Enable threaded IRQ for Adreno SMMUv2/MMU500
      iommu/arm-smmu: Move handing of RESUME to the context fault handler
      iommu/arm-smmu-qcom: Make set_stall work when the device is on
      drm/msm: Don't use a worker to capture fault devcoredump
      drm/msm: Delete resume_translation()
      drm/msm: Temporarily disable stall-on-fault after a page fault
      iommu/smmu-arm-qcom: Delete resume_translation()

 drivers/gpu/drm/msm/adreno/a2xx_gpummu.c         |  5 ---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c            |  2 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c            |  4 ++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c          | 54 +++++++++++++++++++-----
 drivers/gpu/drm/msm/adreno/adreno_gpu.h          |  2 +
 drivers/gpu/drm/msm/msm_debugfs.c                |  3 ++
 drivers/gpu/drm/msm/msm_drv.c                    |  4 ++
 drivers/gpu/drm/msm/msm_drv.h                    | 23 ++++++++++
 drivers/gpu/drm/msm/msm_gpu.c                    | 20 ++++-----
 drivers/gpu/drm/msm/msm_gpu.h                    |  8 +---
 drivers/gpu/drm/msm/msm_iommu.c                  | 12 ++----
 drivers/gpu/drm/msm/msm_mmu.h                    |  2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c |  9 ++++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c       | 43 +++++++++++++------
 drivers/iommu/arm/arm-smmu/arm-smmu.c            |  6 +++
 include/linux/adreno-smmu-priv.h                 |  8 ++--
 16 files changed, 144 insertions(+), 61 deletions(-)
---
base-commit: 8ffd015db85fea3e15a77027fda6c02ced4d2444
change-id: 20250117-msm-gpu-fault-fixes-next-96e3098023e1

Best regards,
-- 
Connor Abbott <cwabbott0@gmail.com>

