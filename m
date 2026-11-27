Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795780744;
	b=fMULo5lY5q/iMUfWY2koH88IRcknzVcy3OLoqC5VI9xaYWwyik8fezbhxKa4U0/W7cXx
	 qAMzn77z4oqsJCN8MM7TmkpbhqwKPVDkkYdq81yvhQF3u6ceE8i/OGbQ1ON6BGx//AAzF
	 NHMJk7MEdvqzBovm+Iwf4t0peXo3Cqf4lEW9zecYoMliZT7tGADD0H/JtjGs81LjmlXCu
	 YJyknXjLp58Gd0zCV274iTuLa4V4iEFkAo+cD443w6o8tecq4QaLNpJVSJST4HCZO8g3e
	 YUrQsboFIXgRqK/vgC0unffUe2yfKx0PoNAFOB6u+K3MCNJlslHw0hY0jc1jCS9fI8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780744;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=Id3upqDD1i+LHsGcQdVswyP8vuaFBxcYGp5N04HwHyM=;
	b=M7TXd5kK0GBbJTsprruj8+kpbx4kvVasW7ryn+rSTO24HwhOjWMHkh9Yp/2GGx91cILO
	 +wOcWTYz/02qn90R4pZtw9TqJWMbrty6RzA9n8XPTiqNNaTGkmHltN5lBv6S8YZvdvyBX
	 ZoRNfC1g8qHLkZPI4lQRJ5hhRs9pqcPyCmR/yeneJhAC8msuMX0fSLMl4w/F/4Pdkh6Z8
	 RflpT2KWhT/YKuhB0d5qveus8E7ZRog3cyfpIc92oXiACeTAv4ysqltojOVCnEVpfL1qe
	 bVh0q24f1uHRyJvti5FsDJRvvs0NUDhdBW/MvxU5d2UNfk5xUhLxdk9XprZhv13tgtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=eTDDdgdJ;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1F2606A69A
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B1F2606A69A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=eTDDdgdJ
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261127115902euoutp02c12ac17f8bdcd8b1b25a31512e3b178f~r5RIsAz2T1646316463euoutp02a
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:59:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261127115902euoutp02c12ac17f8bdcd8b1b25a31512e3b178f~r5RIsAz2T1646316463euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795780742;
	bh=Id3upqDD1i+LHsGcQdVswyP8vuaFBxcYGp5N04HwHyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eTDDdgdJ9gPOOx7Xw2sMngNEd0oxJe1W9gj3acfWV4ZIIPZawecBhxm2tmZAPe5D4
	 Mr6d8NPXukg82mYDgdIh30MdUfPD8obx07k9USmhKVWCJuASlFHqGczPi3hRN6shuX
	 8wlZ3ncNeGtX/HG/xrhNoXuMLoemC0l92kG8WBFk=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261127115901eucas1p22ee3dbe744707c23f8ac2442f755e041~r5RH9qnN12876328763eucas1p2J;
	Fri, 27 Nov 2026 11:59:01 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261127115900eusmtip1b004ba38c6e7a6b1daeab6d50a5c4eca~r5RG3wJIQ0138901389eusmtip1M;
	Fri, 27 Nov 2026 11:59:00 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux.dev, linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe
	<jgg@nvidia.com>, Sibi Sankar <sibi.sankar@oss.qualcomm.com>, Honglei Huang
	<honghuan@amd.com>, prakash.gupta@oss.qualcomm.com, Alex Williamson
	<alex@shazbot.org>, Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, Abhinav Kumar
	<abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>, Mauro Carvalho
	Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil+cisco@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 3/4] dma-mapping: add DMA_IOVA_FLAGS mask for the
 dma_iova_state size flags
Date: Fri, 27 Nov 2026 12:58:47 +0100
Message-ID: <20261127115849.2780625-4-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127115849.2780625-1-m.szyprowski@samsung.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261127115901eucas1p22ee3dbe744707c23f8ac2442f755e041
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261127115901eucas1p22ee3dbe744707c23f8ac2442f755e041
X-EPHeader: CA
X-CMS-RootMailID: 20261127115901eucas1p22ee3dbe744707c23f8ac2442f755e041
References: <20261127115849.2780625-1-m.szyprowski@samsung.com>
	<CGME20261127115901eucas1p22ee3dbe744707c23f8ac2442f755e041@eucas1p2.samsung.com>

dma_iova_state::__size uses its top bit to record that SWIOTLB was used
for one of the linked ranges. Users that mask or validate sizes refer to
DMA_IOVA_USE_SWIOTLB directly, so adding another flag would require
updating all of them.

Add DMA_IOVA_FLAGS covering all flags kept in __size and use it in
dma_iova_size(), in the size check of dma_iova_try_alloc() and in the
vfio-pci dma-buf length validation. No functional change.

Cc: stable@vger.kernel.org # v7.3+
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/dma-iommu.c          | 8 ++++----
 drivers/vfio/pci/vfio_pci_dmabuf.c | 2 +-
 include/linux/dma-mapping.h        | 8 +++++++-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 78742aeba932..99eb382a1359 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1838,11 +1838,11 @@ bool dma_iova_try_alloc(struct device *dev, struct dma_iova_state *state,
 		return false;
 
 	/*
-	 * DMA_IOVA_USE_SWIOTLB is flag which is set by dma-iommu
-	 * internals, make sure that caller didn't set it and/or
-	 * didn't use this interface to map SIZE_MAX.
+	 * DMA_IOVA_FLAGS are set by dma-iommu internals, make sure that
+	 * caller didn't set them and/or didn't use this interface to map
+	 * SIZE_MAX.
 	 */
-	if (WARN_ON_ONCE((u64)size & DMA_IOVA_USE_SWIOTLB))
+	if (WARN_ON_ONCE((u64)size & DMA_IOVA_FLAGS))
 		return false;
 
 	addr = iommu_dma_alloc_iova(domain,
diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index c16f460c01d6..8bda610dd988 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -211,7 +211,7 @@ static int validate_dmabuf_input(struct vfio_device_feature_dma_buf *dma_buf,
 	 * dma_iova_try_alloc() will WARN on if userspace proposes a size that
 	 * is too big, eg with lots of ranges.
 	 */
-	if ((u64)(length) & DMA_IOVA_USE_SWIOTLB)
+	if ((u64)(length) & DMA_IOVA_FLAGS)
 		return -EINVAL;
 
 	*lengthp = length;
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index efde0e5a58dc..0ebf3090ea0f 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -135,10 +135,16 @@ struct dma_iova_state {
  */
 #define DMA_IOVA_USE_SWIOTLB		(1ULL << 63)
 
+/*
+ * All flags stored in the upper bits of dma_iova_state::__size. Sizes passed
+ * to dma_iova_try_alloc() must not overlap with them.
+ */
+#define DMA_IOVA_FLAGS			DMA_IOVA_USE_SWIOTLB
+
 static inline size_t dma_iova_size(struct dma_iova_state *state)
 {
 	/* Casting is needed for 32-bits systems */
-	return (size_t)(state->__size & ~DMA_IOVA_USE_SWIOTLB);
+	return (size_t)(state->__size & ~DMA_IOVA_FLAGS);
 }
 
 #ifdef CONFIG_DMA_API_DEBUG
-- 
2.43.0

