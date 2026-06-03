Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C353E1718
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 03:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456699; cv=none; b=VxC+KgvwbD4u4LPZeZgjMrigGBa+VuOz8CUMLIyMs8/YBkAgc6NhBvPD7ai7SbN7yJj+cx+eLQ7/LJwRFopc3Hf5AxzooLn7oMxuqJmj1+MpdTzX9SBDOqtJe85dbFA1zHktlmknW/3fZ3m6cSor8rjtx7e+t425zuBBLUhsW8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456699; c=relaxed/simple;
	bh=BrLl55rtH6dYClV7fN4/ASsckeGkMGxQmJmComhF1Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oQLBpyknum8B5sHINjvWY+RU4La43HlzCv/SjY4Ff0sJlnElKRAhctd/hiDGRxrFVOM/GMz6yyJPTUTL6bMMrzlI7HG2uaDRY0WUFgPU9/YDqEl9+18sumsmUS9tZemiQiq3Qs8i/JmfATGGDJD75M/jZN/NSZu/dna6wpfLjY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pK0fVmP/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pK0fVmP/"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bf0ddaf50fso35597855ad.1
        for <iommu@lists.linux.dev>; Tue, 02 Jun 2026 20:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780456697; x=1781061497; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1w/uqKkKsuzaL77QabRVI67EugYIJNkq2g/yoq3O5NI=;
        b=pK0fVmP/X5D5T4C6lRivw3A0wPOD9ga4OhdHC7ipq5Uk0nlSmtHCekdoKRRFdGH3V1
         VnoNSPMvKbqgrhPkxg71BQJji7IPVtyBJcHKGoe2dNbTvSJUJPLAqhEK3J7hXMOYFbiL
         pO56OYo8DhAsk4cFzsuByqK2tT+h+yaXn+y4vd6AqH/HI2B73VmqtGxYDmfenp0k7jxc
         26QfTdOWVARsKhmn5RrbxEyudBkef5eCheRBXtMUEAi77u+5CjZrT7pUw6a9th7UWLsh
         ghALfbfD0CdTF5rntYMrKCOCuXqKnwj4XtHxII54GoqP+4YTjpnUShSQ+b8s7UoSRKOR
         gHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780456697; x=1781061497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1w/uqKkKsuzaL77QabRVI67EugYIJNkq2g/yoq3O5NI=;
        b=Z6OyNyTi8H/NF1B7BoN5YckI0NWNeDdiFxeXNHOx0fzfmgl/EPuxDz+TDLKp1Wl9sy
         +1BgvPMtZF4zo43b8UEsW4Zi2HnUsh9Kn9Qgc+1c8YyQvLVLNFIrToCfdLBg7abwddfb
         N6VQ5+6WD8oGsatXaKn0RXQ8UO+mfxPfyKRPuyVlGeyMYzpLFnhoWeWWiB2PYsiOViQX
         Nyjvs+q4rrcZ6BXXKfBKhZKYKiMIjSLN5DFMOPmCYzldy2gyQVSteVi1D8rVjUb43K4g
         4A2yK/0nIqsb4L/SXBQMnsrSNyDRQZr9tGRbukA8Qxk35ezY2IFYs3A3uSL/Jnz97Y8+
         igFA==
X-Gm-Message-State: AOJu0YxR+va9OqkAvo/r2e8Z5154EwpWV623/2LbJhusStoSiICDGTCk
	/H3MzrnKHOFvjL5wdBPGDlHUh3JgBwJIqw0wQjzJrPLKfNIg1xwiAHiXA45OxfTC
X-Gm-Gg: Acq92OH9ghFLIcWZrDy1XfkRyzOLqNQv6lFErzVKhRh0tZlooybOiJkJEPCSJI+2H6V
	1NPKAurAPFzJhlSk9n1he/fYAHc1/jfGVHuuWVSwdTf+00uUMVHL5V0OiIaqfk7r5U+6lx77u91
	5Xg2rL/Woa73OXm1ljlVgB81YyJRTODYwF3qXqmM9wuoxMKG/Ri7aMCFOGQ4cLh0lqV+B+C5G/k
	ohMx/M/8QtZani39uPWAeu5pDsMukry4DTxbNZfHBVS8QadD2cTLAbZCoZ43u/64IFORslW/tFD
	HpnNpgMoDoAEncngdYgLqxfeHagFlCoJMQe/LGauEkPrWI6Q+DmWqt4eoVa//E7bnV8ekXPmTPx
	ipEJXMKEeyqH2ZCFXmKHU+S9ApDjmYHbyRsVVY4n5iTNGXAdkgZ7HxqVeOhGVx7oS799tWHWfv1
	bExSKyG1MTKZkVRkldVnWAVtTbJRAAqYP8bpFB4tkYFIWb2SccgpzMXDf8XFulTo68yU77XhXZb
	EGsOZKmi2i6LRkCJtbN5CbLqQem0gEkTz9Zwd0bhEPZgA==
X-Received: by 2002:a17:903:234e:b0:2c0:c3ac:4af3 with SMTP id d9443c01a7336-2c163a203admr14348355ad.15.1780456697015;
        Tue, 02 Jun 2026 20:18:17 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f94a7fsm7457345ad.28.2026.06.02.20.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:18:16 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: iommu@lists.linux.dev
Cc: Barry Song <baohua@kernel.org>,
	Qinxin Xia <xiaqinxin@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv2] dma: map_benchmark: turn dma_sg_map_param buf into a flexible array
Date: Tue,  2 Jun 2026 20:17:58 -0700
Message-ID: <20260603031758.290538-1-rosenp@gmail.com>
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
Reviewed-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 v2: use params->npages in sg_alloc_table
 kernel/dma/map_benchmark.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 29eeb5fdf199..fdc070f419f6 100644
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
 
 	if (sg_alloc_table(&params->sgt, params->npages, GFP_KERNEL))
-		goto free_buf;
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

