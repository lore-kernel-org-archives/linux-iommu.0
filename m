Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B1438F23F
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772012289; cv=none; b=jYl2CBboO4SkbnHv5t4n+rF4V+i8FFSBI7aFsvuE8EmbmJvv6G0kFua+nR08uzdLIYW8v6f0VZ9EE2NXdV7TVfdYE1DOXkVC957Hy7eKlDmSF8ySLMd0brfa+Wf+hjN85rjJi2/DjDfF6hbcLNE6jlpcaQq0E+zrLOza4nDdtOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772012289; c=relaxed/simple;
	bh=7hKeXPXAVcEdqySUdhdu1CX5wNLDueYaRZ+rlUSWqu0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KFljUp8E69Ssfy7v4dfekQdo329J5CYiOS8ff9nC/ZOXxF9f4K7/bVlO+1lywUJMXBb486z1DjdC44bKoZufckfOaajh1rRgR6ZBxKc62isxi1rRbn7Qw9G5uC6yvsA0wbbd+nPxrZYr0NJEMuzuE/fASyc6ZGZLcDQI6mW89sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=CrssyKpN; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="CrssyKpN"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JwtjLw0PDJywja8AdToc9VD5WNrXXmtNvW+lo0FDA5s=;
	b=CrssyKpNkyAAnjiuPH3xZD4wp6nqLUXQ31UjnAsQdoa5OVP5Ku7aQtr0EuzukNjeS8TGsQNSl
	sZP99Wj6o6YoYr5C+GtpVgmAQIVPnocIG5bFm+jYR36657zClu+d2cApyyjPWM38HehfwIZb1eB
	1LkygXTqDatUpISlYWfvUbA=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4fLTsq6YpCz1cyQp;
	Wed, 25 Feb 2026 17:33:19 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 8187D40565;
	Wed, 25 Feb 2026 17:38:06 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 25 Feb 2026 17:38:05 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <21cnbao@gmail.com>, <jonathan.cameron@huawei.com>,
	<wangzhou1@hisilicon.com>, <xiaqinxin@huawei.com>
CC: <iommu@lists.linux.dev>, <prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>, Barry Song
	<baohua@kernel.org>
Subject: [PATCH v7 2/3] dma-mapping: benchmark: add support for dma_map_sg
Date: Wed, 25 Feb 2026 17:37:59 +0800
Message-ID: <20260225093800.3625054-3-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260225093800.3625054-1-xiaqinxin@huawei.com>
References: <20260225093800.3625054-1-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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
 include/uapi/linux/map_benchmark.h |   5 +-
 kernel/dma/map_benchmark.c         | 115 +++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/map_benchmark.h b/include/uapi/linux/map_benchmark.h
index e076748f2120..4b17829a9f17 100644
--- a/include/uapi/linux/map_benchmark.h
+++ b/include/uapi/linux/map_benchmark.h
@@ -19,6 +19,7 @@
 
 enum {
 	DMA_MAP_BENCH_SINGLE_MODE,
+	DMA_MAP_BENCH_SG_MODE,
 	DMA_MAP_BENCH_MODE_MAX
 };
 
@@ -33,7 +34,9 @@ struct map_benchmark {
 	__u32 dma_bits; /* DMA addressing capability */
 	__u32 dma_dir; /* DMA data direction */
 	__u32 dma_trans_ns; /* time for DMA transmission in ns */
-	__u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
+	__u32 granule;  /* - SINGLE_MODE: number of pages mapped/unmapped per operation
+			 * - SG_MODE: number of scatterlist entries (each maps one page)
+			 */
 	__u8 map_mode;  /* the mode of dma map */
 	__u8 expansion[75]; /* For future use */
 };
diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 312e7060c7a9..e1689fdd3878 100644
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
@@ -117,8 +118,122 @@ static struct map_benchmark_ops dma_single_map_benchmark_ops = {
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
+	return params;
+
+free_page:
+	while (i-- > 0)
+		free_page((unsigned long)params->buf[i]);
+
+	sg_free_table(&params->sgt);
+free_buf:
+	kfree(params->buf);
+out:
+	kfree(params);
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
+static void dma_sg_map_benchmark_initialize_data(void *mparam)
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
+	.initialize_data = dma_sg_map_benchmark_initialize_data,
+	.do_map = dma_sg_map_benchmark_do_map,
+	.do_unmap = dma_sg_map_benchmark_do_unmap,
+};
+
 static struct map_benchmark_ops *dma_map_benchmark_ops[DMA_MAP_BENCH_MODE_MAX] = {
 	[DMA_MAP_BENCH_SINGLE_MODE] = &dma_single_map_benchmark_ops,
+	[DMA_MAP_BENCH_SG_MODE] = &dma_sg_map_benchmark_ops,
 };
 
 static int map_benchmark_thread(void *data)
-- 
2.33.0

