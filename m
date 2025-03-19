Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31821D7E5C
	for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395450; cv=none; b=NSJZKopcQeB59ndutCj28gOO+05KxYgtvSGVhNYgCJJLrL3XdPpr9AmTtmfP/aDIgz0JiuBO/bUTVy9BwYgGuFQxvhwV3lVie7vP4yqWF7wzbog12U7rdwzxDu4ZNRgcm9XC/T5WyrBICHqCWnlxWZ9zgbT4Dxi0dhQi5/i41QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395450; c=relaxed/simple;
	bh=W+2qxiUePPwUKrcvsCPyy4DS+hrPlZHy31bDsxo4fQg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DTRISgfGTr9iDZWcOKBjA2ZEiS0RZyCjRWTirjOtUTv9SlwN6l4oNJ1CGYvK0sUMqfkxRzPhs6YDuDDDOD2sxcDRVUMbCHGA0KDrLnZ6CLJd/GyG13uXwEHDcCB/J7PYSN+fYKgKGSfzq0HU9+TwNuiLtema9YA3pWDi4HOQiOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDFebo3q; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDFebo3q"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c55d853b54so107582185a.0
        for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 07:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742395447; x=1743000247; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DZvJrb+zBc9tB4E4JhmrwjQA5QPEwUV+8PpbNLpgvNM=;
        b=dDFebo3q1AOYSh9Zbi+L6UmvRAthdVt0GuiQXxnow0O7cgbOjdO+MxPJ+6IR5PLA5q
         c1KfIu0hc6w9TabbTYHoIfB5/LFWCmHWxuwe+l3S5HMPRSgnEadGDbjZ8wONqNVwn8Dj
         IA1HIjS42TIc+QvVyVkKr4UOguBVDmb9KMTeGyAX6Nqo1LOfuzE2YpclofJ06ghTf3t+
         ESe5Ld5pX5jEAXw2oKv94yRKiief1F2joh+a07myHAqfAdmXQ2bNbgBg8XcXZHPTgRne
         BXK9mL2SYwECIBvA/dge1EGFNzGwf8OYGTh7tnUup3s7k308F1VYa+Z6XiM+kNjveRQX
         S2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742395447; x=1743000247;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DZvJrb+zBc9tB4E4JhmrwjQA5QPEwUV+8PpbNLpgvNM=;
        b=NTqNeBePjlEIjpvblH6gF6e2TSU6UrKY1KFyQtf8SJDnUHttbQjESzXmynvUAKbp4k
         cEviSFzYBOko6NnBTf6qYSfShpLzlV2ujVwl6ht7syYKYayi0JQvaJc/J90zyzXWaHjo
         s6Xj+ApfNH5SY2qaTjrT4rFECo1giw5pUPgtRLtYByiJmf1k4km7UBW4RxtTrlwXgSPk
         5+l4AiJz9tuqlcB2sBpZuC4FVb8PHEW5DiQyRS59iUcdkNm57yPIBDJQRkIGmPBwCq5R
         N4bf14iA9vIYBdMWo4T9OT79LXziRc3iwo7qlOeyofY8oMTneWdzvpeLScg4zcPrbFj/
         dLhw==
X-Gm-Message-State: AOJu0YyW6wCRz6E50TlRE8ZNkmJ4YThSCVVzyYVmAS7+Bd1suzYM0z/C
	NS0kt+9suhcGguGB8Z3Ev4R56EPX4k+4HvfMjTzTOapcZ0RXQkPH
X-Gm-Gg: ASbGnctcjbnfBtO18fnyrfNhdq55qWBBh6mhMYzI4KfLuMaG1ZKpZwhxA+q8et/0RdM
	ORR98RM75ntcCJXP0vk/1Vvf0aRzmgiee8OMg00cjafK2LKFPb8ZArfz/7i7Yl8cbg9/PJX4gsM
	SXNtRaG7dIzyKaJ7rQ/uG3MQq9EAwtx+Jg52bHJDd65aWcrd7b9pq7KL2W0nbwi65eN6RtbHMVt
	bdcJtSWP9456iQpGplw4v9CPQrqkMcZnqsGL4Sa53exMBRw9MACL4/WCOqJ7Cq973LveByO02d1
	RKUSPPt83VErGXxu3R8vSO+5qm9xBhepCvqThVq4mUOH0yDu5QzHRH9jPOFBQ0L0qY8D0HLhe3a
	7d/zN/H8K+mB1EA==
X-Google-Smtp-Source: AGHT+IH8wFR2r4P4bYD39ofrHSl4H2gYM7bk1WgoKLisHaottHVJmyfq/MFmaRHVPdil7K8nUd/zNA==
X-Received: by 2002:a05:620a:472c:b0:7c5:8f36:fbeb with SMTP id af79cd13be357-7c5a8454c75mr149047885a.12.1742395447329;
        Wed, 19 Mar 2025 07:44:07 -0700 (PDT)
Received: from [192.168.1.99] (ool-4355b0da.dyn.optonline.net. [67.85.176.218])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c5201fsm868587485a.23.2025.03.19.07.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 07:44:06 -0700 (PDT)
From: Connor Abbott <cwabbott0@gmail.com>
Subject: [PATCH v5 0/5] iommu/arm-smmu, drm/msm: Fixes for stall-on-fault
Date: Wed, 19 Mar 2025 10:43:59 -0400
Message-Id: <20250319-msm-gpu-fault-fixes-next-v5-0-97561209dd8c@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC/Y2mcC/43PwW6DMAwG4Fepcp4nx06g7LT3mHZIgqGRClSEo
 lYV797Qy1APaMff1v9ZfqgkY5Skvg4PNcocUxz6HOzHQYWT61uBWOesCMmi1iV0qYP2coXGXc8
 TNPEmCXq5TVAVwlgdkVi0yvXLKK9tbv/85nyKaRrG++vSrNfpP9BZA4IPlWcmb2v0323n4vkzD
 J1a0Zk2EOEORBmqCy6CQSrR0DvEW4h2IM4QusYhanu0pN8h8wcxmh3IrK+JNl64bEzgLbQsyxM
 DZl6smwEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742395446; l=3767;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=W+2qxiUePPwUKrcvsCPyy4DS+hrPlZHy31bDsxo4fQg=;
 b=KuiYN+2L5L9ZTkYhp2nQbTVJiw0RI+ulKpDIosj5jHuAWlohXExldKuu0bne/raFKDh/osyLf
 wtodUGcp3MSBERRMcHsuvuYsQDtGtaxFLRVCv768rnsZMtcPy0a/I1z
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
Connor Abbott (5):
      iommu/arm-smmu: Save additional information on context fault
      iommu/arm-smmu-qcom: Don't read fault registers directly
      iommu/arm-smmu: Fix spurious interrupts with stall-on-fault
      iommu/arm-smmu-qcom: Make set_stall work when the device is on
      drm/msm: Temporarily disable stall-on-fault after a page fault

 drivers/gpu/drm/msm/adreno/a5xx_gpu.c            |  2 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c            |  4 ++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c          | 42 +++++++++++-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h          | 26 ++++++++
 drivers/gpu/drm/msm/msm_iommu.c                  |  9 +++
 drivers/gpu/drm/msm/msm_mmu.h                    |  1 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c |  6 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c       | 67 +++++++++++++++----
 drivers/iommu/arm/arm-smmu/arm-smmu.c            | 84 ++++++++++++++++++------
 drivers/iommu/arm/arm-smmu/arm-smmu.h            | 21 +++---
 10 files changed, 216 insertions(+), 46 deletions(-)
---
base-commit: 866e43b945bf98f8e807dfa45eca92f931f3a032
change-id: 20250117-msm-gpu-fault-fixes-next-96e3098023e1

Best regards,
-- 
Connor Abbott <cwabbott0@gmail.com>

