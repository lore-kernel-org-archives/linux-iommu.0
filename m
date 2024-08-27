Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C553D1D31A3
	for <iommu@lists.linux.dev>; Tue, 27 Aug 2024 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782650; cv=none; b=IVEf9hEN7xkfebC6UxALgneb0bZwf2l1BSi2Xo7cOemQVVvEmZ3ohwRq8DePD83diG5W666hEKxJO8fnD7D5TBK+GwdjiwB+pUDCRTm6ttxBYaEzr9DgDtV0pWkiAR5hOTE+sTyDtBjZtIULsQe36GR+EOXnG56PvaOSOlpIHq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782650; c=relaxed/simple;
	bh=0Rk9V2/hD0rJcjKDKxzcXvMS10n5ckBqPtI6KzWqjaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUboM0aF0pOOOYswngxscuhonwfKcNDieiizfUtTUR/s8DkQe4SteBouXXZlKx6zvsalMDoAdm+Ovn2LdfxnfdGdjTEcHCQkCydIKRhKNaHH354t2JaDHsy8V6spOPQZQf1757U3lL+E42ygHIyPeVaMXOyHC1EbeDKJSGztiYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cvk/PxxM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cvk/PxxM"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-201d5af11a4so51854365ad.3
        for <iommu@lists.linux.dev>; Tue, 27 Aug 2024 11:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724782647; x=1725387447; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlnDL4DTfIpU6WguUty7oq+VmfQ4+6diTuDRQNVtIjA=;
        b=Cvk/PxxMNo2lzxQT2KO4T3VYQoGjSil58y53GIfdm1QJMky8FyZwyFgkbEY0C79ngP
         bnE0EJ5bnFx5VraOT+KBIt4BKbJEyU8aTmG9QNd/A1ywLTaQCopNGevfVUi5qvQaRkCY
         f//KWsMVrdMMRPnbfgsYZDvfEMj0s0s6/d0CXnP5PeolH+vjTHTgj5HMuOBlq//LJa7e
         rMNosWBpHSdw3jDa8xLht9SbyHPlrEYgMBf8vWyw0GOB29vcnIEtsTX3xX78U3YDgF7+
         MaWmwwSatjsxeibfqY1dpdG3rGrxGzwqTBc0nj/5bhaNfWrYfNHXQaZL1ZLLst9MGjhB
         fGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724782647; x=1725387447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VlnDL4DTfIpU6WguUty7oq+VmfQ4+6diTuDRQNVtIjA=;
        b=iqgJaZJ0/6EVO6+qpErZ6zwNEAPtXFq/2rBSPqITIwRzp5n/vPHFAkTYPC2UmhrlmE
         aNmF/C1ZSU0/Iw9esjlTYrQRrBdJb3VCeGfr3CI13pAsX8eBvSQ77pgcC5+NCk7+owKQ
         5H1r9mlCj7V+qogo24Kkp62WnqAqNoC2hMCwWBWGFUR0oo00I4sXtqQ990z1ynR+WR4D
         FYDb91VA3l988PUGknI4WD+GlfiK6uMrbObBy/RJ8Gjaj6Do1piAwA0VV0XeZMoilB4I
         sxauTGAjzl3yyAKFePJbq+SIibRLWe8ftUUSQvltg8Zzg3ywAfk7KD+78yBgBg613vvZ
         nwsQ==
X-Gm-Message-State: AOJu0Yyx3xgWLDWjCmObKdIzt3/r0T0F4d22fXijdLa7GIdXgEGlJO6h
	RwXJMs0OYQqctWwe8DQu58ggNpWhCs7HjtGpoWVNeefjswsUH6ruF/yXZQ==
X-Google-Smtp-Source: AGHT+IH740SM6E9kgQZAZ/5lLwngeaj4TPfrfm6aQ5M9xb8MdaSEXtw7CS0r0ewtH7ZBKZzhgIkHbQ==
X-Received: by 2002:a17:902:f60a:b0:203:a279:a144 with SMTP id d9443c01a7336-204df45d558mr40520575ad.25.1724782647112;
        Tue, 27 Aug 2024 11:17:27 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:12e9:d196:a1e9:ab67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385566551sm86532335ad.13.2024.08.27.11.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:17:26 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@chromium.org>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 2/4] iommu/io-pgtable-arm: Re-use the pgtable walk for iova_to_phys
Date: Tue, 27 Aug 2024 11:17:10 -0700
Message-ID: <20240827181717.187245-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827181717.187245-1-robdclark@gmail.com>
References: <20240827181717.187245-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

Re-use the generic pgtable walk path.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/io-pgtable-arm.c | 75 +++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 0132f1eff688..efed8e519111 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -710,42 +710,6 @@ static size_t arm_lpae_unmap_pages(struct io_pgtable_ops *ops, unsigned long iov
 				data->start_level, ptep);
 }
 
-static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
-					 unsigned long iova)
-{
-	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
-	arm_lpae_iopte pte, *ptep = data->pgd;
-	int lvl = data->start_level;
-
-	do {
-		/* Valid IOPTE pointer? */
-		if (!ptep)
-			return 0;
-
-		/* Grab the IOPTE we're interested in */
-		ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
-		pte = READ_ONCE(*ptep);
-
-		/* Valid entry? */
-		if (!pte)
-			return 0;
-
-		/* Leaf entry? */
-		if (iopte_leaf(pte, lvl, data->iop.fmt))
-			goto found_translation;
-
-		/* Take it to the next level */
-		ptep = iopte_deref(pte, data);
-	} while (++lvl < ARM_LPAE_MAX_LEVELS);
-
-	/* Ran out of page tables to walk */
-	return 0;
-
-found_translation:
-	iova &= (ARM_LPAE_BLOCK_SIZE(lvl, data) - 1);
-	return iopte_to_paddr(pte, data) | iova;
-}
-
 struct io_pgtable_walk_data {
 	void				*data;
 	int (*visit)(struct io_pgtable_walk_data *walk_data, int lvl,
@@ -760,6 +724,41 @@ static int __arm_lpae_iopte_walk(struct arm_lpae_io_pgtable *data,
 				 arm_lpae_iopte *ptep,
 				 int lvl);
 
+struct iova_to_phys_data {
+	arm_lpae_iopte pte;
+	int lvl;
+};
+
+static int visit_iova_to_phys(struct io_pgtable_walk_data *walk_data, int lvl,
+			      arm_lpae_iopte *ptep, size_t size)
+{
+	struct iova_to_phys_data *data = walk_data->data;
+	data->pte = *ptep;
+	data->lvl = lvl;
+	return 0;
+}
+
+static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
+					 unsigned long iova)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	struct iova_to_phys_data d;
+	struct io_pgtable_walk_data walk_data = {
+		.data = &d,
+		.visit = visit_iova_to_phys,
+		.addr = iova,
+		.end = iova + 1,
+	};
+	int ret;
+
+	ret = __arm_lpae_iopte_walk(data, &walk_data, data->pgd, data->start_level);
+	if (ret)
+		return 0;
+
+	iova &= (ARM_LPAE_BLOCK_SIZE(d.lvl, data) - 1);
+	return iopte_to_paddr(d.pte, data) | iova;
+}
+
 static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
 			    struct io_pgtable_walk_data *walk_data,
 			    arm_lpae_iopte *ptep, int lvl)
@@ -776,8 +775,10 @@ static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
 		return 0;
 	}
 
-	if (WARN_ON(!iopte_table(pte, lvl)))
+	if (!iopte_table(pte, lvl)) {
+		WARN_ON(!selftest_running);
 		return -EINVAL;
+	}
 
 	ptep = iopte_deref(pte, data);
 	return __arm_lpae_iopte_walk(data, walk_data, ptep, lvl + 1);
-- 
2.46.0

