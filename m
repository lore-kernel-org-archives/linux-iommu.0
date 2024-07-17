Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CDA181D14
	for <iommu@lists.linux.dev>; Wed, 17 Jul 2024 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721234204; cv=none; b=a3wt4QdupwRvgWEcw9t4PnArOslj5BoAH5LkO19RfwUbwwadr5wfxIGy4JEDa27O+Pubk8e19rbx5uejVBIHLAO3EaIA95tuSeajq5NZRohEh2Zq9IbDG0yL2zkBk7UkTI2CnB2tUkO+jy1z9ufrvRUz8xSqWKaACH0OyTkHIlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721234204; c=relaxed/simple;
	bh=pevFJEVWM2LxwHZaGOh4hSpXKwvZeu6orjWuJWggIok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rsMG31bDSU3th1Rwb3QKwHrQ381i1AdWjE0KlJ/pYToOUADV2X0UHca7adkPtLUCIWrW2i+M+1+GZj5HC5PBb7Wl3LYjd1Jdo2qGZM7kFHLgPMeX8kSWZ5LFWmR/rXOLpffONh+vRXKYcQMRpi+igRtA10cTqHjUYHhR57mPOi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meUiuC1n; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meUiuC1n"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fc49c0aaffso9566035ad.3
        for <iommu@lists.linux.dev>; Wed, 17 Jul 2024 09:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721234201; x=1721839001; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4TKuZ+LLWKFD2SRhsXU6njcd+7Nl5m44Gcrf0C6YsTI=;
        b=meUiuC1nqoGyMRb7VzBJzGRaBz5uWFd9M3HqAye5Z3qYDtqWmByVsbn7Y3BpR98d33
         JMc382VWU1VhdaCbW5K617NcSlQy6NZpImmPQJAUH9vAdAV6j+PRYpkEjVVdknz/pBVA
         u9nbl5BU8/11myBbskkvIWwh6C5AH3CvZmT6Jemnf9ZFBaDBa/9AxXrB9hHOwBCnZ3Vj
         nWquEcoS7J1ZFCl9m+G9kNVUlxAHqJvpb8wU1iTxLauHNpJAKdo2dD32Xp55ntv8Z10y
         FSyiXRQq7BO+xz+LeULl4zd4scuqjKwoE91Pn/mPeBTDgQ0W9KwfDgms1j7hLezyp9Ke
         dJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721234201; x=1721839001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TKuZ+LLWKFD2SRhsXU6njcd+7Nl5m44Gcrf0C6YsTI=;
        b=TskzNlU5CCLaWB+qcXYne7AuONeyZIVWFYrKwybExrxlhHDwinFer4j988QApNdngB
         3M0RUrGs/YpiqsvxALynvu8VynQdV0N7PV5WzR7OndHS7ILimBP9/23xbEKVYsuRAPIM
         DORD/F9Uux21LLEdGEHOucPt6EGOE45ZZAhyet1PUnEwWsf8oo2r80DQmG8pzST0UTe4
         FDZ56bl3FM1gKvQsCswwNHLk3rEdRCceK+VKaET9kgj77z7R7xEW6bse7GZYF0OO+12x
         Oj+xvvlP3XRV83/8mHzhJaXWUJKzNqN+HT6uv8dq0pvYy48vPsB4+2tkNOFvD6pnKJd2
         OegA==
X-Forwarded-Encrypted: i=1; AJvYcCVlaCx5SCnF/iZk1mknKIHNxrREoJNm9PUd8NDOY+oNX5wiT5/qfVTcfnUKnIaf1vi72MH59nP8QiKoD/Ay7nUtUsC9x20=
X-Gm-Message-State: AOJu0YyFZZ6pWeIiKNT5CUdaDjC31Elax3By2/1V1ATA1jwoAHvcSJYH
	ynUAw0VfchbkcGWwZNnktPP52NiQ2r7/KrH1d1PaEc/vEipEMuDp
X-Google-Smtp-Source: AGHT+IHEmLpSAb65L1ZZEAG7DejWL9QRUnhbkb1WfvjNwqFc5ST7wh4b/x5LadbiinMc04M/Mvyhlw==
X-Received: by 2002:a17:902:eccc:b0:1fb:6ea1:5e with SMTP id d9443c01a7336-1fc4e562501mr19451975ad.44.1721234201188;
        Wed, 17 Jul 2024 09:36:41 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc27178sm77113815ad.134.2024.07.17.09.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 09:36:40 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	Rob Clark <robdclark@chromium.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joao Martins <joao.m.martins@oracle.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-pm@vger.kernel.org (open list:SUSPEND TO RAM),
	Marijn Suijten <marijn.suijten@somainline.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sean Paul <sean@poorly.run>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH v6 0/2] io-pgtable-arm + drm/msm: Extend iova fault debugging
Date: Wed, 17 Jul 2024 09:36:20 -0700
Message-ID: <20240717163627.43423-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

This series extends io-pgtable-arm with a method to retrieve the page
table entries traversed in the process of address translation, and then
beefs up drm/msm gpu devcore dump to include this (and additional info)
in the devcore dump.

This is a respin of https://patchwork.freedesktop.org/series/94968/
(minus a patch that was already merged)

v2: Fix an armv7/32b build error in the last patch
v3: Incorperate Will Deacon's suggestion to make the interface
    callback based.
v4: Actually wire up the callback
v5: Drop the callback approach
v6: Make walk-data struct pgtable specific and rename
    io_pgtable_walk_data to arm_lpae_io_pgtable_walk_data

Rob Clark (2):
  iommu/io-pgtable-arm: Add way to debug pgtable walk
  drm/msm: Extend gpu devcore dumps with pgtbl info

 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 10 +++++++
 drivers/gpu/drm/msm/msm_gpu.c           |  9 +++++++
 drivers/gpu/drm/msm/msm_gpu.h           |  8 ++++++
 drivers/gpu/drm/msm/msm_iommu.c         | 22 +++++++++++++++
 drivers/gpu/drm/msm/msm_mmu.h           |  3 ++-
 drivers/iommu/io-pgtable-arm.c          | 36 ++++++++++++++++++-------
 include/linux/io-pgtable.h              | 17 ++++++++++++
 7 files changed, 95 insertions(+), 10 deletions(-)

-- 
2.45.2

