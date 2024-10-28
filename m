Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDCF1E25F7
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 21:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730151327; cv=none; b=EdQ+DaDP13KTqgfC1eq9XXq1AuGDt4mrc/G0PkfU8JWcF5C12/ZYolbEWXcIdkPDS0n1rEuADN+YMvfqKzhgaE9iLaAfDuCj7NPTtzBcEWEPCdqRgobw2l762yz4DPnjEzmU9ylNSLEBVQHcGzm9y76YVHLyAGAtEGuSPODK97U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730151327; c=relaxed/simple;
	bh=7uXbqAU2Rs+FdAUI0yMJyvdaxWyQLWN4ppo3xQU6jME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTtvoa+PB1SfPJyJyctWlKCKlSeEUV50mJn/Psx8M8dYs/MUsN0Ikl0sbGae2wzSHPiY/UjK4JCZQYLbP9Et74ioLLt9Mkeq1HyCN+q8Mpgkv75yvfkvIIEof1xikmrlEF1fKLt99vl8pKfDiIihokrTujAdugjimDSxN0ES8pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XslILdLn; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XslILdLn"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2b9480617so3805964a91.1
        for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 14:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730151324; x=1730756124; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m061Pyg3UwMZEnlvYwP1sOYnaFDaV5Le181aUe2JWFs=;
        b=XslILdLnQ/vL2YZ0IHniYrzcyaDEPI+uKqt9M0CJpRBrNnHjLhw2aLoq01IyQrATOE
         okFBywYWeZi/3zWMyAOnZEM0C21qjpfPWfKoBkvAVNOupb+RrA0Ym1yOBKcp2U3Bh3n5
         hX5bRdxJg+TH26ebR77Osp1PAYF31KP606h1cDhMwmrInNfTrLwNq6BPsJ5rbwNWr6Wo
         rnOLw+ELhrYOfIb6D8wFYUwFrhGJ44ZsQQm9oYAATjbaIfFDlR8SOvxaVMxga5TZr3mP
         HpFgKwAduzGNLh2C12ygKyYSgp/F6bxX6AaD1eUqq+gvfqdGBA9y1OC/pHcm2gPCzazl
         ovmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730151324; x=1730756124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m061Pyg3UwMZEnlvYwP1sOYnaFDaV5Le181aUe2JWFs=;
        b=Z9/ZQAfbfazGeuukF1lKOjMumKEqx6KlJIc+ubrPXsycRlu/mcgk5OmhEaZGKnDwUW
         +eyCvQHUVQd6TYrM+s5IzwkZj7WwFlF8T5mEWsGdWUPenJjINjBY4kPPo1BDabN8NZdk
         88b1oI5xMmM5276enNYm1vGOe4ZGffjIDaC009ykz3TezvcIDc5ae6z5gS3EpvE9dZIg
         0el/wQN55pYcm/9W5tw/+POsaFGjqmjqnKR1nUbwM//n8fHgVGVQMBwOoPtKP2TawO14
         5haLdqp6uIF2gNj6lzHBLr9OhUt2gEoJxbi9oX0ABJIpYdjbGd1Rgimw76Wb+rdde9IH
         gODQ==
X-Gm-Message-State: AOJu0Yz68TDI/kvn1ngBL/BdZfdzDMLPqPW48Slfwzyml11Jc9QJ1bHb
	t2/vINRgjfGA1aatp7j3WfXZkbCpwfgzS9NTSYrZZJKrWTHTuTOSlUKzSA==
X-Google-Smtp-Source: AGHT+IFMkNPD4yFz3qyWlzboYMBT0a0xBeKCCszOPUsi1vknNqZcTwRtbyVqgGg1MSNysN4Mc2hgGA==
X-Received: by 2002:a17:90a:c90b:b0:2e2:e092:5323 with SMTP id 98e67ed59e1d1-2e8f11a9716mr11015208a91.29.1730151323871;
        Mon, 28 Oct 2024 14:35:23 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:12e9:d196:a1e9:ab67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e4c2a9dsm9890110a91.15.2024.10.28.14.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 14:35:23 -0700 (PDT)
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
Subject: [PATCH v10 1/4] iommu/io-pgtable-arm: Make pgtable walker more generic
Date: Mon, 28 Oct 2024 14:31:37 -0700
Message-ID: <20241028213146.238941-2-robdclark@gmail.com>
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

We can re-use this basic pgtable walk logic in a few places.

Signed-off-by: Rob Clark <robdclark@chromium.org>
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
2.47.0

