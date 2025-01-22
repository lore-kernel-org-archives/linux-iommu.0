Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A657D18C008
	for <iommu@lists.linux.dev>; Wed, 22 Jan 2025 20:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737576071; cv=none; b=CTU2Swy3va8ckegnc68odRqFRGfsZncYR98pCf0l4Mrmpq4MZhKlVqHdsTS4h06bn++A17G97uj7kibvmCQTiIbX4fDVq8+Md0vZprykYQbG1xPgyJpjPwKPN78k7UMlqNmIapi3YtuwXRJVd181i335DHU6hdOqGeQ8z9s0AhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737576071; c=relaxed/simple;
	bh=+WyN8FK5rY7qRc7VsIGAiJo2lnVpGPEuUicLFpDWETs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=b7qjIdMakC82U4xUshLZAk+5t3f96czaMY05WnXo49v4Y6w+1Ufv8SlxPrtmMCtS936cAMmuXUmT14lmybYTVTUMaYWG8ggxn2FC9UfGKmsRxAqNS13pcehMrMpqUt9j5Y9ebcC1WHVypNHtU0S1Gk4goU3221tAWbr4XRba7w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTT2lOl0; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTT2lOl0"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b6e5af88eeso1579385a.0
        for <iommu@lists.linux.dev>; Wed, 22 Jan 2025 12:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737576068; x=1738180868; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jurTTxyZurW5GCpnwp6J13h1Jad371IuO/OxoFLazdE=;
        b=MTT2lOl0wtEZEWl6Ak0MoQA8UicZo6lPfZ6c40JmpFu57/gBH24Ir6K5WsklsQVsmt
         xa61dj4qUPagmuaqZK2S4fRgVPwC26fmb+pFz8Suhz5HDWytCAwQQbsV8AYhSo3ZgV45
         jolkvmW7HRe0/z6Xvb67YG+YIhq2Wre1kG/ljoc72xp9giWH2xcFCzqUSVtYtZvF750c
         5iP4oplLB4ycbMZXsM2u1NOX6c/tgaCSYFz81b4kucUvWXSGhud71Q1zy8k2Asr4KEp6
         ltjX6Noy0gSoksdfmpsEGb00ltTzs7gSpUEk2ycy0skVD8w49UPnzWDTHe1RUCgl2I9X
         wS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737576068; x=1738180868;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jurTTxyZurW5GCpnwp6J13h1Jad371IuO/OxoFLazdE=;
        b=pOK8WAOhnMcG2bIBxBv/UQmxw6qC/uQTpQkoUeqrne4apwimwoMIQbtEo6pcAkl3Cz
         qdBA6IetdcFJ+S5+hT0ABjQMnAJRr+Zdj3Vvz2MirltAVLNrozFacyf87i7pzc4ZPAF+
         kzquUYOzA02Rf7zkO2y7AIdGzw/H4LCWjimU0+jj2zLtjDRRQt8JSyAzSinfK9hIC1u4
         T3kXQvozNuM0QUvtE0XEOFIrw8M27IwgxPrryiGpyc0bnHdOUmOdKTvqJQic/A1+QpLC
         /ZY0HkGi+e1d2Wjy0sgmkcRs+7udW78+35WtH39c2fozRH5TZqLYuMaK+fX0vPCWcBvb
         +UFw==
X-Gm-Message-State: AOJu0YwfyCHahvdo8JF2T7pdmJyKu8HAs4A/y/aYiP4XtfQrBkyQ/BHv
	dOAdrdrNpp6B0vKV9Uti1fc42fzDG005ztyi1o1qzE4SQ4C0dJ7b
X-Gm-Gg: ASbGncsh6WhG3zTJGhWQ28z/6Mk06XSkUGPNGB0qP+H6GstSv0OIkfGjRPjSDGtHbte
	Fdby0oDtKCF9wccKQIaFjyAn3ikEZGwGejpjDbF2GbmzljZg/x5fHeBvs2vvc2f7OR2SIoO54ai
	of0nGgl/ibhEmug3zY1XXI0VZTtZIeHimwciO5Y0qZAmRWSQJC8QGQ7LyaCjtiMP/Kqhpb/1jX0
	Z1wOqjg2zHhExC9Sh3mqqQNlCx+NRAyuYN6FwCtKLvTO/GU4llp/WHBhKDCO07fonV1P8xTFW1E
	bahCUTm2VvWc2T0ClXSfp44wC6wJ
X-Google-Smtp-Source: AGHT+IHPM76iU6Z5PtzDIriPWj/nNzCyP2ix3l+fnM7JVaz7sX/vP0vOsO1NLQa7vmhO30zGz8RV4Q==
X-Received: by 2002:a05:620a:28ca:b0:7a9:a632:48ad with SMTP id af79cd13be357-7be6324e361mr1073763385a.11.1737576068474;
        Wed, 22 Jan 2025 12:01:08 -0800 (PST)
Received: from [192.168.1.99] (ool-4355b0da.dyn.optonline.net. [67.85.176.218])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be6147e30asm694606385a.31.2025.01.22.12.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 12:01:08 -0800 (PST)
From: Connor Abbott <cwabbott0@gmail.com>
Subject: [PATCH v3 0/3] iommu/arm-smmu, drm/msm: Fixes for stall-on-fault
Date: Wed, 22 Jan 2025 15:00:57 -0500
Message-Id: <20250122-msm-gpu-fault-fixes-next-v3-0-0afa00158521@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHlOkWcC/43NPQ6DMAwF4KtUmevKcfgpnXqPqgMBA5EIoAQQF
 eLuDUxMVcf3rPd5FZ6dYS8el1U4no03fReCul5E0eRdzWDKkAUhxShlCtZbqIcJqnxqR6jMwh4
 6XkbIElaY3ZEUSxHmg+PjGtavd8iN8WPvPsenWe7tH+gsAUEXmVaKdFyiftY2N+2t6K3Y0ZlOE
 OEPiAJUJiopIqQUIzpD27Z9AdUaNRoJAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737576067; l=2962;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=+WyN8FK5rY7qRc7VsIGAiJo2lnVpGPEuUicLFpDWETs=;
 b=a4zT3xeEwtyC9Lok7bYUo82pNV1IICFMNUHKvQZdQPpSD93+dLg1/j5KSWHZfEPg9D0yl3UG5
 I8IDAG+Ikk+BU8oBibWzReXFAvKresl7KM82p7INLVNp/P+OYQJ5ccX
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

Patch 1 fixes the first problem and is independent of the rest of the
series. Patch 3 fixes the second problem and is dependent on patch 2, so
there will have to be some cross-tree coordination.

I've rebased this series on the latest linux-next to avoid rebase
troubles.

Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
---
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
Connor Abbott (3):
      iommu/arm-smmu: Fix spurious interrupts with stall-on-fault
      iommu/arm-smmu-qcom: Make set_stall work when the device is on
      drm/msm: Temporarily disable stall-on-fault after a page fault

 drivers/gpu/drm/msm/adreno/a5xx_gpu.c      |  2 ++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      |  4 +++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 42 +++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    | 24 ++++++++++++++++
 drivers/gpu/drm/msm/msm_iommu.c            |  9 ++++++
 drivers/gpu/drm/msm/msm_mmu.h              |  1 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 45 +++++++++++++++++++++++++++---
 drivers/iommu/arm/arm-smmu/arm-smmu.c      | 41 ++++++++++++++++++++++++++-
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  1 -
 9 files changed, 162 insertions(+), 7 deletions(-)
---
base-commit: 0907e7fb35756464aa34c35d6abb02998418164b
change-id: 20250117-msm-gpu-fault-fixes-next-96e3098023e1

Best regards,
-- 
Connor Abbott <cwabbott0@gmail.com>

