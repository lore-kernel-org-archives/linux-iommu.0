Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B0A32BF26
	for <iommu@lists.linux.dev>; Mon, 22 Dec 2025 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766417601; cv=none; b=izs+7K6tTWeTOG9+tYNf5gmLzDKn/cQw0JJDURMgc0f1oSwBSTpnEZyf5Q+/pozAC/AXHer5R2bTd5rnSSTOYhONC8jv9LwuIMkxN48Wnn3UybCpLZyIGB0Da4Urvhd1sYldtVoJEclGP087MAbSykF9ex5V8k+V8Yc9jvhqbT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766417601; c=relaxed/simple;
	bh=3ORkZSqrryRlwuouwJX2eBKc9+YX6usq4fRVveD/X0M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j8GUUYsubctMamQBwctd9A43UbmoVrTACjG5jl0l9ICXr2wZ7FpeTZ7NdQu0lWJu1y0nhO0ixu9iJ7YuTbtarXw6Loyjhtk60mh1cGYrqqWAZqrIPZkC9KeD4x37cH1WOwWaEXcnnXQVSapy4aubb75hAcY+tFeFwJM+w73A5RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=BLHvy/hq; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="BLHvy/hq"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8Nn9Tf6p9jv3oIFqF6C3yOaSQKn/TVtZ2Dbbt/Kekjc=;
	b=BLHvy/hqm1LhNdND4b8nhJY+525RXnN/gN1ofe3iulsbl4LEfldQVzBxnRu5bqZMo6RkfMFGA
	C7L7tg+9A4zGSpwLvnrvcFIL8nkyNUgzdJ7JcBM8FrDw1orwdSHfVoEnWQv89hpo2WLx2w8E/Oc
	wI10n1F/IZRrmIwMNMHg2yc=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dZhtT3fp4z1T4GK;
	Mon, 22 Dec 2025 23:30:57 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 07D934036C;
	Mon, 22 Dec 2025 23:33:17 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Dec 2025 23:33:16 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <21cnbao@gmail.com>, <xiaqinxin@huawei.com>,
	<jonathan.cameron@huawei.com>, <wangzhou1@hisilicon.com>
CC: <iommu@lists.linux.dev>, <prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>, Barry Song
	<baohua@kernel.org>
Subject: [PATCH v5 2/3] dma-mapping: benchmark: add support for dma_map_sg
Date: Mon, 22 Dec 2025 23:32:45 +0800
Message-ID: <20251222153246.2220659-3-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251222153246.2220659-1-xiaqinxin@huawei.com>
References: <20251222153246.2220659-1-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj200003.china.huawei.com (7.202.194.15)

Support for dma scatter-gather mapping and is intended for testing
mapping performance. It achieves by introducing the dma_sg_map_param
structure and related functions, which enable the implementation of
scatter-gather mapping preparation, mapping, and unmapping operations.
Additionally, the dma_map_benchmark_ops array is updated to include
operations for scatter-gather mapping. This commit aims to provide
a wider range of mapping performance test to cater to different scenarios.

Reviewed-by: Barry Song <baohua@kernel.org>
Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 include/uapi/linux/map_benchmark.h |   1 +
 kernel/dma/map_benchmark.c         | 117 ++++++++++++++++++++++++++++-
 2 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/map_benchmark.h b/include/uapi/linux/map_benchmark.h
index e076748f2120..5fa3745e1651 100644
--- a/include/uapi/linux/map_benchmark.h
+++ b/include/uapi/linux/map_benchmark.h
@@ -19,6 +19,7 @@
 
 enum {
 	DMA_MAP_BENCH_SINGLE_MODE,
+	DMA_MAP_BENCH_SG_MODE,
 	DMA_MAP_BENCH_MODE_MAX
 };
 
diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index a6345c10901c..76c0e1d5ff08 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/timekeeping.h>
 #include <uapi/linux/map_benchmark.h>
@@ -117,8 +118,121 @@ static struct map_benchmark_ops dma_single_map_benchmark_ops = {
 	.do_unmap = dma_single_map_benchmark_do_unmap,
 };
 
+struct dma_sg_map_param {
+	struct sg_table sgt;
+	struct device *dev;
+	void **buf;
+	u32 npages;
+	u32 dma_dir;
+};
+
+static void *dma_sg_map_benchmark_prepare(struct map_benchmark_data *map)
+{
+	struct scatterlist *sg;
+	int i;
+
+	struct dma_sg_map_param *params = kzalloc(sizeof(*params), GFP_KERNEL);
+
+	if (!params)
+		return NULL;
+	/*
+	 * Set the number of scatterlist entries based on the granule.
+	 * In SG mode, 'granule' represents the number of scatterlist entries.
+	 * Each scatterlist entry corresponds to a single page.
+	 */
+	params->npages = map->bparam.granule;
+	params->dma_dir = map->bparam.dma_dir;
+	params->dev = map->dev;
+	params->buf = kmalloc_array(params->npages, sizeof(*params->buf),
+				    GFP_KERNEL);
+	if (!params->buf)
+		goto out;
+
+	if (sg_alloc_table(&params->sgt, params->npages, GFP_KERNEL))
+		goto free_buf;
+
+	for_each_sgtable_sg(&params->sgt, sg, i) {
+		params->buf[i] = (void *)__get_free_page(GFP_KERNEL);
+		if (!params->buf[i])
+			goto free_page;
+
+		sg_set_buf(sg, params->buf[i], PAGE_SIZE);
+	}
+
+	return_ptr(params);
+
+free_page:
+	while (i-- > 0)
+		free_page((unsigned long)params->buf[i]);
+
+	sg_free_table(&params->sgt);
+free_buf:
+	kfree(params->buf);
+out:
+	return NULL;
+}
+
+static void dma_sg_map_benchmark_unprepare(void *mparam)
+{
+	struct dma_sg_map_param *params = mparam;
+	int i;
+
+	for (i = 0; i < params->npages; i++)
+		free_page((unsigned long)params->buf[i]);
+
+	sg_free_table(&params->sgt);
+
+	kfree(params->buf);
+	kfree(params);
+}
+
+static void dma_sg_map_benchmark_prepare_data(void *mparam)
+{
+	struct dma_sg_map_param *params = mparam;
+	struct scatterlist *sg;
+	int i = 0;
+
+	if (params->dma_dir == DMA_FROM_DEVICE)
+		return;
+
+	for_each_sgtable_sg(&params->sgt, sg, i)
+		memset(params->buf[i], 0x66, PAGE_SIZE);
+}
+
+static int dma_sg_map_benchmark_do_map(void *mparam)
+{
+	struct dma_sg_map_param *params = mparam;
+	int ret = 0;
+
+	int sg_mapped = dma_map_sg(params->dev, params->sgt.sgl,
+				   params->npages, params->dma_dir);
+	if (!sg_mapped) {
+		pr_err("dma_map_sg failed on %s\n", dev_name(params->dev));
+		ret = -ENOMEM;
+	}
+
+	return ret;
+}
+
+static void dma_sg_map_benchmark_do_unmap(void *mparam)
+{
+	struct dma_sg_map_param *params = mparam;
+
+	dma_unmap_sg(params->dev, params->sgt.sgl, params->npages,
+		     params->dma_dir);
+}
+
+static struct map_benchmark_ops dma_sg_map_benchmark_ops = {
+	.prepare = dma_sg_map_benchmark_prepare,
+	.unprepare = dma_sg_map_benchmark_unprepare,
+	.prepare_data = dma_sg_map_benchmark_prepare_data,
+	.do_map = dma_sg_map_benchmark_do_map,
+	.do_unmap = dma_sg_map_benchmark_do_unmap,
+};
+
 static struct map_benchmark_ops *dma_map_benchmark_ops[DMA_MAP_BENCH_MODE_MAX] = {
 	[DMA_MAP_BENCH_SINGLE_MODE] = &dma_single_map_benchmark_ops,
+	[DMA_MAP_BENCH_SG_MODE] = &dma_sg_map_benchmark_ops,
 };
 
 static int map_benchmark_thread(void *data)
@@ -290,7 +404,8 @@ static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
 
 	switch (cmd) {
 	case DMA_MAP_BENCHMARK:
-		if (map->bparam.map_mode >= DMA_MAP_BENCH_MODE_MAX) {
+		if (map->bparam.threads < 0 ||
+		    map->bparam.map_mode >= DMA_MAP_BENCH_MODE_MAX) {
 			pr_err("invalid map mode\n");
 			return -EINVAL;
 		}
-- 
2.33.0

