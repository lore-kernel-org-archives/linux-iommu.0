Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029D11D04B5;
	Thu, 22 Aug 2024 18:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351872; cv=none; b=M/uQFTMbJDA9BKVkZNPWzQTyoRmmvIKZ2BwKDD/jB6+24NxkvAqYXCxim/xcie5VIjMsL5rrmhHwq66lf0F5xZz9TX6+W3YYRFOVd61yy/CAnOJ6PE2UOxMA54MNbBi1+xnV5qKdeW34K40pHk8H5Y7f+4u16O2Z20GueBXBgNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351872; c=relaxed/simple;
	bh=NVFmBvAgubMJWBFshBt0g9Yy9k4ztAxKDlDYqd+NV3E=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=swbBBXNgowhJw57rfv7GgxE+IbDx8Nu330tgsTirg0wIc3nLfRYe11j9JIQcRxozF0xK8PsrlM4435htbmxjp+af91L9xd1+b7ne8P9UT1VU2JaB4tq6BdpA0lQNNU116h0RlesaGQq9wKDI/Lp9kHKp0ifKVirttJkJ1aYVgFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1/J1T83; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1/J1T83"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20231aa8908so10878955ad.0;
        Thu, 22 Aug 2024 11:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724351869; x=1724956669; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYiVVcr8/wboBmezLWjDsQm81ttJxTuVeu5qAg4kVjI=;
        b=J1/J1T83NRI6UEdegrudYxMVVdXhIUoWo7o7g3ptSRHQs0ImBNnQxw0EEmfdAL8XyZ
         KawtOvFTYMqV1dmXXwQmxn8c9o+Zyxr2fYDL3i88QLfWSKgpPurQz3QSi0GtjVbhLV/a
         SRThxN2eW7KS4oRaAO9Na5wI3AAd3bN3aXXjbBVwU4x4Vx3kqJiq+MxIg1QkqwHEOL+p
         blU564d2j+B9W4bZdK0BEke2MmJ8zFlMcpg+zHqn8QYget/yjMKAZYZ0ShUvbwDQ2SIo
         KHcwM78+n6dysEMT96sRXPS5EWwh9JYWddpDGjBJxMtNEVvy7TNPV0jhEiJDUoCefRt/
         GT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351869; x=1724956669;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AYiVVcr8/wboBmezLWjDsQm81ttJxTuVeu5qAg4kVjI=;
        b=QhJ8qvcHgfzQJVqYjBwGsBPfq1ZzlVAOR57ViAGpI3n2C24TbWLY7X5vaVYbo+w6aP
         fYW33O24/OamDOzDoeMBe1Fz7nCIhYzYRkDdiNy9f/ByPhQNDNu4eP4sMQaJBZ+cPPow
         RdsDofGCZras+V83CkK50iXO4N3gHJqCPMM/r37KYuozR0/SDjqiY8K94QhWCxkqgEoC
         tf3EjYdc01b0lbjunnq/q74XEIw3gs2vcG/2LzF9Ca1XXb8oGoGcq+RQdrzDWiads6wF
         hCDVufTuqih9tn/4DHVEFDSaNpGlADwu65NBvzSML1g7aMW7RYUwbqyBSLjxpQkOLOU/
         ypKw==
X-Forwarded-Encrypted: i=1; AJvYcCUzJHabGVQaoveHuzi2RN1e4utx8heIsDdKm1Hn8veALj6Pt470L2FnGKLpMkjTQu5sKaKOaQ==@lists.linux.dev, AJvYcCVRVyO45loumTmpWVGG2TLNcn4ZXI7MEA3lmpQzPl9ETFd3vLk2lZ+W6Ym1tp8z2tk7IbG+rnRmwhPGkg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMA70TyN6EuXrQpLkeXnuawotiRmTsuPChAFbXNytzblwbjYAi
	oZwe1ugVHsBE0IsdnMG/DmwBZqt+y3wmZLMQMZD1SyLhbu6N382l
X-Google-Smtp-Source: AGHT+IH8+45q6oXd8x8II3Jds1dxAoYSz31lmfPW/kQ0FnzP0cCsfuNQ8sVNo0lwZUKJpv9rCx8MxQ==
X-Received: by 2002:a17:903:228d:b0:1fc:f65:cd8a with SMTP id d9443c01a7336-20367d1394dmr75819225ad.18.1724351869298;
        Thu, 22 Aug 2024 11:37:49 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e4f9sm15667145ad.65.2024.08.22.11.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:37:49 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	robin.murphy@arm.com,
	hch@lst.de,
	m.szyprowski@samsung.com,
	petr@tesarici.cz,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: [RFC 3/7] dma: Add function for drivers to know if allowing blocking is useful
Date: Thu, 22 Aug 2024 11:37:14 -0700
Message-Id: <20240822183718.1234-4-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240822183718.1234-1-mhklinux@outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

With the addition of swiotlb throttling functionality, storage
device drivers may want to know whether using the DMA_ATTR_MAY_BLOCK
attribute is useful. In a CoCo VM or environment where swiotlb=force
is used, the MAY_BLOCK attribute enables swiotlb throttling. But if
throttling is not enable or useful, storage device drivers probably
do not want to set BLK_MQ_F_BLOCKING at the blk-mq request queue level.

Add function dma_recommend_may_block() that indicates whether
the underlying implementation of the DMA map calls would benefit
from allowing blocking. If the kernel was built with
CONFIG_SWIOTLB_THROTTLE, and swiotlb=force is set (on the kernel
command line or due to being a CoCo VM), this function returns
true. Otherwise it returns false.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 include/linux/dma-mapping.h |  5 +++++
 kernel/dma/direct.c         |  6 ++++++
 kernel/dma/direct.h         |  1 +
 kernel/dma/mapping.c        | 10 ++++++++++
 4 files changed, 22 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 7b78294813be..ec2edf068218 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -145,6 +145,7 @@ int dma_set_mask(struct device *dev, u64 mask);
 int dma_set_coherent_mask(struct device *dev, u64 mask);
 u64 dma_get_required_mask(struct device *dev);
 bool dma_addressing_limited(struct device *dev);
+bool dma_recommend_may_block(struct device *dev);
 size_t dma_max_mapping_size(struct device *dev);
 size_t dma_opt_mapping_size(struct device *dev);
 unsigned long dma_get_merge_boundary(struct device *dev);
@@ -252,6 +253,10 @@ static inline bool dma_addressing_limited(struct device *dev)
 {
 	return false;
 }
+static inline bool dma_recommend_may_block(struct device *dev)
+{
+	return false;
+}
 static inline size_t dma_max_mapping_size(struct device *dev)
 {
 	return 0;
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 80e03c0838d4..34d14e4ace64 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -649,6 +649,12 @@ bool dma_direct_all_ram_mapped(struct device *dev)
 				      check_ram_in_range_map);
 }
 
+bool dma_direct_recommend_may_block(struct device *dev)
+{
+	return IS_ENABLED(CONFIG_SWIOTLB_THROTTLE) &&
+			is_swiotlb_force_bounce(dev);
+}
+
 size_t dma_direct_max_mapping_size(struct device *dev)
 {
 	/* If SWIOTLB is active, use its maximum mapping size */
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index d2c0b7e632fc..63516a540276 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -21,6 +21,7 @@ bool dma_direct_need_sync(struct device *dev, dma_addr_t dma_addr);
 int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		enum dma_data_direction dir, unsigned long attrs);
 bool dma_direct_all_ram_mapped(struct device *dev);
+bool dma_direct_recommend_may_block(struct device *dev);
 size_t dma_direct_max_mapping_size(struct device *dev);
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index b1c18058d55f..832982bafd5a 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -858,6 +858,16 @@ bool dma_addressing_limited(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dma_addressing_limited);
 
+bool dma_recommend_may_block(struct device *dev)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (dma_map_direct(dev, ops))
+		return dma_direct_recommend_may_block(dev);
+	return false;
+}
+EXPORT_SYMBOL_GPL(dma_recommend_may_block);
+
 size_t dma_max_mapping_size(struct device *dev)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
-- 
2.25.1

