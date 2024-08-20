Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123C21C578F
	for <iommu@lists.linux.dev>; Tue, 20 Aug 2024 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174238; cv=none; b=UP+K2mv7xl/S6yUhohrD7yr9dsZbKkrtURIKKK2l7h8P9BTr+t9oDiZGwq7AS/XWXOk8rLUvasc+X9kHgzkz4aTZxPbyfWAGckwo4MDctJYIgKET2STLJtvxTOcbzOsKeBX0UkQmBZsZ/6moNf4/VK5Nn6ksb6+Wp8VhSJ0bWbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174238; c=relaxed/simple;
	bh=+gseIl1zsUZZaTdCls9oXHT0YEdPWdsZsVsrwqAiYiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pK5Xt6wCYvtHZPvuCqAktNMb+iY0A8chZqrruISQ2yo3HCXuQQ8SUO7+HQ6R2ap3HxATaU4p5jTUvRopsGPTUdT0Nq0Levr7D15Fh/zWWqh+4xEWOwVqg5dMyILsJ7Dp+ms6Ves6Bv0UryLPUfASDK1mWM/YVbwfVO2Rw3NHN0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WesuThAt; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WesuThAt"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-201ee6b084bso48356575ad.2
        for <iommu@lists.linux.dev>; Tue, 20 Aug 2024 10:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724174236; x=1724779036; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fyhtVpDgygfT5fUkGsgqPbatgiu5TzPiPLAt109+iE=;
        b=WesuThAtIeCCnrBZR7WxAkIbZo9t/CqmfaIh6PV9ZX/1EJFZAbo6IoORAglj4tykvI
         QGQD0TIEt8jfSquTCLbNaMvwDDbdOiWMSfGm1uJBvBDVAxrwdzqw2l8Vha11oHNCog+U
         sQHCdka2unlZWBfo6M5/RaX+c/fWqcFlmJpHqLQ5ayB5tta8ValXAlw9hOU+IuMKGx92
         J8T/arIPKtRWELyH8qLi41449/tGvRZ2VuZMXag0XSzSsN38qP3MB0a9RPpKWc/CF8DM
         Qs+uKUW7lJgWgx6ncLK5e521/1o0zy4WSgvzwVTphCb5AiLzaANN0oTtmuT646nxnAth
         Cb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724174236; x=1724779036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fyhtVpDgygfT5fUkGsgqPbatgiu5TzPiPLAt109+iE=;
        b=w9ORIDLEZU6+/yjGVVRcRHr8KPzWYoK9niKyPtCKGsAioqpC7IWmoMn5+MMV/goAYk
         K+nWZKtrz4Ysf2CwOsM6w+THIMV1+8cM+c0qt4odenCXqOBzp2WtPRaRmUPfE365M1wK
         Mxm673urrover+XPItXYnCmaDSEPb7CX/Ix/VmcrWnTodeTGtSLW6EAnDC+XqgoXVYm+
         lGKPdOgqXQut4q5PqvnxWRQp8cN5Fx3LPnNArxqxYojUSCJIPusduM/Wz4vspNeTtNzb
         IWbpSwzzjpUjKB/H5gtYzBg4BO8h2CShP9t0qXn/L5oLZ3PYujgnOkJk1H3cnIGIO53p
         MCUA==
X-Gm-Message-State: AOJu0YxB82NMLmAwKcAjfILalgf90Z2xFzAEpXT+M9RfKMmLwXpshvs7
	EazzwMNpjG5GWIkMU+4x1KkpseedLmkl75fF1RYCsroaqsaenuqbLjCcyg==
X-Google-Smtp-Source: AGHT+IG89nPNiTxJdoeWAd4I9+Nt1kCBeEpf+Ehrfj9fghEkvWbqdwi+s8kDEywa2ecTlYbOssqipA==
X-Received: by 2002:a17:902:e549:b0:202:671:e5bd with SMTP id d9443c01a7336-2020671f9b0mr167387315ad.42.1724174235653;
        Tue, 20 Aug 2024 10:17:15 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:bd02:d0ce:e791:dc08:a375])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f038b303sm80401575ad.192.2024.08.20.10.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 10:17:15 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Mostafa Saleh <smostafa@google.com>,
	Will Deacon <will@kernel.org>,
	Rob Clark <robdclark@chromium.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 3/4] iommu/io-pgtable-arm: Add way to debug pgtable walk
Date: Tue, 20 Aug 2024 10:16:46 -0700
Message-ID: <20240820171652.145673-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240820171652.145673-1-robdclark@gmail.com>
References: <20240820171652.145673-1-robdclark@gmail.com>
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
index 5fa1274a665a..a666ee03de47 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -759,6 +759,30 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 	return iopte_to_paddr(d.pte, data) | iova;
 }
 
+static int visit_pgtable_walk(struct io_pgtable_walk_data *walk_data, int lvl,
+			      arm_lpae_iopte pte, size_t size)
+{
+	struct arm_lpae_io_pgtable_walk_data *data = walk_data->data;
+	data->ptes[data->level++] = pte;
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
@@ -928,6 +952,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 		.unmap_pages	= arm_lpae_unmap_pages,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
 		.read_and_clear_dirty = arm_lpae_read_and_clear_dirty,
+		.pgtable_walk	= arm_lpae_pgtable_walk,
 	};
 
 	return data;
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index f9a81761bfce..76eabd890e6a 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -174,12 +174,26 @@ struct io_pgtable_cfg {
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
@@ -193,6 +207,7 @@ struct io_pgtable_ops {
 			      struct iommu_iotlb_gather *gather);
 	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
 				    unsigned long iova);
+	int (*pgtable_walk)(struct io_pgtable_ops *ops, unsigned long iova, void *wd);
 	int (*read_and_clear_dirty)(struct io_pgtable_ops *ops,
 				    unsigned long iova, size_t size,
 				    unsigned long flags,
-- 
2.46.0

