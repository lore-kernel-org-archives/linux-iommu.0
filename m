Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25F71990BD
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692562; cv=none; b=SX8ksJVMP4U1oxwUdLteII9LOsEJSXrBLs2Hu6B/C4sv2aTOG/3LRRL+4sb+5nqjOgZeVxQ4f3KjZF74YJH2HPUSNnad91EG1VzGf2Au6QRx0aF37x25LeD/jg+BBbw7wzxKu9DipSxVTsSmJYG6aJ/yWqyQ64c2Q/8vPcMdP1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692562; c=relaxed/simple;
	bh=XGTqvhBSomuWVnpuTB9nRwhF8NvYdo4ZB99rM+0HxIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCLpB51lM2lb7iznVR9+dUqjmlHYJd9v14RNPsVDzP3meh+lYV4UVPB4luKCNhJmn9feN68Tht5kyu4MQqfuvvGVP2VdcuvHbL4MuCf0Fq8t7i53c49sSgNBfKyJ46mMk6VtMCrcbxsBpySEqcNKKxHcbQS4+Q7IEj0qr7qwMj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJPfrg+w; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJPfrg+w"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-201fae21398so30927165ad.1
        for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 10:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724692560; x=1725297360; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+I4ZaCB/sqpP5JzZUXf+AGUdGSF6g4dYvIuEdY7CXs=;
        b=SJPfrg+ww9lii6c06vkyPEBk/yZ7QUGQls0MDmaEYeuS2BWoy2ODfh1Tq+U4qpfAG2
         fe2RN8kA3oGn9wM6eKUFHIfMLN3w4SOgZ3UjDQbazR566DlQmgAaivoNZBFet1QKjBfM
         WAMOVes05/F3zBi1QRAJW3oVacKlmk7jcraPvukYeDzmUzprSRIDFsdOfCLU9gJ6CNZt
         6l6oF4/9mujw64yYC7zpWoR2qSDrSXRklJ/5sFIqFHikoOZDVosmOgm2MofgDy60IWBw
         gOqDUE+rLSyIPrsB+9v5T0QjEnGHltvU047O3e+y4B1qkjywVGOWC70JLHcH8VKi98gc
         OcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724692560; x=1725297360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+I4ZaCB/sqpP5JzZUXf+AGUdGSF6g4dYvIuEdY7CXs=;
        b=ZS/pSiF8ULypWP/wmNDHMpDzlKFPbuxwdE+AjJZarK416P61SeBwCY8IqfeNNX5LjK
         HSRSc7LxYcT0dt7ZTb9heTa0MMGlW8FlC9r1E/k756aYahCoO3IaTSLEKdXv3tsMyx4k
         e8okwJTgVKyNlJKXvp8eXeZJ7zeTBdHClqwMCJhqaCq9rX93CK8wFFLMfE5uhim2yS8B
         hwfabVRqpXR8Lh3VyhObXZ+IfMRwiRBxwep0kcDuR0GRozYnEvuQtvp9r310LAfuF+e+
         su/QkTRizrwtL02858CLVk3LeUOwiyeBSORCnJzemOzwe6ZAXEMpVuJqzXzChml2VScG
         fSnA==
X-Gm-Message-State: AOJu0YzMEi4qdVV0eEAKoifR5o2RrIOeHnTMit7nNw+foh30fqvhgSbZ
	0eSGhgBJC4F1cJClPd0suo8mBtPZYdPbSSblBxtDmHd9F6NQk6qwEDXuhQ==
X-Google-Smtp-Source: AGHT+IFDqoQr7ndvoqg0WiXE2EFba86vbWS6GZn4EuCOqNm05J6X0ruWnhG+tYye9U/muYuTqrThgA==
X-Received: by 2002:a17:902:daca:b0:1fd:8c25:415d with SMTP id d9443c01a7336-204df48723cmr2286975ad.36.1724692559502;
        Mon, 26 Aug 2024 10:15:59 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:12e9:d196:a1e9:ab67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385ae6ebasm69617045ad.240.2024.08.26.10.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 10:15:58 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@chromium.org>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 2/4] iommu/io-pgtable-arm: Re-use the pgtable walk for iova_to_phys
Date: Mon, 26 Aug 2024 10:15:39 -0700
Message-ID: <20240826171546.6777-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826171546.6777-1-robdclark@gmail.com>
References: <20240826171546.6777-1-robdclark@gmail.com>
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
 drivers/iommu/io-pgtable-arm.c | 73 +++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 37 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 0132f1eff688..f50ebea85dd8 100644
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
@@ -776,7 +775,7 @@ static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
 		return 0;
 	}
 
-	if (WARN_ON(!iopte_table(pte, lvl)))
+	if (WARN_ON(!iopte_table(pte, lvl) && !selftest_running))
 		return -EINVAL;
 
 	ptep = iopte_deref(pte, data);
-- 
2.46.0

