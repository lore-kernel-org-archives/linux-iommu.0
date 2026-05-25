Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A90318ED7
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 22:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779746808; cv=none; b=kK6ZEfcrjVn2WSYUjXmOfrBRinpSXEu+9qrjwYvJhCM2X8yb84rQfHb1qTfC3iBj9Am327r+Ln4FaK8JQF39qp+rCW9+0j4cWHm8m8ZIxy7X/CFQV5UO7zmZPHs3l5EcdtE4DKOePZMVZJPJ2j6le5/qpLG033ylFWLlmfsDGPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779746808; c=relaxed/simple;
	bh=YtQ/yTW46aJTgBS2RYdCC7Mi93eGRCfeb8vPr+OmWWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FIoJ0rUa4BWt4G21+ta+HBAxqoEBWpE4l06A5Oaqw3B8GXhI/h95k0Tj3iYFSHmJeyxtl8LoDPE60bWfJzp3cX3p7h/Jdl7GYiQy4PRPyL/j5HYrbgSPvTVvGWh4P5FMKswlQZ0Kd2+qeVUh/FumDaF96DljCH0xiGU2ZUeNjK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezpUABzy; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezpUABzy"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-368f25ff4c4so5463960a91.2
        for <iommu@lists.linux.dev>; Mon, 25 May 2026 15:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779746807; x=1780351607; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cb+vYhTU8Eum/FCo/941Nl+1j7gWIUnZrBBYNxLzj3g=;
        b=ezpUABzyZo6RD2DGDrX5d7tpnfz+A8V2AzGtPNkQDL2V+NdNlgjK0jXNH8DA56hIW3
         i1PJNm5fLgamA0k9G/QZONex3jBryIjnE911gXu42qg0b0QbOPIq0Le7tYZmEmyux7D9
         GJi2/w9thzS2ZtCcS2I1ZajqWlsI/riX+MrVGrakTS/b2Zp0O8puo26r9B0nUrLmbY+K
         4MSCj8FzAY5D81OXi02iKduzOTNVGSJ4WrbG+z8N63bGTrZngiJwFbFZs4PaBYNxUpnv
         qTCvYl+R1TfSetzBWoITn6tTmClv8f6DpWXuA/U0luqgSBIoEUpkfoRhWQamxzl2sSS9
         sMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779746807; x=1780351607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cb+vYhTU8Eum/FCo/941Nl+1j7gWIUnZrBBYNxLzj3g=;
        b=jIwYjV3xzwEKgO14mtzQgL3vOlwXwGxoCuAa42zHRtxUC1sorKI/n6sqd9b/14EFkB
         z7emgxv7QODXaD0W/JIkZ3Q7TxnLZPsCcegG+XP2fe44KvQ41RqsfpuRR3WvArZLU/H+
         WCq+/rvvTnZFu6rBAGQUY8FO2Y777qCtV4S+uDOjQ+aJlEqRPzxJOWgBZDuDTw1GxCqf
         d9fhGOv0ioIzCf8YoAPRLLGZFyuzASPWKxN0eVHeUBpgSNh1wwqO4pM8zntc2Idyd5pK
         HZO/V5y59RcfahPnwHx6/qtLcml1c6/uRNXb860DngUjLZYFgrRLWwR7DKtI0kr4G2QN
         2vTA==
X-Gm-Message-State: AOJu0YwkoJpZAzjf55Vpr71E52V5qDDspesZEqG4twuN9Zpf7GQVAF0t
	MK7wuVlpoYyuDhow849F2zNWubSGXbQLKUmvCGwIqjIbs3ws3VT/glrGQr7LnA==
X-Gm-Gg: Acq92OEDF9FJ6CcD60GY7xIUZTP7rvpGlvFNs2par+lBHyqKnJvF8TXBKqysxYN0PDw
	I/PkWq6KVG5U3sHjVJfiu++BVuTXpEdcc6bQtLd3AXUnSkaZ82sBrjE/ogX4qXFUSAjkDjGEePQ
	iuFwWrqXgoJ98VXWIfW47LEIQXw9mdW2gqxbcKBmGPDbDGDPGRKqSo+JYTk85fkMlszXnP8rdzQ
	Un6LIjG9vcY37fwH1OT2c+02bUdT6VTfnZdKaslGaYbGj1jgwyBXMStby8yIzBMmGwc3BAi7DvW
	bTr+oaNqQPjAsDG59+El2hRzOqPrFPSi0d5t6m8BiUoL8D91MCFqxC0nc9v+mu1yYOf/5111gxj
	TWGywkHp0FpznqNcZzPieATVF9hiXtkshiT8ITMu1oQS2meMZFKF5wDIjv+o4MvughgRF/Pp6zA
	7N9N/GdQ01N5n0TyM94+7uFDdE1Xy5j+hWlxr9pYa59beH4G1ktNplwXIfVQOAzdFLsAdRe4Ofq
	5DB5vEtK3Adjw3y+TRQVV2Rqv9iqPecQXs=
X-Received: by 2002:a17:90b:5343:b0:368:a27f:9083 with SMTP id 98e67ed59e1d1-36a67761c51mr13108866a91.7.1779746806663;
        Mon, 25 May 2026 15:06:46 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36adc0a6e94sm4713224a91.4.2026.05.25.15.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 15:06:46 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: iommu@lists.linux.dev
Cc: Barry Song <baohua@kernel.org>,
	linusw@kernel.org,
	Qinxin Xia <xiaqinxin@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH] dma: map_benchmark: turn dma_sg_map_param buf into a flexible array
Date: Mon, 25 May 2026 15:06:28 -0700
Message-ID: <20260525220628.94833-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The buf pointer was kmalloc_array()'d immediately after the parent
struct allocation, with the count (granule, validated to 1..1024 by
the ioctl) trivially available beforehand.  Move buf to the struct
tail as a flexible array member and fold the two allocations into a
single kzalloc_flex(), dropping the kfree(params->buf) in both the
prepare error path and unprepare.

Add __counted_by for extra runtime analysis.

Assisted-by: Claude:Opus-4.7
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 kernel/dma/map_benchmark.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 29eeb5fdf199..a65da5c7710c 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -121,35 +121,35 @@ static struct map_benchmark_ops dma_single_map_benchmark_ops = {
 struct dma_sg_map_param {
 	struct sg_table sgt;
 	struct device *dev;
-	void **buf;
 	u32 npages;
 	u32 dma_dir;
+	void *buf[] __counted_by(npages);
 };
 
 static void *dma_sg_map_benchmark_prepare(struct map_benchmark_data *map)
 {
+	struct dma_sg_map_param *params;
 	struct scatterlist *sg;
+	u32 npages;
 	int i;
 
-	struct dma_sg_map_param *params = kzalloc(sizeof(*params), GFP_KERNEL);
-
-	if (!params)
-		return NULL;
 	/*
 	 * Set the number of scatterlist entries based on the granule.
 	 * In SG mode, 'granule' represents the number of scatterlist entries.
 	 * Each scatterlist entry corresponds to a single page.
 	 */
-	params->npages = map->bparam.granule;
+	npages = map->bparam.granule;
+
+	params = kzalloc_flex(*params, buf, npages);
+	if (!params)
+		return NULL;
+
+	params->npages = npages;
 	params->dma_dir = map->bparam.dma_dir;
 	params->dev = map->dev;
-	params->buf = kmalloc_array(params->npages, sizeof(*params->buf),
-				    GFP_KERNEL);
-	if (!params->buf)
-		goto out;
 
-	if (sg_alloc_table(&params->sgt, params->npages, GFP_KERNEL))
-		goto free_buf;
+	if (sg_alloc_table(&params->sgt, npages, GFP_KERNEL))
+		goto free_params;
 
 	for_each_sgtable_sg(&params->sgt, sg, i) {
 		params->buf[i] = (void *)__get_free_page(GFP_KERNEL);
@@ -166,9 +166,7 @@ static void *dma_sg_map_benchmark_prepare(struct map_benchmark_data *map)
 		free_page((unsigned long)params->buf[i]);
 
 	sg_free_table(&params->sgt);
-free_buf:
-	kfree(params->buf);
-out:
+free_params:
 	kfree(params);
 	return NULL;
 }
@@ -183,7 +181,6 @@ static void dma_sg_map_benchmark_unprepare(void *mparam)
 
 	sg_free_table(&params->sgt);
 
-	kfree(params->buf);
 	kfree(params);
 }
 
-- 
2.54.0

