Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5FD2C159F
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750072722; cv=none; b=s175vfbLbJvuOM01zZkf2vVqF1dxKbmXR0m7DD94nX9Xz/mQF3YkSbsVg0wkIU5sw2uOF7wUUbZkwI9n7enfC7oprdlsrkAczR4ybNWAfuREmeZ1TzFmDLNdQvSqg9O0q+M8CQlMfI9Hov7hzsFIAnvORhURwlZm9b+50pSan98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750072722; c=relaxed/simple;
	bh=hrasx9LpaBhIfwmbsVUucBku/W+eFelK4E1GYnytmA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aRXiSDQc57hsIkNq1ujY1z1bMbttRkKlo+Bj7XmxnqHvXkgDawTQB4fbxy/Rk4OUmzYvnUMavwR83jD7q7MbFkw1RXQT9A4vgeA9BgcXqpDynx4BZf+FvcV2mE17EpR1T6/4hnooC2NY9OOWGGyNYRYbcCLf3Jl9H9A2OJ1eI+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iUwoHhao; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iUwoHhao"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450cfb790f7so34974565e9.0
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 04:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750072718; x=1750677518; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFRRbT8s9vGTGk+mkini82Ing/hSasgp2YN4IKINJ8I=;
        b=iUwoHhaoX3vfP+L9DqQTh896JKx/j2IgDVQxS2aEpBJDs2el3p9P63TEGSgJxVnhN5
         b4T4DOYex2xovuEDhxDCJXtg9SNlwcSc0kUhH1suXRVhqhKxxZkoeiVuYeKGzxfoGaUS
         gDn4t9jYPGStUVvEB3iMyW3+xVI3tnXAdRxZrXRB3Sf2V5DCByL+4QyGCrm1CCeNrp2D
         M/R5qMvLASF9AewDfHT/2d3bBVMVePO3zZMkvD6AekSdIeT0YgaMOWTJTQ1DFbAYDhz4
         Lq42S/UNwGb8eSykPjgeghV3lRskk83wxzIudrpGe5QpoQmz0/AsXFO4ZZB5K6gYAttN
         bpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750072718; x=1750677518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFRRbT8s9vGTGk+mkini82Ing/hSasgp2YN4IKINJ8I=;
        b=l9BUuDMkjCNC3j2AZhkKdHOcKEkKROulBhdQHQu/pKPSliNo+pOJLQeUpXx1qB4vQK
         wtUXJaTtIeeDK/+lvLZ2AYdx9WsH6f+07G5YUkNnhkZxF8xNYEwRUkkveZevpqkRhEp/
         /M/FeM6QAfPPQSsdL5k4tsXIKj6hn2doG/3dgXfBIjpPNmt+Jqr5xtTOpQP2bdp16FC5
         PgVm4oWBFSGjUbUSwK1exL1y2PIBZJrQtHURGn9/oS4SduVdXlb/5Vp7eierB3aIMTXF
         Tgg9ZV5+n4FW9zGp1+CgXbV7yxEFwP2sqr+apvzDDHBIYuhj3f7l0T+UHGe35HbLWZ2n
         zWvg==
X-Forwarded-Encrypted: i=1; AJvYcCXSyBOar9GLhOzg4FPHPgkITqNmBsWOm2K2Qcarkr6t4BEVC0P6+9us+Wcz55W7Gv11JQoCKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlYbQB54y2L1oMSa0Fz/MRpz/Hvs565attnDhWKdIs2PP1VZZ9
	EF+ViT7w0Dk01njCPBq3gnHobnVGLKH3xOS9OoKlu8ufJ+R3AbiEf6d+cGXXreOEONs=
X-Gm-Gg: ASbGncvN4niYvVD09UDCT/LW7/nn/56ZpJVoHNtVPu+jO8lseEnP2iOkiKM32uZxvT+
	TXTCREdx8PlRzoaNd9RYGBpJVTGIYDvWxcXXpabtJ9P3SQ+p27/RlInlnsFqYasFmcb98PO4H2n
	J2ykaIU1PU42AqJ/ppwDWxKrDGG0WCjNYw6uAohsKJBT56hN8WLj4mhdH4rdnJF2NAqLs+DhmvZ
	Jb4G8BPs6vJ5DmQXgQnQq0T65RK3j3ZeMoDv2mZWb3kV3R7600PHSlnMTmVLROf8Bw9C7UmvEp3
	Y6q6uXk5u98tJRwSTT8Xsn4CcSQ9uVcV1awx7pX94ppnUjSYAyxadcyxR/9e0IpEApaLyiNHwIJ
	KUg==
X-Google-Smtp-Source: AGHT+IF204pDh3GMb9mprc3RWx877M/hSlys4cJP5Klv0u7H3rkiPLZ3mCZ6j16z/jbKHnJ8e4e+kw==
X-Received: by 2002:a05:600c:3e18:b0:450:cfa7:5ea1 with SMTP id 5b1f17b1804b1-4533caa629amr84883665e9.16.1750072717932;
        Mon, 16 Jun 2025 04:18:37 -0700 (PDT)
Received: from localhost.localdomain ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a54a36sm10931250f8f.15.2025.06.16.04.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 04:18:37 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: hch@lst.de
Cc: olteanv@gmail.com,
	broonie@kernel.org,
	oe-kbuild-all@lists.linux.dev,
	arnd@arndb.de,
	larisa.grigore@nxp.com,
	Frank.li@nxp.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	James Clark <james.clark@linaro.org>,
	kernel test robot <lkp@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Subject: [PATCH] dma-mapping: Stub out dma_{alloc,free,map}_pages() API
Date: Mon, 16 Jun 2025 12:17:49 +0100
Message-Id: <20250616111749.316413-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202506160036.t9VDxF6p-lkp@intel.com>
References: <202506160036.t9VDxF6p-lkp@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The implementations are in mapping.c which requires HAS_DMA so stub them
out if not present. This is required for some drivers to pass randconfig
builds.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506160036.t9VDxF6p-lkp@intel.com/
Signed-off-by: James Clark <james.clark@linaro.org>
---
 include/linux/dma-mapping.h | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 55c03e5fe8cb..766f28a0e11f 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -161,6 +161,12 @@ void *dma_vmap_noncontiguous(struct device *dev, size_t size,
 void dma_vunmap_noncontiguous(struct device *dev, void *vaddr);
 int dma_mmap_noncontiguous(struct device *dev, struct vm_area_struct *vma,
 		size_t size, struct sg_table *sgt);
+struct page *dma_alloc_pages(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp);
+void dma_free_pages(struct device *dev, size_t size, struct page *page,
+		dma_addr_t dma_handle, enum dma_data_direction dir);
+int dma_mmap_pages(struct device *dev, struct vm_area_struct *vma,
+		size_t size, struct page *page);
 #else /* CONFIG_HAS_DMA */
 static inline dma_addr_t dma_map_page_attrs(struct device *dev,
 		struct page *page, size_t offset, size_t size,
@@ -291,6 +297,21 @@ static inline int dma_mmap_noncontiguous(struct device *dev,
 {
 	return -EINVAL;
 }
+static inline struct page *dma_alloc_pages(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
+{
+	return NULL;
+}
+static inline void dma_free_pages(struct device *dev, size_t size,
+		struct page *page, dma_addr_t dma_handle,
+		enum dma_data_direction dir)
+{
+}
+static inline int dma_mmap_pages(struct device *dev, struct vm_area_struct *vma,
+				 size_t size, struct page *page)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_HAS_DMA */
 
 #ifdef CONFIG_IOMMU_DMA
@@ -438,13 +459,6 @@ static inline bool dma_need_unmap(struct device *dev)
 }
 #endif /* !CONFIG_HAS_DMA || !CONFIG_DMA_NEED_SYNC */
 
-struct page *dma_alloc_pages(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp);
-void dma_free_pages(struct device *dev, size_t size, struct page *page,
-		dma_addr_t dma_handle, enum dma_data_direction dir);
-int dma_mmap_pages(struct device *dev, struct vm_area_struct *vma,
-		size_t size, struct page *page);
-
 static inline void *dma_alloc_noncoherent(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
 {
-- 
2.34.1

