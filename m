Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEF91BAED6
	for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849522; cv=none; b=e5/zR0zq1np1BEd1QphIZ0Egv9mBXQgulqno0gcHs8T4RQMZSp7gmSQaO4eJOqwQTEkJVu2t2/9bIas/hm12dwbzP9T33gymO96usJC/2FoQaipOGbn6JdvOvqnL0dDD7IZyoXZvOe7rbK1kEdvTIt2q4wbNOuqGinM+OwELOks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849522; c=relaxed/simple;
	bh=/euwcJ37lmgggUB2kgCU779rDOTrO1t4pPXCh1a2HCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KEvDQp3U117DtxxhdwygJi854ZvJbafe+3B0Q4eIgkyv9lOn7d9M938CPYOZloW90ja6/PK6AqyIDHbecb1o3HpXv9HkAfOHVyr35fSBPFjMcvOD/eR2dg1xfobWnL+NTfbyl2PzDh4suz60+7lc8b4pWiyivjoN6iErylS3NGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICaiSuIl; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICaiSuIl"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-726b939f0c0so2215866b3a.3
        for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 08:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733849520; x=1734454320; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlC6t8gjI6tvzSf5j3uS4n/ZcFOyWrhFgx3uHy4obYw=;
        b=ICaiSuIl03qCJLoU24f4HMlC7r6jQzKr9Vfr3cZnlP3NkiZjwX3sWS8SuEOkEH9Th2
         EZrhzZaHU/UGn0DPsHbhT8ecc1BPJU2YWiojyV21Jw2QDUYqSNTayjzMuB+qNfnJ9kY3
         lQYHVwGh+5TAn4EHO5IIHfRSmKQ9ilnJV77hMkgsYUOIGVLVZidWjsumPME3u2vUhvme
         FGxKEJBeYsMjwWmizcRGzhgMbq7K+Ii4Jiwq48RGf9vHkDYIJLf4iyV7Jhaj33XRxXUU
         E6Y5IoWlNdOFdAFTVMeeTySa8YkC1v+r8Ca5MkbEAeAu952bOH9iwaWIs3QvCJri0ZoP
         0EqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733849520; x=1734454320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KlC6t8gjI6tvzSf5j3uS4n/ZcFOyWrhFgx3uHy4obYw=;
        b=QKGD6WcFNnfSjGPeF29pPu/06SirmjNrxL7KVGRBhERmkBLHVSWPZ7LiuLIdXGdFj0
         NiV3OmliHhDevJSFXobWNEOhR/jPXeEp9JhHBGjILdYgkJ3AE80O/LH7r4Nc/OI177YJ
         G0lCvjjkY6h9kJZ3chXI73hdAfy3zeD6fPj01vWDmELLyY7JMdcVd1qQBOPHda2Y9EE8
         qXj6D4g4vY0HB/3KLS44T4RQllTC3OvgYc/BOfOFAc8EB/9enbzQFUqlw+z/tOdqLi5z
         JjnyO65qTqMcuBWlCw3zuaBlcEJvUPK1LJ0FtSMtdz4TUdBrth/UccgzxzL7URdBSEN9
         5X1Q==
X-Gm-Message-State: AOJu0YwS8g9QA3noPMS4YnzrE05uwTArlqTmezyMsIaJJVtbUA/XHXcu
	NoYrHFVPHVwVmIudXMGpDct0hX+wb22eABZW/ptOa6WDPG76ijZUsIWFJQ==
X-Gm-Gg: ASbGncsIYEQGr1MUB7KySsqJ3lfWQ5ie/Z4cxjydvH+r88nwm+UuNeo8kLyELDY4fxD
	CJw6l4VqD2NSpamsLg6dZMoRm6KwyPJHFMRTYPkRtnUlm76IVmK/MKQQUBToKPwc/txrVkW9d/2
	Yo8kpOB269T3cgVCW22eMIMQ2j0DmicKaTcyfABMOG1sf9t2k9po/jE5fR/mmquah4ohE8H4pYC
	P84XKxgDMa3NupWHIHgAMX2pIdQYClaKTYCXmsPFOyHCTA7R2IE++0YuvH0pPUjvXzBSAMgsywS
	xo83j66iQMifh9IFiM8JOn8PZMW86x4=
X-Google-Smtp-Source: AGHT+IH1n6c0fXB/5rusM6KflQSKemThS3VyuHQY8wT9jvY3JVEpZqXFRbfZPqjeknRfEZ0z87Krzw==
X-Received: by 2002:a05:6a00:c89:b0:725:f376:f4ff with SMTP id d2e1a72fcca58-7273cb14556mr7832493b3a.13.1733849520359;
        Tue, 10 Dec 2024 08:52:00 -0800 (PST)
Received: from localhost ([2a00:79e1:2e00:1301:12e9:d196:a1e9:ab67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7261829be9dsm3195343b3a.89.2024.12.10.08.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:51:59 -0800 (PST)
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
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v11 3/4] iommu/io-pgtable-arm: Add way to debug pgtable walk
Date: Tue, 10 Dec 2024 08:51:21 -0800
Message-ID: <20241210165127.600817-4-robdclark@gmail.com>
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

Add an io-pgtable method to walk the pgtable returning the raw PTEs that
would be traversed for a given iova access.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/io-pgtable-arm.c | 26 ++++++++++++++++++++++++++
 include/linux/io-pgtable.h     | 15 +++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 88b128c77893..c51c48851f9f 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -762,6 +762,31 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 	return iopte_to_paddr(d.pte, data) | iova;
 }
 
+static int visit_pgtable_walk(struct io_pgtable_walk_data *walk_data, int lvl,
+			      arm_lpae_iopte *ptep, size_t size)
+{
+	struct arm_lpae_io_pgtable_walk_data *data = walk_data->data;
+	data->ptes[lvl] = *ptep;
+	data->level = lvl + 1;
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
@@ -937,6 +962,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 		.unmap_pages	= arm_lpae_unmap_pages,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
 		.read_and_clear_dirty = arm_lpae_read_and_clear_dirty,
+		.pgtable_walk	= arm_lpae_pgtable_walk,
 	};
 
 	return data;
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index b1ecfc3cd5bc..d7bfbf351975 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -178,12 +178,26 @@ struct io_pgtable_cfg {
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
@@ -197,6 +211,7 @@ struct io_pgtable_ops {
 			      struct iommu_iotlb_gather *gather);
 	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
 				    unsigned long iova);
+	int (*pgtable_walk)(struct io_pgtable_ops *ops, unsigned long iova, void *wd);
 	int (*read_and_clear_dirty)(struct io_pgtable_ops *ops,
 				    unsigned long iova, size_t size,
 				    unsigned long flags,
-- 
2.47.1

