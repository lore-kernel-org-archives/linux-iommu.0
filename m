Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498817F7ED
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 17:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486755; cv=none; b=o1pUxe+tDRoPmigoAgWUzRDaGaRX0P2xsbhD0CBjJ9lPUPi7sT1rFYlMo8nWQldjBCePlkJs9sJWLFQk9mqy1jMgN0tp2ERaa2w10Hzab946nMABk7oWOA2N8jEhOKOh/HCc2+AJgJj/fOGg9Jaogxf5KHvEjNH2pSpAKvx7myU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486755; c=relaxed/simple;
	bh=kISKM7grARDjVqkmmI4mRYiokLw9iJb/8Ywk3w14sJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ar+uF3p2suzVUYLswrz/B4jSy1k9sSkonMH09UF2RWeTM6RT9Bo2jMKqItiUqBOvQ7R025sR6qpciAIVoyzI1u4nCMnMfNXS6eGnLDpVOQZDWEcSAsfllqKZSMSDt2dIk0BGTKtbcls1YTUfe+TZeqhL5HEqScdt+R7eCOpHp/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVeQI1W4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVeQI1W4"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f082d92864so124842955ad.1
        for <iommu@lists.linux.dev>; Thu, 23 May 2024 10:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716486752; x=1717091552; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wABXq7eXvgE4oT9T1Y9/oyMqa6vAj39hBqoQ2M3pSr8=;
        b=aVeQI1W4j8edwmCbOe/h4n+1ie6R0CYC7pE5ZumvLQYF/sX09lsRdp78ScLbi30hcO
         txJ5520SoRTbfuoKF7M/ozyniOEtzPXwYzKYGuHkyYvctMWpVgct20RO0ohVRFaRTInc
         tufiu0tC9P8w1ywXaWqzOWgR2es1Y/9KOtScLqDQtJt7avQPKSYDTSEykysx5Z4u3vQk
         4BvbRtrwWvEiwfG6JB3BmXQuFNYncXHiBcf3wY0UIzCTw1z7un8qGXgViAeyqB9+2fwD
         6LRo9Cj9bvgzwB8LBp7bWA/s5JeuzAseMYZ3yF9wYsjpPhxy4qTyb66ZsrP6uuAXly4Y
         Ta8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486753; x=1717091553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wABXq7eXvgE4oT9T1Y9/oyMqa6vAj39hBqoQ2M3pSr8=;
        b=JF8IXjkwcjFLMr3/lQtU8os2kVKHzZGjsDkLdO/QerNYD0UR7T5dL532oPhHXHAWj2
         5ECSPYgZgB3PGk0JU+pttWmJUKWQE7BBH/lehof6Lrqanv3qy11M+Ep2gJFo2qx8L8WA
         7HN8+CqfUcr7mg6hT4n8OM4VQ53mI5v+ZzUNJvtjOt3xHCrX8NdGo8CKM74rQ/ADdc5w
         HTdkKSgJygt2dq0zf0A/sswSZmOD+AgYgTy2ryZqOBLlbXP1A1IcQp78zwhOwOp185GY
         hISL5uOFsF8G6N0KqAOvcqOullaow8ea767brjnMxGVdfai5HzWNgVKrv0lOWia4uPXV
         2y6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJZMwiUXKuNrPNi16S7OLLc5fVDNIBCa5dwKfgXEDCRbY9dKRbMfccP90zmgYtVS4JHnB2XmyKTIGrnuPu0xSZdOXeaLc=
X-Gm-Message-State: AOJu0Yxov5zKfCMImUS/p708h4poZjhbl2QEUx7dl8pE0nwp7E3DkGIE
	o/bEgeqmzlPqDSJmTqJfk00ZHviW6pxVqy0Nx/ybq/hYMRS4xeAl
X-Google-Smtp-Source: AGHT+IFBPjfPlLDxDBNEdpWCZ7OpFK84HiZnku+Zm5KcsQ3+xnkFTJMGfUhkA5lhqjC+tpNwMNZFoQ==
X-Received: by 2002:a17:902:e889:b0:1f3:4b2a:1ac8 with SMTP id d9443c01a7336-1f4486bd92cmr964985ad.13.1716486752590;
        Thu, 23 May 2024 10:52:32 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f326c0cec2sm31874455ad.174.2024.05.23.10.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:52:31 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Will Deacon <will@kernel.org>,
	Rob Clark <robdclark@chromium.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 1/2] iommu/io-pgtable-arm: Add way to debug pgtable walk
Date: Thu, 23 May 2024 10:52:21 -0700
Message-ID: <20240523175227.117984-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523175227.117984-1-robdclark@gmail.com>
References: <20240523175227.117984-1-robdclark@gmail.com>
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
 drivers/iommu/io-pgtable-arm.c | 51 ++++++++++++++++++++++++++++------
 include/linux/io-pgtable.h     |  4 +++
 2 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index f7828a7aad41..f47a0e64bb35 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -693,17 +693,19 @@ static size_t arm_lpae_unmap_pages(struct io_pgtable_ops *ops, unsigned long iov
 				data->start_level, ptep);
 }
 
-static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
-					 unsigned long iova)
+static int arm_lpae_pgtable_walk(struct io_pgtable_ops *ops, unsigned long iova,
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
+	ret = arm_lpae_pgtable_walk(ops, iova, iova_to_phys_walk_cb, &d);
+	if (ret)
+		return 0;
 
-found_translation:
-	iova &= (ARM_LPAE_BLOCK_SIZE(lvl, data) - 1);
-	return iopte_to_paddr(pte, data) | iova;
+	iova &= (ARM_LPAE_BLOCK_SIZE(d.level, data) - 1);
+	return iopte_to_paddr(d.pte, data) | iova;
 }
 
 static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
@@ -807,6 +839,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 		.map_pages	= arm_lpae_map_pages,
 		.unmap_pages	= arm_lpae_unmap_pages,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
+		.pgtable_walk	= arm_lpae_pgtable_walk,
 	};
 
 	return data;
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

