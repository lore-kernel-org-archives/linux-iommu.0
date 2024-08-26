Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43755198E80
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692559; cv=none; b=qeN8MvrWZK0eUQm4mTte5Stg19Sbh2prAFKs2puMgIKczL93xfPaIIQUXgrvG0HCqHaFj5mU6v5vHBV7OgTH6KwmnH73dM3A9jLt+G5MUlogLhvfPNNnIHPThNDdXQbtZ5cASZfz4VtP4Ugbfe9/U3mhFWDhSOzLF/P9WzJnO2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692559; c=relaxed/simple;
	bh=IHBkbRTSRs1I3VQNuuBQURPtkVM0/9Lbyd7rf++i6iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRp+LZtMAXDLdhAbDkEukE14T7oB3ENm/m1p/b+ADZ/4y0/ioj9IGUYYsdiCoV7cjZN82BhCn9Rdkvx5EeK+2rDL/473NL+K608qX4pE8VkHzHPsEI9cXnu96xzCXP14yDnkbuZKCph7daowaUXM7dxCE345kExA0IlN2X51fbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6zHJxfz; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6zHJxfz"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-714262f1bb4so3273355b3a.3
        for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 10:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724692557; x=1725297357; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKDm3s2TCTU5rY2IssAZFvBpqQYJOpn3EVObKPXkHYI=;
        b=W6zHJxfzZvfcqiw5CTE9/IbFEr3nBaPZe4w7BmAJhnrzNQJOruo0TbtVxYpSLMe3rp
         oyABjXiHWPb0+Xi025aNqMTsMszbu2oBwKO71oEX6BbAkYkWTLrminhwAm19JG9Y5PZK
         cMYh7EpxaE+dtGM2bcbpLbPidV49PVYDhVzpnGUSFraYOeHV/nu2RkjrTkoqtS9BPvN4
         TN5HLBRWrBGFSUcFK7u52Bwz5HnFvZQQ7OhmSkhrWLloEaFPrYHSX9+IvvOYHRCa9eEe
         X/+46XWsuhr8L7GFjBsQbBMWOOL6a2go67sHV0LCesqLNhr8joTgrPUROO5LYWt4sZYp
         c+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724692557; x=1725297357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKDm3s2TCTU5rY2IssAZFvBpqQYJOpn3EVObKPXkHYI=;
        b=au8n06pZ8zqJ79Hlb+6p1iyr3asmXy/zKN0gk5XN0WuaGWMzqoeJ63wS+bEnpdPhm8
         dm1/AY77HTKb0IA0l7U7ME9Flb8mGwlGdLQMWtThWxgdrngc5QU07LSlDF4zsoIhJ6ab
         +TLsR7XOhenl0+YPItUw3HWAuTTIgQHafN13FmstZj7kj5X+ZjaC68Ihu0RIfxrzzp9j
         CbZn9ddBVI4RcFX3ORZQDLvMKbk3Px4jXkGqN6ehsR8qzYez1cAT/HTHXcXIoV9l74rL
         yFcWDlhUsEfZ7s8WS8U6TRPu+OblLnmtWlgzelViMo5Q3XznX4006KO+7awTd/A+U4fC
         GDcA==
X-Gm-Message-State: AOJu0YzYgAQ6Jt5N+9yKroVlxEaO/M+qpjResxy454aWGdICyp7RaDKG
	peWAM6iFrtE5F5OsL2jxBv5Zjr5mS6f3l21FvEo/DegPNpuaEOmRi08enQ==
X-Google-Smtp-Source: AGHT+IFyw/mmqh3djt5tp2R0vCWdcanP5Sz+JyI69oHSQ3iIBkiy8Pb71WSJwf746F34gE42GQodbw==
X-Received: by 2002:a05:6a21:3a46:b0:1c6:b0cc:c50f with SMTP id adf61e73a8af0-1cc8b49ba5dmr10427140637.25.1724692556800;
        Mon, 26 Aug 2024 10:15:56 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:12e9:d196:a1e9:ab67])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac98152sm6824309a12.3.2024.08.26.10.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 10:15:56 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@chromium.org>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 1/4] iommu/io-pgtable-arm: Make pgtable walker more generic
Date: Mon, 26 Aug 2024 10:15:38 -0700
Message-ID: <20240826171546.6777-2-robdclark@gmail.com>
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

We can re-use this basic pgtable walk logic in a few places.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/io-pgtable-arm.c | 59 +++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index f5d9fd1f45bf..0132f1eff688 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -747,33 +747,31 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 }
 
 struct io_pgtable_walk_data {
-	struct iommu_dirty_bitmap	*dirty;
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
 
 	if (iopte_leaf(pte, lvl, iop->fmt)) {
 		size_t size = ARM_LPAE_BLOCK_SIZE(lvl, data);
-
-		if (iopte_writeable_dirty(pte)) {
-			iommu_dirty_bitmap_record(walk_data->dirty,
-						  walk_data->addr, size);
-			if (!(walk_data->flags & IOMMU_DIRTY_NO_CLEAR))
-				iopte_set_writeable_clean(ptep);
-		}
+		int ret = walk_data->visit(walk_data, lvl, ptep, size);
+		if (ret)
+			return ret;
 		walk_data->addr += size;
 		return 0;
 	}
@@ -782,13 +780,13 @@ static int io_pgtable_visit_dirty(struct arm_lpae_io_pgtable *data,
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
@@ -803,7 +801,7 @@ static int __arm_lpae_iopte_walk_dirty(struct arm_lpae_io_pgtable *data,
 
 	for (idx = ARM_LPAE_LVL_IDX(walk_data->addr, lvl, data);
 	     (idx < max_entries) && (walk_data->addr < walk_data->end); ++idx) {
-		ret = io_pgtable_visit_dirty(data, walk_data, ptep + idx, lvl);
+		ret = io_pgtable_visit(data, walk_data, ptep + idx, lvl);
 		if (ret)
 			return ret;
 	}
@@ -811,6 +809,20 @@ static int __arm_lpae_iopte_walk_dirty(struct arm_lpae_io_pgtable *data,
 	return 0;
 }
 
+static int visit_dirty(struct io_pgtable_walk_data *walk_data, int lvl,
+		       arm_lpae_iopte *ptep, size_t size)
+{
+	struct iommu_dirty_bitmap *dirty = walk_data->data;
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
@@ -819,7 +831,8 @@ static int arm_lpae_read_and_clear_dirty(struct io_pgtable_ops *ops,
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
 	struct io_pgtable_walk_data walk_data = {
-		.dirty = dirty,
+		.data = dirty,
+		.visit = visit_dirty,
 		.flags = flags,
 		.addr = iova,
 		.end = iova + size,
@@ -834,7 +847,7 @@ static int arm_lpae_read_and_clear_dirty(struct io_pgtable_ops *ops,
 	if (data->iop.fmt != ARM_64_LPAE_S1)
 		return -EINVAL;
 
-	return __arm_lpae_iopte_walk_dirty(data, &walk_data, ptep, lvl);
+	return __arm_lpae_iopte_walk(data, &walk_data, ptep, lvl);
 }
 
 static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
-- 
2.46.0

