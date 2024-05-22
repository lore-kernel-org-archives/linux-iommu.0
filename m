Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77976146A91
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 21:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716414630; cv=none; b=ADZF9YP6+/Li2hS85M+8UsdcnqOY7Cm/1HWA3tN+YmM0ACsF07sp2UFekU4oz4cZ7BsjuhUBUK7hEaAKfwgb4/31VgjCiYrSXEBRIKnBHBSOof+c+ZQsm+eU1Y1r8wFmzskMAwjqy+JllJkx+eFONjDfnKoZHQ7uyj/25ugEzvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716414630; c=relaxed/simple;
	bh=NGDoaOJbYFqrUhHamNYTmJyBFeJ5rGeyA6DGw6BnM+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7vEAUnwY7HjrSvIp1cXcSFWs0EsJ2df0q7wuOSkOU6NrC4pDQYaHkl7lyy0N2NE3mCcmS8FqWa0w9LqVgBaZdZwowZif9mFdWSPsddh01WDNS55K1UVWO6g5E+aKVxAt6N+0fcaBSJH5bNr7tPa/iaxbLxmo2yFqgj4wx+hzLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgrzgZaX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgrzgZaX"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ecc23e6c9dso115569195ad.2
        for <iommu@lists.linux.dev>; Wed, 22 May 2024 14:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716414629; x=1717019429; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2K8+gSIw4h67vM78HufTAFJM7Lhu4djthlJzN7dgn0c=;
        b=WgrzgZaXokthTmLHjiNjbC62URnnmAsLza85EFqcFAtOUyu6HlCVAHL/7iVZ+6au+d
         y34RKUIHbt3skD6D6Ieybdtbs4sXetBy6eWkB5loet6Fay5bIiUDW/ixLNcNdjG5ko4g
         HvYDvyTh+FHSjrg2aAoLRbre/md3yHp5WCJM8WnFvUGWFmtzeAqKX5CSO/PHE0Iqs/ue
         KjHUrMitAYxQaYkJL6EpRzOv6tZJn8i1cegbqeANdXRELw/cM6k8x14edHO8xILKTyBi
         4qk6+LuzHmZ8hUlbyiyJp+NzpL7wt7GUgIY8Gulq6x9v1+kRp1zxJiENbKyFaeK++aVD
         TOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716414629; x=1717019429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2K8+gSIw4h67vM78HufTAFJM7Lhu4djthlJzN7dgn0c=;
        b=ri+WmBx0HVVQ8FgWhYR6QkpewC9dq2CowR/tbNLiDV/FgeaHW3BkM6IU2YNsHKq6Ih
         TgTTgU1xxwoXa7uwd2de0uBi52WNz9GxeokxAEQZXyJRNLlKbMhV5/k+OtrmfmJ0v6Db
         Nu5HrQJ2kMS/HooTlz6oGf20MBiiZ68cUVVvQUzOo8/xvvQvdhInjH9FpLGxpJarEwjM
         Rc5UnPvouMGy63I4SlTmnMf8JSf3VmpCnaLG1EWIPqmyUqwCFeE0nzecr4pjtABmhJRL
         ve9GosDpSrjVIfk5ExmBrEqRMv1kDedi7xDN4K6t6iPKq0Z7RtudbQbKVGaRgK1xg9T2
         0sow==
X-Forwarded-Encrypted: i=1; AJvYcCVev0yktB9wDqDF47mhHLMMczBMubTyhjhLstDvnhYg81/IbStxYDjtCb0TzgTLfXM6xVxW4kqcI+7xveK51v9GIrKLzr8=
X-Gm-Message-State: AOJu0Yyh54UoBB34+XQNrMpcRVXAA6GmoaxIl1Wzo6P0meCt6HvwdpQ3
	2mWAFMlWg8zIWV5HNEfOjRUqDIZJQmz8QMg1v565M5QBjqZx+wo9
X-Google-Smtp-Source: AGHT+IFIIpfLzA2F8YRHGJoHwYIzp1NwLhTR7zRlOfJiiosDMMxFWV3+xMEZwsF1wYLyTw/w3Kgo7A==
X-Received: by 2002:a17:902:f544:b0:1f2:f854:f59 with SMTP id d9443c01a7336-1f31c9652d7mr38668525ad.15.1716414628554;
        Wed, 22 May 2024 14:50:28 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c03619csm243076425ad.209.2024.05.22.14.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 14:50:27 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Rob Clark <robdclark@chromium.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/2] iommu/io-pgtable-arm: Add way to debug pgtable walk
Date: Wed, 22 May 2024 14:50:04 -0700
Message-ID: <20240522215014.26007-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522215014.26007-1-robdclark@gmail.com>
References: <20240522215014.26007-1-robdclark@gmail.com>
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
 drivers/iommu/io-pgtable-arm.c | 50 ++++++++++++++++++++++++++++------
 include/linux/io-pgtable.h     |  4 +++
 2 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index f7828a7aad41..86d2b34d6f95 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -693,17 +693,19 @@ static size_t arm_lpae_unmap_pages(struct io_pgtable_ops *ops, unsigned long iov
 				data->start_level, ptep);
 }
 
-static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
-					 unsigned long iova)
+static int pgtable_walk(struct io_pgtable_ops *ops, unsigned long iova,
+			int (*cb)(void *cb_data, void *pte, int level),
+			void *cb_data)
 {
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	arm_lpae_iopte pte, *ptep = data->pgd;
 	int lvl = data->start_level;
+	int ret;
 
 	do {
 		/* Valid IOPTE pointer? */
 		if (!ptep)
-			return 0;
+			return -EFAULT;
 
 		/* Grab the IOPTE we're interested in */
 		ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
@@ -711,22 +713,52 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 
 		/* Valid entry? */
 		if (!pte)
-			return 0;
+			return -EFAULT;
+
+		ret = cb(cb_data, &pte, lvl);
+		if (ret)
+			return ret;
 
-		/* Leaf entry? */
+		/* Leaf entry?  If so, we've found the translation */
 		if (iopte_leaf(pte, lvl, data->iop.fmt))
-			goto found_translation;
+			return 0;
 
 		/* Take it to the next level */
 		ptep = iopte_deref(pte, data);
 	} while (++lvl < ARM_LPAE_MAX_LEVELS);
 
 	/* Ran out of page tables to walk */
+	return -EFAULT;
+}
+
+struct iova_to_phys_walk_data {
+	arm_lpae_iopte pte;
+	int level;
+};
+
+static int iova_to_phys_walk_cb(void *cb_data, void *pte, int level)
+{
+	struct iova_to_phys_walk_data *d = cb_data;
+
+	d->pte = *(arm_lpae_iopte *)pte;
+	d->level = level;
+
 	return 0;
+}
+
+static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
+					 unsigned long iova)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	struct iova_to_phys_walk_data d;
+	int ret;
+
+	ret = pgtable_walk(ops, iova, iova_to_phys_walk_cb, &d);
+	if (ret)
+		return 0;
 
-found_translation:
-	iova &= (ARM_LPAE_BLOCK_SIZE(lvl, data) - 1);
-	return iopte_to_paddr(pte, data) | iova;
+	iova &= (ARM_LPAE_BLOCK_SIZE(d.level, data) - 1);
+	return iopte_to_paddr(d.pte, data) | iova;
 }
 
 static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 86cf1f7ae389..261b48af068a 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -177,6 +177,7 @@ struct io_pgtable_cfg {
  * @map_pages:    Map a physically contiguous range of pages of the same size.
  * @unmap_pages:  Unmap a range of virtually contiguous pages of the same size.
  * @iova_to_phys: Translate iova to physical address.
+ * @pgtable_walk: (optional) Perform a page table walk for a given iova.
  *
  * These functions map directly onto the iommu_ops member functions with
  * the same names.
@@ -190,6 +191,9 @@ struct io_pgtable_ops {
 			      struct iommu_iotlb_gather *gather);
 	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
 				    unsigned long iova);
+	int (*pgtable_walk)(struct io_pgtable_ops *ops, unsigned long iova,
+			    int (*cb)(void *cb_data, void *pte, int level),
+			    void *cb_data);
 	int (*read_and_clear_dirty)(struct io_pgtable_ops *ops,
 				    unsigned long iova, size_t size,
 				    unsigned long flags,
-- 
2.45.1

