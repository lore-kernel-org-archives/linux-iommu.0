Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C4B1BC09F
	for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849507; cv=none; b=Vre8hbaRT2YmMw0Xm5Y42Ly1KKcYE8uaDC1GSvcHReXLW3uXforMOiVCzUHFfbuUIzUTgjUqOOKhwcQql7pbzul161ORz8QqHstuM3zq6fNl2zqC33tWI8ROHcIgLwG6uwGKURtQo3B5ptnLfF14zbBN8j1n3fN5lvZDYkv2z3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849507; c=relaxed/simple;
	bh=Mxw/pGwRlstlF+sMsnwXXRjVPqmnOa+upzVXrXLGTd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p7Inak1OCiFKJzuzVw8i9j/VwESz/ZS01OHMjFcSrpkxO2hjdFIM3861II4H+SOJiNH6iio4tKqUf3VVF/3a9H8xqYk3fX/Sqmcu7rjjcjise42/vCdD1Ef9lG5DzwxzZu7pc8kO9Cv0ersHL1jtRfN2oUCz1rq8cWmAVivxVg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kImILh/0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kImILh/0"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21644aca3a0so27891955ad.3
        for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 08:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733849505; x=1734454305; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JuzEEwZKQf9j9mqhaN0lST/eQY9CbMt5tK8I46FKdZM=;
        b=kImILh/0gyTRW4ReWEg1jTbM/9xDFOSQu/cnaQKfY8XOUahCrJ2FQPLKYOpnlpHbB6
         cieXo0vaLqpZ4lOiBHcvqZpJYGNyv8+enliMHz39Zy2AREPRk1YyYyv6sPlqAp3+pgw6
         cSzB29rNEk5hxbCu9PlOimFY4dIZ6apzXaIxg+vOpzZIX6hz20BgtMnJVaeRof3CGaca
         fBYW6aE/75wZfWXpVtZw+EWL0t4e+2Rmw+3xR7+7L6OIGjarxgzE9DXwIoMpm+ondCvh
         Zf4eJsQV43FbCofSmC+/8jUpV/GSfixM1D5PtCzphxow06NuGdTFdAm1KTKIWQR/T1Gb
         LO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733849505; x=1734454305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JuzEEwZKQf9j9mqhaN0lST/eQY9CbMt5tK8I46FKdZM=;
        b=e3cRbRwJMrfeeQAH1A/qJP12HOdbGPv/mbx2rSjSFx0W370Sz4R1qUcyNtDuXLuuOz
         8srDuUvxxlh60h5aFK8PtE8ftZ3By+wvRpxnOrYsRAoGgPylfYsioNiy/EpCNd1mFvCc
         bjnf/NQw/XhDOe+K+anFP9Ues3RHWE3/GFSLpkjkZRGqz+yLku9+lXJ26CmLJjPtbsJN
         adIthtPvEZfjzOpZoREgPcmydJ+mQPaT0kPy+rZHDkPkyoHH1bAiUNva78MJ780fvEcd
         QCF7N0NY292yUsIF9Awp2iECLxnP8xPuQFZmc/gYyOMcI8g1xvs2P9+dJqQ5fBfGzpsO
         Uu1A==
X-Gm-Message-State: AOJu0Yw8cOLLyZu3/gQV0OwZpjEbVHj/L+9Dz8Hc6+Qfw42kD+71AslI
	zqglhXVbP2P1mRIMTc3NpbOofGc5upQQgfPP1DA8CBFbS1FzGY3mjphSOw==
X-Gm-Gg: ASbGncs/GKK77apnhbt1OBkH8DxjJmegE12e0CSpbuBzn+iehwvNUMHYWR5VKprxaJW
	51W7DyMfpgYQlYGScopJPI2TgseBE/q+RS/T3lKHq0DRwV3z6aSP0to6y+P8rNZUVuAfQaqiFcJ
	Ow6bmym7cOkDmV0YdkaIZJe2KfdyRfSKqC4jxfmCxPrIg+v1pVkD943sQoToyVnPILU6Om3yvQA
	2JaxlF0i+FAid3Okx2RXWds6XwOM6T+oTrcmadgy6/FLeTgvZN23vey992UCPIDgB4vi30Hld07
	JSQVL+o9HYlH9oDRQOQDQa8pviFu
X-Google-Smtp-Source: AGHT+IHq5GJLA69hWJIqMBI3xX9I2B1vs+oiOQMLHk1Gt8OrfhdtpCShimUSU+G1kzy0p/Cgwakamg==
X-Received: by 2002:a17:902:e750:b0:216:3c36:69a7 with SMTP id d9443c01a7336-2166a0987ddmr69103725ad.45.1733849504588;
        Tue, 10 Dec 2024 08:51:44 -0800 (PST)
Received: from localhost ([2a00:79e1:2e00:1301:12e9:d196:a1e9:ab67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216363a3176sm51054905ad.246.2024.12.10.08.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:51:44 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Mostafa Saleh <smostafa@google.com>,
	Will Deacon <will@kernel.org>,
	Rob Clark <robdclark@chromium.org>,
	dri-devel@lists.freedesktop.org (open list:DRM DRIVER for Qualcomm Adreno GPUs),
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joao Martins <joao.m.martins@oracle.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-pm@vger.kernel.org (open list:SUSPEND TO RAM),
	Marijn Suijten <marijn.suijten@somainline.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Sean Paul <sean@poorly.run>
Subject: [PATCH v11 0/4] io-pgtable-arm + drm/msm: Extend iova fault debugging
Date: Tue, 10 Dec 2024 08:51:18 -0800
Message-ID: <20241210165127.600817-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.47.1
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
v11: Adjust logic in 3/4 [smostafa@]

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
 drivers/iommu/io-pgtable-arm.c          | 157 +++++++++++++++---------
 include/linux/io-pgtable.h              |  15 +++
 7 files changed, 167 insertions(+), 57 deletions(-)

-- 
2.47.1

