Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22B719412F
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692557; cv=none; b=XwSx0E/zJgPHldv79lEn7u2+FfE/qo51LIsQJfQfyuYFIEbBjPX8SHHD2QVJNJI0AEgxV7ph1oWcv1qW8H31cd9TdYBSl77zSw6UL7sI6UuxjHqWYsD0danzk0vFwtla4OabuQ7h9M2SSOkAbCbWfEFDaNffuJ4cv4Wptq3o/5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692557; c=relaxed/simple;
	bh=aag4ttsnwtXSFMZta8hZFDauX1VZpiHxIrwcXJXjvsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p3tes3E1uzS6rciqcs7RHxwLuOWGiNC/bysqEECiI4rf0F5Pms8WpkGAjTGmjAVTxtcjt0rKgy505gMiyO8Qr1/NUHJvLS2xbHyzKFL+xLqopTMKVRi69FitIRhHr6d+fl/oqJ7oYeZUHgyt1SYw32Mso9PHFxr1mmLCCz+OTh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PY4qo3o/; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PY4qo3o/"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7106cf5771bso3662886b3a.2
        for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 10:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724692554; x=1725297354; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vcql72JPQTQ2OTkoapF5mbW4vnMiQPQvKYGW7HfPhkQ=;
        b=PY4qo3o/vJrhJHnYAcYflCby9+9WIsTEw6l+xAaXmsCTOnhK+XdcGOSLGUFmOvuALZ
         kw2U27VZHwwU99iPOxjKJARmNVr6GciwZ4e3QcPbkjWwR6ZHfjSSuQ1LL7xFL0qsIIvM
         ruVRyhYvXNkDAOBdGoB3S6AVu3CXMinVZhs/05byG1+XQJu/eY4iNMYVuTRqyJxtCOtT
         nDJLGdtzBpv8PMu/Ci1Zo4QfYMg+HQ85RyFK3NQ3dlWvPVn7fi/DSDb0V3vyEEgqWFc3
         2sGjYbwBSHkeQ+If5t+nDlhb8//NQjHBSvx5O6WOMdWtUJL9D5cbNMWJUMSCS3YgigIk
         DKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724692554; x=1725297354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vcql72JPQTQ2OTkoapF5mbW4vnMiQPQvKYGW7HfPhkQ=;
        b=FczCN7MRzihaRb+gOROiU+DElx87KvIp7ys0PMhwHp8aJ4Jkvj2aDbn4MCVvSCjRr9
         ldAMFx3nxt0gtnsifBbGnwIeJJ5b/xw93xOXSI1/XpoBADRMugywT1SVHTwZK9JMMF3H
         BJNC24sea8tsvTryKhLDDoRJy1Nzt6DjYoIRXqolv6Ey8020QyL9zaCi4txttyM/6Ngj
         fRzBagq9Fi6iezN1tb1HuT4pQBz+w1VMMpy3qtgQMDoMow2IdUaPUAEIyExBKq18QJjF
         IVcZ2nwFc7uUMPnwtmMBzlxSEEdkiPmZCvkhD9xGBkt2U6CriPfTZ0mLj02gAlZaufce
         aFXg==
X-Gm-Message-State: AOJu0YyLugFYZECqxQL6p7yBTEVcwL2zw+CkBH4Wn3+Y9wFHZJX1ZJBd
	9NTg4/Iro4x70KNOr/HaGDg391qzCOUhaSW/HBKgK+UW7og1lXhyp0H5fw==
X-Google-Smtp-Source: AGHT+IHqCiVZD8k41tBXvr0tubaCtVb1j37tqzR+PZ1WdzT88DIUTlpRPwV6ErHFhiO0ftk2Eidn8w==
X-Received: by 2002:a05:6a20:4f89:b0:1cc:bb4e:a905 with SMTP id adf61e73a8af0-1ccbb4ea95amr1234779637.1.1724692553998;
        Mon, 26 Aug 2024 10:15:53 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:12e9:d196:a1e9:ab67])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9acdca6asm6761815a12.48.2024.08.26.10.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 10:15:53 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@chromium.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	dri-devel@lists.freedesktop.org (open list:DRM DRIVER for Qualcomm Adreno GPUs),
	freedreno@lists.freedesktop.org (open list:DRM DRIVER for Qualcomm Adreno GPUs),
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joao Martins <joao.m.martins@oracle.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-arm-msm@vger.kernel.org (open list:DRM DRIVER for Qualcomm Adreno GPUs),
	linux-kernel@vger.kernel.org (open list),
	linux-pm@vger.kernel.org (open list:SUSPEND TO RAM),
	Marijn Suijten <marijn.suijten@somainline.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Sean Paul <sean@poorly.run>
Subject: [PATCH v8 0/4] io-pgtable-arm + drm/msm: Extend iova fault debugging
Date: Mon, 26 Aug 2024 10:15:37 -0700
Message-ID: <20240826171546.6777-1-robdclark@gmail.com>
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
v8: Pass pte pointer to callback so it can modify the actual pte

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

