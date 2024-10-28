Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8B91F4275
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 21:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730151332; cv=none; b=GdItjrUXXf/ENokwvmyG4rd6GpGa/WZCwcFqMy1ObKMUMbUPCfBOjGZRLd/OrOjKqI8xz18VT2ciQ7zG4AgwsV8e6+T091s9GuHtTyoBxTDkm/mbQFlmtK/qGuNQu1MuPnfk7f5yCT/6OYe4rSweeFCf0htMMGjbKcg5OsLFp+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730151332; c=relaxed/simple;
	bh=CC5DXv1pWsSCQKxatEBjAd9fJMcRefvmUAh3/PlXxlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ktsml8THI8hVGodHtEEmKrAWSBrdJkuZbsg4/0+y2sh66oO+qSewm/Hj5cRV5Tflu83tbFUiKvb0rCMyu+tMD10a1urhXZJQBRkqn43q0aZmaCU/to4qFoiUXhe7gMPHPdqUBHpjuRAQ1EdaEHS7CUR+H1R5Q/k9N581BZLsbFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsehMGfA; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsehMGfA"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e983487a1so3505251b3a.2
        for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 14:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730151329; x=1730756129; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5JCDOT4G1vRDgamkQTQYoEg3xqOKYS4iUoOBpBdGUM=;
        b=lsehMGfAozhiyGJTxISoOsaXwqYF+ptF2v0iqgDNwz+7/m9IXnMhTphn0cK/jJlK7s
         7LCIfzM6gePu76tXZ3ZHIBAuit7gebTY0a/EFcMVNIhwWZF1HYRTSNMD8X/V2SNj/sa6
         rutz3zIxcDUNdK5LrqhWZLb0Rct7hB8E+sFN8Y4pbW8/PWVTDd7HIW1KZODUa0ieX3Ud
         mvuPgOoXRZxGICekVNdJ6hXy/+YT1Jry/ubx0sAzWIlTumKLSisU+OGm/xb0eI4mdIng
         AuXaEEtIhHWuTRgIdVJsMON/w6nlpwSN6LOq26+9uThR9y9vGN+CB6PS2WMTGJgbsDOY
         Y0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730151329; x=1730756129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5JCDOT4G1vRDgamkQTQYoEg3xqOKYS4iUoOBpBdGUM=;
        b=umdktXt9fvXOx7i+FYkh8ahts/v5YNwkH8xyY1jXCv4unw30b7w6LsOOUdfU19VjBt
         Vi7oq3x4TO30ClqHxF8yeNJ+HMAvQj8Uqfjf+Syl5R7UCVlEnw31tKGxpDhXCneSiQsG
         fTLp7Qej0jBsBjoAGGAzg8rjnvKmJKiDltlm5cSQA+absyeFFeOk08UyCyi8H8xQCC0D
         fA4Mk6OE37l8ncFY9ZCF9SM4QlbhinGlnzIOti2gnW4urhbW8/kD4+AuDaT6/O+b5Wr/
         j4n3+dU9yVwpQWYX5JV3t6jQ+Zkvb3vrFVreqWDMKvec13qeFCphbn2sat6wu4oFuDP9
         PLcQ==
X-Gm-Message-State: AOJu0Yzzhv9zmh1JbH4FI1fEazZ4P0c5ArRZDm1LHabaorw/5I/VWjEd
	+5wIJJP/3IrUMmgThpRkBPk5mI9TA/RHiVPkYju50CtopS5yg5AR+xjzKA==
X-Google-Smtp-Source: AGHT+IGJ/vSmxwIqBeNVXBSzAWZP5g2tROL+0Y2wcPzndUVsioqMA6yobuvrQ/JZESgfajh0W3hfHw==
X-Received: by 2002:a05:6a00:230b:b0:71e:4cff:2654 with SMTP id d2e1a72fcca58-72062f86088mr14718581b3a.6.1730151329086;
        Mon, 28 Oct 2024 14:35:29 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:12e9:d196:a1e9:ab67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791e4dasm6207770b3a.25.2024.10.28.14.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 14:35:28 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Rob Clark <robdclark@chromium.org>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 3/4] iommu/io-pgtable-arm: Add way to debug pgtable walk
Date: Mon, 28 Oct 2024 14:31:39 -0700
Message-ID: <20241028213146.238941-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028213146.238941-1-robdclark@gmail.com>
References: <20241028213146.238941-1-robdclark@gmail.com>
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
 drivers/iommu/io-pgtable-arm.c | 25 +++++++++++++++++++++++++
 include/linux/io-pgtable.h     | 15 +++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 88b128c77893..6739e1fa54ec 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -762,6 +762,30 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 	return iopte_to_paddr(d.pte, data) | iova;
 }
 
+static int visit_pgtable_walk(struct io_pgtable_walk_data *walk_data, int lvl,
+			      arm_lpae_iopte *ptep, size_t size)
+{
+	struct arm_lpae_io_pgtable_walk_data *data = walk_data->data;
+	data->ptes[data->level++] = *ptep;
+	return 0;
+}
+
+static int arm_lpae_pgtable_walk(struct io_pgtable_ops *ops, unsigned long iova,
+				 void *wd)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	struct io_pgtable_walk_data walk_data = {
+		.data = wd,
+		.visit = visit_pgtable_walk,
+		.addr = iova,
+		.end = iova + 1,
+	};
+
+	((struct arm_lpae_io_pgtable_walk_data *)wd)->level = 0;
+
+	return __arm_lpae_iopte_walk(data, &walk_data, data->pgd, data->start_level);
+}
+
 static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
 			    struct io_pgtable_walk_data *walk_data,
 			    arm_lpae_iopte *ptep, int lvl)
@@ -937,6 +961,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 		.unmap_pages	= arm_lpae_unmap_pages,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
 		.read_and_clear_dirty = arm_lpae_read_and_clear_dirty,
+		.pgtable_walk	= arm_lpae_pgtable_walk,
 	};
 
 	return data;
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index b1ecfc3cd5bc..d7bfbf351975 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -178,12 +178,26 @@ struct io_pgtable_cfg {
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
+ * @pgtable_walk: (optional) Perform a page table walk for a given iova.
  *
  * These functions map directly onto the iommu_ops member functions with
  * the same names.
@@ -197,6 +211,7 @@ struct io_pgtable_ops {
 			      struct iommu_iotlb_gather *gather);
 	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
 				    unsigned long iova);
+	int (*pgtable_walk)(struct io_pgtable_ops *ops, unsigned long iova, void *wd);
 	int (*read_and_clear_dirty)(struct io_pgtable_ops *ops,
 				    unsigned long iova, size_t size,
 				    unsigned long flags,
-- 
2.47.0

