Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C9F1E9B0A
	for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737388010; cv=none; b=EoEUUGYiTCnI92Wv1CdHGFdfhtR+mVT0AZapsz3OZYsLb8H/suTQLIzoW9hMugK8/+q4t+PcH6LQmStbT5yikIwgzuW+FBxdqbH9GngwQNR04zJf+KEb5U9xHoQeS13FgT4/sI+D0dOmSzDYDiqskLc9HInPWD1lupIXUP+mxQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737388010; c=relaxed/simple;
	bh=lKYxJxxQvusCy8B0sZYN2iP5UpseVkNuNGCfUBuNbWw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bQSLKlAZ+5dkPDRsNzLKmQKLCP6tQaCIMyqaKYaB4khQkraxsoRxN6aopH3wN2cV//gZ1stnw5Xy2lKLjfHeWV4DSIauJs/xGvheifTDD0AdBlJwS5CU/d8L6m3TK4Wc0LWFFY1CsIBf6+W54ff07JXJQgldMjL+Q+fO8R3RQw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R16T40PO; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R16T40PO"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-46796a6b9e7so5583381cf.3
        for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 07:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737388008; x=1737992808; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jyWkEYx8l19GBLVFTRZATObQ9E8Z6bbFOrHEmmyhtMk=;
        b=R16T40PO+Du7liokoqYpPeaxdn5vl/z3jJszpq3BrX36RgPwbbR6f8LthkuOy4PxSX
         3t3Y9Z03Fb9j03wSbrOaYIUFVlMT2d/EkJcJt1YOF7Ptz8G62bdVN5b3U4bGKWcmiP+3
         zU2aXZVhVMT28zXGCOAuCFoQe3OqlaZMciTJXf0a44RChdVeCOgTTGKhC0x2yxbAzdGX
         TqbTqagLP6L96FhXMBuA0Lx6Dau17+ZjLlsdig1dC8IX9Qf1QE437NCHuLrPtSv5RaWB
         1n88vz2kI8qF3vrZAE+LPMUnotbxxcOhRV64D8kAQGjSI8NaZ7Gscz1BbMmhs7qSuWx8
         tOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737388008; x=1737992808;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jyWkEYx8l19GBLVFTRZATObQ9E8Z6bbFOrHEmmyhtMk=;
        b=U7eHAtdtMK6DyoNX4eCBpWzRSJtCtLHCLVbGfksQkUKiEjY7H8U49gkzkcRKw0OqBw
         8Id570JgQ1zHGkqou8NjcLgTbEZJ1GQpNWY/MPK80QOpR+MAoJFdXhNAoVgUho7eZmxl
         5cFO9f6fzUJACtQ+8GDSJJ5J0RJQHrKv1E2z/LnfsBzYGzbEVYTGzJpbtokXBoGqJ0MY
         HA3DatwAxkHzpgSmkM05bEOL7isw/DAd9vd+z1Asiv4mOBtvw5dRgPpmQCxwd932FjVb
         S7d/VGxCDmJayujhn2QYgnyVmj3QN3+6PQttNWjP7pO4qruNuOAVcGl6I1O4wvd2aajY
         rwDA==
X-Gm-Message-State: AOJu0YzMp0AMujINs5F3Z345HcTrNMzUPiuMDhgARQRpyKlOXrBUiSa5
	48VX4JVSc2IWnsrbCd8N68movAeMoZxR4Rc/tg6Qrc/Ea1ED2/XI
X-Gm-Gg: ASbGncvV5ytlrrZzNuW0czGu4X9c/j2GYCYhTSAV2HncMu4q8iBI8uiI1Bul8cMc4iF
	Rvl/FqWSzfDFI/feuW3NfXZyPVAbw44+F+YR0r1pLIMt3ibQsLgyxKwfb1SQPSHtV1HEO5WCrSA
	lOGS1K8gdiiT+F+zxBPvI9gIcvq1pDCqoZlNaWqHVSLMdSEh5ejrczgXGEq/66G9bc0io/Vgh6w
	Z86KkNC9BFT5NwDOE52xLzl+DcAUiZph20QxS2twEgOQx5gDlVb3eGR3+Qav1TZwvM2co+Pza/h
	JmjPlfwhF6KhgoccmohuiZcIxv/j
X-Google-Smtp-Source: AGHT+IHR7cjTCixBLNtbAIMXQS0zWLEWtnuMbfw/UHe2dC10Tj90Pa0lJRvcim4eXFdZ/kNXVMOUoQ==
X-Received: by 2002:a05:622a:4ce:b0:467:6eee:1138 with SMTP id d75a77b69052e-46e12a4a7bamr72560861cf.6.1737388007681;
        Mon, 20 Jan 2025 07:46:47 -0800 (PST)
Received: from [192.168.1.99] (ool-4355b0da.dyn.optonline.net. [67.85.176.218])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e258c82a6sm24230501cf.59.2025.01.20.07.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 07:46:47 -0800 (PST)
From: Connor Abbott <cwabbott0@gmail.com>
Subject: [PATCH v2 0/3] iommu/arm-smmu, drm/msm: Fixes for stall-on-fault
Date: Mon, 20 Jan 2025 10:46:44 -0500
Message-Id: <20250120-msm-gpu-fault-fixes-next-v2-0-d636c4027042@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAORvjmcC/42NTQ6CMBCFr0Jm7Zj+BBVX3sOwaMsAk1AgLRAM6
 d2tnMDl916+9w6IFJgiPIsDAm0ceRozqEsBrjdjR8hNZlBClULKO/rosZtXbM06LNjyThFH2he
 sbqRF9RBKk4Ssz4HONtvvOnPPcZnC53za5C/9Y3STKNC6ymqtbNkI++q84eHqJg91SukLjY83x
 cAAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737388006; l=2714;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=lKYxJxxQvusCy8B0sZYN2iP5UpseVkNuNGCfUBuNbWw=;
 b=f7olHGP2Z1qbp+CTIun177dJ1Ntn9nRXTPCjKXceI0rQQ0OUsCtI3Md/ssDJM/frqEjSzshHy
 hqtiuQ1+59vB8KCwoMHx8rX0iYy3xcsxCtrxJQKSpnIDad2eWBW4ik7
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
 drivers/iommu/arm/arm-smmu/arm-smmu.c      | 30 ++++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  1 -
 9 files changed, 152 insertions(+), 6 deletions(-)
---
base-commit: 0907e7fb35756464aa34c35d6abb02998418164b
change-id: 20250117-msm-gpu-fault-fixes-next-96e3098023e1

Best regards,
-- 
Connor Abbott <cwabbott0@gmail.com>

