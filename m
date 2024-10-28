Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0911E00A0
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 21:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730151324; cv=none; b=aFWf0BtgV0S4nIp82v27z21vDsdYEPT+lZizfO8P8eetgjqu74yd/fi4uaNV3Ul8bmMUSY8L59NGIMdiSuXBOEejC+WwQa0Vwzipuj6tdogg3X+teeMvt4MHRXaKOCSgVNHukUia/cRuse2yQwnstKXOgzyQb/xUse2bsJ8Zuok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730151324; c=relaxed/simple;
	bh=86+cVO9x+rqe0mkARdlhmy599lZTkD1tVtwmH1rilNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YVMMOcFtNYkQU9u5JslF5MmkOpn19+KMJMc5DlMQdNow8jf4XEmWSTDmPE+3CZQee2BJNcadzWZ8JVX16Tbl3MeZU9CmYHdIfbq4YNfCNvrW004ES8dgbDa5+9CQnzbcbS1C+0Q3IyHBYRQ411U89+qtIKixX+5szkShhJQCF1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsXjirSr; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsXjirSr"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso41393925ad.2
        for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 14:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730151322; x=1730756122; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O/WuSIt+DjzGI2XfAN06ei9IlKFvKYq+fLWWtLmBqEs=;
        b=PsXjirSrEE3lP1aXUWXx+DAcLW/iNyhth8N3boyZ01JUhCXGE4uDCsqf31Ft5xGp3v
         UK6ALmOBO+YKdMWHvirNnYvWNlfPw8/b915n5VnK27FjrtHy806Q5P2sYGh8OcMqMF5m
         zgpTx4k4k/rPZpkWmvul9f+SnQ/Nys1DGMHFknXznMQ3r/bWOxcUCDbFEKwvb9OMYNDt
         EBZwI9mymT9Amse2SJM1g8fblrJPZOGH4IEsvCoMlj8epz39+I4wt5cOIHlJJC8oTfb4
         kKMnfvkIp2wqlh768xFrDVp9ensSd2hgGhzAJQi3h9k7Aa+5OubQ2tfNRU8wfu3ycYM1
         2PqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730151322; x=1730756122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/WuSIt+DjzGI2XfAN06ei9IlKFvKYq+fLWWtLmBqEs=;
        b=RvGlKFThsLHPkba2V42dEbbY7qY94dxOru4AiPrzJySOTyB3jNwtUR0Vj0vS1pJNbt
         xou9VudQKb6AjvjcdzmjvLBo3coxS5arkunYVuhaIFTYKQWVlhdCyb75Vz7CWba3Ivad
         BuqI6WnErW+oDaGRIM3QtCO0U/76tQSj6pucIimLfBQ/etJCI+PiqKbGlVU03VnSAtSc
         +jakBuBOW2DdKSs0MdWa1bjHWISVHZkyUJRVL108sW2dpGgRgBsRhFK/ZRiwKOLlS+Qp
         wGfUt3QzNsTk40Pvdogh4MWLKoBJYn29ZPGC0f/VyYiEoQv5BEg9hb67Jevr7MqAXZV6
         joRw==
X-Gm-Message-State: AOJu0Yy6mZRUQdimWWkiU2BIyg+GkT1ht2sghOWuauP6mqZMADJ5a7mt
	QAwiTCe7DqFfSJDZU56A53Wq4/T0MJlCjBNpQpeDg0yZE6KaRUc2NAwYhA==
X-Google-Smtp-Source: AGHT+IHpXaUaQZbGQlSlLzr86C3aCU0KQKQ4WqN1NM7MJCznKl4kJ0inRJj992VpciPWjE7vWWI19Q==
X-Received: by 2002:a17:903:2445:b0:20c:bcd8:5ccb with SMTP id d9443c01a7336-210c6c0610amr146342205ad.30.1730151321914;
        Mon, 28 Oct 2024 14:35:21 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:12e9:d196:a1e9:ab67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf6d3dcsm55171655ad.88.2024.10.28.14.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 14:35:21 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Rob Clark <robdclark@chromium.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	dri-devel@lists.freedesktop.org (open list:DRM DRIVER for Qualcomm Adreno GPUs),
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joao Martins <joao.m.martins@oracle.com>,
	Joerg Roedel <jroedel@suse.de>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
	Marijn Suijten <marijn.suijten@somainline.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sean Paul <sean@poorly.run>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH v10 0/4] io-pgtable-arm + drm/msm: Extend iova fault debugging
Date: Mon, 28 Oct 2024 14:31:36 -0700
Message-ID: <20241028213146.238941-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.47.0
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

v2:  Fix an armv7/32b build error in the last patch
v3:  Incorperate Will Deacon's suggestion to make the interface
     callback based.
v4:  Actually wire up the callback
v5:  Drop the callback approach
v6:  Make walk-data struct pgtable specific and rename
     io_pgtable_walk_data to arm_lpae_io_pgtable_walk_data
v7:  Re-use the pgtable walker added for arm_lpae_read_and_clear_dirty()
v8:  Pass pte pointer to callback so it can modify the actual pte
v9:  Fix selftests_running case
v10: Call visit cb for all nodes traversed, leave the decision about
     whether to care about non-leaf nodes to the callback

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
 drivers/iommu/io-pgtable-arm.c          | 156 +++++++++++++++---------
 include/linux/io-pgtable.h              |  15 +++
 7 files changed, 166 insertions(+), 57 deletions(-)

-- 
2.47.0

