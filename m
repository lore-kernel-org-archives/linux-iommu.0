Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A311B8E8A
	for <iommu@lists.linux.dev>; Tue, 20 Aug 2024 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174227; cv=none; b=qLAwJ/UJaHv0ISCmUJ9a3tOqjk0NnrRghiXgecK+3kci4tfYXvUH18ZV3u5Cre1Yt078TC5g5CgsPRIQN5BACH527JRByl7RdFVuKENA0UYY4qImjjhumJx54k6BUiDVDaolLbQKRnooMmWMOWNlqMNL1RttEhTem2152RQEULk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174227; c=relaxed/simple;
	bh=K0bgmvxUNrz5vihGLhxf3Ou13m+eII+OugE43qEVdV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sua/LDxRsW+7jBMG5CnJmv+xn1oXRMDUv+JPoItKHx4TPbAAKNgnhVEx5Fz2cqGtj/kLdvE3+Kohy301H6rbJkg4cfsWogYtv+gBMiLlsdSkqnrmJabynUxdWle4eMmUTkGT3klljKYtBnK7GWDqatxc1wFBXdFcFSdoD6O66so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdmQuWT0; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdmQuWT0"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d3b595c18dso4271676a91.0
        for <iommu@lists.linux.dev>; Tue, 20 Aug 2024 10:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724174225; x=1724779025; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dx99I4gVjE0nKHxOcEFDps9UKSShAk0pVoAeBRskDVw=;
        b=GdmQuWT07xpiW5f/XT1cHEPbTs27EYst+dwzwzCyIF4DlfxtmITQRragm92hMvgZyL
         z3714CctxDPegg1Pa9v103Jg/Xh7ScSKAuHq6MyTN60VcYxR5ihZ8HQI9QpnjheUEsMU
         CCNahpiYiDbOaR1bifdzmHUB9Sds/ZXzLZ0f0CucPIMZtr212aUGjrrnRsfPPlkJxl1w
         CgD8wSQzf6jP+gstb2dd/wA6kC2TIo2SwVs+hNTWn0644LQh4QuZuNCrbtvCIbg0pftq
         +hkEmajkdCO2GM4qLGluoB6mQF9SPTP907ux4uZE+13RQ+LIpYkCtQdJwHdFxGbDWoZP
         jsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724174225; x=1724779025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dx99I4gVjE0nKHxOcEFDps9UKSShAk0pVoAeBRskDVw=;
        b=gtXeySxwi3PoPzM46NNGRQHQZfk2ISkDlV/aF6MNHZwjrrFcBrGF/Y6h0DnFuiY8zB
         4RuhVMAF933vhLYi1jBQNsxiSEWjvQPRkNNw9nktmf8wYncIbbhWCZm5wq1gPxjvSLpP
         cXsQJ8w0A5LOBn3ta1DpDDLmO4ASph3LXrZCvtt9bYtk2MvtgGv4fbuI/a2VgpvACgx9
         0fEq73selSNxZASOuH0EL4wCkrYoWMXI5Ejbmnlce5UQ50snM3lMtGE327gBI4CZLBzh
         IohYHzDPaztLG/VUwPWE+AJol6wq8CaU3hPucvbqn2zV3Q7jMiz4fr2OGKOmUj7Gd+h9
         zHHA==
X-Gm-Message-State: AOJu0YzTURpge4iZ7ojFd6Ts+DOoNdi+qYDBk5maM4vSLX9ZFq2SfqBB
	2NJXvd6i7IjtXAZBZcbHo5PaDDoTSdvVKmjpLON6Xz3V7X6WalhLL+ZcNQ==
X-Google-Smtp-Source: AGHT+IFqPaVzJwjKdCz+zT/UW2wJpDdZc+xGRDH+xt/ijn6H6ZIBqZtSC9ajtEejlFBlcXFWdHaCwg==
X-Received: by 2002:a17:90a:ce08:b0:2ab:8324:1b47 with SMTP id 98e67ed59e1d1-2d47327c70bmr5465287a91.15.1724174224643;
        Tue, 20 Aug 2024 10:17:04 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:bd02:d0ce:e791:dc08:a375])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3171e01sm9721042a91.30.2024.08.20.10.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 10:17:04 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Mostafa Saleh <smostafa@google.com>,
	Will Deacon <will@kernel.org>,
	Rob Clark <robdclark@chromium.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	dri-devel@lists.freedesktop.org (open list:DRM DRIVER for Qualcomm Adreno GPUs),
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joao Martins <joao.m.martins@oracle.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-pm@vger.kernel.org (open list:SUSPEND TO RAM),
	Marijn Suijten <marijn.suijten@somainline.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sean Paul <sean@poorly.run>
Subject: [PATCH v7 0/4] io-pgtable-arm + drm/msm: Extend iova fault debugging
Date: Tue, 20 Aug 2024 10:16:43 -0700
Message-ID: <20240820171652.145673-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.46.0
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
v7: Re-use the pgtable walker added for arm_lpae_read_and_clear_dirty()

Rob Clark (4):
  iommu/io-pgtable-arm: Make pgtable walker more generic
  iommu/io-pgtable-arm: Re-use the pgtable walk for iova_to_phys
  iommu/io-pgtable-arm: Add way to debug pgtable walk
  drm/msm: Extend gpu devcore dumps with pgtbl info

 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  10 ++
 drivers/gpu/drm/msm/msm_gpu.c           |   9 ++
 drivers/gpu/drm/msm/msm_gpu.h           |   8 ++
 drivers/gpu/drm/msm/msm_iommu.c         |  22 ++++
 drivers/gpu/drm/msm/msm_mmu.h           |   3 +-
 drivers/iommu/io-pgtable-arm.c          | 147 +++++++++++++++---------
 include/linux/io-pgtable.h              |  15 +++
 7 files changed, 158 insertions(+), 56 deletions(-)

-- 
2.46.0

