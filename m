Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097CF1822E0
	for <iommu@lists.linux.dev>; Wed, 17 Jul 2024 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721234206; cv=none; b=PlCUqY/cMSqjzvifd2b8hdyIqcFmXQe6/QNBfk9KvAS5Mh4NU1z+ZNNeUCYR1Oay+sj1Ls1GvIiSqlOpp72eY8QYz5lHxLUSCTAJzyZl2qb+a+HrUW+KuFR7wMeuumWWymdy0JCQDdYrjRAIqKJsOzgn85wm0FI3W9qW1JSuN4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721234206; c=relaxed/simple;
	bh=XM7TQLXxkCjoyQOEvQv3KFLUCZo9Ca3tYpBMnVbT2f8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZaVKCNhAK0Dw09aIgHIqEVAW0hKjRN4YhgaicHF3xq66YTZL/VJkvu2nA/8DR3l+wv7rjBGt4uWjVhblCXTdQYY4h48ECfJTjMwokg/xkd7NShfer1Op0C8YvRyzs+dbeGThODYapKbpDMefZH38dvAiJBv8Vcnv1nH4hMPzXbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwUU3lum; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwUU3lum"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fbe6f83957so58854055ad.3
        for <iommu@lists.linux.dev>; Wed, 17 Jul 2024 09:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721234204; x=1721839004; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xS3DSdckRYn7jTy4h1ciXu44qXa/Pj3ya32AUzBMa0Y=;
        b=dwUU3lumbXS8jBXgRVWePLw0wv84tqRRmbzpQs4U+DtizsUo2NTvS+qqS8Rwv2nS9M
         Jww5YNM/D8skLhp3cck57GHv39GjqQMiamvw5okyrVc8gs68TEkevZTuQ+EQn16CtC95
         k+YdZQcGtwRXsFl+wO+U5mLjvKMa7LOXMXVl1k3C0hg5VfXFm6bErmYSTIbt2aiVq2Bd
         VSex1nPJYW5Ap5VRmgNBO6mgKa+pC7LpdfqJTOFhfDK0/nS5Xj/vHkw0mVEC8LxLm9yw
         Kx1YlIZpqwkbe+dLNP8v8OwLPcS2wPS4BX4BJHRBxZz5k0sZcYstkr9d/QNQH5EYg5qT
         e0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721234204; x=1721839004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xS3DSdckRYn7jTy4h1ciXu44qXa/Pj3ya32AUzBMa0Y=;
        b=Ayw9+QD5bCmpMLme9mxwBklWNFXLCLkBSkMoNt22ayHoGp6/OR+ArQMsNkgA5IVDqt
         9otnRlaF0cdMYSwEb9gh7gNnJL9ZEtlaNqZtkKhmUnQXUsoyRzg9lWv9ul1pqL37CE/r
         UL0jUq9w6P7FqPCIDQuFMYDdEM8UkT1ZtCyYjG6Sdl+GzYLD5RHpaRE11wceiEn7Qe4r
         7S56ChE8L//UGRvEBwIpbWQ51qaBnqDAdYAC9oE9cGp800pt5rNRRD/jck37h4B9OIQE
         4SHFQd34GstsyVxZr7UfjLqkXctRWkAjYNnKtCx62+Lco1pWhvVKHET3E8X9ke0L7Z5y
         qtXA==
X-Forwarded-Encrypted: i=1; AJvYcCUrV7LHR+8ndSUlXegSv7ZnU3mM6e391l+oG1XISHQ83JxMI2Vkz4hTuh22ToirjDJLsvOeUVA6Fpe9KjlEAgRpaiykMNk=
X-Gm-Message-State: AOJu0YwVOlKSj7OIcTl0WlScG6kI7dAHcAeocQcJSpPatpeLrXDobz3C
	29+WEiykvt+znP/sqwyCndgJuRv9Mr7ep/H5lHwLzck51wfUaO9Q
X-Google-Smtp-Source: AGHT+IFurVoTGjQHWIcjxe79/Go15gofqseCdO3ikokdIlMnT18lCbu7d4emLjIItFuPe/nEVyrcRw==
X-Received: by 2002:a17:902:ec8c:b0:1fb:779e:4fd0 with SMTP id d9443c01a7336-1fc4e130dfdmr17894525ad.24.1721234204256;
        Wed, 17 Jul 2024 09:36:44 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc4c34a38fsm13762865ad.37.2024.07.17.09.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 09:36:43 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	Rob Clark <robdclark@chromium.org>,
	Joerg Roedel <jroedel@suse.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 1/2] iommu/io-pgtable-arm: Add way to debug pgtable walk
Date: Wed, 17 Jul 2024 09:36:21 -0700
Message-ID: <20240717163627.43423-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717163627.43423-1-robdclark@gmail.com>
References: <20240717163627.43423-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

Add an io-pgtable method to walk the pgtable returning the raw PTEs that
would be traversed for a given iova access.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Acked-by: Joerg Roedel <jroedel@suse.de>

---
 drivers/iommu/io-pgtable-arm.c | 36 +++++++++++++++++++++++++---------
 include/linux/io-pgtable.h     | 17 ++++++++++++++++
 2 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 3d23b924cec1..e70803940b46 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -690,9 +690,11 @@ static size_t arm_lpae_unmap_pages(struct io_pgtable_ops *ops, unsigned long iov
 				data->start_level, ptep);
 }
 
-static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
-					 unsigned long iova)
+static int arm_lpae_pgtable_walk(struct io_pgtable_ops *ops,
+				 unsigned long iova,
+				 void *_wd)
 {
+	struct arm_lpae_io_pgtable_walk_data *wd = _wd;
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	arm_lpae_iopte pte, *ptep = data->pgd;
 	int lvl = data->start_level;
@@ -700,7 +702,7 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 	do {
 		/* Valid IOPTE pointer? */
 		if (!ptep)
-			return 0;
+			return -ENOENT;
 
 		/* Grab the IOPTE we're interested in */
 		ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
@@ -708,22 +710,37 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 
 		/* Valid entry? */
 		if (!pte)
-			return 0;
+			return -ENOENT;
 
-		/* Leaf entry? */
+		wd->ptes[wd->level++] = pte;
+
+		/* Leaf entry?  If so, we've found the translation */
 		if (iopte_leaf(pte, lvl, data->iop.fmt))
-			goto found_translation;
+			return 0;
 
 		/* Take it to the next level */
 		ptep = iopte_deref(pte, data);
 	} while (++lvl < ARM_LPAE_MAX_LEVELS);
 
 	/* Ran out of page tables to walk */
-	return 0;
+	return -ENOENT;
+}
+
+static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
+					 unsigned long iova)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	struct arm_lpae_io_pgtable_walk_data wd = {};
+	int ret, lvl;
+
+	ret = arm_lpae_pgtable_walk(ops, iova, &wd);
+	if (ret)
+		return 0;
+
+	lvl = wd.level + data->start_level;
 
-found_translation:
 	iova &= (ARM_LPAE_BLOCK_SIZE(lvl, data) - 1);
-	return iopte_to_paddr(pte, data) | iova;
+	return iopte_to_paddr(wd.ptes[wd.level - 1], data) | iova;
 }
 
 static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
@@ -804,6 +821,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 		.map_pages	= arm_lpae_map_pages,
 		.unmap_pages	= arm_lpae_unmap_pages,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
+		.pgtable_walk	= arm_lpae_pgtable_walk,
 	};
 
 	return data;
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 86cf1f7ae389..df6f6e58310c 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -171,12 +171,28 @@ struct io_pgtable_cfg {
 	};
 };
 
+/**
+ * struct arm_lpae_io_pgtable_walk_data - information from a pgtable walk
+ *
+ * @ptes:     The recorded PTE values from the walk
+ * @level:    The level of the last PTE
+ *
+ * @level also specifies the last valid index in @ptes
+ */
+struct arm_lpae_io_pgtable_walk_data {
+	u64 ptes[4];
+	int level;
+};
+
 /**
  * struct io_pgtable_ops - Page table manipulation API for IOMMU drivers.
  *
  * @map_pages:    Map a physically contiguous range of pages of the same size.
  * @unmap_pages:  Unmap a range of virtually contiguous pages of the same size.
  * @iova_to_phys: Translate iova to physical address.
+ * @pgtable_walk: (optional) Perform a page table walk for a given iova.  The
+ *                type for the wd parameter is specific to pgtable type, as
+ *                the PTE size and number of levels differs per pgtable type.
  *
  * These functions map directly onto the iommu_ops member functions with
  * the same names.
@@ -190,6 +206,7 @@ struct io_pgtable_ops {
 			      struct iommu_iotlb_gather *gather);
 	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
 				    unsigned long iova);
+	int (*pgtable_walk)(struct io_pgtable_ops *ops, unsigned long iova, void *wd);
 	int (*read_and_clear_dirty)(struct io_pgtable_ops *ops,
 				    unsigned long iova, size_t size,
 				    unsigned long flags,
-- 
2.45.2

