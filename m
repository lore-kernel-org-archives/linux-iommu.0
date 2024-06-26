Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44A2194A4B
	for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 20:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434446; cv=none; b=RU3004ksXPzgIMcKJHCtvUdgSDlKHBIy+PSTM74SGacAbtPM/jhNakcqEk9/1daKsoSJz1N9OjmGLypSApWOvyFpJTVDOhqedCezhd4jmEejXF5w/VKSYJplZ4SvBhLOJTET35hBfdfItkcy7vXm+QtxY9c+M/V4Yh9W4Ic/B94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434446; c=relaxed/simple;
	bh=7ygJSLQfDdfbrZWFxTLGncJDB5G5YXZLoE2oO7GcnVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftDPlV15xjNHgyMKTSAim3NiL5ckdRkPjwV6tW/ZBdZ91VdKDdmzSofTt7jrbcfoDd8usmWY1PDy1KpJiSyue6YxzfDOuPhWAjpTZ0PnwxsFupmHCsgNMVFQRopR5alRMOhDMFMMse5nmDL+P4Oc76jYH1AKYuzHf0S+7DxSw58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/sCDusL; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/sCDusL"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c70c372755so5702830a91.1
        for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 13:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719434443; x=1720039243; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1ccrWAfm2+YAWyJm8Rli1gQgctwQczx9hjWBKBs/tM=;
        b=X/sCDusLpvd1ODmVm4n8aFBlz2Y8Olz9d3G+OwtG0xjWsSdSKwdO7i/CSzrHU8C8nr
         4RzsUx2UbofFvIVeJ4aYYBpHvUZKG1wx7uTk7It/PkRv+oLmfxN7+Ujes7BvxRjFzLlB
         xsrtxPtHHh94rfUMuYuDYrX391W4KC4AkZ5zt/MpMpdcOn+hvH3SYvgejomB3FLgYTAk
         jahpSbJztJ2zlbHRFyg5QTEA/yY5YTuUQdrndQp5z5/J0a7+kAaPwpuJVrTT4qBCjIeK
         QIJlrJnQxbHSG1IeH3KDkeP8rKKVwyzrrgVsdD8zl6Kp2ibGAYGNBQFrtstPDSghaGJs
         JrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434443; x=1720039243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1ccrWAfm2+YAWyJm8Rli1gQgctwQczx9hjWBKBs/tM=;
        b=VCYOLoHTyXQvcqvmQquy4BJOhqKOpgv80kRjeZWCDX3xSBnnK9Meydug18ieMeRd0K
         KT3SbOVfDrrpAnDkSMs4bs39ryhD1WrfmNLinz9jGMUQVY0bP8knwRtdd02LidZ858vm
         SmYxHUU3Fwyo2NXkDmpCzXqs//XCClEEoxi1WeSI2OF2otsXzC8WPMmE+Hwbj4Pcm6jO
         jLb7ppO2jilzK+7l5AGbfgfx4c6HQMrhIDf5nv5zsumgarCGsu9QTT0QzO7Ks6kmxkTy
         LRDAnIarwwmVy4Tg4BliBjXXvpDvFP7zBxISFlegWvga6OrQ4dWV8tRGoSu40BwiMxuQ
         AqZw==
X-Gm-Message-State: AOJu0YyPScwF1oADZCIlq2p7RYmogX1iPsZHIup5UPoddofpQvlKJwET
	ubf+zPQKB8B1deEu8fkFLPdhxDkFRPCCf2Fk/FnSm4QeOWrv36N+fBeS5w==
X-Google-Smtp-Source: AGHT+IHFbn9Mf226mkG84HxOEUEeVxy3S7mHjti4OIr1hTcwdtgFTCvCt4mnQxIt5on4rnPcSA7KNA==
X-Received: by 2002:a17:90a:5d93:b0:2c8:50c1:52ab with SMTP id 98e67ed59e1d1-2c86127e28amr9802564a91.8.1719434443268;
        Wed, 26 Jun 2024 13:40:43 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8e2376e6asm1482166a91.2.2024.06.26.13.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 13:40:42 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@chromium.org>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 1/2] iommu/io-pgtable-arm: Add way to debug pgtable walk
Date: Wed, 26 Jun 2024 13:40:26 -0700
Message-ID: <20240626204033.255813-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626204033.255813-1-robdclark@gmail.com>
References: <20240626204033.255813-1-robdclark@gmail.com>
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
---
 drivers/iommu/io-pgtable-arm.c | 34 +++++++++++++++++++++++++---------
 include/linux/io-pgtable.h     | 16 ++++++++++++++++
 2 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 3d23b924cec1..24bbfd9a8874 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -690,8 +690,8 @@ static size_t arm_lpae_unmap_pages(struct io_pgtable_ops *ops, unsigned long iov
 				data->start_level, ptep);
 }
 
-static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
-					 unsigned long iova)
+static int arm_lpae_pgtable_walk(struct io_pgtable_ops *ops, unsigned long iova,
+				 struct io_pgtable_walk_data *wd)
 {
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	arm_lpae_iopte pte, *ptep = data->pgd;
@@ -700,7 +700,7 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 	do {
 		/* Valid IOPTE pointer? */
 		if (!ptep)
-			return 0;
+			return -ENOENT;
 
 		/* Grab the IOPTE we're interested in */
 		ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
@@ -708,22 +708,37 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 
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
+	struct io_pgtable_walk_data wd = {};
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
@@ -804,6 +819,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 		.map_pages	= arm_lpae_map_pages,
 		.unmap_pages	= arm_lpae_unmap_pages,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
+		.pgtable_walk	= arm_lpae_pgtable_walk,
 	};
 
 	return data;
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 86cf1f7ae389..4d696724c7da 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -171,12 +171,26 @@ struct io_pgtable_cfg {
 	};
 };
 
+/**
+ * struct io_pgtable_walk_data - information from a pgtable walk
+ *
+ * @ptes:     The recorded PTE values from the walk
+ * @level:    The level of the last PTE
+ *
+ * @level also specifies the last valid index in @ptes
+ */
+struct io_pgtable_walk_data {
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
+ * @pgtable_walk: (optional) Perform a page table walk for a given iova.
  *
  * These functions map directly onto the iommu_ops member functions with
  * the same names.
@@ -190,6 +204,8 @@ struct io_pgtable_ops {
 			      struct iommu_iotlb_gather *gather);
 	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
 				    unsigned long iova);
+	int (*pgtable_walk)(struct io_pgtable_ops *ops, unsigned long iova,
+			    struct io_pgtable_walk_data *wd);
 	int (*read_and_clear_dirty)(struct io_pgtable_ops *ops,
 				    unsigned long iova, size_t size,
 				    unsigned long flags,
-- 
2.45.2

