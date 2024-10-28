Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094031EE015
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 21:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730151328; cv=none; b=Yavesy1II4ekE+9Aqfatxya78IiMApXRxX70HDhXeR8OZRFyXoxRlnpOVDPsdWqrX7v8YQJd38YD97DKNaZGVUt4DqZmS8yYb6t0nfygGeljpbxqhpyaI9+Rkd12cmZ1dCMylENBys4az6OKyd+XFJl+L8jL3eIR56p1tuf6fpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730151328; c=relaxed/simple;
	bh=+E+z/EOaiAO9EI4kie6YvvmAmAMMQ+x08UASzW5Rucg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQWmc51mm+K+59uEmsCPB9aWlNKpH63kyJfC91R6+PowSfBCU/7uUOBmQdrNTGr8tu37Y4sYOEusZAMXnvGwHZBrseKO1jeqq7tdhe9p6PKYDNCIzry7/25fVO+egDwL9yUH59EDS4nt4VJI3s438YYzTikChHvwK2h2BhLf7ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1z4oPWD; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1z4oPWD"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ea8de14848so2526728a12.2
        for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 14:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730151326; x=1730756126; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HG6V5IEjg5fR7H7zxvH/yThNTAfW1zJep5mmD3Nzp9E=;
        b=L1z4oPWDVMQ5+uWii8Zg18NvpudbBfs5+QAaCBKwnDBhaGbAZrv4sXkFfVIpD5X/FC
         qiiDzNJ5JXg0P5xRZHd0mbH3hxDLnhNELpR2onQlaV5bssKFwOt8OS7cTZsJafxKbx96
         ckmvlf2UnrqSJjUXuQQfExoUjAW9ae4BmXw48sxnM9c1g2RfPvJVx4gghAsenrFZicML
         6EPIJHGlC/qcZZz+gltOk/JZ1tqfFh8jCBaxuE5OV1o+9F/Yz/TxjBNElSuxW+HIu99N
         aG/G/r/o7jkmYiooRCFUCOxVIReZA5t3Fbty6iJiWscSiqAxLlM0UfegqyPukyftnfuV
         YVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730151326; x=1730756126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HG6V5IEjg5fR7H7zxvH/yThNTAfW1zJep5mmD3Nzp9E=;
        b=kbDjkBlI5TqmTMJHRsSODJzP9MGXj8Cpex9PyrnAzZkrzsJMe0/QPOAoq51zl/01M+
         gbvVjtyZXMb5JwmUDMCyIjfqCn4j2DUWna10cwwm0WkI5Nkfor/xAyYk3OGZ+dhbMCBh
         Q2t/T/QKKHdI+i8ahTkgxpmoRGd8usBJbRAX8KP7SkSYjVHVhOjpYz94vjKbrkqeW43e
         YKBWmGiJx3gyjVIfeLTp8D7TU4qDGm/+fU2mGU9juMGqBPKznDieNDRGiO+BNrtap3bu
         s6paATSWego7TMjKoywTbVbjfa54dkILJxbf3apON/QhNUTRWJZOwptxh2bMz667oJu1
         4DbA==
X-Gm-Message-State: AOJu0YyfqWbJl0botir5u0GlJwyOT8fy6LHGUWFANjnhKhIna0ZdMNJb
	0Fb2hdUwuh9LloeGJ1t8cv1GW4llL3MTfbIaA/qgC//rTQSdlazOqgzRvA==
X-Google-Smtp-Source: AGHT+IHYfTByDMFcPygEQ50HF0A5OEX5ytobSAKHJ4GmVG1OnJTN978gymeL5m5xxwFxhYlpGaAN7A==
X-Received: by 2002:a05:6a20:4499:b0:1d9:1a3b:85d4 with SMTP id adf61e73a8af0-1d9a83b5192mr14212818637.6.1730151325996;
        Mon, 28 Oct 2024 14:35:25 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:12e9:d196:a1e9:ab67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057931a06sm6216898b3a.55.2024.10.28.14.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 14:35:25 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Rob Clark <robdclark@chromium.org>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 2/4] iommu/io-pgtable-arm: Re-use the pgtable walk for iova_to_phys
Date: Mon, 28 Oct 2024 14:31:38 -0700
Message-ID: <20241028213146.238941-3-robdclark@gmail.com>
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

Re-use the generic pgtable walk path.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/io-pgtable-arm.c | 74 +++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 7e9c0f8ae138..88b128c77893 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -712,42 +712,6 @@ static size_t arm_lpae_unmap_pages(struct io_pgtable_ops *ops, unsigned long iov
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
 	struct io_pgtable		*iop;
 	void				*data;
@@ -763,6 +727,41 @@ static int __arm_lpae_iopte_walk(struct arm_lpae_io_pgtable *data,
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
@@ -780,8 +779,9 @@ static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
 		return 0;
 	}
 
-	if (WARN_ON(!iopte_table(pte, lvl)))
+	if (!iopte_table(pte, lvl)) {
 		return -EINVAL;
+	}
 
 	ptep = iopte_deref(pte, data);
 	return __arm_lpae_iopte_walk(data, walk_data, ptep, lvl + 1);
-- 
2.47.0

