Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637551A8417
	for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 18:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139660; cv=none; b=SNqh8mvLV7NlRABSd5W01atmBpyxbAAhuOqR8FdXrGg2ENSqr2vBUZ20ZtKd06z/WACvHNsVC1n0QwdF/DT4Hl60Ogh26Ra072jn2jMZgeOTCSX8Vfr/4LeA0BVEvW87khvbYSIn+HhRyfOnxDF5EwxeAHokt6yE5aueDey+4NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139660; c=relaxed/simple;
	bh=wufxwIG7SZVGT+NpZWvu5eUyVT71GkroNC9AubeD6sU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KH7LRUZUfDlkyREjZZlD9vqmYCdCeawG/vKVuueE0h3Pml+++VAs5JRMFNYnxdYepxK9cr6DAS1DJXK/0cNc45fO0iFKbMEuCE75NW1Rh5eJGNBUu0QQp2fSIcp7vEtn9iY/4K3BjMHQKmpU+D164G9W/NTCn02U0i8mlyVNZ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJRXrc7a; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJRXrc7a"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d8eacc4194so3396576d6.2
        for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 10:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737139657; x=1737744457; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ra6/FwxtS9APR+DM5MjQWhKeuNW85TPSbzZLBgVdyU=;
        b=CJRXrc7aVtwamuMswsjD/g1o8F8Qu5LszATRg01o34nCgynAinBVQC0tTQSSskB2oS
         JUIbku4Uy9shXz1ycSgh1i+vOMROs/oWl5M7bTX/PV5P7LHsEM8DFjLWV9D1jffULdN+
         FEVM6LIXLDl7LOo4aAl1K73X2wlNsdcgVsQCDC2Nh5mGUsavLKh6I9Jm7Pz3OOF5gbgu
         jQw2XgdtvANXWiARJWIDB5UgAw11X41mNawMRCXui9eCpBuWDAyV+d0jMl197DeUEIRA
         nlJlLcEX4I/bFo84CPrTe8qfCZJGY9gpZhLoakpUxD6JrlQdzLJsozOo33DnIAhE+s8d
         hu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737139657; x=1737744457;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ra6/FwxtS9APR+DM5MjQWhKeuNW85TPSbzZLBgVdyU=;
        b=npUfLgUNmkyV+BbDBOq/nquZ0B91DnNOm9s644jYT8d0FJOBcLoLd6+X8PaMSwO8tn
         34QFQPuj5GBG9FCCmc5Jac8uarvlhJHImt+f7NJSzIQOjvus8UYfiSiDcVjHlVMa40QL
         i6rJi9rIQ4/LnH96/ZOyz5NKkea1UHVDlymQbyXdNPMA6C2yrT1pQaQR9Xf/EP/Sy0hc
         JeN5g6EoXUxs8oKBPZGBbMVHRyAuT4Rzsuf6IVLzH3yGpBaXiNtPwmmC0PNejGB8X5yF
         L1q767OE7wWtgH0TohRW+68rxKKZ1W0oj7186OXN7mTYXrX2i4juPJcFxX/gGk4eCvNK
         wueQ==
X-Gm-Message-State: AOJu0Ywi6S4TAr7VWErVWoNA/GlavgfuFCsYtqhtVuV61Um2Q9pk27Mr
	rN8JOb5EGx4V8E0786KvGGIkJ5J8qMh/SXsgGNowkzMVXSL0SSRX
X-Gm-Gg: ASbGncuvC/lwP4/n4YAgB7ixTLfpfEK41CQnQxDDkc05J4NIDjB+A1FzF+hp/7zf8i2
	QicFalbNSlwpNWE7kSVIdLlIeTBenjtE3STyGY6RI6BP5yfGY9oWiMyaHkjKUcdhxMvaQI8JKEz
	X2rrKeVol+9MxO0L9nXNWXLJ2yj2VZwRGPSOM0wsUp8xRqdK/yjPFZdiJidOX97QVoJffkbjQuU
	IvkbOQhtkm5PPK1RDb+hWovVLaNsUvAiQAWe/x16fHZCJuniF2rSi4sb6m8bhzATCxVjlQYlWEh
	HhWSR3moCJySa/M=
X-Google-Smtp-Source: AGHT+IHEGS3WMZchQKb6AiaCl+4ohD5OQ+8Gq4AMLYPZ/+pdqcNLdTJ3oItGfaDD1AJRyHaTYAAAVQ==
X-Received: by 2002:a05:6214:c82:b0:6d9:2fe3:bf0c with SMTP id 6a1803df08f44-6e1b2158965mr20166666d6.4.1737139657265;
        Fri, 17 Jan 2025 10:47:37 -0800 (PST)
Received: from [192.168.1.99] (ool-4355b0da.dyn.optonline.net. [67.85.176.218])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afcd3859sm13992176d6.74.2025.01.17.10.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 10:47:36 -0800 (PST)
From: Connor Abbott <cwabbott0@gmail.com>
Subject: [PATCH 0/3] iommu/arm-smmu, drm/msm: Fixes for stall-on-fault
Date: Fri, 17 Jan 2025 13:47:06 -0500
Message-Id: <20250117-msm-gpu-fault-fixes-next-v1-0-bc9b332b5d0b@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKqlimcC/x3LSwqEMBBF0a1IjS1IIn63Ij0QfWqBRklpI4h7N
 zg8XO5NiiBQapKbAv6isvkImybUz52fwDJEkzMuN9aWvOrK037y2J3LwaNcUPa4Dq4LZKaujMt
 gKe57wFfj3f6e5wViwNJ/agAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737139656; l=2214;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=wufxwIG7SZVGT+NpZWvu5eUyVT71GkroNC9AubeD6sU=;
 b=RzjUDIZzgJrcKPPHCBVN/rS1IQljrG9wOjACFFGTOV2ahU8dMokrXTl3UGiT9YmU29Wrd+Hio
 +pb1RkanhupDPC3GvaEwsdahnKSFbIIkGWx35my0A19lFaiS/f1vahd
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
Connor Abbott (3):
      iommu/arm-smmu: Fix spurious interrupts with stall-on-fault
      iommu/arm-smmu-qcom: Make set_stall work when the device is on
      drm/msm: Temporarily disable stall-on-fault after a page fault

 drivers/gpu/drm/msm/adreno/a5xx_gpu.c      |  2 ++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      |  4 +++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 56 +++++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    | 21 +++++++++++
 drivers/gpu/drm/msm/msm_iommu.c            |  9 +++++
 drivers/gpu/drm/msm/msm_mmu.h              |  1 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 46 +++++++++++++++++++++---
 drivers/iommu/arm/arm-smmu/arm-smmu.c      | 32 +++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  2 +-
 9 files changed, 167 insertions(+), 6 deletions(-)
---
base-commit: 0907e7fb35756464aa34c35d6abb02998418164b
change-id: 20250117-msm-gpu-fault-fixes-next-96e3098023e1

Best regards,
-- 
Connor Abbott <cwabbott0@gmail.com>

