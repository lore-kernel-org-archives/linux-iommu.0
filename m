Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62AB280A5D
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107443; cv=none; b=HTu3t4W+luGSXlzKrNW2YoDOHAJB/CVopLh5Ybndr4wFxt7mpmly6e/n1Av8KkWpRxPI7i3pyzURQ78tYrVtlt0rn9fw5rVdk0S8nQjpbP4Hvvx7lpIUtxxRiOA0EMoY3BUQqqd7MNzWFas5PSj57QZvtFFbsr6mdzJY95PTY0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107443; c=relaxed/simple;
	bh=msh5539EjP+JTGfOm7TmnwDK21yliTFnve+XoihROqc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cEWy3awEcoWyTmkLauV4h5WW+Y4EgZnU06kcdrfv4CVibbSxZw4awHo7Fusa+qKRKjlBLpaWyOpqhrIzBASNeyM+tWudlQ3lagWz1Y5zUSR9kmF+/OOGRTGndG53S87JORRZ6uP8nHevcQiYY3+18dKmZomD6GCffBKGJwzl77E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9mkSVw2; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9mkSVw2"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e8b0740f0eso7682486d6.0
        for <iommu@lists.linux.dev>; Tue, 04 Mar 2025 08:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741107440; x=1741712240; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4N8VHwibUhruAck2dmF0TGYAITA4/2gddqUqD7otHMo=;
        b=X9mkSVw218O2MHVtlTObvDrgj+Y5g86gPb1m9BTzXyJJPR9EPfPmHPDoVxaesFqPDf
         22YqZ9kh2rOHgr9BXu1YChGCpZV5q7Uk5IAY8JhmEej64IFS/j5TnpkaxaJODci5RwQh
         bMYzbXgfeiW4zLNntbvbQCRwG7RGL9jqeRx1M8P6+1W9H4b3tc/EKgpzo10kN6GHN3wI
         9uQ8OupYOH28zsTMTKEYCsPPX1xnlmRwkIvJqpJFsGeXmPnMr4B80ll3Qnwi4gyWTA0g
         DVA4VHuIe5pYJ4vTLGLG8wiSjzfrPVEI1+IZCmArQOUeym+7vlmPhQ9m+RXNDCNQ3tMg
         rULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107440; x=1741712240;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4N8VHwibUhruAck2dmF0TGYAITA4/2gddqUqD7otHMo=;
        b=jA2U7n1ZEuW5qj5lORocOwMfLuFvuflRHrC+RWhRxQAHJi9FqiOa2iO+bA5QBoQ+av
         UOYPJripBiVKrvPrppajAr6KwhXzyKpNM9pEJB/hHyTqpejWADx65ia/p3QEFFzO4gQl
         g8oNyE+WtoLZpc3VlBPdujH5czQQu2utlcigMG7chJE7j57Kr9KO6CUUBseuh3MXJ1LG
         M5PKZm2JOufYFpsWPD1UWKhlTuizmvlG+zIt7Fj3xVezae7MWOq9pJIo86OHu4PHG6tA
         qhhByXU5tzY3otQR0pRSmUVOn9yyCkJxpgYKuRYqi9YGHLu7/QHfk/eMowAB7p25WmpL
         X7Og==
X-Gm-Message-State: AOJu0YwkQUa+iprc/rEwpoazK+D0Oe7e4LtwwE608xc7tGftaRgCUfQG
	ny1ka64HbHKtMRC3PegadSUBQR+WbPkMT/fdHrzIsPGnjRaeNt+e
X-Gm-Gg: ASbGncsbv2710yuooq1BoOJthPGhsynkbkh/JUXu18bS42QRwtWK7kdWkiX/ZaR9sz6
	0J2rWX4kFjf6zXUqHbj0pPxvtetWGXOvU57vCdr+Rf83LxX9r68jY6LeY34o3VhuGumtKn+1UYl
	u5z518OW7X3e/4npXldkqabZShs3wwlumH35PFXvRbqxHxQpdrXcKebPvV/JePoD1KGb4eUOBwm
	og7V3R4eCiX8sB7qGVunNJYDG0QukX0sukF+oORkzXT0iAG35EG70V4PKdoiYIDyNWdDJkjuQhd
	bA+uXa5B2+esmh+xdzol1uhwUv0yt6WGlYRq1iz0+fNZkxR+Ro4iTGsNdzWohfoIzTkldHRIB8d
	xrn8=
X-Google-Smtp-Source: AGHT+IEjBShiUHTmpe9BMjUgMebZZwGJVd8KDtAxwtvq24tPACT0iVbZHCMtbB96Yct3APfYOpiThw==
X-Received: by 2002:ad4:5ca3:0:b0:6e8:8f31:3120 with SMTP id 6a1803df08f44-6e8a0d8b6cbmr87598206d6.8.1741107440528;
        Tue, 04 Mar 2025 08:57:20 -0800 (PST)
Received: from [192.168.1.99] (ool-4355b0da.dyn.optonline.net. [67.85.176.218])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976ec3b6sm68915966d6.125.2025.03.04.08.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 08:57:19 -0800 (PST)
From: Connor Abbott <cwabbott0@gmail.com>
Subject: [PATCH v4 0/5] iommu/arm-smmu, drm/msm: Fixes for stall-on-fault
Date: Tue, 04 Mar 2025 11:56:46 -0500
Message-Id: <20250304-msm-gpu-fault-fixes-next-v4-0-be14be37f4c3@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM4wx2cC/43NSw6DMAwE0KugrOvKcfh21XtUXQQwEImfCCAqx
 N0bWKEuUJcz1jyvwvJg2IqHt4qBZ2NN17rg3zyRVbotGUzusiCkAKWMoLENlP0EhZ7qEQqzsIW
 WlxGSkBUmMZJiKdy8H/i4uvXr7XJl7NgNn+PTLPf2D3SWgJBmSaoUpUGO6bNstKnvWdeIHZ3pB
 BFeQOSgPFRh5iNF6NMvpM4QXUDKQagLjSiDOCB5hrZt+wLr0SnRUgEAAA==
X-Change-ID: 20250117-msm-gpu-fault-fixes-next-96e3098023e1
To: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, freedreno@lists.freedesktop.org, 
 Connor Abbott <cwabbott0@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741107439; l=3515;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=msh5539EjP+JTGfOm7TmnwDK21yliTFnve+XoihROqc=;
 b=Yavv0d1CLCCiAkzMuG0FSXiwmFR5GAOb6ZI7nc0yBLbQYtJjjJMoJ6ZB5l36VedPILL/LfxB/
 3FVj0xLJBQtCu9H3ML69818ww2mDXCQabfOEhSJAL5M0FYjXXvbU03/
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

Patches 1-3 fixes the first problem and is independent of the rest of the
series. Patch 5 fixes the second problem and is dependent on patch 4, so
there will have to be some cross-tree coordination.

I've rebased this series on the latest linux-next to avoid rebase
troubles.

Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
---
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
Connor Abbott (5):
      iommu/arm-smmu: Save additional information on context fault
      iommu/arm-smmu-qcom: Don't read fault registers directly
      iommu/arm-smmu: Fix spurious interrupts with stall-on-fault
      iommu/arm-smmu-qcom: Make set_stall work when the device is on
      drm/msm: Temporarily disable stall-on-fault after a page fault

 drivers/gpu/drm/msm/adreno/a5xx_gpu.c            |  2 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c            |  4 ++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c          | 42 ++++++++++++-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h          | 24 ++++++++
 drivers/gpu/drm/msm/msm_iommu.c                  |  9 +++
 drivers/gpu/drm/msm/msm_mmu.h                    |  1 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c |  4 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c       | 64 ++++++++++++++-----
 drivers/iommu/arm/arm-smmu/arm-smmu.c            | 78 ++++++++++++++++++------
 drivers/iommu/arm/arm-smmu/arm-smmu.h            | 19 +++---
 10 files changed, 204 insertions(+), 43 deletions(-)
---
base-commit: 866e43b945bf98f8e807dfa45eca92f931f3a032
change-id: 20250117-msm-gpu-fault-fixes-next-96e3098023e1

Best regards,
-- 
Connor Abbott <cwabbott0@gmail.com>

