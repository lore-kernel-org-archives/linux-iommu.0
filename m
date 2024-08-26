Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C0F1991B2
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 17:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692566; cv=none; b=gsqLDy3MECVFrYeEnu6R8l4Lsby5e7kIeNnaWCVffRIKWqxmKZtfgzfDOzOR06jJztBWLcdxdsb+jQSQx+2M61uRft0U8U8SZtyGmtbMV3dbCblbCrezncK1li2ThDiv8l6+TlD0z+y4fUTgk3k82DT6CuGBkkPFkWTCIxtLyhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692566; c=relaxed/simple;
	bh=Dm/PpuWGX/lF0MB+mMAk/NkdNLWRfPXi8uc0os6PuY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7mZVtnR6hFYd4ExhELM8gIsklsdDSyrXjp7XhW27e7ufr6Xy5te1/5/IOOqA+ph5cdycRdlRCtGJDPeWtteXsNxvH30BOEnBukixo16y1eFl3YSUM3KhiLSLxDAnm0Plwun2Ui5q+sGCKFa1fwDCVeIahz76zjpeN+M2Duh7xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2KKx2qf; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2KKx2qf"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39d20c4be31so16633125ab.1
        for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 10:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724692563; x=1725297363; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JP4TZEK1BK3FCdoYwuXOrd9TRG8IyqaAd5V9ttXFyYQ=;
        b=F2KKx2qfGGGVjvWhdQE1+7mYMBPzodXkI45Kf1mCh3LLyCLgo2l/v+PL9Nh1YvFDGw
         HA8sGcqoOmD/CSVQ7zP+jPl1Qk7pTAnk+pp0WFT03pea83pJeMsy/6ZZBE6/LgPdjLVj
         f+ZoWAYU8Iw8PuJVx0DpNZw0koNy2qH8SgpMWmS3ec6tLSTEJqAfw5QLUAmzT56SrJ0Y
         PPjxDwLQZdRvHGp4pX1LsuXS1wZQhz3BSDehnxO99CVnZK7qviQFKzxPkTTo2PSN4woH
         bz2LUTM9jseLE/ORBbSimsTI9nvyRiTTi9a01Stq8f+GiQnma/LiFoqFE4m2vNn+XlCV
         ZGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724692563; x=1725297363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JP4TZEK1BK3FCdoYwuXOrd9TRG8IyqaAd5V9ttXFyYQ=;
        b=Jf9yzRb05i4C9EDFHMUgBSAeNYXetRgeYSF4sC93vt+2ZML2T9Ibt+/pWzuT8Vt5NK
         4Q56pv4eLGjBzuYHLvz3ea+u+s5oij4AH/yOsLpcEm0BbuMuPLMQGWOWWUtdr+yoKKLu
         6zhQx/95QJDfQS87s+bS0BIroLYKR5tPvq3kNFBnNUJ5ZyWfIS3Ur+Oo4+cdgwtKTXbC
         pS7o0tnavlpTymvXMdyDA9Tm1C+MjNYZC86typ2xo5xkO73gudaPWPPZc88rm/M70pwV
         TJ60tm+Y6FOiQNwJmWxmIY1DvMxNCyTBjs9Rnm+bXDtwk/BKfvWhjPzNMSo6LCnTaA+p
         ojcA==
X-Gm-Message-State: AOJu0YwbuUXAjn3BIQPncnTKRR+eeYYSW6UwCDR4d02c76giySxv6Vk2
	dvje6pEdXZLUuMCAKJCNhJ2ExEJQIwIkn1AQAIMs3HOE8e7Ihq6PVhLq4Q==
X-Google-Smtp-Source: AGHT+IFzZhZ24BSgc0zToZ5EuWURN6G2xkvE2v3EkHzS1HwmPoHerM5RzvQaEMtBZgU9U98rh+O6OA==
X-Received: by 2002:a05:6e02:1a8a:b0:39d:290b:6800 with SMTP id e9e14a558f8ab-39e3c9edf77mr129742785ab.28.1724692562965;
        Mon, 26 Aug 2024 10:16:02 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:12e9:d196:a1e9:ab67])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad55283sm7884302a12.74.2024.08.26.10.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 10:16:02 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@chromium.org>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joao Martins <joao.m.martins@oracle.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 3/4] iommu/io-pgtable-arm: Add way to debug pgtable walk
Date: Mon, 26 Aug 2024 10:15:40 -0700
Message-ID: <20240826171546.6777-4-robdclark@gmail.com>
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

Add an io-pgtable method to walk the pgtable returning the raw PTEs that
would be traversed for a given iova access.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/io-pgtable-arm.c | 25 +++++++++++++++++++++++++
 include/linux/io-pgtable.h     | 15 +++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index f50ebea85dd8..2f57a50afe2c 100644
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

