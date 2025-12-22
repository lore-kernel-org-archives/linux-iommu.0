Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C4032C301
	for <iommu@lists.linux.dev>; Mon, 22 Dec 2025 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766417600; cv=none; b=Sn22lNVqhgrJvBxNK+OuqA7XQAczbnTaRNPFoF2aPaZIQJY5bWWAaUjcRl4VM97uzC8PQqJJ5Wf62wtJ+AAzmH7M1SVRMUaITrtu6hKvJD6tog44iQGHvLi5v0Vp7wKKpgxbOo5t0p1Mn8YVMFZ5uyjAIaf7jaXi7iF+UDMlZp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766417600; c=relaxed/simple;
	bh=iH03pfoF4mvkTa2wcRHUM9Z8ksajUOI4hdloQnHz4Jk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sIh0kRchKqTsdDNXSjFHcLKVzKOFULB5ul2CA7MaGO4W6udixXRX/0OSCaglG7UXsmMqrEugSC+d6oBHWZjfH9UUtvm2KWMfZTD76uDtHyuUn9XthNXD97cTwCYCyXB5iYjJaN0c0WIwef9SnwKe6j5heWN9PyL5jfv8vGdQLy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6CKovsEY; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6CKovsEY"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=doI5KMdG3Xum6cEQbVdMde7Z+vfULP8iPsOF4kcO7Qw=;
	b=6CKovsEYt5BUKpe0tqKF3abFx6zVjmzQsM/Hg04VHr52Q3t3SRnb2/CRnFa218AbKe1UczaNH
	vmbRi00kUV+cxs1NhjvFfnlMeKsUOFDvFTvXp+df8s0pO9OxCsmBJGal3fzn6GflJnUuWe4/1f6
	9Qnt5Hh21F6swyF3p6oSGJg=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dZhsX0Y9pzLlTC;
	Mon, 22 Dec 2025 23:30:08 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 462D740562;
	Mon, 22 Dec 2025 23:33:13 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Dec 2025 23:33:12 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <21cnbao@gmail.com>, <xiaqinxin@huawei.com>,
	<jonathan.cameron@huawei.com>, <wangzhou1@hisilicon.com>
CC: <iommu@lists.linux.dev>, <prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>, Barry Song
	<baohua@kernel.org>
Subject: [PATCH v5 1/3] dma-mapping: benchmark: modify the framework to adapt to more map modes
Date: Mon, 22 Dec 2025 23:32:44 +0800
Message-ID: <20251222153246.2220659-2-xiaqinxin@huawei.com>
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

This patch adjusts the DMA map benchmark framework to make the DMA
map benchmark framework more flexible and adaptable to other mapping
modes in the future. By abstracting the framework into four interfaces:
prepare, unprepare, prepare_data, do_map, and do_unmap.
The new map schema can be introduced more easily
without major modifications to the existing code structure.

Reviewed-by: Barry Song <baohua@kernel.org>
Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 include/uapi/linux/map_benchmark.h |   8 +-
 kernel/dma/map_benchmark.c         | 130 ++++++++++++++++++++++++-----
 2 files changed, 115 insertions(+), 23 deletions(-)

diff --git a/include/uapi/linux/map_benchmark.h b/include/uapi/linux/map_benchmark.h
index c2d91088a40d..e076748f2120 100644
--- a/include/uapi/linux/map_benchmark.h
+++ b/include/uapi/linux/map_benchmark.h
@@ -17,6 +17,11 @@
 #define DMA_MAP_TO_DEVICE       1
 #define DMA_MAP_FROM_DEVICE     2
 
+enum {
+	DMA_MAP_BENCH_SINGLE_MODE,
+	DMA_MAP_BENCH_MODE_MAX
+};
+
 struct map_benchmark {
 	__u64 avg_map_100ns; /* average map latency in 100ns */
 	__u64 map_stddev; /* standard deviation of map latency */
@@ -29,7 +34,8 @@ struct map_benchmark {
 	__u32 dma_dir; /* DMA data direction */
 	__u32 dma_trans_ns; /* time for DMA transmission in ns */
 	__u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
-	__u8 expansion[76]; /* For future use */
+	__u8 map_mode;  /* the mode of dma map */
+	__u8 expansion[75]; /* For future use */
 };
 
 #endif /* _UAPI_DMA_BENCHMARK_H */
diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 794041a39e65..a6345c10901c 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -5,6 +5,7 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -31,17 +32,105 @@ struct map_benchmark_data {
 	atomic64_t loops;
 };
 
+struct map_benchmark_ops {
+	void *(*prepare)(struct map_benchmark_data *map);
+	void (*unprepare)(void *mparam);
+	void (*prepare_data)(void *mparam);
+	int (*do_map)(void *mparam);
+	void (*do_unmap)(void *mparam);
+};
+
+struct dma_single_map_param {
+	struct device *dev;
+	dma_addr_t addr;
+	void *xbuf;
+	u32 npages;
+	u32 dma_dir;
+};
+
+static void *dma_single_map_benchmark_prepare(struct map_benchmark_data *map)
+{
+	struct dma_single_map_param *params __free(kfree) = kzalloc(sizeof(*params),
+								    GFP_KERNEL);
+	if (!params)
+		return NULL;
+
+	params->npages = map->bparam.granule;
+	params->dma_dir = map->bparam.dma_dir;
+	params->dev = map->dev;
+	params->xbuf = alloc_pages_exact(params->npages * PAGE_SIZE, GFP_KERNEL);
+	if (!params->xbuf)
+		return NULL;
+
+	return_ptr(params);
+}
+
+static void dma_single_map_benchmark_unprepare(void *mparam)
+{
+	struct dma_single_map_param *params = mparam;
+
+	free_pages_exact(params->xbuf, params->npages * PAGE_SIZE);
+	kfree(params);
+}
+
+static void dma_single_map_benchmark_prepare_data(void *mparam)
+{
+	struct dma_single_map_param *params = mparam;
+
+	/*
+	 * for a non-coherent device, if we don't stain them in the
+	 * cache, this will give an underestimate of the real-world
+	 * overhead of BIDIRECTIONAL or TO_DEVICE mappings;
+	 * 66 means evertything goes well! 66 is lucky.
+	 */
+	if (params->dma_dir != DMA_FROM_DEVICE)
+		memset(params->xbuf, 0x66, params->npages * PAGE_SIZE);
+}
+
+static int dma_single_map_benchmark_do_map(void *mparam)
+{
+	struct dma_single_map_param *params = mparam;
+
+	params->addr = dma_map_single(params->dev, params->xbuf,
+				      params->npages * PAGE_SIZE, params->dma_dir);
+	if (unlikely(dma_mapping_error(params->dev, params->addr))) {
+		pr_err("dma_map_single failed on %s\n", dev_name(params->dev));
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void dma_single_map_benchmark_do_unmap(void *mparam)
+{
+	struct dma_single_map_param *params = mparam;
+
+	dma_unmap_single(params->dev, params->addr,
+			 params->npages * PAGE_SIZE, params->dma_dir);
+}
+
+static struct map_benchmark_ops dma_single_map_benchmark_ops = {
+	.prepare = dma_single_map_benchmark_prepare,
+	.unprepare = dma_single_map_benchmark_unprepare,
+	.prepare_data = dma_single_map_benchmark_prepare_data,
+	.do_map = dma_single_map_benchmark_do_map,
+	.do_unmap = dma_single_map_benchmark_do_unmap,
+};
+
+static struct map_benchmark_ops *dma_map_benchmark_ops[DMA_MAP_BENCH_MODE_MAX] = {
+	[DMA_MAP_BENCH_SINGLE_MODE] = &dma_single_map_benchmark_ops,
+};
+
 static int map_benchmark_thread(void *data)
 {
-	void *buf;
-	dma_addr_t dma_addr;
 	struct map_benchmark_data *map = data;
-	int npages = map->bparam.granule;
-	u64 size = npages * PAGE_SIZE;
+	__u8 map_mode = map->bparam.map_mode;
 	int ret = 0;
 
-	buf = alloc_pages_exact(size, GFP_KERNEL);
-	if (!buf)
+	struct map_benchmark_ops *mb_ops = dma_map_benchmark_ops[map_mode];
+	void *mparam = mb_ops->prepare(map);
+
+	if (!mparam)
 		return -ENOMEM;
 
 	while (!kthread_should_stop())  {
@@ -49,23 +138,14 @@ static int map_benchmark_thread(void *data)
 		ktime_t map_stime, map_etime, unmap_stime, unmap_etime;
 		ktime_t map_delta, unmap_delta;
 
-		/*
-		 * for a non-coherent device, if we don't stain them in the
-		 * cache, this will give an underestimate of the real-world
-		 * overhead of BIDIRECTIONAL or TO_DEVICE mappings;
-		 * 66 means evertything goes well! 66 is lucky.
-		 */
-		if (map->dir != DMA_FROM_DEVICE)
-			memset(buf, 0x66, size);
+		if (!mb_ops->prepare_data)
+			mb_ops->prepare_data(mparam);
 
 		map_stime = ktime_get();
-		dma_addr = dma_map_single(map->dev, buf, size, map->dir);
-		if (unlikely(dma_mapping_error(map->dev, dma_addr))) {
-			pr_err("dma_map_single failed on %s\n",
-				dev_name(map->dev));
-			ret = -ENOMEM;
+		ret = mb_ops->do_map(mparam);
+		if (ret)
 			goto out;
-		}
+
 		map_etime = ktime_get();
 		map_delta = ktime_sub(map_etime, map_stime);
 
@@ -73,7 +153,8 @@ static int map_benchmark_thread(void *data)
 		ndelay(map->bparam.dma_trans_ns);
 
 		unmap_stime = ktime_get();
-		dma_unmap_single(map->dev, dma_addr, size, map->dir);
+		mb_ops->do_unmap(mparam);
+
 		unmap_etime = ktime_get();
 		unmap_delta = ktime_sub(unmap_etime, unmap_stime);
 
@@ -108,7 +189,7 @@ static int map_benchmark_thread(void *data)
 	}
 
 out:
-	free_pages_exact(buf, size);
+	mb_ops->unprepare(mparam);
 	return ret;
 }
 
@@ -209,6 +290,11 @@ static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
 
 	switch (cmd) {
 	case DMA_MAP_BENCHMARK:
+		if (map->bparam.map_mode >= DMA_MAP_BENCH_MODE_MAX) {
+			pr_err("invalid map mode\n");
+			return -EINVAL;
+		}
+
 		if (map->bparam.threads == 0 ||
 		    map->bparam.threads > DMA_MAP_MAX_THREADS) {
 			pr_err("invalid thread number\n");
-- 
2.33.0

