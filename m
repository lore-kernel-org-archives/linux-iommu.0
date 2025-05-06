Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFC4284693
	for <iommu@lists.linux.dev>; Tue,  6 May 2025 16:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746548070; cv=none; b=Ewj7aISZaR7V109XzCpUxq7YgM6sEQun9vJBd90VBJHQ99EuNpjbA3cvmmIInCxZAQ35sxCel019RB9j5DND7G40g1p6XubNiNfmdB3V4S8u99eXpV2sNIP41H1FLXlPeBriTZQoAHsa9QXVH3MDFjSB2inBSf9Aj1In+s7X/qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746548070; c=relaxed/simple;
	bh=J4ezkoYK7Ut1+f0JAhXkaWnZsQhoaIxP9gRoRYlE2NY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=uNAHiQQ5xqb5gq62jSeGz7sEphZ5/QEgPMwkAiJIeh5tMaWzJAO5a++BHOXMfNSE8bvC8Pyav7Fewn1X+4g6oRu6qvXYybsRbpJipuXMA8sehcggxBU4+HjpXWPlqH1EcHqcQeIY4eUupnGOo9875PY5krCM5YZYPbWCGqMYBm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QAY9W9XL; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QAY9W9XL"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250506161421euoutp0260691524ea61e78ca82a8a0a3e0d320b~8-DVMT1AC1279612796euoutp02F
	for <iommu@lists.linux.dev>; Tue,  6 May 2025 16:14:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250506161421euoutp0260691524ea61e78ca82a8a0a3e0d320b~8-DVMT1AC1279612796euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1746548061;
	bh=38gsLZDZw+0ZNz2g5WlLXi2RATEcYA0mxjT1byT2J3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QAY9W9XL3FlVR/fXhpvgJn4hlo8RvOUYGfj8HZmAttsk482hkmKSqVjV/z2bUhJTS
	 AbjVpzGUmdnIxjj/XnqgWgdnWRGgSZ5lBPhxzZpZm7x0ySMciS5LAHzqYaATRUUhvZ
	 dBwRyZyWO0HTmqyBwfKFTikE9pHii8LgPrp+YPT0=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250506161421eucas1p295fd08ced0f914e5f77d61ff28305681~8-DU_iaB62492624926eucas1p2N;
	Tue,  6 May 2025 16:14:21 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250506161420eusmtip2cc26fd1272a1c3b881edbd680c4dd705~8-DUjjfkt0053200532eusmtip2-;
	Tue,  6 May 2025 16:14:20 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Tomasz Figa
	<tfiga@chromium.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Sergey
	Senozhatsky <senozhatsky@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 1/3] media: videobuf2: use sgtable-based scatterlist
 wrappers
Date: Tue,  6 May 2025 18:13:44 +0200
Message-Id: <20250506161346.1211105-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250506161346.1211105-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250506161421eucas1p295fd08ced0f914e5f77d61ff28305681
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250506161421eucas1p295fd08ced0f914e5f77d61ff28305681
X-EPHeader: CA
X-CMS-RootMailID: 20250506161421eucas1p295fd08ced0f914e5f77d61ff28305681
References: <20250506161346.1211105-1-m.szyprowski@samsung.com>
	<CGME20250506161421eucas1p295fd08ced0f914e5f77d61ff28305681@eucas1p2.samsung.com>

Use common wrappers operating directly on the struct sg_table objects to
fix incorrect use of statterlists sync calls. dma_sync_sg_for_*()
functions have to be called with the number of elements originally passed
to dma_map_sg_*() function, not the one returned in sgt->nents.

Fixes: d4db5eb57cab ("media: videobuf2: add begin/end cpu_access callbacks to dma-sg")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/media/common/videobuf2/videobuf2-dma-sg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
index c6ddf2357c58..b3bf2173c14e 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
@@ -469,7 +469,7 @@ vb2_dma_sg_dmabuf_ops_begin_cpu_access(struct dma_buf *dbuf,
 	struct vb2_dma_sg_buf *buf = dbuf->priv;
 	struct sg_table *sgt = buf->dma_sgt;
 
-	dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->nents, buf->dma_dir);
+	dma_sync_sgtable_for_cpu(buf->dev, sgt, buf->dma_dir);
 	return 0;
 }
 
@@ -480,7 +480,7 @@ vb2_dma_sg_dmabuf_ops_end_cpu_access(struct dma_buf *dbuf,
 	struct vb2_dma_sg_buf *buf = dbuf->priv;
 	struct sg_table *sgt = buf->dma_sgt;
 
-	dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->nents, buf->dma_dir);
+	dma_sync_sgtable_for_device(buf->dev, sgt, buf->dma_dir);
 	return 0;
 }
 
-- 
2.34.1

