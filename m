Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4661D45EB
	for <iommu@lists.linux.dev>; Tue, 27 Aug 2024 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782653; cv=none; b=RSach+wvhG+ZDptfMx+OVrhp9adyJEtfTKske9QY9nJeXCX/8wemHse3bzjDSdcj4mods98DVi67FB4/yVhGU2GiO8Q5A24/04SDatpZDBMTrlwT+bntcm9sP3GQPTOTkZghMj2517e7sZzDARR7sXeRmPcwG5/UWYANRYMa7Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782653; c=relaxed/simple;
	bh=I90NUqSplO+OUpgx4frtAQS27LaYivRbF8zKE+14v70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7SXfQS0t7W3xaIKo752kSUsARb6p1xnI+GIR6RRNeJACIOGo7p51Vqg60AjmGck7tF/bEmYf2BrVReqSP9vm4vkSpQralvLHD9SPqf6jiM6a9KRVUoPq41Qu5Jk0o99NpCPme4yHA2SvdG6zl65ygcVB3juAnonBtvGEW4GReQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOgvyw2b; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOgvyw2b"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fec34f94abso59726515ad.2
        for <iommu@lists.linux.dev>; Tue, 27 Aug 2024 11:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724782651; x=1725387451; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLUmHTIZzlGw27lOXBe2/x1CsKIYYG9Yp6GcbVarkT4=;
        b=AOgvyw2b+vZINtoo7gHkX4CVD/OH93VcL9iaeFzDG/X6xnW6xc5r4FGNB2SuQHHTap
         IklFK0st0mTq1Q0UMxDWtx8L00RlEo620brw8T8PlCIFtnOzqdXIOxb84DJfB0fLVTXB
         5DWcL+A2faamtPn5S3zV8kwUbPsKPu4NMzHqHRlz8ibAyH6efc6UBamX/9cRuUiPTGky
         yegnyfoyXfA8b2n+nvJ5dQ2CCFRIEFiXnUJKCSGTcPvESPVQEnEaagweEt259TzSODcN
         P2YZU1axWX575/DN/awIYoK8WwkPW2WjTxO4Rw4MS8VcDFq9X0if+Sf09IDCQGAbC3is
         na2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724782651; x=1725387451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLUmHTIZzlGw27lOXBe2/x1CsKIYYG9Yp6GcbVarkT4=;
        b=Mr6EOnDyNnCEueuYObYaGZmBVbRLq38CPY4ognDcnimmoepAy9kgDPzxQNyg/3FkzD
         r3gQxq1uMaH+oLs9qk0sEUwshIVWmx1j+9Zw83HrK7Z6x5OWcu4fdonzxfPMjVbCU/S5
         bMX+nmt4tNDWdmxeOnpecohbr/SbSyth3HHvh9Jn/yT8O5W58fqyBypyi0l/gx4UK1oG
         QfdwliSqqqV1ggiwgG8mcMGN8691RwfSUNNWWiGu5u51mkRcZYpKpeCs/EwudyOiaAQ5
         gRzhlhC7fk3PhNmL7EOrPfA1VEmB7Px0orUSpOD8zcJvrokLs8+9Q+R4VbV5TP6fndtF
         lcZg==
X-Gm-Message-State: AOJu0YzlTKOxJu38m6A3ps5gN3wSg7p/qH1ZGgh1nn+nTH3zvElwo3pV
	zx69PpSPVtDyoDaYqxi9ALYgTYD+EDoDgz4U6IAPKwLHgVC7TR5a+901VA==
X-Google-Smtp-Source: AGHT+IHYyoolcYxZtR5c29wHJT7jmBszW3F5rBHLKaZnAGuTG+FmizoxCTxOLMcJ10P4+O/V0/dwMA==
X-Received: by 2002:a17:902:ce0c:b0:203:a0c3:b342 with SMTP id d9443c01a7336-203a0c3b4a4mr132648915ad.9.1724782650615;
        Tue, 27 Aug 2024 11:17:30 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:12e9:d196:a1e9:ab67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385704048sm85663225ad.215.2024.08.27.11.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:17:29 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@chromium.org>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joao Martins <joao.m.martins@oracle.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Steven Price <steven.price@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 3/4] iommu/io-pgtable-arm: Add way to debug pgtable walk
Date: Tue, 27 Aug 2024 11:17:11 -0700
Message-ID: <20240827181717.187245-4-robdclark@gmail.com>
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

Add an io-pgtable method to walk the pgtable returning the raw PTEs that
would be traversed for a given iova access.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/io-pgtable-arm.c | 25 +++++++++++++++++++++++++
 include/linux/io-pgtable.h     | 15 +++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index efed8e519111..11af49119f37 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -759,6 +759,30 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
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
@@ -930,6 +954,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
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

