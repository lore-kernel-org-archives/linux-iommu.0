Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EDD231C8E
	for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849509; cv=none; b=tnJAjAIl473HZ5+I0JZF20M56RL2TtCv1WUWhZMe2wBQLFaajIVEzzt+6wpRmixnUgBeN63zc0H+oqMdfg95gf3DmHVZ9Y/kNINocd5TXCvICqZtb8VQDSnFhWWqhCMvd1LkiqVNegLHXAo6WVpOXo6UhheKX82qNrfmbUI1Ac0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849509; c=relaxed/simple;
	bh=HQjazjHoVqCC77TI+HmmJVcQ/ST4rzg2hFCio5lxu0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLd3yoofCGTzz9F5R+IZiCD0VzDGcIn1y1nEwx3z+y8b4UHDfPWJ3TBGRw3XuuYXFOHTScJudxQb6wokGBwUHv8XQDA91llYcXKbeejuDKLaszBYxrPFS7bLfjzm7viwFdbjJIm80SPbjcBch+Zidgj7KVtUEVQVBRy3Vu5hXpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OS/xNSF6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OS/xNSF6"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21675fd60feso11298895ad.2
        for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 08:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733849506; x=1734454306; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXOH6pZZi9eL22B8MhhX9UUu8EkOGTpVPSjjBt9TTq4=;
        b=OS/xNSF6mKWFlwE7j9FQ6TqeTwlKnsFJqQ/iicKoc4ROiQKAC5xDgkVIrlneiQE8qi
         PSG00lQtglHDBN1cNg/8Ex2Sp47UN2KxLmkQh75PIZ5TFHNh6B4h03Ke1M/vzvOF5TCY
         7KlccRBpbWke2Y+2zqelK4kM9hOkAeFgTBdefCHCX8fItyAQM6VeDE80iaaL1gm/IJvp
         mXJHWoigOTX4P5F+sf7bOROYGqnYCNiaQTmLmJFoPCQkfyY6fFijPPS/YD0k0p5HCOO3
         XJm5mN5NR4DWzsLm/Kcndp4PIBvwNihqjO3VcV3gnV6sdlkXorg21HIIeJ9ryTobNLQu
         CgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733849506; x=1734454306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXOH6pZZi9eL22B8MhhX9UUu8EkOGTpVPSjjBt9TTq4=;
        b=GPuHaUzhJJNX0QlxF1DMGPYISdGiVJ0x+vdBKL7gLleetvUiU9ZMI4DNyAyUqNwq3+
         dom0Kay0VqQGzWSjVSA3DdGTTsp7Z/E1Zs2qNMmDkTKfr2kmCP5uB+atSLo9yJ6VTtrH
         BBrl8C9FwkaidmapGYixo0iczGhhuyzXnb9lJ76cfBgLtN8otNAJ5sisGIV0AQXxAy6Q
         Q+nrR/ge4kjmmbiXwwUeAc5uclsbfOYXpEcv+wHQ12dh19k8sqC8Y9IEpsLS//1GKAnO
         MzR6rTyDkZ0gjfabMOFbDnV6t4G9JjvRdUBWciTfVyGjZNEERLd8+DCmNM/p5lL9ZnR0
         YN8A==
X-Gm-Message-State: AOJu0YxyMR7Vy0enVKpUCelkqOKXofDP1TavZfXoKN1HVAnw7Oy5rBK9
	miyq6CEbaO6ZAn9HS8Uc6lxwftYYemFMWMq2RXWoHbyVUk6arIMYAqqQJQ==
X-Gm-Gg: ASbGncsuHByIgihikgaioOat98WKDqCCnC4Y9aW436XVzUbEUiGipdhQXi3LRwBLCdN
	Uk58mwRwWp05iWvpPZiBGhZJAh5IG1lNQQQ0jNRXyt5I7ZFPsgt8TwY72Byb11dPQsZKUaJpSu2
	RAcqFDmM+I6Oyg2NOKKCJnWiwZdlWxUfBRYpe6fZMzWxO6w7xAnqYDOuNOIVwfoOp1jDrhpGXOy
	WNQuCmuYDfUH2Ol4h++tgejezAJXPjqBp3rCscifx4XX5GGuq176/jBOqGPYqM8Q3ay5zTbxg9Q
	NA6kaUWVyZYF67bOs2YNjxGC033z
X-Google-Smtp-Source: AGHT+IGzJ9YtJRIXUx2WRftwh52jZYFp+OAl8TSYa6XERyxw2e0dtG6AQ2EjYin88gd4uM+Xi+ABrA==
X-Received: by 2002:a17:902:e94d:b0:216:7761:cc48 with SMTP id d9443c01a7336-2167761cd20mr46263785ad.40.1733849506543;
        Tue, 10 Dec 2024 08:51:46 -0800 (PST)
Received: from localhost ([2a00:79e1:2e00:1301:12e9:d196:a1e9:ab67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8ef9fcdsm91889225ad.146.2024.12.10.08.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:51:46 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Mostafa Saleh <smostafa@google.com>,
	Will Deacon <will@kernel.org>,
	Rob Clark <robdclark@chromium.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v11 1/4] iommu/io-pgtable-arm: Make pgtable walker more generic
Date: Tue, 10 Dec 2024 08:51:19 -0800
Message-ID: <20241210165127.600817-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210165127.600817-1-robdclark@gmail.com>
References: <20241210165127.600817-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

We can re-use this basic pgtable walk logic in a few places.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 67 ++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 0e67f1721a3d..7e9c0f8ae138 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -749,33 +749,33 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 }
 
 struct io_pgtable_walk_data {
-	struct iommu_dirty_bitmap	*dirty;
+	struct io_pgtable		*iop;
+	void				*data;
+	int (*visit)(struct io_pgtable_walk_data *walk_data, int lvl,
+		     arm_lpae_iopte *ptep, size_t size);
 	unsigned long			flags;
 	u64				addr;
 	const u64			end;
 };
 
-static int __arm_lpae_iopte_walk_dirty(struct arm_lpae_io_pgtable *data,
-				       struct io_pgtable_walk_data *walk_data,
-				       arm_lpae_iopte *ptep,
-				       int lvl);
+static int __arm_lpae_iopte_walk(struct arm_lpae_io_pgtable *data,
+				 struct io_pgtable_walk_data *walk_data,
+				 arm_lpae_iopte *ptep,
+				 int lvl);
 
-static int io_pgtable_visit_dirty(struct arm_lpae_io_pgtable *data,
-				  struct io_pgtable_walk_data *walk_data,
-				  arm_lpae_iopte *ptep, int lvl)
+static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
+			    struct io_pgtable_walk_data *walk_data,
+			    arm_lpae_iopte *ptep, int lvl)
 {
 	struct io_pgtable *iop = &data->iop;
 	arm_lpae_iopte pte = READ_ONCE(*ptep);
 
-	if (iopte_leaf(pte, lvl, iop->fmt)) {
-		size_t size = ARM_LPAE_BLOCK_SIZE(lvl, data);
+	size_t size = ARM_LPAE_BLOCK_SIZE(lvl, data);
+	int ret = walk_data->visit(walk_data, lvl, ptep, size);
+	if (ret)
+		return ret;
 
-		if (iopte_writeable_dirty(pte)) {
-			iommu_dirty_bitmap_record(walk_data->dirty,
-						  walk_data->addr, size);
-			if (!(walk_data->flags & IOMMU_DIRTY_NO_CLEAR))
-				iopte_set_writeable_clean(ptep);
-		}
+	if (iopte_leaf(pte, lvl, iop->fmt)) {
 		walk_data->addr += size;
 		return 0;
 	}
@@ -784,13 +784,13 @@ static int io_pgtable_visit_dirty(struct arm_lpae_io_pgtable *data,
 		return -EINVAL;
 
 	ptep = iopte_deref(pte, data);
-	return __arm_lpae_iopte_walk_dirty(data, walk_data, ptep, lvl + 1);
+	return __arm_lpae_iopte_walk(data, walk_data, ptep, lvl + 1);
 }
 
-static int __arm_lpae_iopte_walk_dirty(struct arm_lpae_io_pgtable *data,
-				       struct io_pgtable_walk_data *walk_data,
-				       arm_lpae_iopte *ptep,
-				       int lvl)
+static int __arm_lpae_iopte_walk(struct arm_lpae_io_pgtable *data,
+				 struct io_pgtable_walk_data *walk_data,
+				 arm_lpae_iopte *ptep,
+				 int lvl)
 {
 	u32 idx;
 	int max_entries, ret;
@@ -805,7 +805,7 @@ static int __arm_lpae_iopte_walk_dirty(struct arm_lpae_io_pgtable *data,
 
 	for (idx = ARM_LPAE_LVL_IDX(walk_data->addr, lvl, data);
 	     (idx < max_entries) && (walk_data->addr < walk_data->end); ++idx) {
-		ret = io_pgtable_visit_dirty(data, walk_data, ptep + idx, lvl);
+		ret = io_pgtable_visit(data, walk_data, ptep + idx, lvl);
 		if (ret)
 			return ret;
 	}
@@ -813,6 +813,23 @@ static int __arm_lpae_iopte_walk_dirty(struct arm_lpae_io_pgtable *data,
 	return 0;
 }
 
+static int visit_dirty(struct io_pgtable_walk_data *walk_data, int lvl,
+		       arm_lpae_iopte *ptep, size_t size)
+{
+	struct iommu_dirty_bitmap *dirty = walk_data->data;
+
+	if (!iopte_leaf(*ptep, lvl, walk_data->iop->fmt))
+		return 0;
+
+	if (iopte_writeable_dirty(*ptep)) {
+		iommu_dirty_bitmap_record(dirty, walk_data->addr, size);
+		if (!(walk_data->flags & IOMMU_DIRTY_NO_CLEAR))
+			iopte_set_writeable_clean(ptep);
+	}
+
+	return 0;
+}
+
 static int arm_lpae_read_and_clear_dirty(struct io_pgtable_ops *ops,
 					 unsigned long iova, size_t size,
 					 unsigned long flags,
@@ -821,7 +838,9 @@ static int arm_lpae_read_and_clear_dirty(struct io_pgtable_ops *ops,
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
 	struct io_pgtable_walk_data walk_data = {
-		.dirty = dirty,
+		.iop = &data->iop,
+		.data = dirty,
+		.visit = visit_dirty,
 		.flags = flags,
 		.addr = iova,
 		.end = iova + size,
@@ -836,7 +855,7 @@ static int arm_lpae_read_and_clear_dirty(struct io_pgtable_ops *ops,
 	if (data->iop.fmt != ARM_64_LPAE_S1)
 		return -EINVAL;
 
-	return __arm_lpae_iopte_walk_dirty(data, &walk_data, ptep, lvl);
+	return __arm_lpae_iopte_walk(data, &walk_data, ptep, lvl);
 }
 
 static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
-- 
2.47.1

